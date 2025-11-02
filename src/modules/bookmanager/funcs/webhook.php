<?php
// File này không được include header.php hay footer.php
define('NV_SYSTEM', true);

// Nạp CSDL và các hàm core của NukeViet
require_once dirname(dirname(dirname(__DIR__))) . '/includes/mainfile.php';

// 1. Xác thực Webhook (tự động load config)
$webhookData = nv_payos_verify_webhook();

if ($webhookData && $webhookData['code'] == '00') {
    $order_id = $webhookData['data']['orderCode']; // Đây là ID (số)

    // 2. Kiểm tra CSDL
    $sql = 'SELECT payment_status FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders WHERE id = :order_id';
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
    }

    // 4. Phản hồi 200 OK cho PayOS
    http_response_code(200);
    echo 'OK';

} else {
    // Chữ ký không hợp lệ hoặc thanh toán thất bại
    http_response_code(400);
    die('Webhook verification failed or payment failed');
}
?>
