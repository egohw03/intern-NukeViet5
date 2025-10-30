<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_IS_MOD_BOOKMANAGER')) {
    die('Stop!!!');
}

if (!defined('NV_IS_USER')) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users&nv_redirect=' . nv_redirect_encrypt($client_info['selfurl']));
}

$page_title = $nv_Lang->getModule('checkout');
$key_words = $page_title;
$description = $page_title;

// Check if cart is empty
$sql = 'SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_cart WHERE userid = ' . $user_info['userid'];
$cart_count = $db->query($sql)->fetchColumn();
if ($cart_count == 0) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

// Get cart items for checkout
$sql = 'SELECT c.quantity, b.id as book_id, b.title, b.price, b.stock_quantity FROM ' . NV_PREFIXLANG . '_' . $module_data . '_cart c INNER JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_books b ON c.book_id = b.id WHERE c.userid = ' . $user_info['userid'];
$result = $db->query($sql);
$checkout_items = [];
$total = 0;
while ($row = $result->fetch()) {
    if ($row['quantity'] > $row['stock_quantity']) {
        $row['quantity'] = $row['stock_quantity'];
    }
    $row['subtotal'] = $row['price'] * $row['quantity'];
    $checkout_items[] = $row;
    $total += $row['subtotal'];
}

// Handle place order
if ($nv_Request->isset_request('place_order', 'post')) {
    $customer_name = $nv_Request->get_title('customer_name', 'post', '');
    $customer_email = $nv_Request->get_title('customer_email', 'post', '');
    $customer_phone = $nv_Request->get_title('customer_phone', 'post', '');
    $customer_address = $nv_Request->get_textarea('customer_address', 'post', '');
    $payment_method = $nv_Request->get_title('payment_method', 'post', '');
    $order_note = $nv_Request->get_textarea('order_note', 'post', '');

    // Validation
    $errors = [];
    if (empty($customer_name)) $errors[] = $nv_Lang->getModule('error_customer_name');
    if (empty($customer_email) || !nv_check_valid_email($customer_email)) $errors[] = $nv_Lang->getModule('error_customer_email');
    if (empty($customer_phone)) $errors[] = $nv_Lang->getModule('error_customer_phone');
    if (empty($customer_address)) $errors[] = $nv_Lang->getModule('error_customer_address');

    if (empty($errors)) {
        // Generate order code
        $order_code = 'ORD' . date('YmdHis') . rand(100, 999);

        // Handle coupon
        $coupon_code = '';
        $discount_amount = 0;
        if (isset($_SESSION[$module_data]['coupon'])) {
            $coupon_code = $_SESSION[$module_data]['coupon']['code'];
            $discount_amount = $_SESSION[$module_data]['coupon']['discount'];
        }
        $final_total = $total - $discount_amount;

        // Insert order
        $sql = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_orders (userid, order_code, customer_name, customer_email, customer_phone, customer_address, total_amount, coupon_code, discount_amount, order_status, payment_status, payment_method, order_note, add_time) VALUES (:userid, :order_code, :customer_name, :customer_email, :customer_phone, :customer_address, :total_amount, :coupon_code, :discount_amount, 0, 0, :payment_method, :order_note, :add_time)';
        $stmt = $db->prepare($sql);
        $stmt->bindParam(':userid', $user_info['userid'], PDO::PARAM_INT);
        $stmt->bindParam(':order_code', $order_code, PDO::PARAM_STR);
        $stmt->bindParam(':customer_name', $customer_name, PDO::PARAM_STR);
        $stmt->bindParam(':customer_email', $customer_email, PDO::PARAM_STR);
        $stmt->bindParam(':customer_phone', $customer_phone, PDO::PARAM_STR);
        $stmt->bindParam(':customer_address', $customer_address, PDO::PARAM_STR);
        $stmt->bindParam(':total_amount', $final_total, PDO::PARAM_STR);
        $stmt->bindParam(':coupon_code', $coupon_code, PDO::PARAM_STR);
        $stmt->bindParam(':discount_amount', $discount_amount, PDO::PARAM_STR);
        $stmt->bindParam(':payment_method', $payment_method, PDO::PARAM_STR);
        $stmt->bindParam(':order_note', $order_note, PDO::PARAM_STR);
        $stmt->bindValue(':add_time', NV_CURRENTTIME, PDO::PARAM_INT);
        $stmt->execute();
        $order_id = $db->lastInsertId();

        // Insert order items
        foreach ($checkout_items as $item) {
            $sql = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_order_items (order_id, book_id, quantity, price) VALUES (:order_id, :book_id, :quantity, :price)';
            $stmt = $db->prepare($sql);
            $stmt->bindParam(':order_id', $order_id, PDO::PARAM_INT);
            $stmt->bindParam(':book_id', $item['book_id'], PDO::PARAM_INT);
            $stmt->bindParam(':quantity', $item['quantity'], PDO::PARAM_INT);
            $stmt->bindParam(':price', $item['price'], PDO::PARAM_STR);
            $stmt->execute();

            // Update stock
            $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_books SET stock_quantity = stock_quantity - ' . $item['quantity'] . ' WHERE id = ' . $item['book_id']);
        }

        // Clear cart
        $db->query('DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_cart WHERE userid = ' . $user_info['userid']);

        // Clear coupon session
        if (isset($_SESSION[$module_data]['coupon'])) {
            unset($_SESSION[$module_data]['coupon']);
        }

        // Redirect to success page
        nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=success&order_code=' . $order_code);
    }
}

// Pre-fill customer info
$customer_info = [
    'name' => $user_info['full_name'] ?: $user_info['username'],
    'email' => $user_info['email'],
    'phone' => $user_info['phone'] ?: '',
    'address' => $user_info['address'] ?: ''
];

// Breadcrumb
$array_mod_title[] = [
    'title' => $module_info['site_title'],
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name
];
$array_mod_title[] = [
    'title' => $page_title,
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=checkout'
];

$contents = book_checkout_theme($checkout_items, $total, $customer_info, $errors ?? []);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
