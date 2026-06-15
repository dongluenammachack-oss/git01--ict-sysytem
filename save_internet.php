﻿<?php
ob_start();
session_start();
if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
ob_end_clean();
header('Content-Type: application/json');
echo json_encode(['status'=>'error','msg'=>'Unauthorized']); exit();
}

require_once 'config.php';
if (!$conn) {
ob_end_clean();
header('Content-Type: application/json; charset=utf-8');
echo json_encode(['status'=>'error','msg'=>'DB connection failed']); exit();
}

// Ensure table exists
mysqli_query($conn,"CREATE TABLE IF NOT EXISTS `internet_records` (
  `id`             INT AUTO_INCREMENT PRIMARY KEY,
  `internet_local` VARCHAR(255) DEFAULT '',
  `internet_type`  VARCHAR(100) DEFAULT '',
  `package`        VARCHAR(255) DEFAULT '',
  `price`          DECIMAL(12,2) DEFAULT 0,
  `start_date`     DATE NULL,
  `end_date`       DATE NULL,
  `document_local` VARCHAR(255) DEFAULT '',
  `document_link`  VARCHAR(500) DEFAULT '',
  `remark`         TEXT,
  `created_at`     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

// ── Handle file upload ──────────────────────────────────
$uploaded_link = '';
if (isset($_FILES['doc_file']) && $_FILES['doc_file']['error'] === UPLOAD_ERR_OK) {
$upload_dir = __DIR__ . '/uploads/internet/';
if (!is_dir($upload_dir)) {
mkdir($upload_dir, 0775, true);
}
$orig_name  = basename($_FILES['doc_file']['name']);
// Sanitize filename
$safe_name  = preg_replace('/[^a-zA-Z0-9._\-]/', '_', $orig_name);
$final_name = time() . '_' . $safe_name;
$dest       = $upload_dir . $final_name;
if (move_uploaded_file($_FILES['doc_file']['tmp_name'], $dest)) {
$uploaded_link = 'uploads/internet/' . $final_name;
}
}

$id              = isset($_POST['internet_id'])  ? (int)$_POST['internet_id'] : 0;
$internet_local  = mysqli_real_escape_string($conn, trim($_POST['internet_local']  ?? ''));
$internet_type   = mysqli_real_escape_string($conn, trim($_POST['internet_type']   ?? ''));
$package         = mysqli_real_escape_string($conn, trim($_POST['package']         ?? ''));
$price_raw       = str_replace([',',' '], '', $_POST['price'] ?? '0');
$price           = (float)$price_raw;
$start_date      = mysqli_real_escape_string($conn, trim($_POST['start_date']      ?? ''));
$end_date        = mysqli_real_escape_string($conn, trim($_POST['end_date']        ?? ''));
$document_local  = mysqli_real_escape_string($conn, trim($_POST['document_local']  ?? ''));
// Use uploaded file link if available, else use the posted link
$document_link_raw = !empty($uploaded_link) ? $uploaded_link : trim($_POST['document_link'] ?? '');
$document_link   = mysqli_real_escape_string($conn, $document_link_raw);
$remark          = mysqli_real_escape_string($conn, trim($_POST['remark']          ?? ''));

$sd_val = $start_date ? "'$start_date'" : 'NULL';
$ed_val = $end_date   ? "'$end_date'"   : 'NULL';

if ($id > 0) {
$sql = "UPDATE internet_records SET
        internet_local='$internet_local', internet_type='$internet_type',
        package='$package', price='$price',
        start_date=$sd_val, end_date=$ed_val,
        document_local='$document_local', document_link='$document_link',
        remark='$remark'
        WHERE id='$id'";
ob_end_clean();
header('Content-Type: application/json; charset=utf-8');
if (mysqli_query($conn, $sql)) {
echo json_encode(['status'=>'updated', 'link'=>$document_link_raw]);
} else {
echo json_encode(['status'=>'error','msg'=>mysqli_error($conn)]);
}
} else {
$sql = "INSERT INTO internet_records
        (internet_local,internet_type,package,price,start_date,end_date,document_local,document_link,remark)
        VALUES ('$internet_local','$internet_type','$package','$price',$sd_val,$ed_val,'$document_local','$document_link','$remark')";
ob_end_clean();
header('Content-Type: application/json; charset=utf-8');
if (mysqli_query($conn, $sql)) {
echo json_encode(['status'=>'saved', 'link'=>$document_link_raw]);
} else {
echo json_encode(['status'=>'error','msg'=>mysqli_error($conn)]);
}
}
mysqli_close($conn);
