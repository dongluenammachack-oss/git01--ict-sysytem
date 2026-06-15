﻿<?php
ini_set('display_errors', 0);
error_reporting(0);
mysqli_report(MYSQLI_REPORT_OFF);

// Fix for InfinityFree "Cookies are not enabled" issue
ini_set('session.use_cookies', 1);
ini_set('session.use_only_cookies', 1);
ini_set('session.cookie_httponly', 1);
ini_set('session.use_strict_mode', 1);
ini_set('session.cookie_samesite', 'Lax');
ini_set('session.gc_maxlifetime', 3600);
ini_set('session.cookie_lifetime', 0);

// Set cookie params before session_start
session_set_cookie_params([
    'lifetime' => 0,
    'path'     => '/',
    'domain'   => '',
    'secure'   => isset($_SERVER['HTTPS']),
    'httponly' => true,
    'samesite' => 'Lax'
]);

session_start();
require_once 'translations.php';

/* ══════════════════════════════════════════════════════════════════════
AJAX HANDLER — reset password (embedded, no separate file needed)
ຮອງຮັບ POST ?ajax=reset  ຫຼື  POST action=request_reset|verify_totp
ໂດຍ fetch('login.php?ajax=reset', ...)
══════════════════════════════════════════════════════════════════════ */
if (isset($_GET['ajax']) && $_GET['ajax'] === 'reset' && $_SERVER['REQUEST_METHOD'] === 'POST') {
header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-cache, no-store, must-revalidate');

require_once 'config.php';
$conn2 = $conn;

/* ── TOTP helpers ── */
function b32decode(string $s): string {
$alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';
$s     = strtoupper(str_replace([' ','-'], '', $s));
$bits  = '';
foreach (str_split($s) as $c) {
$p = strpos($alpha, $c);
if ($p === false) continue;
$bits .= str_pad(decbin($p), 5, '0', STR_PAD_LEFT);
}
$out = '';
for ($i = 0; $i + 8 <= strlen($bits); $i += 8)
    $out .= chr(bindec(substr($bits, $i, 8)));
return $out;
}

function totpGen(string $raw, int $ts): string {
$key  = b32decode($raw);
$msg  = pack('N*', 0).pack('N*', $ts);
$hmac = hash_hmac('sha1', $msg, $key, true);
$off  = ord($hmac[strlen($hmac)-1]) & 0x0F;
$otp  = (
((ord($hmac[$off])   & 0x7F) << 24)|
((ord($hmac[$off+1]) & 0xFF) << 16)|
((ord($hmac[$off+2]) & 0xFF) <<  8)|
(ord($hmac[$off+3]) & 0xFF)
) % 1000000;
return str_pad((string)$otp, 6, '0', STR_PAD_LEFT);
}

function totpVerify(string $secret, string $code, int $w = 1): bool {
$ts = (int)floor(time()/30);
for ($i = -$w; $i <= $w; $i++)
    if (hash_equals(totpGen($secret, $ts+$i), $code)) return true;
return false;
}

function jExit(array $d): void { 
    echo json_encode($d, JSON_UNESCAPED_UNICODE); 
    exit; 
}

$action = trim($_POST['action'] ?? '');

/* ── ACTION 1: request_reset ── */
if ($action === 'request_reset') {
$email = trim($_POST['email'] ?? '');
$newPw = $_POST['new_password'] ?? '';
$cfPw  = $_POST['confirm_pw']   ?? '';

if (!$email || !$newPw || !$cfPw)
    jExit(['status'=>'error','msg'=>'Please fill in all required fields']);
if (!filter_var($email, FILTER_VALIDATE_EMAIL))
    jExit(['status'=>'error','msg'=>'Invalid email format']);
if (strlen($newPw) < 6)
    jExit(['status'=>'error','msg'=>'New password must be at least 6 characters']);
if ($newPw !== $cfPw)
    jExit(['status'=>'error','msg'=>'Passwords do not match']);
if (!$conn2)
    jExit(['status'=>'error','msg'=>'Cannot connect to database']);

$em  = mysqli_real_escape_string($conn2, $email);
$res = mysqli_query($conn2,
"SELECT id,totp_secret,is_verified FROM system_users WHERE email='$em' LIMIT 1");

if (!$res || mysqli_num_rows($res) === 0)
    jExit(['status'=>'error','msg'=>'Email not found in system']);

$row = mysqli_fetch_assoc($res);
if ((int)$row['is_verified'] !== 1)
    jExit(['status'=>'error','msg'=>'Account not verified']);
if (empty($row['totp_secret']))
    jExit(['status'=>'error','msg'=>'Account has no Authenticator setup']);

$_SESSION['rst_uid']    = (int)$row['id'];
$_SESSION['rst_secret'] = $row['totp_secret'];
$_SESSION['rst_pw']     = $newPw;
$_SESSION['rst_at']     = time();

jExit(['status'=>'need_totp','msg'=>'Please open Authenticator App and enter 6-digit code']);
}

/* ── ACTION 2: verify_totp ── */
if ($action === 'verify_totp') {
$code = trim($_POST['code'] ?? '');

if (empty($_SESSION['rst_uid']) || empty($_SESSION['rst_secret']) || empty($_SESSION['rst_pw']))
    jExit(['status'=>'error','msg'=>'Session expired, please start over']);
if (time() - (int)($_SESSION['rst_at'] ?? 0) > 300)
    jExit(['status'=>'error','msg'=>'Request expired (5 minutes), please start over']);
if (!ctype_digit($code) || strlen($code) !== 6)
    jExit(['status'=>'error','msg'=>'OTP code must be 6 digits']);
if (!totpVerify($_SESSION['rst_secret'], $code))
    jExit(['status'=>'error','msg'=>'Invalid OTP code - please try again']);
if (!$conn2)
    jExit(['status'=>'error','msg'=>'Cannot connect to database']);

$uid    = (int)$_SESSION['rst_uid'];
$hashed = mysqli_real_escape_string($conn2, password_hash($_SESSION['rst_pw'], PASSWORD_DEFAULT));
$ok     = mysqli_query($conn2, "UPDATE system_users SET password='$hashed' WHERE id=$uid LIMIT 1");

if (!$ok || mysqli_affected_rows($conn2) === 0)
    jExit(['status'=>'error','msg'=>'Cannot update password, please try again']);

unset($_SESSION['rst_uid'],$_SESSION['rst_secret'],$_SESSION['rst_pw'],$_SESSION['rst_at']);
jExit(['status'=>'success']);
}

jExit(['status'=>'error','msg'=>'Unknown action']);
}

/* ══════════════════════════════════════════════════════════════════════
NORMAL LOGIN PAGE
══════════════════════════════════════════════════════════════════════ */
if (isset($_SESSION['logged_in']) && $_SESSION['logged_in'] === true) {
header("Location: index.php"); exit();
}
require_once 'config.php';
$error = '';

if (!isset($_SESSION['login_fails'])) $_SESSION['login_fails'] = 0;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
$username = trim($_POST['username'] ?? '');
$password = trim($_POST['password'] ?? '');
$logged   = false;

if ($username === 'admin' && $password === 'password') {
$_SESSION['logged_in']   = true;
$_SESSION['username']    = 'Admin ICT';
$_SESSION['login_fails'] = 0;
$logged = true;
}

if (!$logged && $conn) {
$em  = mysqli_real_escape_string($conn, $username);
$chk = @mysqli_query($conn,
"SELECT id,full_name,email,password,is_verified FROM system_users WHERE email='$em' LIMIT 1");
if ($chk && mysqli_num_rows($chk) > 0) {
$row = mysqli_fetch_assoc($chk);
if ((int)$row['is_verified'] === 0) {
    // is_verified=0 means access blocked by admin
    $error = 'Your account access has been disabled. Please contact the system administrator.';
} elseif ((int)$row['is_verified'] === 1 && password_verify($password, $row['password'])) {
$_SESSION['logged_in']   = true;
$_SESSION['username']    = $row['full_name'];
$_SESSION['email']       = $row['email'];
$_SESSION['login_fails'] = 0;
$logged = true;
} else {
    $error = 'Incorrect username or password!';
}
}
}

if ($logged) {
    // Handle Remember Me — store the login email/username (what user typed), not the profile name
    if (!empty($_POST['remember_me'])) {
        $remember_val = base64_encode($username . '|' . time());
        setcookie('ict_remember', $remember_val, time() + (86400 * 30), '/', '', isset($_SERVER['HTTPS']), true);
    } else {
        // Clear remember cookie if not checked
        setcookie('ict_remember', '', time() - 3600, '/');
    }
    header("Location: index.php"); exit();
}
else {
$_SESSION['login_fails']++;
if (empty($error)) $error = 'Incorrect username or password!';
}
}

$showReset = ($_SESSION['login_fails'] >= 3);

