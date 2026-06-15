<?php
session_start();
if (!isset($_SESSION['logged_in']) || $_SESSION['logged_in'] !== true) {
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['status'=>'error','msg'=>'Unauthorized']); exit();
}

ini_set('display_errors', 0);
error_reporting(0);
mysqli_report(MYSQLI_REPORT_OFF);
header('Content-Type: application/json; charset=utf-8');

require_once 'config.php';
if (!$conn) {
    echo json_encode(['status' => 'error', 'msg' => 'DB connect failed']);
    exit();
}

// Auto-create/alter table
@mysqli_query($conn, "CREATE TABLE IF NOT EXISTS `equipment_stock` (
  `id`         INT(11)      NOT NULL AUTO_INCREMENT,
  `e_id`       VARCHAR(100) NOT NULL DEFAULT '',
  `eng_name`   VARCHAR(255) DEFAULT '',
  `lao_name`   VARCHAR(255) DEFAULT '',
  `e_new`      INT(11)      DEFAULT 0,
  `all_stock`  INT(11)      DEFAULT 0,
  `type`       VARCHAR(100) DEFAULT '',
  `date_in`    DATE         DEFAULT NULL,
  `created_at` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

// Add date_in column if missing (for existing tables)
@mysqli_query($conn, "ALTER TABLE `equipment_stock` ADD COLUMN IF NOT EXISTS `date_in` DATE DEFAULT NULL");

function esc($c, $v) { return mysqli_real_escape_string($c, trim($v ?? '')); }

$eq_id    = esc($conn, $_POST['eq_id']    ?? '');
$e_id     = esc($conn, $_POST['e_id']     ?? '');
$eng_name = esc($conn, $_POST['eng_name'] ?? '');
$lao_name = esc($conn, $_POST['lao_name'] ?? '');
$e_new    = (int)($_POST['e_new']    ?? 0);
$all_stock = max(0, $e_new);
$type     = esc($conn, $_POST['type']     ?? '');
$date_in  = esc($conn, $_POST['date_in']  ?? '');
$di = ($date_in !== '') ? "'$date_in'" : "NULL";

if (!empty($eq_id)) {
    // Fetch current e_new and all_stock to compute the delta
    $rs = @mysqli_query($conn, "SELECT e_new, all_stock FROM equipment_stock WHERE id='$eq_id' LIMIT 1");
    $old_e_new   = 0;
    $old_all     = 0;
    if ($rs && mysqli_num_rows($rs) > 0) {
        $old = mysqli_fetch_assoc($rs);
        $old_e_new = (int)$old['e_new'];
        $old_all   = (int)$old['all_stock'];
    }
    // all_stock = old_all + (new e_new - old e_new), clamped to >= 0
    $delta     = $e_new - $old_e_new;
    $new_all   = max(0, $old_all + $delta);

    $sql = "UPDATE equipment_stock SET
            e_id='$e_id', eng_name='$eng_name', lao_name='$lao_name',
            e_new=$e_new, all_stock=$new_all, type='$type', date_in=$di
            WHERE id='$eq_id'";
    if (mysqli_query($conn, $sql)) {
        echo json_encode(['status' => 'updated']);
    } else {
        echo json_encode(['status' => 'error', 'msg' => 'UPDATE failed: ' . mysqli_error($conn)]);
    }
} else {
    $sql = "INSERT INTO equipment_stock (e_id, eng_name, lao_name, e_new, all_stock, type, date_in)
            VALUES ('$e_id', '$eng_name', '$lao_name', $e_new, $all_stock, '$type', $di)";
    if (mysqli_query($conn, $sql)) {
        echo json_encode(['status' => 'saved']);
    } else {
        echo json_encode(['status' => 'error', 'msg' => 'INSERT failed: ' . mysqli_error($conn)]);
    }
}

mysqli_close($conn);
?>
