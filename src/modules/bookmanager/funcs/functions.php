<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

/**
 * Format price
 */
function nv_format_price($price)
{
    return number_format($price, 0, ',', '.') . ' VNĐ';
}

// ===========================================
// BẮT ĐẦU CODE CẦN THÊM
// ===========================================

// Include file config PayOS
require_once NV_ROOTDIR . '/modules/bookmanager/payos_config.php';

/**
 * [ĐÃ XÓA COUPON] Tạo đơn hàng mới
 *
 * @param array $customer_info Thông tin khách hàng
 * @param string $payment_method Phương thức thanh toán
 * @return array|null Mảng chứa order_id và order_code, hoặc null nếu lỗi
 */
function nv_create_order($customer_info, $payment_method)
{
    global $db, $module_data, $user_info;

    // Lấy giỏ hàng và tổng tiền
    $cart = nv_get_cart();
    $total = nv_get_cart_total();
    if (empty($cart)) {
        return null;
    }

    // Tạo mã đơn hàng duy nhất (10 ký tự: BKM- + 6 ký tự)
    $order_code = 'BKM-' . strtoupper(substr(uniqid(), -6));
    $payment_status = ($payment_method == 'COD') ? 0 : 0; // 0 = Chưa thanh toán
    $order_status = 0; // 0 = Chờ xử lý

    try {
        $db->beginTransaction();

        // 1. Chèn vào bảng _orders
        $sql = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_orders
                (userid, order_code, customer_name, customer_email, customer_phone, customer_address,
                 total_amount, order_status, payment_status, payment_method, add_time)
                VALUES
                (:userid, :order_code, :customer_name, :customer_email, :customer_phone, :customer_address,
                 :total_amount, :order_status, :payment_status, :payment_method, ' . NV_CURRENTTIME . ')';

        $stmt = $db->prepare($sql);
        $stmt->bindParam(':userid', $user_info['userid'], PDO::PARAM_INT);
        $stmt->bindParam(':order_code', $order_code, PDO::PARAM_STR);
        $stmt->bindParam(':customer_name', $customer_info['name'], PDO::PARAM_STR);
        $stmt->bindParam(':customer_email', $customer_info['email'], PDO::PARAM_STR);
        $stmt->bindParam(':customer_phone', $customer_info['phone'], PDO::PARAM_STR);
        $stmt->bindParam(':customer_address', $customer_info['address'], PDO::PARAM_STR);
        $stmt->bindParam(':total_amount', $total, PDO::PARAM_STR);
        $stmt->bindParam(':order_status', $order_status, PDO::PARAM_INT);
        $stmt->bindParam(':payment_status', $payment_status, PDO::PARAM_INT);
        $stmt->bindParam(':payment_method', $payment_method, PDO::PARAM_STR);

        $stmt->execute();
        $order_id = $db->lastInsertId();

        if (!$order_id) {
            throw new Exception("Không thể tạo đơn hàng.");
        }

        // 2. Chèn vào bảng _order_items
        $sql_item = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_order_items
                     (order_id, book_id, quantity, price)
                     VALUES
                     (:order_id, :book_id, :quantity, :price)';

        $stmt_item = $db->prepare($sql_item);

        foreach ($cart as $item) {
            $stmt_item->bindParam(':order_id', $order_id, PDO::PARAM_INT);
            $stmt_item->bindParam(':book_id', $item['book_id'], PDO::PARAM_INT);
            $stmt_item->bindParam(':quantity', $item['quantity'], PDO::PARAM_INT);
            $stmt_item->bindParam(':price', $item['price'], PDO::PARAM_STR);
            $stmt_item->execute();

            // 3. Trừ kho (Quan trọng)
            nv_update_stock($item['book_id'], $item['quantity']);
        }

        $db->commit();

        // 4. Xóa giỏ hàng
        nv_clear_cart();
        unset($_SESSION['checkout_form']);

        return ['order_id' => $order_id, 'order_code' => $order_code];

    } catch (Exception $e) {
        $db->rollBack();
        error_log('Lỗi tạo đơn hàng: ' . $e->getMessage());
        return null;
    }
}

/**
 * [DÙNG cURL] Tạo link thanh toán PayOS
 */
