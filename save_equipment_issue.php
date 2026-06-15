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

// Auto-create table with new schema
@mysqli_query($conn, "CREATE TABLE IF NOT EXISTS `equipment_issues` (
  `id`          INT(11)      NOT NULL AUTO_INCREMENT,
  `username`    VARCHAR(150) DEFAULT '',
  `ins_number`  VARCHAR(100) DEFAULT '',
  `department`  VARCHAR(100) DEFAULT '',
  `team`        VARCHAR(100) DEFAULT '',
  `e_id`        VARCHAR(100) DEFAULT '',
  `eng_name`    VARCHAR(255) DEFAULT '',
  `lao_name`    VARCHAR(255) DEFAULT '',
  `quantity`    INT(11)      DEFAULT 0,
  `in_stock`    INT(11)      DEFAULT 0,
  `e_old_stock` INT(11)      DEFAULT 0,
  `type`        VARCHAR(100) DEFAULT '',
  `date_out`    DATE         DEFAULT NULL,
  `created_at`  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

// Add columns if missing (for existing tables)
@mysqli_query($conn, "ALTER TABLE `equipment_issues` ADD COLUMN IF NOT EXISTS `team` VARCHAR(100) DEFAULT ''");
@mysqli_query($conn, "ALTER TABLE `equipment_issues` ADD COLUMN IF NOT EXISTS `quantity` INT(11) DEFAULT 0");
@mysqli_query($conn, "ALTER TABLE `equipment_issues` ADD COLUMN IF NOT EXISTS `in_stock` INT(11) DEFAULT 0");
@mysqli_query($conn, "ALTER TABLE `equipment_issues` ADD COLUMN IF NOT EXISTS `e_old_stock` INT(11) DEFAULT 0");
@mysqli_query($conn, "ALTER TABLE `equipment_issues` ADD COLUMN IF NOT EXISTS `date_out` DATE DEFAULT NULL");

function esc($c, $v) { return mysqli_real_escape_string($c, trim($v ?? '')); }

$username    = esc($conn, $_POST['username']    ?? '');
$ins_number  = esc($conn, $_POST['ins_number']  ?? '');
$department  = esc($conn, $_POST['department']  ?? '');
$team        = esc($conn, $_POST['team']        ?? '');
$e_id        = esc($conn, $_POST['e_id']        ?? '');
$eng_name    = esc($conn, $_POST['eng_name']    ?? '');
$lao_name    = esc($conn, $_POST['lao_name']    ?? '');
$quantity    = (int)($_POST['quantity']    ?? 0);
$in_stock    = (int)($_POST['in_stock']    ?? 0);
$e_old_stock = (int)($_POST['e_old_stock'] ?? 0);
$type        = esc($conn, $_POST['type']        ?? '');
$date_out    = esc($conn, $_POST['date_out']    ?? '');
$do = ($date_out !== '') ? "'$date_out'" : "NULL";

if ($quantity <= 0) {
    echo json_encode(['status' => 'error', 'msg' => 'Quantity must be greater than 0']);
    exit();
}

// Check current stock then deduct both all_stock and e_new (E OldStock)
$tc = @mysqli_query($conn, "SHOW TABLES LIKE 'equipment_stock'");
if ($tc && mysqli_num_rows($tc) > 0) {
    $rs = @mysqli_query($conn, "SELECT all_stock, e_new FROM equipment_stock WHERE e_id='$e_id' LIMIT 1");
    if ($rs && mysqli_num_rows($rs) > 0) {
        $cur      = mysqli_fetch_assoc($rs);
        $cur_all  = (int)$cur['all_stock'];
        $cur_enew = (int)$cur['e_new'];
        if ($quantity > $cur_all) {
            echo json_encode(['status' => 'error', 'msg' => "Stock insufficient. Available: $cur_all, Requested: $quantity"]);
            exit();
        }
        $new_all  = max(0, $cur_all  - $quantity);
        $new_enew = max(0, $cur_enew - $quantity);
        @mysqli_query($conn, "UPDATE equipment_stock SET all_stock=$new_all, e_new=$new_enew WHERE e_id='$e_id'");
    }
}

$sql = "INSERT INTO equipment_issues
        (username, ins_number, department, team, e_id, eng_name, lao_name, quantity, in_stock, e_old_stock, type, date_out)
        VALUES ('$username','$ins_number','$department','$team','$e_id','$eng_name','$lao_name',$quantity,$in_stock,$e_old_stock,'$type',$do)";

if (mysqli_query($conn, $sql)) {
    echo json_encode(['status' => 'saved']);
} else {
    echo json_encode(['status' => 'error', 'msg' => 'INSERT failed: ' . mysqli_error($conn)]);
}

mysqli_close($conn);
?>
