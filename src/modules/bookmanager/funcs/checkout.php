<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

require_once NV_ROOTDIR . '/modules/bookmanager/funcs/functions.php';

if (!defined('NV_IS_USER')) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$cart = nv_get_cart();
if (empty($cart)) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=cart');
}

$page_title = $lang_module['checkout'];
$key_words = $lang_module['checkout'];

$total = nv_get_cart_total();
$discount = 0;
$coupon_applied = false;
$coupon_message = '';

// Handle apply coupon
if ($nv_Request->isset_request('apply_coupon', 'post')) {
    $coupon_code = $nv_Request->get_title('coupon_code', 'post', '');
    $coupon_result = nv_apply_coupon($coupon_code, $total);
    if ($coupon_result['valid']) {
        $discount = $coupon_result['discount'];
        $coupon_applied = true;
        $coupon_message = 'Mã giảm giá đã được áp dụng';
    } else {
        $coupon_message = $coupon_result['message'];
    }
}

$final_total = $total - $discount;
$order_created = false;
$order_code = '';

// Handle checkout
if ($nv_Request->isset_request('checkout', 'post')) {
    $customer_info = [
        'name' => $nv_Request->get_title('customer_name', 'post', ''),
        'email' => $nv_Request->get_title('customer_email', 'post', ''),
        'phone' => $nv_Request->get_title('customer_phone', 'post', ''),
        'address' => $nv_Request->get_textarea('customer_address', 'post', '', 'br')
    ];

    $payment_method = $nv_Request->get_title('payment_method', 'post', 'COD');

    if (!empty($customer_info['name']) && !empty($customer_info['email']) && !empty($customer_info['phone']) && !empty($customer_info['address'])) {
        $order_code = nv_create_order_with_coupon($customer_info, $payment_method, $coupon_applied ? $coupon_result['coupon']['id'] : 0, $discount);
        if ($order_code) {
            $order_created = true;
        }
    }
}

// Breadcrumbs
$array_mod_title[] = [
    'title' => $lang_module['checkout']
];

// Template
$xtpl = new XTemplate('checkout.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('TOTAL', nv_format_price($total));
$xtpl->assign('FINAL_TOTAL', nv_format_price($final_total));
$xtpl->assign('DISCOUNT', nv_format_price($discount));
$xtpl->assign('COUPON_MESSAGE', $coupon_message);
$xtpl->assign('COUPON_APPLIED', $coupon_applied);

if ($order_created) {
    $xtpl->assign('ORDER_CODE', $order_code);
    $xtpl->parse('main.success');
} else {
    // Cart items
    foreach ($cart as $item) {
        $item['image_url'] = !empty($item['image']) ? NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $item['image'] : '';
        $item['price_format'] = nv_format_price($item['price']);
        $item['subtotal'] = nv_format_price($item['price'] * $item['quantity']);

        $xtpl->assign('ITEM', $item);
        $xtpl->parse('main.checkout_form.cart_items');
    }

    // Pre-fill user info
    $xtpl->assign('CUSTOMER_NAME', $user_info['full_name']);
    $xtpl->assign('CUSTOMER_EMAIL', $user_info['email']);

    // Coupon message
    if (!empty($coupon_message)) {
        $xtpl->parse('main.checkout_form.coupon_message');
    }

    // Discount row
    if ($discount > 0) {
        $xtpl->parse('main.checkout_form.discount_row');
    }

    $xtpl->parse('main.checkout_form');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