function nv_payos_create_payment_link($order_id, $amount, $description, $return_url, $cancel_url)
{
    $payos_api_url = 'https://api-merchant.payos.vn/v2/payment-requests';

    // 1. Dữ liệu gốc (để gửi trong body)
    $data = [
        'orderCode' => $order_id,
        'amount' => $amount,
        'description' => $description,
        'returnUrl' => $return_url,
        'cancelUrl' => $cancel_url
    ];
    $json_data = json_encode($data);

    // 2. TẠO CHỮ KÝ ĐÚNG (SỬA LỖI Ở ĐÂY)
    // Dữ liệu để tạo chữ ký phải được sắp xếp theo key
    $data_to_sign = $data; // Copy mảng
    ksort($data_to_sign); // Sắp xếp các key theo thứ tự alphabet

    // Tạo chuỗi canonical (key1=value1&key2=value2...)
    $canonical_string = '';
    foreach ($data_to_sign as $key => $value) {
        $canonical_string .= $key . '=' . $value . '&';
    }
    $canonical_string = rtrim($canonical_string, '&');

    // 3. Tạo chữ ký từ chuỗi đã sắp xếp
    $signature = hash_hmac('sha256', $canonical_string, PAYOS_CHECKSUM_KEY);

    // 4. Chuẩn bị header (dùng chữ ký vừa tạo)
    $headers = [
        'x-client-id: ' . PAYOS_CLIENT_ID,
        'x-api-key: ' . PAYOS_API_KEY,
        'x-signature: ' . $signature, // Chữ ký đã được sửa
        'Content-Type: application/json'
    ];

    try {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $payos_api_url);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $json_data); // Body là JSON của dữ liệu gốc
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        
        // Bỏ qua xác thực SSL (cho localhost)
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

        $response_body = curl_exec($ch);
        $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);

        if ($http_code != 200 && $http_code != 201) {
             // Ghi log lỗi cURL
             error_log('PayOS cURL Error: ' . curl_error($ch));
        }

        curl_close($ch);

        if ($http_code == 200 || $http_code == 201) {
            $response_data = json_decode($response_body, true);
            if ($response_data && $response_data['code'] == '00' && isset($response_data['data']['checkoutUrl'])) {
                return $response_data['data']['checkoutUrl'];
            } else {
                // Ghi log nếu PayOS trả về lỗi (như lỗi code 20)
                error_log('PayOS API Error: ' . $response_body); 
            }
        }
    } catch (Exception $e) {
        error_log('PayOS cURL Exception: ' . $e->getMessage());
    }
    return null;
}

/**
 * [KHÔNG DÙNG SDK] Xác thực Webhook từ PayOS
 */
function nv_payos_verify_webhook()
{
    try {
        $headers = getallheaders();
        $payos_signature = $headers['x-payos-signature'] ?? $headers['X-Payos-Signature'] ?? ($_SERVER['HTTP_X_PAYOS_signature'] ?? '');
        if (empty($payos_signature)) {
            return null;
        }

        $webhook_body = file_get_contents('php://input');
        if (empty($webhook_body)) {
            return null;
        }

        $expected_signature = hash_hmac('sha256', $webhook_body, PAYOS_CHECKSUM_KEY);

        if (hash_equals($expected_signature, $payos_signature)) {
            return json_decode($webhook_body, true);
        }
    } catch (Exception $e) {
        error_log('PayOS Webhook Exception: ' . $e->getMessage());
    }
    return null;
}

/**
 * Cập nhật số lượng tồn kho
 */
function nv_update_stock($book_id, $quantity)
{
    global $db, $module_data;
    $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_books SET stock_quantity = stock_quantity - :quantity WHERE id = :book_id';
    $stmt = $db->prepare($sql);
    $stmt->bindParam(':quantity', $quantity, PDO::PARAM_INT);
    $stmt->bindParam(':book_id', $book_id, PDO::PARAM_INT);
    return $stmt->execute();
}

/**
 * Xóa giỏ hàng của user hiện tại
 */
function nv_clear_cart()
{
    global $db, $module_data, $user_info;
    $sql = 'DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_cart WHERE userid = :userid';
    $stmt = $db->prepare($sql);
    $stmt->bindParam(':userid', $user_info['userid'], PDO::PARAM_INT);
    return $stmt->execute();
}

// ===========================================
// KẾT THÚC CODE CẦN THÊM
// ===========================================

?>