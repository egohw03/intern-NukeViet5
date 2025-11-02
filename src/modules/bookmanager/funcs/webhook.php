<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

// 1. Kiểm tra file op chuẩn
if (!defined('NV_IS_MOD_BOOKMANAGER')) {
    die('Stop!!!');
}

// 2. (QUAN TRỌNG) Tắt theme, header, footer
// Báo cho NukeViet biết đây là một
// 'op' đặc biệt, không cần render HTML
if (defined('NV_IS_AJAX')) {
    define('NV_IS_MOD_AJAX', true);
}
@ob_end_clean(); // Xóa bộ đệm (nếu có)
define('NV_NO_HEADER', true); // Không nạp header
define('NV_NO_FOOTER', true); // Không nạp footer

// 3. Nạp các hàm cần thiết
// (Tất cả biến global $db, $module_data... đã có sẵn)
require_once NV_ROOTDIR . '/modules/bookmanager/funcs/functions.php';

// 4. Giữ nguyên logic xử lý webhook của bạn
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

            // Email disabled
            // $customer_info = [
            //     'name' => $order['customer_name'],
            //     'email' => $order['customer_email'],
            //     'phone' => $order['customer_phone'],
            //     'address' => $order['customer_address']
            // ];
            //
            // try {
            //     nv_send_order_confirmation_email($order['order_code'], $customer_info);
            //     error_log('Payment confirmation email sent for order: ' . $order['order_code']);
            // } catch (Exception $e) {
            //     error_log('Failed to send payment confirmation email: ' . $e->getMessage());
            // }
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

// 5. (QUAN TRỌNG) Dừng kịch bản ngay lập tức
die();
?>