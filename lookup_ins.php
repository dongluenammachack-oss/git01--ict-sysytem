<?php
// Dedicated INS Number lookup endpoint
session_start();
ini_set('display_errors', 0);
error_reporting(0);
mysqli_report(MYSQLI_REPORT_OFF);

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-cache');

// Must be logged in
if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
    echo json_encode(['status'=>'error','msg'=>'Unauthorized']);
    exit();
}

require_once 'config.php';

if (!$conn) {
    echo json_encode(['status'=>'error','msg'=>'DB connection failed']);
    exit();
}

$ins = trim($_GET['ins_number'] ?? '');

if (empty($ins)) {
    echo json_encode(['status'=>'error','msg'=>'No INS Number provided']);
    exit();
}

$ins_esc = mysqli_real_escape_string($conn, $ins);
$found = null;

// 1. Search employees table first
$te = @mysqli_query($conn, "SHOW TABLES LIKE 'employees'");
if ($te && mysqli_num_rows($te) > 0) {
    $re = @mysqli_query($conn,
        "SELECT username, department, team, ins_number, location
         FROM employees WHERE ins_number='$ins_esc' LIMIT 1"
    );
    if ($re && mysqli_num_rows($re) > 0) {
        $found = mysqli_fetch_assoc($re);
        $found['source'] = 'employees';
    }
}

// 2. Search device tables (laptops, desktops, etc.)
if (!$found) {
    $dev_tables = ['laptops','desktops','tablets','phones','monitors','dgps','powerbanks'];
    foreach ($dev_tables as $tbl) {
        $tc = @mysqli_query($conn, "SHOW TABLES LIKE '$tbl'");
        if (!$tc || mysqli_num_rows($tc) == 0) continue;
        $rd = @mysqli_query($conn,
            "SELECT username, department, team, ins_number,
                    location_local AS location
             FROM `$tbl` WHERE ins_number='$ins_esc' LIMIT 1"
        );
        if ($rd && mysqli_num_rows($rd) > 0) {
            $found = mysqli_fetch_assoc($rd);
            $found['source'] = $tbl;
            break;
        }
    }
}

// 3. Search account tables
if (!$found) {
    $acc_tables = ['office365_accounts','survey123_accounts','google_accounts','trimble_accounts'];
    foreach ($acc_tables as $tbl) {
        $tc = @mysqli_query($conn, "SHOW TABLES LIKE '$tbl'");
        if (!$tc || mysqli_num_rows($tc) == 0) continue;
        $ra = @mysqli_query($conn,
            "SELECT full_name AS username, department, team, ins_number
             FROM `$tbl` WHERE ins_number='$ins_esc' LIMIT 1"
        );
        if ($ra && mysqli_num_rows($ra) > 0) {
            $found = mysqli_fetch_assoc($ra);
            $found['source'] = $tbl;
            break;
        }
    }
}

if ($found) {
    echo json_encode(['status' => 'found', 'data' => $found]);
} else {
    echo json_encode(['status' => 'not_found', 'msg' => 'No user found with INS: ' . $ins]);
}
?>