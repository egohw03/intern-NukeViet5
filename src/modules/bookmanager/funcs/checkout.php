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

global $db, $nv_Request, $lang_module, $lang_global, $module_data, $module_name, $module_upload, $user_info, $module_info, $module_file, $array_mod_title;

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

// Get default address and all addresses
$default_address = nv_get_default_address($user_info['userid']);
$all_addresses = nv_get_user_addresses($user_info['userid']);

// Handle apply coupon
if ($nv_Request->isset_request('apply_coupon', 'post')) {
$coupon_code = $nv_Request->get_title('coupon_code', 'post', '');
$coupon_result = nv_apply_coupon($coupon_code, $total, $user_info['userid']);
if ($coupon_result['valid']) {
$discount = $coupon_result['discount'];
$coupon_applied = true;
$coupon_message = 'Mã giảm giá đã được áp dụng';
} else {
$coupon_message = $coupon_result['message'];
}
}

// Load form values from session if not submitting
if (!$nv_Request->isset_request('checkout', 'post') && !$nv_Request->isset_request('apply_coupon', 'post')) {
    $customer_name = $_SESSION['checkout_form']['customer_name'] ?? $user_info['full_name'];
    $customer_email = $_SESSION['checkout_form']['customer_email'] ?? $user_info['email'];
    $customer_phone = $_SESSION['checkout_form']['customer_phone'] ?? ($default_address['phone'] ?? '');
    $customer_address = $_SESSION['checkout_form']['customer_address'] ?? ($default_address['address'] ?? '');
    $payment_method = $_SESSION['checkout_form']['payment_method'] ?? 'COD';
    $coupon_code_input = $_SESSION['checkout_form']['coupon_code'] ?? '';
    $saved_address_id = $_SESSION['checkout_form']['saved_address_id'] ?? 0;
} else {
    // Preserve form values
    $customer_name = $nv_Request->get_title('customer_name', 'post', $user_info['full_name']);
    $customer_email = $nv_Request->get_title('customer_email', 'post', $user_info['email']);
    $customer_phone = $nv_Request->get_title('customer_phone', 'post', $default_address['phone'] ?? '');
    $customer_address = $nv_Request->get_textarea('customer_address', 'post', $default_address['address'] ?? '', 'br');
    $payment_method = $nv_Request->get_title('payment_method', 'post', 'COD');
    // Normalize payment method values
    if ($payment_method == 'Bank Transfer') {
        $payment_method = 'bank_transfer';
    } elseif ($payment_method == 'Credit Card') {
        $payment_method = 'card';
    }
    $saved_address_id = $nv_Request->get_int('saved_address', 'post', 0);
    if ($saved_address_id > 0 && $customer_name == $user_info['full_name'] && $customer_phone == ($default_address['phone'] ?? '') && $customer_address == ($default_address['address'] ?? '')) {
        // If user selected a saved address and hasn't modified the inputs, use the selected address
        foreach ($all_addresses as $addr) {
            if ($addr['id'] == $saved_address_id) {
                $customer_name = $addr['full_name'];
                $customer_phone = $addr['phone'];
                $customer_address = $addr['address'];
                break;
            }
        }
    }
    $coupon_code_input = $nv_Request->get_title('coupon_code', 'post', '');
}

// Save to session
$_SESSION['checkout_form'] = [
    'customer_name' => $customer_name,
    'customer_email' => $customer_email,
    'customer_phone' => $customer_phone,
    'customer_address' => $customer_address,
    'payment_method' => $payment_method,
    'coupon_code' => $coupon_code_input,
    'saved_address_id' => $saved_address_id,
];

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
    // Normalize payment method values
    if ($payment_method == 'Bank Transfer') {
        $payment_method = 'bank_transfer';
    } elseif ($payment_method == 'Credit Card') {
        $payment_method = 'card';
    }

    if (!empty($customer_info['name']) && !empty($customer_info['email']) && !empty($customer_info['phone']) && !empty($customer_info['address'])) {
        // Check stock availability before creating order
        $stock_check_passed = true;
        foreach ($cart as $item) {
            $book = nv_get_book($item['book_id']);
            if (!$book || $book['stock_quantity'] < $item['quantity']) {
                $stock_check_passed = false;
                break;
            }
        }

        if (!$stock_check_passed) {
            $message = 'Một số sản phẩm trong giỏ hàng không còn đủ số lượng. Vui lòng cập nhật giỏ hàng.';
        } else {
            $order_code = nv_create_order_with_coupon($customer_info, $payment_method, $coupon_applied ? $coupon_result['coupon']['id'] : 0, $discount);
            if ($order_code) {
    // Send confirmation email (don't fail the order if email fails)
    try {
        nv_send_order_confirmation_email($order_code, $customer_info);
    } catch (Exception $e) {
        // Log email error but don't stop the order process
        error_log('Email sending failed: ' . $e->getMessage());
    }

        if ($payment_method == 'card') {
                // Redirect to VNPay payment gateway
                $vnpay_url = nv_generate_vnpay_payment_url($order_code, $final_total);
                nv_redirect_location($vnpay_url);
            } else {
                $order_created = true;
            }
        }
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

    // Saved addresses
    if (!empty($all_addresses)) {
        foreach ($all_addresses as $address) {
            $address['selected'] = ($address['id'] == $saved_address_id) ? 'selected' : '';
            $address['address_truncated'] = mb_strlen($address['address']) > 50 ? mb_substr($address['address'], 0, 50) . '...' : $address['address'];
            $xtpl->assign('ADDRESS', $address);
            if ($address['is_default']) {
                $xtpl->parse('main.checkout_form.saved_addresses.address.default');
            }
            $xtpl->parse('main.checkout_form.saved_addresses.address');
        }
        $xtpl->parse('main.checkout_form.saved_addresses');
    }

    // Pre-fill user info
    $xtpl->assign('CUSTOMER_NAME', $customer_name);
    $xtpl->assign('CUSTOMER_EMAIL', $customer_email);
    $xtpl->assign('CUSTOMER_PHONE', $customer_phone);
    $xtpl->assign('CUSTOMER_ADDRESS', $customer_address);
    $xtpl->assign('COUPON_CODE', $coupon_code_input);

    // Payment method selected
    if ($payment_method == 'COD') {
        $xtpl->parse('main.checkout_form.cod_selected');
    } elseif ($payment_method == 'bank_transfer') {
        $xtpl->parse('main.checkout_form.bank_selected');
    } elseif ($payment_method == 'card') {
        $xtpl->parse('main.checkout_form.card_selected');
    }

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
