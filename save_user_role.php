<?php
session_start();
ini_set('display_errors', 0);
error_reporting(0);
mysqli_report(MYSQLI_REPORT_OFF);
header('Content-Type: application/json; charset=utf-8');

// Admin only
if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
    echo json_encode(['status'=>'error','msg'=>'Unauthorized']); exit();
}
$role_check = strtolower($_SESSION['role'] ?? '');
$is_admin = ($role_check === 'admin' || $_SESSION['username'] === 'Admin ICT');
if (!$is_admin) {
    echo json_encode(['status'=>'error','msg'=>'Access denied']); exit();
}

require_once 'config.php';
if (!$conn) { echo json_encode(['status'=>'error','msg'=>'DB failed']); exit(); }

$id = (int)($_POST['id'] ?? 0);
if ($id <= 0) { echo json_encode(['status'=>'error','msg'=>'Invalid ID']); exit(); }

// Update role
if (isset($_POST['role'])) {
    $new_role = in_array($_POST['role'], ['admin','user']) ? $_POST['role'] : 'user';
    $ok = mysqli_query($conn, "UPDATE system_users SET role='$new_role' WHERE id=$id");
    echo json_encode($ok ? ['status'=>'ok'] : ['status'=>'error','msg'=>mysqli_error($conn)]);
    exit();
}

// Toggle access (is_verified)
if (isset($_POST['is_verified'])) {
    $val = (int)$_POST['is_verified'] === 1 ? 1 : 0;
    $ok = mysqli_query($conn, "UPDATE system_users SET is_verified=$val WHERE id=$id");
    echo json_encode($ok ? ['status'=>'ok'] : ['status'=>'error','msg'=>mysqli_error($conn)]);
    exit();
}

// Reset password (Admin reset for any user)
if (isset($_POST['new_password'])) {
    $new_pw = trim($_POST['new_password'] ?? '');
    if (strlen($new_pw) < 6) {
        echo json_encode(['status'=>'error','msg'=>'Password must be at least 6 characters']); exit();
    }
    $hashed = password_hash($new_pw, PASSWORD_DEFAULT);
    $hashed_esc = mysqli_real_escape_string($conn, $hashed);
    $ok = mysqli_query($conn, "UPDATE system_users SET password='$hashed_esc' WHERE id=$id");
    echo json_encode($ok ? ['status'=>'ok'] : ['status'=>'error','msg'=>mysqli_error($conn)]);
    exit();
}

// Update permissions (can_edit, can_delete, view_only)
if (isset($_POST['perm']) && isset($_POST['val'])) {    $allowed_perms = ['can_edit','can_delete','view_only'];
    $perm = $_POST['perm'];
    if (!in_array($perm, $allowed_perms)) {
        echo json_encode(['status'=>'error','msg'=>'Invalid permission']); exit();
    }
    $val = (int)$_POST['val'] === 1 ? 1 : 0;

    // Create table if not exists
    @mysqli_query($conn,"CREATE TABLE IF NOT EXISTS `user_permissions` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `user_id` INT NOT NULL UNIQUE,
        `can_edit` TINYINT(1) DEFAULT 1,
        `can_delete` TINYINT(1) DEFAULT 0,
        `view_only` TINYINT(1) DEFAULT 0,
        `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

    // If view_only ON: set can_edit=0, can_delete=0
    if ($perm === 'view_only' && $val === 1) {
        $sql = "INSERT INTO user_permissions (user_id,can_edit,can_delete,view_only) VALUES($id,0,0,1)
                ON DUPLICATE KEY UPDATE can_edit=0, can_delete=0, view_only=1";
    } else {
        $sql = "INSERT INTO user_permissions (user_id,$perm) VALUES($id,$val)
                ON DUPLICATE KEY UPDATE $perm=$val";
    }

    $ok = mysqli_query($conn, $sql);
    echo json_encode($ok ? ['status'=>'ok'] : ['status'=>'error','msg'=>mysqli_error($conn)]);
    exit();
}

echo json_encode(['status'=>'error','msg'=>'No action specified']);
?>