<?php
ob_start();
session_start();
if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
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
    echo json_encode(['status'=>'error','msg'=>'DB connect failed: '.mysqli_connect_error()]);
    exit();
}

// Force utf8mb4 on this connection explicitly
mysqli_query($conn, "SET NAMES 'utf8mb4' COLLATE 'utf8mb4_unicode_ci'");
mysqli_query($conn, "SET CHARACTER SET utf8mb4");
mysqli_set_charset($conn, 'utf8mb4');

function esc($c, $v) { return mysqli_real_escape_string($c, trim($v ?? '')); }

// ── Map Device Type → Table name ─────────────────────────
$table_map = [
'Laptop'    => 'laptops',
'Desktop'   => 'desktops',
'Tablet'    => 'tablets',
'Phone'     => 'phones',
'Monitor'   => 'monitors',
'DGPS'      => 'dgps',
'PowerBank' => 'powerbanks',
];

// ── ຮັບຄ່າຈາກ Form ───────────────────────────────────────
$id                   = esc($conn, $_POST['id']                   ?? '');
$device_type          = esc($conn, $_POST['device_type']          ?? '');
$halo_id              = esc($conn, $_POST['halo_id']              ?? '');
$brand                = esc($conn, $_POST['brand']                ?? '');
$model                = esc($conn, $_POST['model']                ?? '');
$serial_number        = esc($conn, $_POST['serial_number']        ?? '');
$date_in              = esc($conn, $_POST['date_in']              ?? '');
$date_out             = esc($conn, $_POST['date_out']             ?? '');
$username             = esc($conn, $_POST['username']             ?? '');
$department           = esc($conn, $_POST['department']           ?? '');
$team                 = esc($conn, $_POST['team']                 ?? '');
$location_local       = esc($conn, $_POST['location_local']       ?? '');
$ins_number           = esc($conn, $_POST['ins_number']           ?? '');
$status               = esc($conn, $_POST['status']               ?? 'Active');
$sv123_user           = esc($conn, $_POST['sv123_user']           ?? '');
$sv123_pass           = esc($conn, $_POST['sv123_password']       ?? '');
$gmail_address        = esc($conn, $_POST['gmail_address']        ?? '');
$gmail_pass           = esc($conn, $_POST['gmail_password']       ?? '');
$dgps_mail            = esc($conn, $_POST['dgps_mail']            ?? '');
$dgps_pass            = esc($conn, $_POST['dgps_password']        ?? '');
$bitlocker_pass       = esc($conn, $_POST['bitlocker_password']   ?? '');
$bitlocker_id         = esc($conn, $_POST['bitlocker_identifier'] ?? '');
$bitlocker_key        = esc($conn, $_POST['bitlocker_key']        ?? '');
$remark               = esc($conn, $_POST['remark']               ?? '');

$di = ($date_in  !== '') ? "'$date_in'"  : "NULL";
$do = ($date_out !== '') ? "'$date_out'" : "NULL";

// ── ກວດ device_type ──────────────────────────────────────
if (empty($device_type) || !isset($table_map[$device_type])) {
echo json_encode(['status'=>'error','msg'=>'ກະລຸນາເລືອກ Device Type ກ່ອນ']);
exit();
}

$table = $table_map[$device_type];

// ── ກວດ table ວ່າມີໃນ DB ຫຼືບໍ່ ──────────────────────────
$tbl_check = mysqli_query($conn, "SHOW TABLES LIKE '$table'");
if (!$tbl_check || mysqli_num_rows($tbl_check) === 0) {
echo json_encode(['status'=>'error','msg'=>"ຕາຕະລາງ '$table' ຍັງບໍ່ມີໃນ DB — ກະລຸນາ import SQL ກ່ອນ"]);
exit();
}

// ── ກວດ column bitlocker_id ທີ່ DB ──────────────────────
$has_bl_id = false;
$col_check = mysqli_query($conn, "SHOW COLUMNS FROM `$table` LIKE 'bitlocker_id'");
if ($col_check && mysqli_num_rows($col_check) > 0) $has_bl_id = true;

// ── BUILD columns & values dynamically ──────────────────
$cols = [
'device_type', 'halo_id', 'brand', 'model', 'serial_number',
'date_in', 'date_out',
'username', 'department', 'team', 'location_local', 'ins_number', 'status',
'sv123_user', 'sv123_pass',
'gmail_address', 'gmail_pass',
'dgps_mail', 'dgps_pass',
'bitlocker_pass', 'bitlocker_key', 'remark',
];

$vals = [
"'$device_type'", "'$halo_id'", "'$brand'", "'$model'", "'$serial_number'",
$di, $do,
"'$username'", "'$department'", "'$team'", "'$location_local'", "'$ins_number'", "'$status'",
"'$sv123_user'", "'$sv123_pass'",
"'$gmail_address'", "'$gmail_pass'",
"'$dgps_mail'", "'$dgps_pass'",
"'$bitlocker_pass'", "'$bitlocker_key'", "'$remark'",
];

// ຖ້າ column bitlocker_id ມີໃນ DB ຄ່ອຍໃສ່
if ($has_bl_id) {
$cols[] = 'bitlocker_id';
$vals[] = "'$bitlocker_id'";
}

// ─── UPDATE ──────────────────────────────────────────────
if (!empty($id)) {
// ຖ້າ Edit: ດຶງຕາຕະລາງເກົ່າຈາກ hidden field (source_table)
$src_table = esc($conn, $_POST['source_table'] ?? $table);
if (!isset(array_flip($table_map)[$src_table]) &&
!in_array($src_table, array_values($table_map))) {
$src_table = $table;
}

$set_parts = [];
foreach ($cols as $i => $col) {
$set_parts[] = "`$col` = {$vals[$i]}";
}

$sql = "UPDATE `$src_table` SET " . implode(", ", $set_parts) . " WHERE id = '$id'";

ob_end_clean();
header('Content-Type: application/json; charset=utf-8');
if (mysqli_query($conn, $sql)) {
echo json_encode(['status'=>'updated', 'table'=>$src_table]);
} else {
echo json_encode(['status'=>'error','msg'=>'UPDATE failed: '.mysqli_error($conn)]);
}

// ─── INSERT ──────────────────────────────────────────────
} else {
$col_str = implode(", ", array_map(fn($c) => "`$c`", $cols));
$val_str = implode(", ", $vals);

$sql = "INSERT INTO `$table` ($col_str) VALUES ($val_str)";

ob_end_clean();
header('Content-Type: application/json; charset=utf-8');
if (mysqli_query($conn, $sql)) {
echo json_encode(['status'=>'saved', 'table'=>$table]);
} else {
echo json_encode(['status'=>'error','msg'=>'INSERT failed: '.mysqli_error($conn)]);
}
}

mysqli_close($conn);