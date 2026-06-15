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

// Auto-create table if not exists
@mysqli_query($conn, "CREATE TABLE IF NOT EXISTS `card_records` (
  `id`          INT(11)      NOT NULL AUTO_INCREMENT,
  `ins_number`  VARCHAR(100) DEFAULT NULL,
  `username`    VARCHAR(150) DEFAULT NULL,
  `department`  VARCHAR(100) DEFAULT NULL,
  `team`        VARCHAR(100) DEFAULT NULL,
  `card_number` VARCHAR(150) DEFAULT NULL,
  `price`       INT(11)      DEFAULT 0,
  `date_issue`  DATE         DEFAULT NULL,
  `remark`      TEXT         DEFAULT NULL,
  `created_at`  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

function esc($c, $v) { return mysqli_real_escape_string($c, trim($v ?? '')); }

$card_id     = esc($conn, $_POST['card_id']     ?? '');
$ins_number  = esc($conn, $_POST['ins_number']  ?? '');
$username    = esc($conn, $_POST['username']    ?? '');
$department  = esc($conn, $_POST['department']  ?? '');
$team        = esc($conn, $_POST['team']        ?? '');
$card_number = esc($conn, $_POST['card_number'] ?? '');
$price       = (int)($_POST['price'] ?? 0);
$date_issue  = esc($conn, $_POST['date_issue']  ?? '');
$remark      = esc($conn, $_POST['remark']      ?? '');
$di = ($date_issue !== '') ? "'$date_issue'" : "NULL";

// --- ສ່ວນທີ່ເພີ່ມໃໝ່: ກວດສອບການເບີກຊ້ຳ (ສະເພາະຕອນ INSERT ໃໝ່) ---
if (empty($card_id)) {
$current_month = date('m');
$current_year  = date('Y');

$check_query = "SELECT id FROM card_records 
                    WHERE ins_number = '$ins_number' 
                    AND price = '$price' 
                    AND MONTH(date_issue) = '$current_month' 
                    AND YEAR(date_issue) = '$current_year'";

$result_check = mysqli_query($conn, $check_query);

if (mysqli_num_rows($result_check) > 0) {
echo json_encode([
'status' => 'error', 
'msg' => 'Error: Your card is over the limit for this month.'
]);
exit;
}
}
// -------------------------------------------------------

// UPDATE
if (!empty($card_id)) {
$sql = "UPDATE card_records SET
        ins_number='$ins_number', username='$username', department='$department',
        team='$team', card_number='$card_number', price=$price,
        date_issue=$di, remark='$remark'
      WHERE id='$card_id'";
if (mysqli_query($conn, $sql)) {
echo json_encode(['status' => 'updated']);
} else {
echo json_encode(['status' => 'error', 'msg' => 'UPDATE failed: ' . mysqli_error($conn)]);
}
} 
// INSERT
else {
$sql = "INSERT INTO card_records
        (ins_number,username,department,team,card_number,price,date_issue,remark)
        VALUES('$ins_number','$username','$department','$team','$card_number',$price,$di,'$remark')";
if (mysqli_query($conn, $sql)) {
echo json_encode(['status' => 'saved']);
} else {
echo json_encode(['status' => 'error', 'msg' => 'INSERT failed: ' . mysqli_error($conn)]);
}
}

mysqli_close($conn);
?>