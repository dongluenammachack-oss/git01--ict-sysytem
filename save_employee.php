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

// Auto-create table
@mysqli_query($conn,"CREATE TABLE IF NOT EXISTS `employees` (
  `id`         INT(11)      NOT NULL AUTO_INCREMENT,
  `username`   VARCHAR(150) DEFAULT NULL,
  `ins_number` VARCHAR(100) DEFAULT NULL,
  `department` VARCHAR(100) DEFAULT NULL,
  `team`       VARCHAR(100) DEFAULT NULL,
  `location`   VARCHAR(150) DEFAULT NULL,
  `phone`      VARCHAR(50)  DEFAULT NULL,
  `created_at` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

function esc($c,$v){ return mysqli_real_escape_string($c,trim($v??'')); }

$employee_id = esc($conn,$_POST['employee_id'] ?? '');
$username    = esc($conn,$_POST['username']    ?? '');
$ins_number  = esc($conn,$_POST['ins_number']  ?? '');
$department  = esc($conn,$_POST['department']  ?? '');
$team        = esc($conn,$_POST['team']        ?? '');
$location    = esc($conn,$_POST['location']    ?? '');
$phone       = esc($conn,$_POST['phone']       ?? '');

if(!empty($employee_id)){
$sql="UPDATE employees SET username='$username',ins_number='$ins_number',
          department='$department',team='$team',location='$location',phone='$phone'
          WHERE id='$employee_id'";
if(mysqli_query($conn,$sql)){ echo json_encode(['status'=>'updated']); }
else { echo json_encode(['status'=>'error','msg'=>mysqli_error($conn)]); }
} else {
$sql="INSERT INTO employees(username,ins_number,department,team,location,phone)
          VALUES('$username','$ins_number','$department','$team','$location','$phone')";
if(mysqli_query($conn,$sql)){ echo json_encode(['status'=>'saved']); }
else { echo json_encode(['status'=>'error','msg'=>mysqli_error($conn)]); }
}
mysqli_close($conn);