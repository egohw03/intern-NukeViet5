<?php
/**
 * PayOS Configuration
 * Contains API keys for PayOS payment gateway
 */

// PayOS API Keys
define('PAYOS_CLIENT_ID', 'c0106937-c219-4e59-a728-0650783e8db5');
define('PAYOS_API_KEY', '7579836f-deb7-41e9-b273-970220d95130');
define('PAYOS_CHECKSUM_KEY', '4f56b5991899d9732a561e6cc4e6190c7db78008c9c0d70f75971fd015cab0d4');

// Webhook URL
// (Hãy đảm bảo tên miền ngrok là đúng với cái đang chạy)

// URL đúng (trỏ tới file .php trực tiếp, không qua index.php)
define('PAYOS_WEBHOOK_URL', 'https://unhumbled-paulita-noncreatively.ngrok-free.dev/nukeviet-nukeviet5.0/src/modules/bookmanager/funcs/webhook.php');
?>