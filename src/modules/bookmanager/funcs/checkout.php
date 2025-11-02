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

global $db, $nv_Request, $lang_module, $lang_global, $module_data, $module_name, $module_upload, $user_info, $module_info, $module_file, $array_mod_title, $op_theme;
$op_theme = 'full';

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
$message = '';

// Get default address and all addresses
$default_address = nv_get_default_address($user_info['userid']);
$all_addresses = nv_get_user_addresses($user_info['userid']);



// Load form values from session if not submitting
if (!$nv_Request->isset_request('checkout', 'post')) {
    $customer_name = $_SESSION['checkout_form']['customer_name'] ?? $user_info['full_name'];
    $customer_email = $_SESSION['checkout_form']['customer_email'] ?? $user_info['email'];
    $customer_phone = $_SESSION['checkout_form']['customer_phone'] ?? ($default_address['phone'] ?? '');
    $customer_address = $_SESSION['checkout_form']['customer_address'] ?? ($default_address['address'] ?? '');
    $payment_method = $_SESSION['checkout_form']['payment_method'] ?? 'COD';
    $saved_address_id = $_SESSION['checkout_form']['saved_address_id'] ?? 0;
} else {
    // Preserve form values
    $customer_name = $nv_Request->get_title('customer_name', 'post', $user_info['full_name']);
    $customer_email = $nv_Request->get_title('customer_email', 'post', $user_info['email']);
    $customer_phone = $nv_Request->get_title('customer_phone', 'post', $default_address['phone'] ?? '');
    $customer_address = $nv_Request->get_textarea('customer_address', 'post', $default_address['address'] ?? '', 'br');
    $payment_method = $nv_Request->get_title('payment_method', 'post', 'COD');
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

}

