﻿<?php
// ════════════════════════════════════════════════════
//  register.php — TOTP Registration (Fixed)
// ════════════════════════════════════════════════════
ini_set('display_errors', 0);
error_reporting(0);
ini_set('display_startup_errors', 0);

// Session config ກ່ອນ session_start
ini_set('session.use_cookies', 1);
ini_set('session.use_only_cookies', 1);
ini_set('session.cookie_httponly', 1);
ini_set('session.cookie_samesite', 'Lax');
ini_set('session.gc_maxlifetime', 1800);

session_start();

// Only set JSON header when this file is called directly (not required)
if (basename($_SERVER['SCRIPT_FILENAME']) === 'register.php') {
    header('Content-Type: application/json; charset=utf-8');
    header('Cache-Control: no-cache, no-store');
}

function jsonOut(array $data): void {
    while (ob_get_level() > 0) ob_end_clean();
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($data, JSON_UNESCAPED_UNICODE);
    exit();
}

// ════ DB ════
require_once 'config.php';
mysqli_set_charset($conn, 'utf8mb4');

@mysqli_query($conn, "CREATE TABLE IF NOT EXISTS `system_users` (
    `id`          INT AUTO_INCREMENT PRIMARY KEY,
    `full_name`   VARCHAR(255) NOT NULL,
    `email`       VARCHAR(255) NOT NULL UNIQUE,
    `password`    VARCHAR(255) NOT NULL,
    `totp_secret` VARCHAR(64)  DEFAULT '',
    `is_verified` TINYINT(1)   DEFAULT 0,
    `role`        VARCHAR(50)  DEFAULT 'user',
    `created_at`  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

// ════ TOTP HELPERS ════
function generateTOTPSecret(): string {
$chars  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
$bytes  = random_bytes(20);
$secret = '';
$n = 0; $bits = 0;
for ($i = 0; $i < 20; $i++) {
$n    = ($n << 8) | ord($bytes[$i]);
$bits += 8;
while ($bits >= 5) {
$bits   -= 5;
$secret .= $chars[($n >> $bits) & 0x1F];
}
}
return $secret;
}

function base32Decode(string $s): string {
$chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
$s     = strtoupper(preg_replace('/[\s=]+/', '', $s));
$n = 0; $bits = 0; $out = '';
for ($i = 0, $len = strlen($s); $i < $len; $i++) {
$pos = strpos($chars, $s[$i]);
if ($pos === false) continue;
$n    = ($n << 5) | $pos;
$bits += 5;
if ($bits >= 8) {
$bits -= 8;
$out  .= chr(($n >> $bits) & 0xFF);
}
}
return $out;
}

function generateTOTP(string $secret, int $counter): string {
$key  = base32Decode($secret);
$msg  = "\x00\x00\x00\x00" . pack('N', $counter);
$hash = hash_hmac('sha1', $msg, $key, true);
$off  = ord($hash[19]) & 0x0F;
$code = (
((ord($hash[$off])     & 0x7F) << 24) |
((ord($hash[$off + 1]) & 0xFF) << 16) |
((ord($hash[$off + 2]) & 0xFF) <<  8) |
((ord($hash[$off + 3]) & 0xFF))
) % 1000000;
return str_pad((string)$code, 6, '0', STR_PAD_LEFT);
}

function verifyTOTP(string $secret, string $code): bool {
$counter = (int)floor(time() / 30);
for ($i = -4; $i <= 4; $i++) {
if (generateTOTP($secret, $counter + $i) === $code) return true;
}
return false;
}

function buildOtpAuthUri(string $secret, string $email): string {
$issuer = 'ICT HALO Laos';
return 'otpauth://totp/'
. rawurlencode($issuer . ':' . $email)
. '?secret='  . $secret
. '&issuer='  . rawurlencode($issuer)
. '&algorithm=SHA1&digits=6&period=30';
}

// ════ ACTION ════
$action = trim($_POST['action'] ?? $_GET['action'] ?? '');

// ── DEBUG ──
if ($action === 'debug_session') {
jsonOut([
'status'      => 'debug',
'session_id'  => session_id(),
'has_pending' => isset($_SESSION['reg_pending']),
'server_time' => time(),
'counter'     => (int)floor(time() / 30),
'current_otp' => isset($_SESSION['reg_pending']['totp_secret'])
? generateTOTP($_SESSION['reg_pending']['totp_secret'], (int)floor(time() / 30))
: 'no_session',
]);
}

// ── STEP 1: request_totp ──
if ($action === 'request_totp') {
$full_name = trim($_POST['full_name'] ?? '');
$email     = trim($_POST['email']     ?? '');
$password  = trim($_POST['password']  ?? '');

if (!$full_name || !$email || !$password)
    jsonOut(['status' => 'error', 'msg' => 'Please complete all required fields']);
if (!filter_var($email, FILTER_VALIDATE_EMAIL))
    jsonOut(['status' => 'error', 'msg' => 'Please enter a valid email address']);
if (mb_strlen($password) < 6)
    jsonOut(['status' => 'error', 'msg' => 'Minimum 6 characters required']);

$em  = mysqli_real_escape_string($conn, $email);
$chk = @mysqli_query($conn, "SELECT id FROM system_users WHERE email='$em' LIMIT 1");
if ($chk && mysqli_num_rows($chk) > 0)
    jsonOut(['status' => 'error', 'msg' => 'Email This is already in use']);

$secret = generateTOTPSecret();

// ✅ ບັນທຶກ session ໃໝ່
$_SESSION['reg_pending'] = [
'full_name'   => $full_name,
'email'       => $email,
'password'    => password_hash($password, PASSWORD_BCRYPT),
'totp_secret' => $secret,
'expiry'      => time() + 900,
];

// ✅ ຢ່າໃຊ້ session_write_close() ຕໍ່ when verify_totp ຕ້ອງອ່ານ session ຄືນ
// session_write_close(); <-- ລຶບອອກໄປ

jsonOut([
'status'  => 'show_qr',
'otp_uri' => buildOtpAuthUri($secret, $email),
'secret'  => $secret,
'email'   => $email,
]);
}

// ── STEP 2: verify_totp ──
if ($action === 'verify_totp') {
$code = preg_replace('/\D/', '', trim($_POST['code'] ?? ''));

// ✅ ກວດ session ກ່ອນ
if (!isset($_SESSION['reg_pending']) || empty($_SESSION['reg_pending'])) {
jsonOut(['status' => 'error', 'msg' => 'Session expired — Please refresh the page and register again']);
}

$p = $_SESSION['reg_pending'];

if (time() > ($p['expiry'] ?? 0)) {
unset($_SESSION['reg_pending']);
jsonOut(['status' => 'error', 'msg' => 'Session expired after 15 minutes — Please register again']);
}

if (strlen($code) !== 6) {
jsonOut(['status' => 'error', 'msg' => 'Please enter the full 6-digit code']);
}

if (!verifyTOTP($p['totp_secret'], $code)) {
$counter = (int)floor(time() / 30);
jsonOut([
'status'       => 'error',
'msg'          => 'Invalid Authenticator code — Please wait for a new code and try again',
'_dbg_time'    => time(),
'_dbg_counter' => $counter,
'_dbg_entered' => $code,
'_dbg_expect'  => generateTOTP($p['totp_secret'], $counter),
]);
}

// ✅ Insert ຜູ້ໃຊ້ໃໝ່
$fn = mysqli_real_escape_string($conn, $p['full_name']);
$em = mysqli_real_escape_string($conn, $p['email']);
$pw = mysqli_real_escape_string($conn, $p['password']);
$sc = mysqli_real_escape_string($conn, $p['totp_secret']);

$ins = @mysqli_query($conn,
"INSERT INTO system_users (full_name, email, password, totp_secret, is_verified, role)
VALUES ('$fn','$em','$pw','$sc', 1, 'user')"
);

// Auto-set default permissions: can_delete=0 for new users
if ($ins) {
    $new_uid = (int)mysqli_insert_id($conn);
    if ($new_uid > 0) {
        // Create table if not exists
        @mysqli_query($conn,"CREATE TABLE IF NOT EXISTS `user_permissions` (
            `id` INT AUTO_INCREMENT PRIMARY KEY,
            `user_id` INT NOT NULL UNIQUE,
            `can_edit` TINYINT(1) DEFAULT 1,
            `can_delete` TINYINT(1) DEFAULT 0,
            `view_only` TINYINT(1) DEFAULT 0,
            `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

        // Insert default: can_edit=1, can_delete=0
        @mysqli_query($conn, "INSERT IGNORE INTO user_permissions (user_id, can_edit, can_delete, view_only) VALUES ($new_uid, 1, 0, 0)");
    }
}

if ($ins) {
unset($_SESSION['reg_pending']);
jsonOut(['status' => 'registered', 'msg' => 'Registration successful! Please log in']);
} else {
jsonOut(['status' => 'error', 'msg' => 'DB error: ' . mysqli_error($conn)]);
}
}

jsonOut(['status' => 'error', 'msg' => 'Unknown action: ' . $action]);
