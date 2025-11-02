<?php
// File này không được include header.php hay footer.php
define('NV_SYSTEM', true);

// Nạp CSDL và các hàm core của NukeViet
require_once dirname(dirname(dirname(__DIR__))) . '/includes/mainfile.php';

// ===========================================
// BẮT ĐẦU SỬA LỖI 500
// Phải khai báo thủ công các biến module vì file này chạy độc lập
global $module_data, $module_name, $lang_module, $global_config, $db;
$module_name = 'bookmanager';
$module_data = $module_name; // Trong NukeViet 5.x, $module_data chỉ là tên module

// Define ngôn ngữ nếu chưa có
if (!defined('NV_LANG_DATA')) {
    define('NV_LANG_DATA', 'vi');
}
if (!defined('NV_LANG_INTERFACE')) {
    define('NV_LANG_INTERFACE', 'vi');
}

// Nạp ngôn ngữ cho module (cần cho việc gửi mail)
if (file_exists(NV_ROOTDIR . '/modules/bookmanager/language/' . NV_LANG_DATA . '.php')) {
     require_once(NV_ROOTDIR . '/modules/bookmanager/language/' . NV_LANG_DATA . '.php');
}

// Nạp hàm global (chứa hàm nv_send_order_confirmation_email)
if (file_exists(NV_ROOTDIR . '/modules/bookmanager/global.functions.php')) {
    require_once(NV_ROOTDIR . '/modules/bookmanager/global.functions.php');
}
// ===========================================
// KẾT THÚC SỬA LỖI 500

// THÊM DÒNG NÀY:
require_once NV_ROOTDIR . '/modules/bookmanager/funcs/functions.php';

try {
    // 1. Xác thực Webhook (tự động load config)
    $webhookData = nv_payos_verify_webhook();

if ($webhookData && $webhookData['code'] == '00') {
        $order_id = $webhookData['data']['orderCode']; // Đây là ID (số)

    // 2. Kiểm tra CSDL
    $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders WHERE id = :order_id';
    $stmt = $db->prepare($sql);
    $stmt->bindParam(':order_id', $order_id, PDO::PARAM_INT);
    $stmt->execute();
        $order = $stmt->fetch();

    // 3. Cập nhật (Nếu đơn hàng tồn tại VÀ chưa thanh toán)
if ($order && $order['payment_status'] == 0) {
$sql_update = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_orders
    SET payment_status = 1, order_status = 1
                            WHERE id = :order_id';

    $stmt_update = $db->prepare($sql_update);
    $stmt_update->bindParam(':order_id', $order_id, PDO::PARAM_INT);
            $stmt_update->execute();

    // 4. Gửi email xác nhận thanh toán thành công
$customer_info = [
    'name' => $order['customer_name'],
    'email' => $order['customer_email'],
    'phone' => $order['customer_phone'],
        'address' => $order['customer_address']
            ];

try {
    nv_send_order_confirmation_email($order['order_code'], $customer_info);
        error_log('Payment confirmation email sent for order: ' . $order['order_code']);
} catch (Exception $e) {
        error_log('Failed to send payment confirmation email: ' . $e->getMessage());
        }
        }

    // 5. Phản hồi 200 OK cho PayOS
    http_response_code(200);
        echo 'OK';

} else {
    // Chữ ký không hợp lệ hoặc thanh toán thất bại
    http_response_code(400);
        echo 'Webhook verification failed or payment failed';
    }
} catch (Exception $e) {
    error_log('Webhook internal error: ' . $e->getMessage() . ' in ' . $e->getFile() . ':' . $e->getLine());
    http_response_code(500);
    echo 'Internal server error';
}
?>
