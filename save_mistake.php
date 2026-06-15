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

// Auto-create table if not exists
@mysqli_query($conn,"CREATE TABLE IF NOT EXISTS `device_mistakes` (
  `id`            INT(11) NOT NULL AUTO_INCREMENT,
  `serial_number` VARCHAR(150) DEFAULT NULL,
  `halo_id`       VARCHAR(100) DEFAULT NULL,
  `ins_number`    VARCHAR(100) DEFAULT NULL,
  `username`      VARCHAR(150) DEFAULT NULL,
  `department`    VARCHAR(100) DEFAULT NULL,
  `team`          VARCHAR(100) DEFAULT NULL,
  `date_turn`     DATE         DEFAULT NULL,
  `problem_case`  VARCHAR(255) DEFAULT NULL,
  `remark`        TEXT         DEFAULT NULL,
  `created_at`    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

function esc($c,$v){ return mysqli_real_escape_string($c,trim($v??'')); }

$mistake_id    = esc($conn,$_POST['mistake_id']   ?? '');
$serial_number = esc($conn,$_POST['serial_number'] ?? '');
$halo_id       = esc($conn,$_POST['halo_id']       ?? '');
$ins_number    = esc($conn,$_POST['ins_number']    ?? '');
$username      = esc($conn,$_POST['username']      ?? '');
$department    = esc($conn,$_POST['department']    ?? '');
$team          = esc($conn,$_POST['team']          ?? '');
$date_turn     = esc($conn,$_POST['date_turn']     ?? '');
$problem_case  = esc($conn,$_POST['problem_case']  ?? '');
$remark        = esc($conn,$_POST['remark']        ?? '');
$dt = ($date_turn!=='') ? "'$date_turn'" : "NULL";

// UPDATE
if(!empty($mistake_id)){
$sql="UPDATE device_mistakes SET
    serial_number='$serial_number', halo_id='$halo_id', ins_number='$ins_number',
    username='$username', department='$department', team='$team',
    date_turn=$dt, problem_case='$problem_case', remark='$remark'
  WHERE id='$mistake_id'";
if(mysqli_query($conn,$sql)){ echo json_encode(['status'=>'updated']); }
else { echo json_encode(['status'=>'error','msg'=>'UPDATE failed: '.mysqli_error($conn)]); }
// INSERT
} else {
$sql="INSERT INTO device_mistakes
    (serial_number,halo_id,ins_number,username,department,team,date_turn,problem_case,remark)
    VALUES('$serial_number','$halo_id','$ins_number','$username','$department','$team',$dt,'$problem_case','$remark')";
if(mysqli_query($conn,$sql)){ echo json_encode(['status'=>'saved']); }
else { echo json_encode(['status'=>'error','msg'=>'INSERT failed: '.mysqli_error($conn)]); }
}
mysqli_close($conn);