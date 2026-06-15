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
$id           =esc($conn,$_POST['update_id']    ??'');
$table        =esc($conn,$_POST['update_table'] ??'');
$full_name    =esc($conn,$_POST['username']     ??'');
$email_type   =esc($conn,$_POST['email_type']   ??'');
$status       =esc($conn,$_POST['status']       ??'actived');
$primary_email=esc($conn,$_POST['email_1']      ??'');
$password     =esc($conn,$_POST['password']     ??'');
$second_email =esc($conn,$_POST['email_2']      ??'');
$third_email  =esc($conn,$_POST['email_3']      ??'');
$department   =esc($conn,$_POST['department']   ??'');
$team         =esc($conn,$_POST['team']         ??'');
$phone        =esc($conn,$_POST['phone']        ??'');
$ins_number   =esc($conn,$_POST['ins_number']   ??'');
$halo_device  =esc($conn,$_POST['halo_id']      ??'');
$remark       =esc($conn,$_POST['remark']       ??'');
$allowed=['office365_accounts','survey123_accounts','google_accounts','trimble_accounts'];
if(!in_array($table,$allowed)||empty($id)){
    echo json_encode(['status'=>'error','msg'=>'Invalid table or ID']);exit();
}

// Add remark column if missing
@mysqli_query($conn,"ALTER TABLE `$table` ADD COLUMN IF NOT EXISTS `remark` TEXT");

$sql="UPDATE `$table` SET 
    full_name='$full_name',
    account_type='$email_type',
    account_status='$status',
    primary_email='$primary_email',
    password='$password',
    second_email='$second_email',
    third_email='$third_email',
    department='$department',
    team='$team',
    phone='$phone',
    ins_number='$ins_number',
    halo_device_number='$halo_device',
    remark='$remark'
    WHERE id='$id'";
if(mysqli_query($conn,$sql)){echo json_encode(['status'=>'updated']);}
else{echo json_encode(['status'=>'error','msg'=>mysqli_error($conn)]);}
mysqli_close($conn);