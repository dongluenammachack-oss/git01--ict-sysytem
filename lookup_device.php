<?php
// Dedicated device lookup endpoint
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

$halo_id = trim($_GET['halo_id'] ?? '');

if (empty($halo_id)) {
    echo json_encode(['status'=>'error','msg'=>'No Halo ID provided']);
    exit();
}

$halo_id_esc = mysqli_real_escape_string($conn, $halo_id);

// Search in all device tables
$tables = [
    'Laptop'     => 'laptops',
    'Desktop'    => 'desktops',
    'Tablet'     => 'tablets',
    'Phone'      => 'phones',
    'Monitor'    => 'monitors',
    'DGPS'       => 'dgps',
    'PowerBank'  => 'powerbanks',
    'Printer'    => 'printers',
    'UPS'        => 'ups',
];

$found = null;

foreach ($tables as $dtype => $tbl) {
    // Check table exists
    $tc = @mysqli_query($conn, "SHOW TABLES LIKE '$tbl'");
    if (!$tc || mysqli_num_rows($tc) == 0) continue;

    $r = @mysqli_query($conn,
        "SELECT halo_id, serial_number, username, department, team,
                ins_number, brand, model, status, location_local
         FROM `$tbl`
         WHERE halo_id='$halo_id_esc'
         LIMIT 1"
    );

    if ($r && mysqli_num_rows($r) > 0) {
        $row = mysqli_fetch_assoc($r);
        $row['device_type']  = $dtype;
        $row['source_table'] = $tbl;
        $found = $row;
        break;
    }
}

if ($found) {
    echo json_encode(['status' => 'found', 'data' => $found]);
} else {
    echo json_encode(['status' => 'not_found', 'msg' => 'No device found with Halo ID: ' . $halo_id]);
}
?>