// Save to session
$_SESSION['checkout_form'] = [
    'customer_name' => $customer_name,
    'customer_email' => $customer_email,
    'customer_phone' => $customer_phone,
    'customer_address' => $customer_address,
    'payment_method' => $payment_method,
    'saved_address_id' => $saved_address_id,
];

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

    // $payment_method already initialized above

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
            $order_result = nv_create_order($customer_info, $payment_method);
            if ($order_result !== null) {
                $order_code = $order_result['order_code'];
                $order_id = $order_result['order_id'];

                // Payment routing
                if ($payment_method == 'PAYOS') {

                    // ===========================================
                    // BẮT ĐẦU GIẢI PHÁP JAVASCRIPT BYPASS cURL
                    // ===========================================

                    // 1. Lấy Keys
                    require_once NV_ROOTDIR . '/modules/bookmanager/payos_config.php';
                    
                    // 2. Chuẩn bị URL (DÙNG URL NGROK MỚI NHẤT CỦA BẠN)
                    // URL NGROK TỪ LOG CỦA BẠN: https://unhumbled-paulita-noncreatively.ngrok-free.dev
                    $ngrok_base_url = 'https://unhumbled-paulita-noncreatively.ngrok-free.dev/nukeviet-nukeviet5.0/src/';
                    
                    $return_url = $ngrok_base_url . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=success&order_code=' . $order_code;
                    $cancel_url = $ngrok_base_url . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=cart';
                    $description = 'Order ' . $order_id;

                    // 3. Chuẩn bị data
                    $order_id_int = (int)$order_id;
                    $amount_int = (int)$total;

                    $data_to_send = [
                        'orderCode' => $order_id_int,
                        'amount' => $amount_int,
                        'description' => $description,
                        'returnUrl' => $return_url,
                        'cancelUrl' => $cancel_url
                    ];
                    
                    // 4. Tạo chuỗi chữ ký (giống hệt funcs/functions.php)
                    $canonical_string = "amount=" . $amount_int . "&cancelUrl=" . $cancel_url . "&description=" . $description . "&orderCode=" . $order_id_int . "&returnUrl=" . $return_url;
                    
                    // 5. Tạo chữ ký
                    $signature = hash_hmac('sha256', $canonical_string, PAYOS_CHECKSUM_KEY);

                    // 6. TẮT HEADER/FOOTER và IN HTML/JS
                    @ob_end_clean(); // Xóa bộ đệm (nếu có)
                    define('NV_NO_HEADER', true); // Tắt header NukeViet
                    define('NV_NO_FOOTER', true); // Tắt footer NukeViet
                    
                    echo '<html><head><title>Đang chuyển hướng đến PayOS...</title>';
                    echo '<style>body{font-family: Arial, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; background: #f4f4f4; margin: 0;} .loader { border: 8px solid #f3f3f3; border-top: 8px solid #3498db; border-radius: 50%; width: 60px; height: 60px; animation: spin 1s linear infinite; } @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }</style>';
                    echo '</head><body>';
                    echo '<div style="text-align: center;">';
                    echo '<div class="loader"></div>';
                    echo '<p style="margin-top: 20px; font-size: 1.2em;">Đang chuyển hướng đến cổng thanh toán...</p>';
                    echo '<p style="color: #777;">Vui lòng không tắt trình duyệt.</p>';
                    echo '</div>';

                    // 7. Nhúng dữ liệu vào JavaScript
                    echo '<script>';
                    echo 'const payosData = ' . json_encode($data_to_send) . ';';
                    echo 'const payosApiUrl = "https://api-sandbox.payos.vn/v2/payment-requests";';
                    echo 'const payosHeaders = {
                            "x-client-id": "' . PAYOS_CLIENT_ID . '",
                            "x-api-key": "' . PAYOS_API_KEY . '",
                            "x-signature": "' . $signature . '",
                            "Content-Type": "application/json"
                          };';
                          
                    echo '
                        async function redirectToPayOS() {
                            try {
                                const response = await fetch(payosApiUrl, {
                                    method: "POST",
                                    headers: payosHeaders,
                                    body: JSON.stringify(payosData)
                                });
                                
                                if (!response.ok) {
                                    const errorData = await response.json();
                                    throw new Error("Lỗi " + response.status + ": " + (errorData.desc || response.statusText));
                                }
                                
                                const result = await response.json();
                                
                                if (result.code === "00" && result.data && result.data.checkoutUrl) {
                                    // Thành công! Chuyển hướng
                                    window.location.href = result.data.checkoutUrl;
                                } else {
                                    throw new Error("PayOS không trả về URL (Mã: " + result.code + "): " + (result.desc || "Lỗi không xác định"));
                                }
                            } catch (error) {
                                console.error("Lỗi khi gọi PayOS:", error);
                                alert("Không thể kết nối đến cổng thanh toán. Chi tiết: " + error.message + ". Vui lòng thử lại sau.");
                                // Chuyển về giỏ hàng
                                window.location.href = "' . $cancel_url . '"; 
                            }
                        }
                        
                        // Tự động chạy
                        redirectToPayOS();
                    ';
                    echo '</script>';
                    echo '</body></html>';
                    
                    // 8. Dừng NukeViet
                    die();

                    // ===========================================
                    // KẾT THÚC GIẢI PHÁP JAVASCRIPT
                    // ===========================================

                } else { // Nếu là COD
                $order_created = true;

                // Email disabled
                // try {
                //     nv_send_order_confirmation_email($order_code, $customer_info);
                // } catch (Exception $e) {
                //     error_log('Email sending failed for COD order: ' . $e.getMessage());
                // }
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

if ($order_created) {
    // Đoạn này chỉ chạy khi là COD
    $xtpl->assign('ORDER_CODE', $order_code);
    $xtpl->parse('main.success.cod');
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
    
    // Gán trạng thái 'checked' cho phương thức thanh toán
    if ($payment_method == 'PAYOS') {
        $xtpl->assign('PAYOS_CHECKED', 'checked');
        $xtpl->assign('COD_CHECKED', '');
    } else {
        // Mặc định là COD
        $xtpl->assign('COD_CHECKED', 'checked');
        $xtpl->assign('PAYOS_CHECKED', '');
    }

    if (!empty($message)) {
        $xtpl->assign('MESSAGE', '<div class="alert alert-danger">' . $message . '</div>');
    } else {
        $xtpl->assign('MESSAGE', '');
    }
    $xtpl->parse('main.checkout_form');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';

?>