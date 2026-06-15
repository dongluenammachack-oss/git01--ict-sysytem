<?php
ob_start();
session_start();
if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
    ob_end_clean();
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['status'=>'error','msg'=>'Unauthorized']); exit();
}
ini_set('display_errors', 0);
error_reporting(0);
mysqli_report(MYSQLI_REPORT_OFF);

require_once 'config.php';
if (!$conn) {
    ob_end_clean();
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['status'=>'error','msg'=>'DB connection failed']); exit();
}

// Force utf8mb4
mysqli_query($conn, "SET NAMES 'utf8mb4' COLLATE 'utf8mb4_unicode_ci'");
mysqli_set_charset($conn, 'utf8mb4');

// Auto-create table
@mysqli_query($conn, "CREATE TABLE IF NOT EXISTS `ict_accessories` (
  `id`            INT(11)      NOT NULL AUTO_INCREMENT,
  `device_type`   VARCHAR(100) DEFAULT '',
  `halo_id`       VARCHAR(100) DEFAULT '',
  `brand`         VARCHAR(100) DEFAULT '',
  `model`         VARCHAR(150) DEFAULT '',
  `serial_number` VARCHAR(150) DEFAULT '',
  `date_in`       DATE         DEFAULT NULL,
  `date_out`      DATE         DEFAULT NULL,
  `qty`           INT(11)      DEFAULT 1,
  `username`      VARCHAR(150) DEFAULT '',
  `department`    VARCHAR(100) DEFAULT '',
  `location`      VARCHAR(150) DEFAULT '',
  `status`        VARCHAR(50)  DEFAULT 'Working',
  `remark`        TEXT,
  `created_at`    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

function esc($c, $v) { return mysqli_real_escape_string($c, trim($v ?? '')); }

$ac_id        = (int)($_POST['ac_id'] ?? 0);
$device_type  = esc($conn, $_POST['device_type']  ?? '');
$halo_id      = esc($conn, $_POST['halo_id']      ?? '');
$brand        = esc($conn, $_POST['brand']        ?? '');
$model        = esc($conn, $_POST['model']        ?? '');
$serial_number= esc($conn, $_POST['serial_number']?? '');
$date_in      = esc($conn, $_POST['date_in']      ?? '');
$date_out     = esc($conn, $_POST['date_out']     ?? '');
$qty          = max(0,(int)($_POST['qty'] ?? 1));
$username     = esc($conn, $_POST['username']     ?? '');
$department   = esc($conn, $_POST['department']   ?? '');
$location     = esc($conn, $_POST['location']     ?? '');
$status       = esc($conn, $_POST['status']       ?? 'Working');
$remark       = esc($conn, $_POST['remark']       ?? '');

$di = $date_in  !== '' ? "'$date_in'"  : 'NULL';
$do = $date_out !== '' ? "'$date_out'" : 'NULL';

ob_end_clean();
header('Content-Type: application/json; charset=utf-8');

if ($ac_id > 0) {
    $sql = "UPDATE ict_accessories SET
            device_type='$device_type', halo_id='$halo_id', brand='$brand', model='$model',
            serial_number='$serial_number', date_in=$di, date_out=$do, qty=$qty,
            username='$username', department='$department', location='$location',
            status='$status', remark='$remark'
            WHERE id=$ac_id";
    if (mysqli_query($conn, $sql)) {
        echo json_encode(['status'=>'updated']);
    } else {
        echo json_encode(['status'=>'error','msg'=>mysqli_error($conn)]);
    }
} else {
    $sql = "INSERT INTO ict_accessories
            (device_type,halo_id,brand,model,serial_number,date_in,date_out,qty,username,department,location,status,remark)
            VALUES ('$device_type','$halo_id','$brand','$model','$serial_number',$di,$do,$qty,'$username','$department','$location','$status','$remark')";
    if (mysqli_query($conn, $sql)) {
        echo json_encode(['status'=>'saved']);
    } else {
        echo json_encode(['status'=>'error','msg'=>mysqli_error($conn)]);
    }
}
mysqli_close($conn);
