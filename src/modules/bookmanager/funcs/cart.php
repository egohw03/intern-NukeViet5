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

$page_title = $nv_Lang->getModule('cart');
$key_words = $page_title;
$description = $page_title;

// Get cart items
$sql = 'SELECT c.id, c.quantity, b.id as book_id, b.title, b.image, b.price FROM ' . NV_PREFIXLANG . '_' . $module_data . '_cart c INNER JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_books b ON c.book_id = b.id WHERE c.userid = ' . $user_info['userid'] . ' ORDER BY c.add_time DESC';
$result = $db->query($sql);
$cart_items = [];
$total = 0;
while ($row = $result->fetch()) {
    $row['image_url'] = !empty($row['image']) ? NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $row['image'] : '';
    $row['price_format'] = number_format($row['price'], 0, ',', '.') . ' VND';
    $row['subtotal'] = $row['price'] * $row['quantity'];
    $row['subtotal_format'] = number_format($row['subtotal'], 0, ',', '.') . ' VND';
    $cart_items[] = $row;
    $total += $row['subtotal'];
}
$total_format = number_format($total, 0, ',', '.') . ' VND';

// Handle coupon application
$coupon_code = $nv_Request->get_title('coupon_code', 'post', '');
$discount = 0;
$coupon_error = '';
$coupon_applied = false;

if ($nv_Request->isset_request('apply_coupon', 'post') && !empty($coupon_code)) {
    $current_time = NV_CURRENTTIME;
    $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_coupons WHERE code = :code AND status = 1 AND start_time <= :current_time AND end_time >= :current_time';
    $stmt = $db->prepare($sql);
    $stmt->bindParam(':code', $coupon_code, PDO::PARAM_STR);
    $stmt->bindParam(':current_time', $current_time, PDO::PARAM_INT);
    $stmt->execute();
    $coupon = $stmt->fetch();

    if ($coupon) {
        if ($coupon['type'] == 0) { // Percentage
            $discount = $total * ($coupon['value'] / 100);
        } else { // Fixed amount
            $discount = min($coupon['value'], $total);
        }
        $coupon_applied = true;
        // Store coupon in session for checkout
        $_SESSION[$module_data]['coupon'] = [
            'code' => $coupon_code,
            'discount' => $discount
        ];
    } else {
        $coupon_error = $nv_Lang->getModule('invalid_coupon');
    }
}

// Apply stored coupon if exists
if (isset($_SESSION[$module_data]['coupon'])) {
    $discount = $_SESSION[$module_data]['coupon']['discount'];
    $coupon_applied = true;
    $coupon_code = $_SESSION[$module_data]['coupon']['code'];
}

$final_total = $total - $discount;
$final_total_format = number_format($final_total, 0, ',', '.') . ' VND';
$discount_format = number_format($discount, 0, ',', '.') . ' VND';

// Handle update cart
if ($nv_Request->isset_request('update_cart', 'post')) {
    $quantities = $nv_Request->get_array('quantity', 'post');
    foreach ($quantities as $cart_id => $quantity) {
        $quantity = (int) $quantity;
        if ($quantity > 0) {
            $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_cart SET quantity = ' . $quantity . ' WHERE id = ' . (int) $cart_id . ' AND userid = ' . $user_info['userid']);
        }
    }
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=cart');
}

// Handle remove item
if ($nv_Request->isset_request('remove', 'get')) {
    $cart_id = $nv_Request->get_int('remove', 'get', 0);
    if ($cart_id > 0) {
        $db->query('DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_cart WHERE id = ' . $cart_id . ' AND userid = ' . $user_info['userid']);
    }
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=cart');
}

// Breadcrumb
$array_mod_title[] = [
    'title' => $module_info['site_title'],
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name
];
$array_mod_title[] = [
    'title' => $page_title,
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=cart'
];

$contents = book_cart_theme($cart_items, $total, $total_format, $discount, $discount_format, $final_total, $final_total_format, $coupon_code, $coupon_error, $coupon_applied);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
