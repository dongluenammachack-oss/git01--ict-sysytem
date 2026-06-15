<?php
session_start();
if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['status'=>'error','msg'=>'Unauthorized']); exit();
}

ini_set('display_errors',0); error_reporting(0); mysqli_report(MYSQLI_REPORT_OFF);
header('Content-Type: application/json; charset=utf-8');

require_once 'config.php';
if(!$conn){ echo json_encode(['status'=>'error','msg'=>'DB connect failed']); exit(); }

// Auto-create transfer log table
@mysqli_query($conn,"CREATE TABLE IF NOT EXISTS `device_transfers` (
  `id`              INT(11)      NOT NULL AUTO_INCREMENT,
  `halo_id`         VARCHAR(100) DEFAULT NULL,
  `serial_number`   VARCHAR(150) DEFAULT NULL,
  `device_type`     VARCHAR(50)  DEFAULT NULL,
  `brand`           VARCHAR(100) DEFAULT NULL,
  `model`           VARCHAR(100) DEFAULT NULL,
  `source_table`    VARCHAR(100) DEFAULT NULL,
  `from_username`   VARCHAR(150) DEFAULT NULL,
  `from_department` VARCHAR(100) DEFAULT NULL,
  `from_team`       VARCHAR(100) DEFAULT NULL,
  `from_ins_number` VARCHAR(100) DEFAULT NULL,
  `from_location`   VARCHAR(150) DEFAULT NULL,
  `to_username`     VARCHAR(150) DEFAULT NULL,
  `to_department`   VARCHAR(100) DEFAULT NULL,
  `to_team`         VARCHAR(100) DEFAULT NULL,
  `to_ins_number`   VARCHAR(100) DEFAULT NULL,
  `to_location`     VARCHAR(150) DEFAULT NULL,
  `transfer_date`   DATE         DEFAULT NULL,
  `remark`          TEXT         DEFAULT NULL,
  `created_at`      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

function esc($c,$v){ return mysqli_real_escape_string($c, trim($v??'')); }

$halo_id         = esc($conn,$_POST['halo_id']          ?? '');
$serial_number   = esc($conn,$_POST['serial_number']    ?? '');
$device_type     = esc($conn,$_POST['device_type']      ?? '');
$brand           = esc($conn,$_POST['brand']            ?? '');
$model           = esc($conn,$_POST['model']            ?? '');
$source_table    = esc($conn,$_POST['source_table']     ?? '');
$from_username   = esc($conn,$_POST['from_username']    ?? '');
$from_department = esc($conn,$_POST['from_department']  ?? '');
$from_team       = esc($conn,$_POST['from_team']        ?? '');
$from_ins_number = esc($conn,$_POST['from_ins_number']  ?? '');
$from_location   = esc($conn,$_POST['from_location']    ?? '');
$to_username     = esc($conn,$_POST['to_username']      ?? '');
$to_department   = esc($conn,$_POST['to_department']    ?? '');
$to_team         = esc($conn,$_POST['to_team']          ?? '');
$to_ins_number   = esc($conn,$_POST['to_ins_number']    ?? '');
$to_location     = esc($conn,$_POST['to_location']      ?? '');
$transfer_date   = esc($conn,$_POST['transfer_date']    ?? '');
$remark          = esc($conn,$_POST['remark']           ?? '');
$td = ($transfer_date!=='') ? "'$transfer_date'" : "NULL";

// 1. Log transfer record
$sql = "INSERT INTO device_transfers
  (halo_id,serial_number,device_type,brand,model,source_table,
   from_username,from_department,from_team,from_ins_number,from_location,
   to_username,to_department,to_team,to_ins_number,to_location,
   transfer_date,remark)
  VALUES
  ('$halo_id','$serial_number','$device_type','$brand','$model','$source_table',
   '$from_username','$from_department','$from_team','$from_ins_number','$from_location',
   '$to_username','$to_department','$to_team','$to_ins_number','$to_location',
   $td,'$remark')";

if(!mysqli_query($conn,$sql)){
echo json_encode(['status'=>'error','msg'=>'Log failed: '.mysqli_error($conn)]); exit();
}

// 2. Update the device's actual record table with new owner info
$allowed_tables = ['laptops','desktops','tablets','phones','monitors','dgps','powerbanks'];
if(!empty($source_table) && in_array($source_table,$allowed_tables) && !empty($halo_id)){
$update_sql = "UPDATE `$source_table` SET
        username       = '$to_username',
        department     = '$to_department',
        team           = '$to_team',
        ins_number     = '$to_ins_number',
        location_local = '$to_location'
      WHERE halo_id = '$halo_id'";
$updated = mysqli_query($conn,$update_sql);
$affected = mysqli_affected_rows($conn);
echo json_encode([
'status'=>'saved',
'updated_rows'=>$affected,
'msg'=>"Transfer logged. Device record updated ($affected row)."
]);
} else {
echo json_encode(['status'=>'saved','msg'=>'Transfer logged. (Device table not updated — no source table)']);
}

mysqli_close($conn);