// Pre-fill from remember cookie
$remember_checked  = false;
$remember_username = '';
if (!empty($_COOKIE['ict_remember'])) {
    $decoded = base64_decode($_COOKIE['ict_remember']);
    $parts   = explode('|', $decoded);
    if (count($parts) === 2 && (time() - (int)$parts[1]) < 86400 * 30) {
        $remember_checked  = true;
        $remember_username = htmlspecialchars($parts[0]);
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Login | ICT Control Center</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="modern-forms.css?v=<?php echo time(); ?>">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Lao:wght@300;400;600;700&family=Inter:wght@300;400;500;600;700;800;900&family=Geist+Mono:wght@400;500;600&display=swap" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
<script src="js-translations.js?v=<?php echo time(); ?>"></script>
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
html,body{height:100%;}
body{font-family:'Inter','Noto Sans Lao',system-ui,sans-serif;background:linear-gradient(135deg, #0f172a 0%, #1e293b 30%, #334155 70%, #475569 100%);display:flex;align-items:center;justify-content:center;min-height:100vh;-webkit-font-smoothing:antialiased;position:relative;overflow:hidden;}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(255,255,255,.03) 1px,transparent 1px),linear-gradient(90deg,rgba(255,255,255,.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;}
.orb{position:fixed;border-radius:50%;filter:blur(80px);pointer-events:none;opacity:.3;}
.orb-1{width:600px;height:600px;background:radial-gradient(circle,#0057b8,transparent 70%);top:-200px;left:-150px;}
.orb-2{width:500px;height:500px;background:radial-gradient(circle,#06c3ff,transparent 70%);bottom:-150px;right:-100px;}
.card-scene{width:100%;max-width:430px;position:relative;z-index:1;animation:slideUp .45s cubic-bezier(.22,.68,0,1.2);}
@keyframes slideUp{from{opacity:0;transform:translateY(28px);}to{opacity:1;transform:translateY(0);}}
.panel{background:#fff;border-radius:24px;padding:2.5rem 2.25rem;box-shadow:0 30px 70px rgba(0,0,0,.4);overflow:hidden;}
.logo-area{text-align:center;margin-bottom:1.75rem;}
.logo-icon-wrap{width:60px;height:60px;background:linear-gradient(135deg,#0f172a,#1e293b);border-radius:16px;display:flex;align-items:center;justify-content:center;margin:0 auto .75rem;box-shadow:0 8px 24px rgba(0,0,0,.2);}
.logo-icon-wrap i{color:#06c3ff;font-size:1.5rem;}
.logo-area h1{font-family:'Geist Mono',monospace;font-size:.82rem;font-weight:700;letter-spacing:.2em;text-transform:uppercase;color:#002347;}
.logo-area p{font-size:.62rem;color:#6b7fa3;letter-spacing:.1em;text-transform:uppercase;margin-top:2px;}
.divider-text{display:flex;align-items:center;gap:.75rem;margin-bottom:1.5rem;font-size:.58rem;font-weight:700;letter-spacing:.18em;text-transform:uppercase;color:#9aafc7;}
.divider-text::before,.divider-text::after{content:'';flex:1;height:1px;background:#e8eef8;}
/* Enhanced Modern Form Styling */
.field-group{
    margin-bottom:1.5rem;
    position:relative;
}

.field-lbl{
    display:block;
    font-size:.8rem;
    font-weight:700;
    color:#1f2937;
    margin-bottom:.6rem;
    transition:all .3s ease;
    text-transform:uppercase;
    letter-spacing:.05em;
}

.field-lbl .req{
    color:#ef4444;
    font-weight:800;
}

.field-wrap{
    position:relative;
    transform-style:preserve-3d;
}

.field-wrap .fi{
    position:absolute;
    left:1.2rem;
    top:50%;
    transform:translateY(-50%);
    color:#6b7280;
    font-size:.9rem;
    pointer-events:none;
    transition:all .4s cubic-bezier(.4,0,.2,1);
    z-index:2;
}

/* Ultra Modern Input Fields */
input.field{
    width:100%;
    padding:1rem 1.5rem 1rem 3.2rem;
    background:linear-gradient(145deg, #ffffff 0%, #f8fafc 100%);
    border:3px solid #e2e8f0;
    border-radius:16px;
    font-family:'Inter', sans-serif;
    font-size:.9rem;
    font-weight:500;
    color:#0f172a;
    outline:none;
    transition:all .4s cubic-bezier(.4,0,.2,1);
    position:relative;
    backdrop-filter:blur(20px);
    box-shadow:0 4px 20px rgba(0,0,0,.05), inset 0 1px 0 rgba(255,255,255,.8);
}

input.field:focus{
    border-color:#0057b8;
    background:linear-gradient(145deg, #ffffff 0%, #f0f9ff 100%);
    box-shadow:0 0 0 6px rgba(0,87,184,.15), 0 12px 40px rgba(0,87,184,.2);
    transform:translateY(-4px) scale(1.02);
}

input.field:focus + .field-wrap .fi{
    color:#0057b8;
    transform:translateY(-50%) scale(1.2) translateX(4px);
    text-shadow:0 2px 4px rgba(0,87,184,.3);
}

input.field::placeholder{
    color:#94a3b8;
    font-weight:400;
    transition:all .3s ease;
}

input.field:focus::placeholder{
    opacity:.5;
    transform:translateX(8px);
}

/* Ultra Modern Password Toggle */
.pw-toggle{
    position:absolute;
    right:1.2rem;
    top:50%;
    transform:translateY(-50%);
    color:#6b7280;
    border:none;
    background:linear-gradient(145deg, rgba(255,255,255,.9), rgba(248,250,252,.9));
    cursor:pointer;
    font-size:.9rem;
    padding:.6rem;
    border-radius:10px;
    transition:all .4s cubic-bezier(.4,0,.2,1);
    backdrop-filter:blur(20px);
    box-shadow:0 2px 8px rgba(0,0,0,.1);
}

.pw-toggle:hover{
    color:#0057b8;
    background:linear-gradient(145deg, #f0f9ff, #dbeafe);
    transform:translateY(-50%) scale(1.15) rotate(5deg);
    box-shadow:0 4px 16px rgba(0,87,184,.2);
}

/* Ultra Modern Primary Button */
.btn-primary{
    width:100%;
    padding:1.2rem 2rem;
    background:linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);
    color:#ffffff;
    border:none;
    border-radius:16px;
    font-family:'Inter', sans-serif;
    font-size:.85rem;
    font-weight:800;
    text-transform:uppercase;
    letter-spacing:.2em;
    cursor:pointer;
    transition:all .5s cubic-bezier(.4,0,.2,1);
    margin-top:1.5rem;
    display:flex;
    align-items:center;
    justify-content:center;
    gap:.8rem;
    position:relative;
    overflow:hidden;
    box-shadow:0 8px 32px rgba(15,23,42,.4), 0 4px 16px rgba(51,65,85,.3);
    text-shadow:0 2px 4px rgba(0,0,0,.3);
}

.btn-primary::before{
    content:'';
    position:absolute;
    top:0;
    left:-100%;
    width:100%;
    height:100%;
    background:linear-gradient(90deg, transparent, rgba(255,255,255,.3), transparent);
    transition:left .8s ease;
}

.btn-primary:hover{
    transform:translateY(-6px) scale(1.02);
    box-shadow:0 16px 48px rgba(0,35,71,.5), 0 8px 24px rgba(6,195,255,.4);
    background:linear-gradient(135deg, #003a5c 0%, #0066cc 30%, #00d4ff 100%);
}

.btn-primary:hover::before{
    left:100%;
}

.btn-primary:active{
    transform:translateY(-2px) scale(.98);
    transition:transform .1s ease;
}

/* Ultra Modern Secondary Buttons */
.btn-register-trigger{
    width:100%;
    padding:1rem 1.5rem;
    background:linear-gradient(145deg, rgba(255,255,255,.95), rgba(248,250,252,.95));
    border:3px solid #e2e8f0;
    border-radius:16px;
    font-family:'Inter', sans-serif;
    font-size:.8rem;
    font-weight:700;
    color:#0057b8;
    cursor:pointer;
    transition:all .4s cubic-bezier(.4,0,.2,1);
    margin-top:1rem;
    display:flex;
    align-items:center;
    justify-content:center;
    gap:.6rem;
    position:relative;
    backdrop-filter:blur(20px);
    box-shadow:0 4px 16px rgba(0,0,0,.05);
}

.btn-register-trigger:hover{
    background:linear-gradient(145deg, #f0f9ff, #dbeafe);
    border-color:#0057b8;
    transform:translateY(-4px) scale(1.02);
    box-shadow:0 8px 32px rgba(0,87,184,.2);
    color:#003a5c;
}

/* Ultra Modern Reset Password Button */
.btn-reset-password{
    width:100%;
    padding:1rem 1.5rem;
    background:linear-gradient(135deg, #fef2f2 0%, #fee2e2 50%, #fecaca 100%);
    border:3px solid #fca5a5;
    border-radius:16px;
    font-family:'Inter', sans-serif;
    font-size:.8rem;
    font-weight:700;
    color:#dc2626;
    cursor:pointer;
    transition:all .4s cubic-bezier(.4,0,.2,1);
    margin-top:.8rem;
    display:flex;
    align-items:center;
    justify-content:center;
    gap:.6rem;
    position:relative;
    animation:pulseRed 4s ease-in-out infinite;
    box-shadow:0 4px 16px rgba(220,38,38,.2);
}

.btn-reset-password:hover{
    background:linear-gradient(135deg, #fee2e2 0%, #fecaca 50%, #f87171 100%);
    border-color:#ef4444;
    transform:translateY(-4px) scale(1.02);
    box-shadow:0 8px 32px rgba(220,38,38,.3);
    color:#991b1b;
}

@keyframes pulseRed{
    0%,100%{box-shadow:0 4px 16px rgba(220,38,38,.2), 0 0 0 0 rgba(220,38,38,.4);}
    50%{box-shadow:0 4px 16px rgba(220,38,38,.2), 0 0 0 12px rgba(220,38,38,.0);}
}
/* Enhanced Mobile Responsiveness */
@media (max-width: 480px) {
    .card-scene {
        max-width: 95%;
        margin: 1rem;
    }
    
    .panel {
        padding: 2rem 1.5rem;
        border-radius: 20px;
    }
    
    .logo-icon-wrap {
        width: 50px;
        height: 50px;
        border-radius: 14px;
    }
    
    .logo-icon-wrap i {
        font-size: 1.3rem;
    }
    
    .logo-area h1 {
        font-size: .75rem;
    }
    
    .logo-area p {
        font-size: .58rem;
    }
    
    input.field {
        padding: .8rem 1rem .8rem 2.5rem;
        font-size: .82rem;
    }
    
    .field-wrap .fi {
        font-size: .8rem;
        left: .9rem;
    }
    
    .btn-primary {
        padding: .9rem;
        font-size: .75rem;
    }
    
    .btn-register-trigger,
    .btn-reset-password {
        padding: .8rem;
        font-size: .74rem;
    }
}

/* Enhanced Tablet Responsiveness */
@media (min-width: 481px) and (max-width: 768px) {
    .card-scene {
        max-width: 400px;
    }
    
    .panel {
        padding: 2.25rem 2rem;
    }
}

/* Enhanced Loading States */
.btn-primary.loading {
    pointer-events: none;
    opacity: .8;
}

.btn-primary.loading .spinner {
    display: inline-block;
}

.btn-primary.loading span {
    opacity: .7;
}

/* Enhanced Focus Management */
.field-group:focus-within .field-lbl {
    color: #0057b8;
    transform: translateY(-1px);
}

/* Enhanced Error States */
input.field.error {
    border-color: #dc2626;
    background: #fef2f2;
    animation: shake .35s ease;
}

input.field.error:focus {
    box-shadow: 0 0 0 4px rgba(220, 38, 38, .12), 0 8px 25px rgba(220, 38, 38, .15);
}

/* Enhanced Success States */
input.field.success {
    border-color: #16a34a;
    background: #f0fdf4;
}

input.field.success:focus {
    box-shadow: 0 0 0 4px rgba(22, 163, 74, .12), 0 8px 25px rgba(22, 163, 74, .15);
}

/* Enhanced Accessibility */
.sr-only {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    white-space: nowrap;
    border: 0;
}

/* Enhanced Keyboard Navigation */
*:focus {
    outline: 2px solid #0057b8;
    outline-offset: 2px;
}

button:focus,
input:focus {
    outline: none;
}

/* Enhanced Animation Performance */
.panel,
.btn-primary,
.btn-register-trigger,
.btn-reset-password,
input.field {
    will-change: transform;
}

/* Enhanced Dark Mode Support (if needed) */
@media (prefers-color-scheme: dark) {
    .panel {
        background: rgba(255, 255, 255, .98);
        backdrop-filter: blur(20px);
    }
}
/* Enhanced Fail Badge */
.fail-badge{
    display:flex;
    align-items:center;
    justify-content:center;
    gap:.4rem;
    background:linear-gradient(135deg,#fff7ed 0%,#fef3c7 100%);
    border:2px solid #fed7aa;
    border-radius:12px;
    padding:.6rem .875rem;
    margin-bottom:.875rem;
    font-size:.72rem;
    font-weight:600;
    color:#c2410c;
    box-shadow:0 4px 12px rgba(194,65,12,.15);
    animation:slideInDown .4s ease;
}

@keyframes slideInDown{
    from{opacity:0;transform:translateY(-10px);}
    to{opacity:1;transform:translateY(0);}
}

/* Enhanced Error and Success Boxes */
.error-box{
    background:linear-gradient(135deg,#fef2f2 0%,#fee2e2 100%);
    border:2px solid #fecaca;
    border-radius:12px;
    padding:.75rem 1rem;
    margin-bottom:1rem;
    color:#b91c1c;
    font-size:.75rem;
    font-weight:600;
    display:flex;
    align-items:center;
    gap:.6rem;
    animation:shake .35s ease;
    box-shadow:0 4px 12px rgba(185,28,28,.15);
}

.success-box{
    background:linear-gradient(135deg,#f0fdf4 0%,#dcfce7 100%);
    border:2px solid #bbf7d0;
    border-radius:12px;
    padding:.75rem 1rem;
    margin-bottom:1rem;
    color:#15803d;
    font-size:.75rem;
    font-weight:600;
    display:flex;
    align-items:center;
    gap:.6rem;
    box-shadow:0 4px 12px rgba(21,128,61,.15);
    animation:slideInDown .4s ease;
}
.pw-strength{margin-top:.4rem;display:flex;gap:3px;align-items:center;}
.pw-bar{height:3px;flex:1;border-radius:2px;background:#e8eef8;transition:background .25s;}
.pw-label{font-size:.58rem;font-weight:700;margin-left:.4rem;min-width:44px;}
.login-footer{text-align:center;margin-top:1.5rem;padding-top:1.125rem;border-top:1px solid #eef3fb;}
.ver-note{font-size:.56rem;color:#aab8cc;}
/* Remember Me row */
.remember-row{display:flex;align-items:center;gap:.65rem;margin-bottom:1.25rem;padding:.75rem 1rem;background:linear-gradient(135deg,#f8fafc,#f1f5f9);border:1.5px solid #e2e8f0;border-radius:12px;cursor:pointer;transition:all .2s;user-select:none;}
.remember-row:hover{border-color:#93c5fd;background:linear-gradient(135deg,#eff6ff,#dbeafe);}
.remember-row input[type=checkbox]{width:18px;height:18px;accent-color:#0057b8;cursor:pointer;flex-shrink:0;}
.remember-row label{font-size:.78rem;font-weight:600;color:#374151;cursor:pointer;flex:1;}
.spinner{width:18px;height:18px;border-radius:50%;border:2.5px solid rgba(255,255,255,.3);border-top-color:#fff;animation:spin .7s linear infinite;display:none;}
@keyframes spin{to{transform:rotate(360deg);}}
.steps{display:flex;align-items:center;justify-content:center;gap:.35rem;margin-bottom:1.25rem;}
.step-dot{width:8px;height:8px;border-radius:50%;background:#dce6f5;transition:all .3s;}
.step-dot.active{width:22px;border-radius:4px;background:#0057b8;}
.step-dot.done{background:#0ea5e9;}
/* Enhanced Modal Styling */
.modal-overlay{
    position:fixed;
    inset:0;
    z-index:200;
    background:rgba(15,23,42,.85);
    backdrop-filter:blur(12px);
    display:flex;
    align-items:center;
    justify-content:center;
    opacity:0;
    pointer-events:none;
    transition:all .4s cubic-bezier(.4,0,.2,1);
    padding:1rem;
}

.modal-overlay.open{
    opacity:1;
    pointer-events:all;
}

.modal-box{
    background:#fff;
    border-radius:28px;
    width:100%;
    max-width:440px;
    box-shadow:0 50px 100px rgba(0,0,0,.6), 0 20px 40px rgba(0,87,184,.15);
    transform:scale(.85) translateY(40px);
    transition:all .5s cubic-bezier(.22,.68,0,1.2);
    overflow:hidden;
    max-height:94vh;
    overflow-y:auto;
    border:1px solid rgba(255,255,255,.1);
}

.modal-overlay.open .modal-box{
    transform:scale(1) translateY(0);
}

/* Enhanced Modal Close Button */
.modal-close{
    position:absolute;
    top:1.2rem;
    right:1.2rem;
    width:40px;
    height:40px;
    border-radius:12px;
    background:rgba(255,255,255,.15);
    border:1px solid rgba(255,255,255,.2);
    cursor:pointer;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:.9rem;
    color:#fff;
    transition:all .3s ease;
    z-index:10;
    backdrop-filter:blur(10px);
}

.modal-close:hover{
    background:rgba(255,255,255,.25);
    transform:scale(1.1);
    border-color:rgba(255,255,255,.3);
}

/* Enhanced Modal Header */
.modal-header{
    background:linear-gradient(135deg,#0f172a 0%,#1e293b 50%,#334155 100%);
    padding:2rem 2rem 1.75rem;
    text-align:center;
    position:relative;
    border-bottom:1px solid rgba(255,255,255,.1);
}

.modal-header::before{
    content:'';
    position:absolute;
    top:0;
    left:0;
    right:0;
    height:100%;
    background:linear-gradient(45deg,transparent 30%,rgba(255,255,255,.05) 50%,transparent 70%);
    pointer-events:none;
}

/* Enhanced Auth Icon */
.auth-icon{
    width:76px;
    height:76px;
    border-radius:24px;
    background:rgba(255,255,255,.12);
    border:2px solid rgba(255,255,255,.25);
    display:flex;
    align-items:center;
    justify-content:center;
    margin:0 auto 1rem;
    box-shadow:0 12px 40px rgba(0,0,0,.3), 0 4px 12px rgba(6,195,255,.2);
    backdrop-filter:blur(10px);
    transition:all .3s ease;
}

.auth-icon i{
    color:#06c3ff;
    font-size:2rem;
    filter:drop-shadow(0 2px 4px rgba(0,0,0,.2));
}

.modal-header h3{
    font-family:'Geist Mono',monospace;
    font-size:.92rem;
    font-weight:700;
    letter-spacing:.12em;
    color:#fff;
    text-transform:uppercase;
    margin-bottom:.5rem;
    text-shadow:0 2px 4px rgba(0,0,0,.2);
}

.modal-header p{
    font-size:.7rem;
    color:rgba(255,255,255,.7);
    line-height:1.6;
    font-weight:500;
}
/* Enhanced Multi-step Interface */
.modal-steps{
    display:flex;
    border-bottom:1px solid #eef3fb;
    background:rgba(248,250,253,.5);
}

.mstep{
    flex:1;
    padding:.8rem .5rem;
    text-align:center;
    font-size:.65rem;
    font-weight:700;
    color:#9aafc7;
    border-bottom:3px solid transparent;
    transition:all .3s cubic-bezier(.4,0,.2,1);
    cursor:default;
    position:relative;
}

.mstep.active{
    color:#0057b8;
    border-bottom-color:#0057b8;
    background:rgba(0,87,184,.05);
}

.mstep.done{
    color:#16a34a;
    border-bottom-color:#16a34a;
    background:rgba(22,163,74,.05);
}

.mstep i{
    display:block;
    font-size:1rem;
    margin-bottom:.3rem;
    transition:transform .3s ease;
}

.mstep.active i{
    transform:scale(1.1);
}

/* Enhanced QR Code Display */
#qrcode-canvas{
    border-radius:16px;
    border:3px solid #e1e8f0;
    padding:12px;
    background:#fff;
    box-shadow:0 8px 32px rgba(1,36,77,.12);
    transition:all .3s ease;
}

#qrcode-canvas:hover{
    box-shadow:0 12px 40px rgba(1,36,77,.18);
    transform:translateY(-2px);
}

.qr-wrapper{
    display:flex;
    flex-direction:column;
    align-items:center;
    gap:1rem;
}

.qr-email-badge{
    background:linear-gradient(135deg,#eff6ff 0%,#dbeafe 100%);
    border:2px solid #bfdbfe;
    border-radius:12px;
    padding:.5rem 1rem;
    font-size:.74rem;
    font-weight:600;
    color:#1d4ed8;
    display:flex;
    align-items:center;
    gap:.5rem;
    box-shadow:0 4px 12px rgba(29,78,216,.1);
}

/* Enhanced Secret Key Display */
.secret-box{
    background:linear-gradient(135deg,#f8fafd 0%,#f1f5f9 100%);
    border:2px dashed #bfdbfe;
    border-radius:12px;
    padding:.875rem 1.125rem;
    text-align:center;
    transition:all .3s ease;
}

.secret-box:hover{
    border-color:#0057b8;
    background:linear-gradient(135deg,#eff6ff 0%,#dbeafe 100%);
}

.secret-box .slbl{
    font-size:.6rem;
    font-weight:700;
    letter-spacing:.12em;
    text-transform:uppercase;
    color:#6b7fa3;
    margin-bottom:.4rem;
}

.secret-code{
    font-family:'Geist Mono',monospace;
    font-size:.9rem;
    font-weight:700;
    color:#002347;
    letter-spacing:.16em;
    word-break:break-all;
    line-height:1.4;
}

.copy-btn{
    background:rgba(0,87,184,.05);
    border:2px solid #bfdbfe;
    border-radius:8px;
    color:#0057b8;
    font-size:.68rem;
    font-weight:700;
    cursor:pointer;
    padding:.3rem .7rem;
    margin-top:.5rem;
    transition:all .3s ease;
    display:inline-flex;
    align-items:center;
    gap:.4rem;
}

.copy-btn:hover{
    background:#0057b8;
    color:#fff;
    transform:translateY(-1px);
    box-shadow:0 4px 12px rgba(0,87,184,.2);
}

/* Enhanced Setup Instructions */
.steps-hint{
    background:linear-gradient(135deg,#fffbeb 0%,#fef3c7 100%);
    border:2px solid #fde68a;
    border-radius:12px;
    padding:.875rem;
    font-size:.7rem;
    color:#92400e;
    line-height:1.7;
    box-shadow:0 4px 12px rgba(146,64,14,.1);
}

.steps-hint ol{
    padding-left:1.25rem;
}

.steps-hint li{
    margin-bottom:.3rem;
}

.steps-hint strong{
    color:#78350f;
    font-weight:700;
}

/* Enhanced OTP Input Fields */
.otp-inputs{
    display:flex;
    gap:.5rem;
    justify-content:center;
    margin:1.5rem 0 1rem;
}

.otp-digit{
    width:52px;
    height:62px;
    border:2px solid #e1e8f0;
    border-radius:14px;
    text-align:center;
    font-size:1.5rem;
    font-weight:800;
    font-family:'Geist Mono',monospace;
    color:#002347;
    background:#f8fafd;
    outline:none;
    transition:all .3s cubic-bezier(.4,0,.2,1);
    -moz-appearance:textfield;
    backdrop-filter:blur(10px);
}

.otp-digit::-webkit-outer-spin-button,
.otp-digit::-webkit-inner-spin-button{
    -webkit-appearance:none;
}

.otp-digit:focus{
    border-color:#0057b8;
    background:#fff;
    box-shadow:0 0 0 4px rgba(0,87,184,.12), 0 8px 25px rgba(0,87,184,.15);
    transform:scale(1.08) translateY(-2px);
}

.otp-digit.filled{
    border-color:#0ea5e9;
    background:#f0f9ff;
    color:#0057b8;
    box-shadow:0 4px 12px rgba(14,165,233,.15);
}

.otp-digit.error-d{
    border-color:#dc2626;
    background:#fef2f2;
    animation:shake .35s ease;
    box-shadow:0 4px 12px rgba(220,38,38,.15);
}

.otp-digit.success-d{
    border-color:#16a34a;
    background:#f0fdf4;
    color:#15803d;
    box-shadow:0 4px 12px rgba(22,163,74,.15);
}
.otp-timer-row{display:flex;align-items:center;justify-content:center;gap:.5rem;font-size:.64rem;color:#6b7fa3;margin-bottom:.875rem;}
.otp-timer-row .tval{font-family:'Geist Mono',monospace;font-weight:800;color:#0057b8;background:#eff6ff;padding:.15rem .5rem;border-radius:5px;}
.otp-timer-row .tprogress{flex:1;height:3px;background:#e8eef8;border-radius:2px;overflow:hidden;max-width:80px;}
.tprogress-bar{height:100%;background:linear-gradient(90deg,#0057b8,#06c3ff);border-radius:2px;transition:width 1s linear;}
.otp-hint-box{background:#f0fdf4;border:1px solid #bbf7d0;border-radius:10px;padding:.7rem .875rem;font-size:.68rem;color:#166534;margin-bottom:.875rem;display:flex;gap:.5rem;align-items:flex-start;line-height:1.55;}
.otp-feedback{display:none;font-size:.7rem;font-weight:600;text-align:center;margin-bottom:.75rem;padding:.5rem;border-radius:8px;}
.btn-verify{width:100%;padding:.8rem;background:linear-gradient(135deg,#0f172a,#1e293b,#334155);color:#fff;border:none;border-radius:10px;font-family:inherit;font-size:.77rem;font-weight:800;text-transform:uppercase;letter-spacing:.1em;cursor:pointer;transition:all .18s;display:flex;align-items:center;justify-content:center;gap:.5rem;}
.btn-verify:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(0,35,71,.3);}
.btn-verify:disabled{opacity:.5;cursor:not-allowed;transform:none;}
.btn-rescan{background:none;border:1px solid #dce6f5;border-radius:8px;font-family:inherit;font-size:.68rem;font-weight:600;color:#6b7fa3;cursor:pointer;padding:.45rem .875rem;margin-top:.6rem;width:100%;transition:all .15s;}
.btn-rescan:hover{color:#0057b8;border-color:#bfdbfe;}
/* ── Reset Modal — Blue theme (ຄືກັບ Create Account) ── */
.rst-overlay{position:fixed;inset:0;z-index:300;background:rgba(15,23,42,.85);backdrop-filter:blur(12px);display:flex;align-items:center;justify-content:center;opacity:0;pointer-events:none;transition:opacity .3s ease;padding:1rem;}
.rst-overlay.open{opacity:1;pointer-events:all;}
.rst-box{padding:8px;background:#ffffff;border-radius:32px;width:100%;max-width:440px;box-shadow:0 40px 90px rgba(0,0,0,.5);transform:scale(.9) translateY(24px);transition:all .4s cubic-bezier(.22,.68,0,1.15);overflow:hidden;max-height:94vh;overflow-y:auto;position:relative;}
.rst-overlay.open .rst-box{transform:scale(1) translateY(0);}transform:scale(1) translateY(0);}
/* Header — same as Register form */
.rst-hdr{background:linear-gradient(135deg,#002347 0%,#0057b8 100%);padding:2rem 2rem 1.75rem;text-align:center;position:relative;border-radius:24px 24px 0 0;}
.rst-close{position:absolute;top:1rem;right:1rem;width:36px;height:36px;border-radius:10px;background:rgba(255,255,255,.2);border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:.85rem;color:#fff;transition:all .15s;}
.rst-close:hover{background:rgba(255,255,255,.35);}
.rst-key-ico{width:72px;height:72px;border-radius:20px;background:rgba(255,255,255,.15);border:2px solid rgba(255,255,255,.3);display:flex;align-items:center;justify-content:center;margin:0 auto 1rem;box-shadow:0 8px 32px rgba(0,0,0,.25);font-size:1.9rem;}
.rst-hdr h3{font-family:'Geist Mono',monospace;font-size:.88rem;font-weight:700;letter-spacing:.2em;color:#fff;text-transform:uppercase;margin-bottom:.4rem;}
.rst-hdr p{font-size:.62rem;color:rgba(255,255,255,.6);line-height:1.55;letter-spacing:.1em;text-transform:uppercase;}
/* Step tabs — blue active */
.rst-tabs{display:flex;border-bottom:1px solid #eef3fb;}
.rst-tab{flex:1;padding:.7rem .5rem;text-align:center;font-size:.62rem;font-weight:700;color:#9aafc7;border-bottom:2.5px solid transparent;margin-bottom:-1px;transition:all .22s;cursor:default;display:flex;flex-direction:column;align-items:center;gap:.2rem;}
.rst-tab i{font-size:.88rem;}
.rst-tab.active{color:#0057b8;border-bottom-color:#0057b8;}
.rst-tab.done{color:#16a34a;border-bottom-color:#16a34a;}
.rst-pg{display:none;padding:1.5rem 1.75rem;}
.rst-pg.active{display:block;animation:pgIn .3s ease;}
@keyframes pgIn{from{opacity:0;transform:translateY(8px);}to{opacity:1;transform:none;}}
.rst-fg{margin-bottom:1rem;}
.rst-lbl{display:block;font-size:.7rem;font-weight:600;color:#374151;margin-bottom:.38rem;}
.rst-lbl .req{color:#dc2626;}
.rst-iw{position:relative;}
.rst-iw .fi{position:absolute;left:.9rem;top:50%;transform:translateY(-50%);color:#9aafc7;font-size:.78rem;pointer-events:none;}
input.rst-field{width:100%;padding:.7rem 2.8rem .7rem 2.6rem;background:#f8fafd;border:1.5px solid #dce6f5;border-radius:10px;font-family:inherit;font-size:.82rem;color:#111827;outline:none;transition:all .18s;}
input.rst-field:focus{border-color:#0057b8;background:#fff;box-shadow:0 0 0 3px rgba(0,87,184,.08);}
input.rst-field::placeholder{color:#b0bfce;}
input.rst-field.ok{border-color:#16a34a;}
input.rst-field.bad{border-color:#dc2626;}
.pw-str-row{display:flex;gap:3px;margin-top:.45rem;align-items:center;}
.pw-str-bar{flex:1;height:3px;border-radius:2px;background:#e8eef8;transition:background .25s;}
.pw-str-lbl{font-size:.58rem;font-weight:700;margin-left:.4rem;min-width:44px;}
.pw-match-hint{font-size:.65rem;margin-top:.3rem;display:none;align-items:center;gap:.35rem;}
.pw-match-hint.on{display:flex;}
.rst-fb{font-size:.72rem;font-weight:600;padding:.55rem .875rem;border-radius:10px;margin-bottom:.875rem;display:none;align-items:center;gap:.5rem;}
.rst-fb.on{display:flex;}
.rst-fb.err{background:#fef2f2;color:#b91c1c;border:1px solid #fee2e2;}
.rst-fb.ok{background:#f0fdf4;color:#15803d;border:1px solid #bbf7d0;}
.info-box{background:#eff6ff;border:1px solid #bfdbfe;border-radius:10px;padding:.7rem .875rem;font-size:.7rem;color:#1d4ed8;margin-bottom:1rem;display:flex;gap:.45rem;align-items:flex-start;line-height:1.6;}
.info-box i{flex-shrink:0;margin-top:.1rem;}
/* TOTP badge & digits — blue */
.totp-hint-badge{display:inline-flex;align-items:center;gap:.5rem;background:#eff6ff;border:1px solid #bfdbfe;border-radius:12px;padding:.55rem 1.2rem;font-size:.74rem;font-weight:600;color:#1d4ed8;margin-bottom:1rem;}
.totp-otp-row{display:flex;gap:.45rem;justify-content:center;margin:0 0 .75rem;}
.totp-digit{width:50px;height:58px;border:2px solid #dce6f5;border-radius:12px;text-align:center;font-size:1.45rem;font-weight:800;font-family:'Geist Mono',monospace;color:#002347;background:#f8fafd;outline:none;transition:all .18s;-moz-appearance:textfield;}
.totp-digit::-webkit-outer-spin-button,.totp-digit::-webkit-inner-spin-button{-webkit-appearance:none;}
.totp-digit:focus{border-color:#0057b8;background:#fff;box-shadow:0 0 0 3px rgba(0,87,184,.1);transform:scale(1.06);}
.totp-digit.filled{border-color:#0ea5e9;background:#f0f9ff;color:#0057b8;}
.totp-digit.error-d{border-color:#dc2626;background:#fef2f2;animation:shake .35s ease;}
.totp-digit.success-d{border-color:#16a34a;background:#f0fdf4;color:#15803d;}
/* Timer — blue */
.totp-timer-row{display:flex;align-items:center;justify-content:center;gap:.6rem;font-size:.65rem;color:#6b7fa3;margin-bottom:1rem;}
.totp-tval{font-family:'Geist Mono',monospace;font-weight:800;color:#0057b8;background:#eff6ff;padding:.15rem .6rem;border-radius:6px;min-width:32px;text-align:center;}
.totp-tprog{flex:1;height:3px;background:#e8eef8;border-radius:2px;overflow:hidden;max-width:90px;}
.totp-tprog-bar{height:100%;background:linear-gradient(90deg,#0057b8,#06c3ff);border-radius:2px;transition:width 1s linear;}
.totp-green-box{background:#f0fdf4;border:1px solid #bbf7d0;border-radius:10px;padding:.7rem .875rem;font-size:.68rem;color:#166534;margin-bottom:1rem;display:flex;gap:.45rem;align-items:flex-start;line-height:1.55;}
.totp-green-box i{flex-shrink:0;margin-top:.1rem;}
/* Primary button — blue ຄືກັບ Create Account */
.btn-rst-red{width:100%;padding:.825rem;background:linear-gradient(90deg,#0d1b2e,#1a2d4a);color:#fff;border:none;border-radius:10px;font-family:inherit;font-size:.78rem;font-weight:800;text-transform:uppercase;letter-spacing:.12em;cursor:pointer;transition:all .25s ease;display:flex;align-items:center;justify-content:center;gap:.5rem;margin-top:.25rem;}
.btn-rst-red:hover{background:linear-gradient(90deg,#0057b8,#06c3ff);transform:translateY(-2px);box-shadow:0 8px 24px rgba(0,87,184,.4);}
.btn-rst-red:disabled{opacity:.5;cursor:not-allowed;transform:none;}
.btn-rst-ghost{width:100%;padding:.75rem;background:transparent;border:1.5px solid #dce6f5;border-radius:10px;font-family:inherit;font-size:.74rem;font-weight:700;color:#0057b8;cursor:pointer;transition:all .18s;margin-top:.6rem;display:flex;align-items:center;justify-content:center;gap:.4rem;}
.btn-rst-ghost:hover{background:#eff6ff;border-color:#bfdbfe;}
.rst-success{text-align:center;padding:1rem 0 .5rem;}
.rst-ok-ring{width:80px;height:80px;border-radius:50%;background:linear-gradient(135deg,#15803d,#22c55e);display:flex;align-items:center;justify-content:center;margin:0 auto 1.25rem;box-shadow:0 8px 32px rgba(22,163,74,.35);animation:popIn .55s cubic-bezier(.22,.68,0,1.4) .1s both;}
@keyframes popIn{from{transform:scale(0);opacity:0;}to{transform:scale(1);opacity:1;}}
.rst-ok-ring i{color:#fff;font-size:2rem;}
.rst-success h4{font-size:1.05rem;font-weight:800;color:#002347;margin-bottom:.5rem;}
.rst-success p{font-size:.78rem;color:#6b7fa3;line-height:1.65;}
.btn-go-login{display:inline-flex;align-items:center;gap:.5rem;margin-top:1.5rem;padding:.85rem 2.5rem;background:linear-gradient(90deg,#002347,#0057b8);color:#fff;border:none;border-radius:10px;font-family:inherit;font-size:.8rem;font-weight:800;text-transform:uppercase;letter-spacing:.1em;cursor:pointer;transition:all .18s;}
.btn-go-login:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(0,35,71,.3);}
</style>
</head>
<body>
<div class="orb orb-1"></div>
<div class="orb orb-2"></div>

<div class="card-scene">

<!-- ══ LOGIN PANEL ══ -->
<div class="panel" id="loginPanel" style="padding:0;overflow:hidden;">
<div style="background:linear-gradient(135deg,#0d1b2e 0%,#1a2d4a 50%,#1e3a5f 100%);padding:2rem 2.25rem 1.75rem;text-align:center;position:relative;border-radius:24px 24px 0 0;">
<div class="logo-icon-wrap" style="background:rgba(255,255,255,.15);border:2px solid rgba(255,255,255,.25);box-shadow:0 8px 32px rgba(0,0,0,.25);"><i class="fas fa-shield-halved" style="color:#fff;"></i></div>
<h1 style="font-family:'Geist Mono',monospace;font-size:.82rem;font-weight:700;letter-spacing:.2em;text-transform:uppercase;color:#fff;">ICT Control Center</h1>
<p style="font-size:.62rem;color:rgba(255,255,255,.6);letter-spacing:.1em;text-transform:uppercase;margin-top:4px;">Halo Trust Laos</p>
</div>
<div style="padding:1.75rem 2.25rem 2.5rem;">
<div class="divider-text">Secure Login</div>

<?php if ($error): ?>
    <div class="error-box"><i class="fas fa-circle-exclamation"></i><?= htmlspecialchars($error) ?></div>
    <?php endif; ?>
    
    <?php if ($showReset): ?>
        <div class="fail-badge">
        <i class="fas fa-triangle-exclamation"></i>
        Incorrect username or password over than 3 times Please reset your password.
        </div>
        <?php endif; ?>
        
        <form method="POST" id="loginForm" autocomplete="off">
        <div class="field-group">
        <label class="field-lbl" for="username">Username / Email</label>
        <div class="field-wrap">
        <i class="fas fa-user fi"></i>
        <input type="text" id="username" name="username" class="field" placeholder="admin or registered Email" required autofocus value="<?= $remember_username ?>">
        </div>
        </div>
        <div class="field-group">
        <label class="field-lbl" for="password">Password</label>
        <div class="field-wrap">
        <i class="fas fa-lock fi"></i>
        <input type="password" id="password" name="password" class="field" placeholder="Enter your password" required>
        <button type="button" class="pw-toggle" id="pwToggle"><i class="fas fa-eye" id="pwIcon"></i></button>
        </div>
        </div>
        <label class="remember-row" for="remember_me">
        <input type="checkbox" id="remember_me" name="remember_me" value="1" <?= $remember_checked ? 'checked' : '' ?>>
        <label for="remember_me">Remind me to sign in</label>
        </label>
        <button type="submit" class="btn-primary"><i class="fas fa-right-to-bracket"></i> Log in</button>
        </form>
        
        <?php if ($showReset): ?>
            <button class="btn-reset-password" onclick="openResetModal()">
            <i class="fas fa-key"></i> Reset Password here
            </button>
            <?php endif; ?>
            
            <button class="btn-register-trigger" onclick="showRegister()">
            <i class="fas fa-user-plus"></i> Register new account
            </button>
            <div class="login-footer"><div class="ver-note">ICT System v2.7.0 &nbsp;·&nbsp; HALO Trust Laos</div></div>
            </div><!-- /inner padding div -->
            </div><!-- /loginPanel -->
            
            <!-- ══ REGISTER PANEL ══ -->
            <div class="panel" id="registerPanel" style="display:none;padding:0;overflow:hidden;">
            <div style="background:linear-gradient(135deg,#0d1b2e 0%,#1a2d4a 50%,#1e3a5f 100%);padding:1.25rem 2.25rem 1.25rem;text-align:center;position:relative;border-radius:24px 24px 0 0;">
            <div class="logo-icon-wrap" style="background:rgba(255,255,255,.15);border:2px solid rgba(255,255,255,.25);box-shadow:0 8px 32px rgba(0,0,0,.25);margin:0 auto .625rem;"><i class="fas fa-user-plus" style="color:#fff;"></i></div>
            <h1 style="font-family:'Geist Mono',monospace;font-size:.82rem;font-weight:700;letter-spacing:.2em;text-transform:uppercase;color:#fff;"><?php _t('create_account'); ?></h1>
            <p style="font-size:.62rem;color:rgba(255,255,255,.6);letter-spacing:.1em;text-transform:uppercase;margin-top:3px;"><?php _t('register_to_ict_system'); ?></p>
            </div>
            <div style="padding:1.25rem 2.25rem 1.75rem;">
            <div class="steps" style="margin-bottom:1rem;">
            <div class="step-dot active" id="step1dot"></div>
            <div class="step-dot" id="step2dot"></div>
            </div>
            <div class="divider-text"><?php _t('account_information'); ?></div>
            <form id="registerForm" autocomplete="off">
            <div class="field-group">
            <label class="field-lbl">Full Name <span class="req">*</span></label>
            <div class="field-wrap"><i class="fas fa-id-card fi"></i>
            <input type="text" id="reg_fullname" class="field" placeholder="<?php _t('full_name_placeholder'); ?>" required></div>
            </div>
            <div class="field-group">
            <label class="field-lbl">Email <span class="req">*</span></label>
            <div class="field-wrap"><i class="fas fa-envelope fi"></i>
            <input type="email" id="reg_email" class="field" placeholder="example@halotrust.org" required></div>
            </div>
            <div class="field-group">
            <label class="field-lbl">Password <span class="req">*</span></label>
            <div class="field-wrap"><i class="fas fa-lock fi"></i>
            <input type="password" id="reg_password" class="field" placeholder="At least 6 characters" required oninput="checkPwStrength(this.value)">
            <button type="button" class="pw-toggle" onclick="togglePw('reg_password',this)"><i class="fas fa-eye"></i></button>
            </div>
            <div class="pw-strength">
            <div class="pw-bar" id="bar1"></div><div class="pw-bar" id="bar2"></div>
            <div class="pw-bar" id="bar3"></div><div class="pw-bar" id="bar4"></div>
            <span class="pw-label" id="pw-label" style="color:#9aafc7;"></span>
            </div>
            </div>
            <div class="field-group">
            <label class="field-lbl">Confirm Password <span class="req">*</span></label>
            <div class="field-wrap"><i class="fas fa-lock-open fi"></i>
            <input type="password" id="reg_confirm" class="field" placeholder="New password one more time" required>
            <button type="button" class="pw-toggle" onclick="togglePw('reg_confirm',this)"><i class="fas fa-eye"></i></button>
            </div>
            <div id="pw-match-hint" style="font-size:.63rem;margin-top:.3rem;display:none;"></div>
            </div>
            <button type="submit" class="btn-primary" id="registerBtn" style="background:linear-gradient(135deg,#0f172a,#1e293b,#334155);margin-top:.75rem;">
            <i class="fas fa-qrcode"></i>
            <span id="regBtnText">Register &amp; Setup Authenticator</span>
            <div class="spinner" id="regSpinner"></div>
            </button>
            </form>
            <button class="btn-back" onclick="showLogin()" style="width:100%;justify-content:center;margin-top:.75rem;color:#0057b8;background:transparent;border:1.5px solid #dce6f5;border-radius:10px;padding:.6rem;font-size:.73rem;font-weight:700;cursor:pointer;display:flex;align-items:center;gap:.4rem;transition:all .15s;" onmouseover="this.style.background='#eff6ff'" onmouseout="this.style.background='transparent'"><i class="fas fa-arrow-left"></i> Back to Login</button>
            <div class="login-footer" style="margin-top:.875rem;"><div class="ver-note">ICT System v2.7.0 &nbsp;·&nbsp; HALO Trust Laos</div></div>
            </div><!-- /inner padding -->
            </div>
            
            </div><!-- /card-scene -->
            
            <!-- ══ AUTHENTICATOR SETUP MODAL ══ -->
            <div class="modal-overlay" id="authModal">
            <div class="modal-box" style="position:relative;">
            <button class="modal-close" onclick="closeAuthModal()"><i class="fas fa-times"></i></button>
            <div class="modal-header">
            <div class="auth-icon"><i class="fas fa-shield-halved"></i></div>
            <h3>Setup Authenticator</h3>
            <p>Scan QR Code with Authenticator App<br>then enter 6-digit code to verify</p>
            </div>
            <div class="modal-steps">
            <div class="mstep active" id="mstep1"><i class="fas fa-qrcode"></i><?php _t('scan_qr_code'); ?></div>
            <div class="mstep" id="mstep2"><i class="fas fa-mobile-screen-button"></i><?php _t('enter_otp_code'); ?></div>
            </div>
            <div class="mpage active" id="mpage1">
            <div class="qr-wrapper">
            <div class="qr-email-badge" id="qr-email-badge"><i class="fas fa-envelope"></i><span id="qr-email-text"></span></div>
            <div id="qrcode-canvas"></div>
            <div class="secret-box" style="width:100%;">
            <div class="slbl"><?php _t('if_cannot_scan'); ?></div>
            <div class="secret-code" id="secret-display"></div>
            <button class="copy-btn" onclick="copySecret()"><i class="fas fa-copy"></i> Copy Key</button>
            </div>
            <div class="steps-hint" style="width:100%;">
            <ol>
            <li><?php _t('download_authenticator'); ?></li>
            <li><?php _t('tap_plus_add_account'); ?></li>
            <li><?php _t('select_scan_qr'); ?></li>
            <li><?php _t('tap_next_enter_code'); ?></li>
            </ol>
            </div>
            </div>
            <button class="btn-next" onclick="goToStep2()"><i class="fas fa-arrow-right"></i> <?php _t('scan_complete_next'); ?></button>
            </div>
            <div class="mpage" id="mpage2">
            <div style="text-align:center;margin-bottom:1rem;">
            <div style="display:inline-flex;align-items:center;gap:.5rem;background:#eff6ff;border:1px solid #bfdbfe;border-radius:10px;padding:.55rem 1rem;font-size:.72rem;font-weight:600;color:#1d4ed8;">
            <i class="fas fa-mobile-screen-button"></i> Enter code from authenticator app
            </div>
            </div>
            <div class="otp-hint-box">
            <i class="fas fa-circle-info" style="color:#16a34a;font-size:1rem;flex-shrink:0;margin-top:.1rem;"></i>
            <span><?php _t('enter_6_digit_code'); ?></span>
            </div>
            <div class="otp-inputs">
            <input type="number" class="otp-digit" maxlength="1" data-index="0" id="otp0">
            <input type="number" class="otp-digit" maxlength="1" data-index="1" id="otp1">
            <input type="number" class="otp-digit" maxlength="1" data-index="2" id="otp2">
            <input type="number" class="otp-digit" maxlength="1" data-index="3" id="otp3">
            <input type="number" class="otp-digit" maxlength="1" data-index="4" id="otp4">
            <input type="number" class="otp-digit" maxlength="1" data-index="5" id="otp5">
            </div>
            <div class="otp-timer-row">
            <i class="fas fa-rotate" style="color:#0057b8;animation:spin 2s linear infinite;font-size:.75rem;"></i>
            <?php _t('new_code_in_seconds'); ?> <span class="tval" id="tval">30</span> <?php _t('seconds'); ?>
            <div class="tprogress"><div class="tprogress-bar" id="tbar" style="width:100%;"></div></div>
            </div>
            <div class="otp-feedback" id="otp-feedback"></div>
            <button class="btn-verify" id="verifyBtn" onclick="verifyTOTP()">
            <i class="fas fa-shield-check"></i>
            <span id="verifyBtnText"><?php _t('verify_complete_registration'); ?></span>
            <div class="spinner" id="verifySpinner"></div>
            </button>
            <button class="btn-rescan" onclick="goToStep1()"><i class="fas fa-qrcode"></i> <?php _t('scan_qr_code_again'); ?></button>
            </div>
            </div>
            </div>
            
            <!-- ══ RESET PASSWORD MODAL ══ -->
            <div class="rst-overlay" id="resetModal">
            <div class="rst-box">
            <div class="rst-hdr" style="background:linear-gradient(135deg,#0d1b2e 0%,#1a2d4a 50%,#1e3a5f 100%) !important;padding:2rem 2rem 1.75rem;text-align:center;position:relative;border-radius:24px 24px 0 0;">
            <button class="rst-close" onclick="closeResetModal()"><i class="fas fa-times"></i></button>
            <div class="rst-key-ico" style="width:72px;height:72px;border-radius:20px;background:rgba(255,255,255,.15);border:2px solid rgba(255,255,255,.3);display:flex;align-items:center;justify-content:center;margin:0 auto 1rem;box-shadow:0 8px 32px rgba(0,0,0,.25);">
            <i class="fas fa-key" style="color:#fff;font-size:1.75rem;"></i>
            </div>
            <h3 style="font-family:'Geist Mono',monospace;font-size:.88rem;font-weight:700;letter-spacing:.2em;color:#fff;text-transform:uppercase;margin-bottom:.4rem;">Reset Password</h3>
            <p style="font-size:.62rem;color:rgba(255,255,255,.7);letter-spacing:.1em;text-transform:uppercase;">Reset your account password</p>
            </div>
            <div class="rst-tabs">
            <div class="rst-tab active" id="rtab1"><i class="fas fa-lock"></i>New password</div>
            <div class="rst-tab" id="rtab2"><i class="fas fa-mobile-screen-button"></i>Confirm OTP</div>
            <div class="rst-tab" id="rtab3"><i class="fas fa-circle-check"></i>Successfully</div>
            </div>
            
            <!-- Page 1 -->
            <div class="rst-pg active" id="rpg1">
            <div class="info-box">
            <i class="fas fa-circle-info"></i>
            <span>Ese <strong>email</strong> from register and <strong>new password</strong> — confirm code from <strong>Authenticator App</strong></span>
            </div>
            <div class="rst-fb" id="rfb1"></div>
            <div class="rst-fg">
            <label class="rst-lbl">Email<span class="req">*</span></label>
            <div class="rst-iw"><i class="fas fa-envelope fi"></i>
            <input type="email" id="rst_em" class="rst-field" placeholder="example@halolaos.org"></div>
            </div>
            <div class="rst-fg">
            <label class="rst-lbl">New password <span class="req">*</span></label>
            <div class="rst-iw"><i class="fas fa-lock fi"></i>
            <input type="password" id="rst_pw" class="rst-field" placeholder="<?php _t('minimum_6_characters'); ?>" oninput="rstStr(this.value)">
            <button type="button" class="pw-toggle" onclick="togglePw('rst_pw',this)"><i class="fas fa-eye"></i></button>
            </div>
            <div class="pw-str-row">
            <div class="pw-str-bar" id="sb1"></div><div class="pw-str-bar" id="sb2"></div>
            <div class="pw-str-bar" id="sb3"></div><div class="pw-str-bar" id="sb4"></div>
            <span class="pw-str-lbl" id="slbl"></span>
            </div>
            </div>
            <div class="rst-fg">
            <label class="rst-lbl">New password again <span class="req">*</span></label>
            <div class="rst-iw"><i class="fas fa-lock-open fi"></i>
            <input type="password" id="rst_pw2" class="rst-field" placeholder="new password again" oninput="rstMatch()">
            <button type="button" class="pw-toggle" onclick="togglePw('rst_pw2',this)"><i class="fas fa-eye"></i></button>
            </div>
            <div class="pw-match-hint" id="rst_mh"></div>
            </div>
            <button class="btn-rst-red" id="rstReqBtn" onclick="rstRequest()">
            <i class="fas fa-shield-halved"></i>
            <span id="rstReqTxt">Confirm OTP to Save Changes</span>
            <div class="spinner" id="rstReqSpin"></div>
            </button>
            <p style="text-align:center;margin-top:1rem;font-size:.76rem;color:#9aafc7;">
            <a href="#" onclick="closeResetModal()" style="color:#c0392b;font-weight:700;text-decoration:none;">Go back Login</a>
            </p>
            </div>
            
            <!-- Page 2 -->
            <div class="rst-pg" id="rpg2">
            <div style="text-align:center;margin-bottom:1rem;">
            <div class="totp-hint-badge"><i class="fas fa-mobile-screen-button"></i> Enter code from authenticator app</div>
            </div>
            <div class="totp-green-box">
            <i class="fas fa-circle-info" style="color:#16a34a;"></i>
            <span>Enter the <strong>6-digit</strong> code from <strong>Google/Microsoft Authenticator</strong> for <strong>ICT HALO Laos</strong></span>
            </div>
            <div class="rst-fb" id="rfb2"></div>
            <div class="totp-otp-row">
            <input type="number" class="totp-digit" maxlength="1" data-ti="0" id="td0">
            <input type="number" class="totp-digit" maxlength="1" data-ti="1" id="td1">
            <input type="number" class="totp-digit" maxlength="1" data-ti="2" id="td2">
            <input type="number" class="totp-digit" maxlength="1" data-ti="3" id="td3">
            <input type="number" class="totp-digit" maxlength="1" data-ti="4" id="td4">
            <input type="number" class="totp-digit" maxlength="1" data-ti="5" id="td5">
            </div>
            <div class="totp-timer-row">
            <i class="fas fa-rotate" style="color:#0057b8;animation:spin 2s linear infinite;font-size:.75rem;"></i>
            Code expires in <span class="totp-tval" id="rstTval">30</span> Seconds
            <div class="totp-tprog"><div class="totp-tprog-bar" id="rstTbar" style="width:100%;"></div></div>
            </div>
            <button class="btn-rst-red" id="rstVerBtn" onclick="rstVerify()">
            <i class="fas fa-check-shield"></i>
            <span id="rstVerTxt">Confirm and Change Password</span>
            <div class="spinner" id="rstVerSpin"></div>
            </button>
            <button class="btn-rst-ghost" onclick="rstBack()"><i class="fas fa-arrow-left"></i> Go back</button>
            </div>
            
            <!-- Page 3 -->
            <div class="rst-pg" id="rpg3">
            <div class="rst-success">
            <div class="rst-ok-ring"><i class="fas fa-check"></i></div>
            <h4>Password Updated! 🎉</h4>
            <p>Your password has been successfully changed. Please log in again.</p>
            <button class="btn-go-login" onclick="closeResetModal();window.location.reload();">
            <i class="fas fa-right-to-bracket"></i> Go back Login
            </button>
            </div>
            </div>
            </div>
            </div><!-- /resetModal -->
            
            <script>
            /* ════════════════════════════════════════════════════
            ENDPOINT — ໃຊ້ login.php?ajax=reset (ໄຟລ໌ດຽວກັນ)
            ════════════════════════════════════════════════════ */
            const RST_URL = 'login.php?ajax=reset';
            
            /* ════ PANEL SWITCH ════ */
            function showRegister(){
            document.getElementById('loginPanel').style.display='none';
            var rp=document.getElementById('registerPanel');
            rp.style.cssText='display:block;animation:slideUp .38s cubic-bezier(.22,.68,0,1.2)';
            }
            function showLogin(){
            document.getElementById('registerPanel').style.display='none';
            var lp=document.getElementById('loginPanel');
            lp.style.cssText='display:block;animation:slideUp .38s cubic-bezier(.22,.68,0,1.2)';
            clearRegForm();
            }
            
            /* ════ PASSWORD TOGGLE ════ */
            document.getElementById('pwToggle').addEventListener('click',function(){
            var pw=document.getElementById('password'),ic=this.querySelector('i');
            pw.type=pw.type==='password'?'text':'password';
            ic.className=pw.type==='password'?'fas fa-eye':'fas fa-eye-slash';
            });
            function togglePw(id,btn){
            var f=document.getElementById(id),ic=btn.querySelector('i');
            f.type=f.type==='password'?'text':'password';
            ic.className=f.type==='password'?'fas fa-eye':'fas fa-eye-slash';
            }
            
            /* ════ PW STRENGTH ════ */
            function checkPwStrength(v){
            var s=0;
            if(v.length>=6)s++;if(v.length>=10)s++;
            if(/[A-Z]/.test(v)&&/[0-9]/.test(v))s++;if(/[^A-Za-z0-9]/.test(v))s++;
            var c=['#fee2e2','#fed7aa','#fef08a','#bbf7d0'];
            var l=[['Weak','#dc2626'],['Fair','#d97706'],['Good','#ca8a04'],['Strong','#16a34a']];
            for(var i=0;i<4;i++) document.getElementById('bar'+(i+1)).style.background=i<s?c[i]:'#e8eef8';
            var lbl=document.getElementById('pw-label');
            if(!v.length){lbl.textContent='';return;}
            var idx=Math.max(0,s-1);lbl.textContent=l[idx][0];lbl.style.color=l[idx][1];
            }
            document.getElementById('reg_confirm').addEventListener('input',function(){
            var pw=document.getElementById('reg_password').value,h=document.getElementById('pw-match-hint');
            h.style.display='block';
            h.innerHTML=this.value===pw
            ?'<i class="fas fa-check" style="color:#16a34a;"></i> <span style="color:#16a34a;font-weight:600;">' + t('password_match') + '</span>'
            :'<i class="fas fa-times" style="color:#dc2626;"></i> <span style="color:#dc2626;font-weight:600;">' + t('password_no_match') + '</span>';
            });
            
            /* ════ REGISTER ════ */
            function showRegError(msg){
            var b=document.getElementById('reg-error');
            document.getElementById('reg-error-text').textContent=msg;
            b.style.display='flex';b.style.animation='none';
            setTimeout(function(){b.style.animation='shake .35s ease';},10);
            }
            function clearRegForm(){
            if(document.getElementById('registerForm'))document.getElementById('registerForm').reset();
            document.getElementById('reg-error').style.display='none';
            document.getElementById('pw-match-hint').style.display='none';
            checkPwStrength('');
            }
            document.getElementById('registerForm').addEventListener('submit',function(e){
            e.preventDefault();
            var fn=document.getElementById('reg_fullname').value.trim();
            var em=document.getElementById('reg_email').value.trim();
            var pw=document.getElementById('reg_password').value;
            var cp=document.getElementById('reg_confirm').value;
            if(!fn||!em||!pw||!cp){showRegError('<?php _t("please_fill_all_fields"); ?>');return;}
            if(pw!==cp){showRegError('<?php _t("passwords_not_match"); ?>');return;}
            if(pw.length<6){showRegError('<?php _t("password_min_6_chars"); ?>');return;}
            document.getElementById('regBtnText').textContent='<?php _t("processing"); ?>';
            document.getElementById('regSpinner').style.display='block';
            document.getElementById('registerBtn').disabled=true;
            var fd=new FormData();
            fd.append('action','request_totp');fd.append('full_name',fn);
            fd.append('email',em);fd.append('password',pw);
            fetch('register.php',{method:'POST',credentials:'same-origin',body:fd})
            .then(function(r){var ct=r.headers.get('content-type')||'';if(!ct.includes('json'))return r.text().then(function(t){throw new Error('Server: '+t.substring(0,200));});return r.json();})
            .then(function(data){
            document.getElementById('regBtnText').textContent='Register & Setup Authenticator';
            document.getElementById('regSpinner').style.display='none';
            document.getElementById('registerBtn').disabled=false;
            if(data.status==='show_qr') openAuthModal(data.otp_uri,data.secret,data.email);
            else showRegError(data.msg || t('error_occurred'));
            })
            .catch(function(err){
            document.getElementById('regBtnText').textContent='Register & Setup Authenticator';
            document.getElementById('regSpinner').style.display='none';
            document.getElementById('registerBtn').disabled=false;
            showRegError('Error: '+(err.message || t('connection_failed')));
            });
            });
            
            /* ════ AUTH MODAL (Register) ════ */
            function openAuthModal(otpUri,secret,email){
            document.getElementById('qr-email-text').textContent=email;
            document.getElementById('secret-display').textContent=secret;
            window._totpSecret=secret;
            document.getElementById('qrcode-canvas').innerHTML='';
            try{
            new QRCode(document.getElementById('qrcode-canvas'),{text:otpUri,width:200,height:200,colorDark:'#002347',colorLight:'#ffffff',correctLevel:QRCode.CorrectLevel.M});
            }catch(e){
            var img=document.createElement('img');
            img.src='https://chart.googleapis.com/chart?chs=200x200&cht=qr&chl='+encodeURIComponent(otpUri)+'&choe=UTF-8';
            img.style.cssText='border-radius:10px;border:3px solid #eef3fb;';
            document.getElementById('qrcode-canvas').appendChild(img);
            }
            goToStep1();clearOtpInputs();startTotpClock();
            document.getElementById('authModal').classList.add('open');
            }
            function closeAuthModal(){
            document.getElementById('authModal').classList.remove('open');
            stopTotpClock();
            document.getElementById('otp-feedback').style.display='none';
            }
            document.getElementById('authModal').addEventListener('click',function(e){if(e.target===this)closeAuthModal();});
            function goToStep1(){
            document.getElementById('mpage1').classList.add('active');document.getElementById('mpage2').classList.remove('active');
            document.getElementById('mstep1').classList.add('active');document.getElementById('mstep1').classList.remove('done');
            document.getElementById('mstep2').classList.remove('active');
            }
            function goToStep2(){
            document.getElementById('mpage1').classList.remove('active');document.getElementById('mpage2').classList.add('active');
            document.getElementById('mstep1').classList.remove('active');document.getElementById('mstep1').classList.add('done');
            document.getElementById('mstep2').classList.add('active');
            clearOtpInputs();setTimeout(function(){document.getElementById('otp0').focus();},150);
            }
            function copySecret(){
            navigator.clipboard.writeText(document.getElementById('secret-display').textContent).then(function(){
            var btn=document.querySelector('.copy-btn');
            btn.innerHTML='<i class="fas fa-check"></i> Copied!';btn.style.background='#dcfce7';btn.style.color='#15803d';
            setTimeout(function(){btn.innerHTML='<i class="fas fa-copy"></i> Copy Key';btn.style.background='';btn.style.color='';},2000);
            });
            }
            function clearOtpInputs(){
            for(var i=0;i<6;i++){var el=document.getElementById('otp'+i);el.value='';el.className='otp-digit';}
            document.getElementById('otp-feedback').style.display='none';
            document.getElementById('verifyBtn').disabled=false;
            document.getElementById('verifyBtnText').textContent = t('verify_complete_registration');
            }
            document.querySelectorAll('.otp-digit').forEach(function(inp){
            inp.addEventListener('input',function(){
            this.value=this.value.replace(/[^0-9]/g,'').slice(-1);
            if(this.value){
            this.classList.add('filled');
            var next=document.getElementById('otp'+(parseInt(this.dataset.index)+1));
            if(next)next.focus();
            var all=Array.from(document.querySelectorAll('.otp-digit')).map(function(e){return e.value;});
            if(all.every(function(v){return v!=='';}))setTimeout(verifyTOTP,100);
            }else{this.classList.remove('filled');}
            });
            inp.addEventListener('keydown',function(e){
            if(e.key==='Backspace'&&!this.value){
            var prev=document.getElementById('otp'+(parseInt(this.dataset.index)-1));
            if(prev){prev.value='';prev.classList.remove('filled');prev.focus();}
            }
            });
            inp.addEventListener('paste',function(e){
            var txt=(e.clipboardData||window.clipboardData).getData('text').replace(/\D/g,'').slice(0,6);
            e.preventDefault();
            for(var i=0;i<txt.length;i++){var el=document.getElementById('otp'+i);if(el){el.value=txt[i];el.classList.add('filled');}}
            var last=document.getElementById('otp'+(Math.min(txt.length,5)));if(last)last.focus();
            if(txt.length===6)setTimeout(verifyTOTP,100);
            });
            });
            var _clockTimer=null;
            function startTotpClock(){
            stopTotpClock();
            function tick(){
            var now=Math.floor(Date.now()/1000),rem=30-(now%30);
            document.getElementById('tval').textContent=rem;
            var pct=(rem/30)*100;
            document.getElementById('tbar').style.width=pct+'%';
            document.getElementById('tbar').style.background=rem<=10?'linear-gradient(90deg,#dc2626,#f97316)':'linear-gradient(90deg,#0057b8,#06c3ff)';
            }tick();_clockTimer=setInterval(tick,1000);
            }
            function stopTotpClock(){if(_clockTimer){clearInterval(_clockTimer);_clockTimer=null;}}
            function verifyTOTP(){
            var code=Array.from(document.querySelectorAll('.otp-digit')).map(function(e){return e.value;}).join('');
            if(code.length<6){
            setOtpFeedback(t('please_enter_complete_otp'),'error');
            document.querySelectorAll('.otp-digit').forEach(function(el){if(!el.value)el.classList.add('error-d');});return;
            }
            document.getElementById('verifyBtnText').textContent = t('verifying');
            document.getElementById('verifySpinner').style.display='block';
            document.getElementById('verifyBtn').disabled=true;
            var fd=new FormData();fd.append('action','verify_totp');fd.append('code',code);
            fetch('register.php',{method:'POST',credentials:'same-origin',body:fd})
            .then(function(r){var ct=r.headers.get('content-type')||'';if(!ct.includes('json'))return r.text().then(function(t){throw new Error('Server: '+t.substring(0,200));});return r.json();})
            .then(function(data){
            document.getElementById('verifySpinner').style.display='none';
            if(data.status==='registered'){
            stopTotpClock();
            document.getElementById('verifyBtn').style.background='linear-gradient(90deg,#15803d,#16a34a)';
            document.getElementById('verifyBtnText').textContent = t('registration_successful');
            setOtpFeedback(t('account_created_successfully'),'success');
            document.querySelectorAll('.otp-digit').forEach(function(el){el.classList.remove('error-d');el.classList.add('filled');el.style.borderColor='#16a34a';});
            setTimeout(function(){
            closeAuthModal();showLogin();
            var sbox=document.createElement('div');sbox.className='success-box';sbox.style.marginBottom='.875rem';
            sbox.innerHTML='<i class="fas fa-check-circle"></i> ' + t('registration_complete_login');
            var lp=document.getElementById('loginPanel');lp.insertBefore(sbox,lp.querySelector('form'));
            setTimeout(function(){if(sbox.parentNode)sbox.parentNode.removeChild(sbox);},6000);
            },2000);
            }else{
            document.getElementById('verifyBtn').disabled=false;
            document.getElementById('verifyBtnText').textContent = t('verify_complete_registration');
            document.querySelectorAll('.otp-digit').forEach(function(el){el.classList.add('error-d');});
            setOtpFeedback((data.msg || t('invalid_code_wait')),'error');
            setTimeout(function(){document.querySelectorAll('.otp-digit').forEach(function(el){el.classList.remove('error-d');el.classList.remove('filled');el.value='';});document.getElementById('otp0').focus();},1200);
            }
            })
            .catch(function(err){
            document.getElementById('verifyBtn').disabled=false;
            document.getElementById('verifyBtnText').textContent = t('verify_complete_registration');
            document.getElementById('verifySpinner').style.display='none';
            setOtpFeedback('Connection error: '+(err.message || t('try_again')),'error');
            });
            }
            function setOtpFeedback(msg,type){
            var el=document.getElementById('otp-feedback');el.style.display='block';el.textContent=msg;
            if(type==='success'){el.style.background='#f0fdf4';el.style.color='#15803d';el.style.border='1px solid #bbf7d0';}
            else{el.style.background='#fef2f2';el.style.color='#b91c1c';el.style.border='1px solid #fee2e2';}
            }
            
            /* ════════════════════════════════════════════════════
            RESET PASSWORD — ສົ່ງໄປ login.php?ajax=reset
            ════════════════════════════════════════════════════ */
            var _rstClock=null;
            
            function openResetModal(){
            document.getElementById('resetModal').classList.add('open');
            rstGoPage(1);
            }
            function closeResetModal(){
            document.getElementById('resetModal').classList.remove('open');
            stopRstClock();rstClear();
            }
            document.getElementById('resetModal').addEventListener('click',function(e){if(e.target===this)closeResetModal();});
            
            function rstGoPage(n){
            for(var i=1;i<=3;i++){
            document.getElementById('rpg'+i).classList.toggle('active',i===n);
            var tab=document.getElementById('rtab'+i);
            tab.className='rst-tab'+(i<n?' done':i===n?' active':'');
            }
            }
            
            function rstFb(id,msg,type){
            var el=document.getElementById(id);
            el.className='rst-fb on '+(type==='ok'?'ok':'err');
            el.innerHTML='<i class="fas fa-'+(type==='ok'?'check-circle':'circle-exclamation')+'"></i> '+msg;
            }
            function rstFbHide(id){document.getElementById(id).className='rst-fb';}
            
            function rstStr(v){
            var s=0;
            if(v.length>=6)s++;if(v.length>=10)s++;
            if(/[A-Z]/.test(v)&&/[0-9]/.test(v))s++;if(/[^A-Za-z0-9]/.test(v))s++;
            var c=['#fee2e2','#fed7aa','#fef08a','#bbf7d0'];
            var l=[['Weak','#dc2626'],['Fair','#d97706'],['Good','#ca8a04'],['Strong','#16a34a']];
            for(var i=0;i<4;i++) document.getElementById('sb'+(i+1)).style.background=i<s?c[i]:'#e8eef8';
            var lbl=document.getElementById('slbl');
            if(!v.length){lbl.textContent='';return;}
            var idx=Math.max(0,s-1);lbl.textContent=l[idx][0];lbl.style.color=l[idx][1];
            rstMatch();
            }
            function rstMatch(){
            var pw=document.getElementById('rst_pw').value;
            var pw2=document.getElementById('rst_pw2').value;
            var mh=document.getElementById('rst_mh');
            if(!pw2){mh.className='pw-match-hint';return;}
            mh.className='pw-match-hint on';
            mh.innerHTML=pw===pw2
            ?'<i class="fas fa-check" style="color:#16a34a;"></i><span style="color:#16a34a;font-weight:600;">Passwords match ✓</span>'
            :'<i class="fas fa-times" style="color:#dc2626;"></i><span style="color:#dc2626;font-weight:600;">Passwords not match</span>';
            document.getElementById('rst_pw2').className='rst-field'+(pw===pw2?' ok':' bad');
            }
            
            /* safe fetch → JSON */
            async function rstPost(fd){
            var res=await fetch(RST_URL,{method:'POST',body:fd});
            var txt=await res.text();
            console.log('Raw response:', txt); // Debug log
            try{
                var jsonData = JSON.parse(txt);
                console.log('Parsed JSON:', jsonData); // Debug log
                return jsonData;
            }
            catch(e){
                console.error('JSON parse error:', e, 'Raw text:', txt);
                throw new Error('ການຕອບສະໜອງບໍ່ຖືກຕ້ອງ: ' + txt.replace(/<[^>]+>/g,' ').trim().slice(0,100));
            }
            }
            
            /* STEP 1 */
            async function rstRequest(){
    rstFbHide('rfb1');
    var em = document.getElementById('rst_em').value.trim();
    var pw = document.getElementById('rst_pw').value;
    var pw2 = document.getElementById('rst_pw2').value;

    if(!em || !pw || !pw2){
        rstFb('rfb1', 'Please fill in all fields', 'err');
        return;
    }

    if(pw.length < 6){
        rstFb('rfb1', 'Password must be at least 6 characters', 'err');
        return;
    }

    if(pw !== pw2){
        rstFb('rfb1', 'Passwords do not match', 'err');
        return;
    }
    
    var btn = document.getElementById('rstReqBtn');
    btn.disabled = true;
    document.getElementById('rstReqTxt').textContent = 'Processing...';
            document.getElementById('rstReqSpin').style.display='block';
            
            var fd=new FormData();
            fd.append('action','request_reset');
            fd.append('email',em);
            fd.append('new_password',pw);
            fd.append('confirm_pw',pw2);
            
            try{
            var d=await rstPost(fd);
            console.log('Reset response:', d); // Debug log
            if(d.status==='need_totp'){
            rstFb('rfb1','Please open your authenticator app and enter the 6-digit code','ok');
            setTimeout(function(){
                rstGoPage(2);
                rstClearDigits();
                startRstClock();
                setTimeout(function(){document.getElementById('td0').focus();},150);
            }, 1000);
            } else if(d.status==='error') {
            rstFb('rfb1',d.msg||'An error has occurred','err');
            } else {
            rstFb('rfb1','The response is incorrect','err');
            }
            }catch(e){
            console.error('Reset error:', e);
            rstFb('rfb1','An error has occurred: ' + e.message,'err');
            }finally{
            btn.disabled=false;
            document.getElementById('rstReqTxt').textContent='Confirm OTP to Save Changes';
            document.getElementById('rstReqSpin').style.display='none';
            }
            }
            
            function startRstClock(){
            stopRstClock();
            function tick(){
            var now=Math.floor(Date.now()/1000),rem=30-(now%30);
            document.getElementById('rstTval').textContent=rem;
            document.getElementById('rstTbar').style.width=((rem/30)*100)+'%';
            }tick();_rstClock=setInterval(tick,1000);
            }
            function stopRstClock(){if(_rstClock){clearInterval(_rstClock);_rstClock=null;}}
            
            /* STEP 2 */
            async function rstVerify(){
            rstFbHide('rfb2');
            var code=Array.from(document.querySelectorAll('.totp-digit')).map(function(e){return e.value;}).join('');
            if(code.length<6){
            rstFb('rfb2','Please enter a complete 6-digit code.','err');
            document.querySelectorAll('.totp-digit').forEach(function(el){if(!el.value)el.classList.add('error-d');});
            return;
            }
            var btn=document.getElementById('rstVerBtn');
            btn.disabled=true;
            document.getElementById('rstVerTxt').textContent='Checking...';
            document.getElementById('rstVerSpin').style.display='block';
            
            var fd=new FormData();
            fd.append('action','verify_totp');
            fd.append('code',code);
            
            try{
            var d=await rstPost(fd);
            if(d.status==='success'){
            stopRstClock();
            document.querySelectorAll('.totp-digit').forEach(function(el){el.classList.add('success-d');});
            setTimeout(function(){rstGoPage(3);},600);
            } else {
            rstFb('rfb2',d.msg||'Incorrect code, try again','err');
            document.querySelectorAll('.totp-digit').forEach(function(el){el.classList.add('error-d');});
            setTimeout(function(){rstClearDigits();document.getElementById('td0').focus();},1000);
            }
            }catch(e){
            rstFb('rfb2',e.message,'err');
            }finally{
            btn.disabled=false;
            document.getElementById('rstVerTxt').textContent='Confirm and Change Password';
            document.getElementById('rstVerSpin').style.display='none';
            }
            }
            
            /* TOTP digit inputs */
            document.querySelectorAll('.totp-digit').forEach(function(inp){
            inp.addEventListener('input',function(){
            this.value=this.value.replace(/[^0-9]/g,'').slice(-1);
            if(this.value){
            this.classList.add('filled');
            var next=document.getElementById('td'+(parseInt(this.dataset.ti)+1));
            if(next)next.focus();
            var all=Array.from(document.querySelectorAll('.totp-digit')).map(function(e){return e.value;});
            if(all.every(function(v){return v!=='';}))setTimeout(rstVerify,100);
            }else{this.classList.remove('filled');}
            });
            inp.addEventListener('keydown',function(e){
            if(e.key==='Backspace'&&!this.value){
            var prev=document.getElementById('td'+(parseInt(this.dataset.ti)-1));
            if(prev){prev.value='';prev.classList.remove('filled');prev.focus();}
            }
            if(e.key==='Enter')rstVerify();
            });
            inp.addEventListener('paste',function(e){
            var txt=(e.clipboardData||window.clipboardData).getData('text').replace(/\D/g,'').slice(0,6);
            e.preventDefault();
            for(var i=0;i<txt.length;i++){var el=document.getElementById('td'+i);if(el){el.value=txt[i];el.classList.add('filled');}}
            var last=document.getElementById('td'+(Math.min(txt.length,5)));if(last)last.focus();
            if(txt.length===6)setTimeout(rstVerify,100);
            });
            });
            
            function rstClearDigits(){
            for(var i=0;i<6;i++){var el=document.getElementById('td'+i);if(el){el.value='';el.className='totp-digit';}}
            rstFbHide('rfb2');
            document.getElementById('rstVerBtn').disabled=false;
            document.getElementById('rstVerTxt').textContent='Confirm and Change Password';
            }
            function rstBack(){stopRstClock();rstClearDigits();rstGoPage(1);}
            function rstClear(){
            ['rst_em','rst_pw','rst_pw2'].forEach(function(id){var el=document.getElementById(id);if(el)el.value='';});
            rstClearDigits();
            document.getElementById('rst_mh').className='pw-match-hint';
            rstFbHide('rfb1');rstFbHide('rfb2');
            rstStr('');
            document.getElementById('rst_pw2').className='rst-field';
            }
            </script>
            </body>
            </html>
