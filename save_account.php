<?php
session_start();
if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['status'=>'error','msg'=>'Unauthorized']); exit();
}

ini_set("display_errors",0);
error_reporting(0);
mysqli_report(MYSQLI_REPORT_OFF);
header('Content-Type: application/json; charset=utf-8');
require_once 'config.php';
if(!$conn){echo json_encode(['status'=>'error','msg'=>'DB connect failed: '.mysqli_connect_error()]);exit();}
function esc($c,$v){return mysqli_real_escape_string($c,trim($v??''));}
$full_name    =esc($conn,$_POST['username']   ??'');
$email_type   =esc($conn,$_POST['email_type'] ??'');
$status       =esc($conn,$_POST['status']     ??'actived');
$primary_email=esc($conn,$_POST['email_1']    ??'');
$password     =esc($conn,$_POST['password']   ??'');
$second_email =esc($conn,$_POST['email_2']    ??'');
$third_email  =esc($conn,$_POST['email_3']    ??'');
$department   =esc($conn,$_POST['department'] ??'');
$team         =esc($conn,$_POST['team']       ??'');
$phone        =esc($conn,$_POST['phone']      ??'');
$ins_number   =esc($conn,$_POST['ins_number'] ??'');
$halo_device  =esc($conn,$_POST['halo_id']    ??'');
$remark       =esc($conn,$_POST['remark']     ??'');
$table_map=['Office 365'=>'office365_accounts','Survey 123'=>'survey123_accounts','Google account'=>'google_accounts','Trimble account'=>'trimble_accounts'];
$table=$table_map[$email_type]??'office365_accounts';

// Create table if not exists
@mysqli_query($conn,"CREATE TABLE IF NOT EXISTS `$table` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `full_name` VARCHAR(255),
  `account_type` VARCHAR(100),
  `account_status` VARCHAR(50) DEFAULT 'actived',
  `primary_email` VARCHAR(255),
  `password` VARCHAR(255),
  `second_email` VARCHAR(255),
  `third_email` VARCHAR(255),
  `department` VARCHAR(100),
  `team` VARCHAR(100),
  `phone` VARCHAR(50),
  `ins_number` VARCHAR(100),
  `halo_device_number` VARCHAR(100),
  `remark` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

$sql="INSERT INTO `$table`(full_name,account_type,account_status,primary_email,password,second_email,third_email,department,team,phone,ins_number,halo_device_number,remark)VALUES('$full_name','$email_type','$status','$primary_email','$password','$second_email','$third_email','$department','$team','$phone','$ins_number','$halo_device','$remark')";
if(mysqli_query($conn,$sql)){echo json_encode(['status'=>'saved']);}
else{echo json_encode(['status'=>'error','msg'=>mysqli_error($conn)]);}
mysqli_close($conn);