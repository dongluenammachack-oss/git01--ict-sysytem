<?php
ini_set('display_errors', 0);
error_reporting(0);
mysqli_report(MYSQLI_REPORT_OFF);

// Auto-detect environment
$is_local = in_array($_SERVER['SERVER_NAME'] ?? '', ['localhost', '127.0.0.1'])
         || strpos($_SERVER['HTTP_HOST'] ?? '', '192.168.') === 0
         || strpos($_SERVER['HTTP_HOST'] ?? '', 'localhost') !== false;

if ($is_local) {
    // Local XAMPP
    $host = "localhost";
    $user = "root";
    $pass = "";
    $db   = "ict_system";
} else {
    // InfinityFree hosting
    $host = "sql106.infinityfree.com";
    $user = "if0_42162854";
    $pass = "PFwWfoivEmS";
    $db   = "if0_42162854_ictsystem";
}

$conn = @mysqli_connect($host, $user, $pass, $db);

if ($conn) {
    mysqli_set_charset($conn, 'utf8mb4');
    mysqli_query($conn, "SET NAMES 'utf8mb4' COLLATE 'utf8mb4_unicode_ci'");
} else {
    $conn = null;
}
?>