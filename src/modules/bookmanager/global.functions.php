<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Oct 19, 2025
 */



/**
 * Get books list
 */
function nv_get_books($limit = 10, $offset = 0, $active_only = true)
{
    global $db, $nv_Cache, $module_name, $module_data, $lang;

    // Temporarily disable cache to test
    // $cache_file = NV_LANG_DATA . '_books_' . $limit . '_' . $offset . '_' . ($active_only ? 'active' : 'all') . NV_CACHE_PREFIX . '.cache';
    // if (($cache = $nv_Cache->getItem($module_name, $cache_file, 3600)) != false) {
    //     return unserialize($cache);
    // }

    $books = array();
    $where = $active_only ? 'WHERE status = 1' : '';
    $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books ' . $where . ' ORDER BY add_time DESC LIMIT ' . (int)$limit . ' OFFSET ' . (int)$offset;
    $result = $db->query($sql);
    while ($row = $result->fetch()) {
        $books[] = $row;
    }

    // $cache = serialize($books);
    // $nv_Cache->setItem($module_name, $cache_file, $cache, 3600);

    return $books;
}

/**
 * Get book by ID
 */
function nv_get_book($id)
{
    global $db, $nv_Cache, $module_name, $module_data, $lang;

    // Temporarily disable cache
    // $cache_file = NV_LANG_DATA . '_book_' . $id . NV_CACHE_PREFIX . '.cache';
    // if (($cache = $nv_Cache->getItem($module_name, $cache_file, 3600)) != false) {
    //     return unserialize($cache);
    // }

    $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books WHERE id = ' . (int)$id . ' AND status = 1';
    $book = $db->query($sql)->fetch();

    // if ($book) {
    //     $cache = serialize($book);
    //     $nv_Cache->setItem($module_name, $cache_file, $cache, 3600);
    // }

    return $book;
}

/**
 * Count total books
 */
function nv_count_books($active_only = true)
{
    global $db, $nv_Cache, $module_name, $module_data, $lang;

    // Temporarily disable cache
    // $cache_file = NV_LANG_DATA . '_count_books' . ($active_only ? '_active' : '_all') . NV_CACHE_PREFIX . '.cache';
    // if (($cache = $nv_Cache->getItem($module_name, $cache_file, 3600)) != false) {
    //     return (int)$cache;
    // }

    $where = $active_only ? 'WHERE status = 1' : '';
    $stmt = $db->prepare('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books ' . $where);
    $stmt->execute();
    $count = $stmt->fetchColumn();

    // $nv_Cache->setItem($module_name, $cache_file, $count, 3600);

    return (int)$count;
}

/**
 * Get categories
 */
function nv_get_categories()
{
    global $db, $module_data;

    $categories = [];
    $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_categories WHERE status = 1 ORDER BY weight ASC';
    $result = $db->query($sql);
    while ($row = $result->fetch()) {
        $categories[$row['id']] = $row;
    }

    return $categories;
}

/**
 * Get book by ID with category
 */
function nv_get_book_with_category($id)
{
    global $db, $module_data;

    $sql = 'SELECT b.*, c.title as cat_title FROM ' . NV_PREFIXLANG . '_' . $module_data . '_books b
    LEFT JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_categories c ON b.cat_id = c.id
    WHERE b.id = ' . intval($id) . ' AND b.status = 1';
    return $db->query($sql)->fetch();
}

/**
 * Add to cart
 */
function nv_add_to_cart($book_id, $quantity = 1)
{
    global $db, $module_data, $user_info;

    if (!defined('NV_IS_USER')) {
        return false;
    }

    $userid = $user_info['userid'];

    // Check if book exists and in stock
    $book = nv_get_book($book_id);
    if (empty($book) || $book['stock_quantity'] < $quantity) {
        return false;
    }

    // Check if already in cart
    $sql = 'SELECT id, quantity FROM ' . NV_PREFIXLANG . '_' . $module_data . '_cart WHERE userid = ' . $userid . ' AND book_id = ' . $book_id;
    $row = $db->query($sql)->fetch();

    if ($row) {
        // Update quantity
        $new_quantity = $row['quantity'] + $quantity;
        if ($new_quantity > $book['stock_quantity']) {
            $new_quantity = $book['stock_quantity'];
        }
        $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_cart SET quantity = ' . $new_quantity . ' WHERE id = ' . $row['id']);
    } else {
        // Insert new
        $db->query('INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_cart (userid, book_id, quantity, add_time) VALUES (' . $userid . ', ' . $book_id . ', ' . $quantity . ', ' . NV_CURRENTTIME . ')');
    }

    return true;
}

/**
 * Get cart items
 */
function nv_get_cart()
{
    global $db, $module_data, $user_info;

    if (!defined('NV_IS_USER')) {
        return [];
    }

    $userid = $user_info['userid'];
    $cart = [];

    $sql = 'SELECT c.*, b.title, b.image, b.price, b.stock_quantity FROM ' . NV_PREFIXLANG . '_' . $module_data . '_cart c
    LEFT JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_books b ON c.book_id = b.id
    WHERE c.userid = ' . $userid . ' AND b.status = 1';
    $result = $db->query($sql);

    while ($row = $result->fetch()) {
        $cart[] = $row;
    }

    return $cart;
}

/**
 * Update cart quantity
 */
function nv_update_cart($book_id, $quantity)
{
    global $db, $module_data, $user_info;

    if (!defined('NV_IS_USER')) {
        return false;
    }

    $userid = $user_info['userid'];

    if ($quantity <= 0) {
        $db->query('DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_cart WHERE userid = ' . $userid . ' AND book_id = ' . $book_id);
    } else {
        $book = nv_get_book($book_id);
        if ($quantity > $book['stock_quantity']) {
            $quantity = $book['stock_quantity'];
        }
        $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_cart SET quantity = ' . $quantity . ' WHERE userid = ' . $userid . ' AND book_id = ' . $book_id);
    }

    return true;
}

/**
 * Remove from cart
 */
function nv_remove_from_cart($book_id)
{
    global $db, $module_data, $user_info;

    if (!defined('NV_IS_USER')) {
        return false;
    }

    $userid = $user_info['userid'];
    $db->query('DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_cart WHERE userid = ' . $userid . ' AND book_id = ' . $book_id);

    return true;
}

/**
 * Get cart total
 */
function nv_get_cart_total()
{
    $cart = nv_get_cart();
    $total = 0;

    foreach ($cart as $item) {
        $total += $item['price'] * $item['quantity'];
    }

    return $total;
}

/**
 * Get cart item count
 */
function nv_get_cart_count()
{
    $cart = nv_get_cart();
    $count = 0;

    foreach ($cart as $item) {
        $count += $item['quantity'];
    }

    return $count;
}

/**
 * Create order
 */
function nv_create_order($customer_info, $payment_method = 'COD')
{
    return nv_create_order_with_coupon($customer_info, $payment_method, 0, 0);
}

/**
 * Create order with coupon
 */
function nv_create_order_with_coupon($customer_info, $payment_method = 'COD', $coupon_id = 0, $discount = 0)
{
    global $db, $module_data, $user_info;

    if (!defined('NV_IS_USER')) {
        return false;
    }

    $cart = nv_get_cart();
    if (empty($cart)) {
        return false;
    }

    $userid = $user_info['userid'];
    $total_amount = nv_get_cart_total() - $discount;
    $order_code = 'ORD' . date('ymdHis') . rand(100, 999);

    // Get coupon code if coupon_id provided
    $coupon_code = '';
    if ($coupon_id > 0) {
        $coupon = nv_get_coupon($coupon_id);
        $coupon_code = $coupon ? $coupon['code'] : '';
    }

    // Insert order
    $sql = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_orders
    (userid, order_code, customer_name, customer_email, customer_phone, customer_address, total_amount, coupon_id, coupon_code, discount_amount, order_status, payment_status, payment_method, add_time)
    VALUES (:userid, :order_code, :customer_name, :customer_email, :customer_phone, :customer_address, :total_amount, :coupon_id, :coupon_code, :discount_amount, 0, 0, :payment_method, :add_time)';

    $stmt = $db->prepare($sql);
    $stmt->bindParam(':userid', $userid, PDO::PARAM_INT);
    $stmt->bindParam(':order_code', $order_code, PDO::PARAM_STR);
    $stmt->bindParam(':customer_name', $customer_info['name'], PDO::PARAM_STR);
    $stmt->bindParam(':customer_email', $customer_info['email'], PDO::PARAM_STR);
    $stmt->bindParam(':customer_phone', $customer_info['phone'], PDO::PARAM_STR);
    $stmt->bindParam(':customer_address', $customer_info['address'], PDO::PARAM_STR);
    $stmt->bindParam(':total_amount', $total_amount, PDO::PARAM_STR);
    $stmt->bindParam(':coupon_id', $coupon_id, PDO::PARAM_INT);
    $stmt->bindParam(':coupon_code', $coupon_code, PDO::PARAM_STR);
    $stmt->bindParam(':discount_amount', $discount, PDO::PARAM_STR);
    $stmt->bindParam(':payment_method', $payment_method, PDO::PARAM_STR);
    $stmt->bindValue(':add_time', NV_CURRENTTIME, PDO::PARAM_INT);

    if ($stmt->execute()) {
    $order_id = $db->lastInsertId();

    // Insert order items
        foreach ($cart as $item) {
        $db->query('INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_order_items (order_id, book_id, quantity, price) VALUES (' . $order_id . ', ' . $item['book_id'] . ', ' . $item['quantity'] . ', ' . $item['price'] . ')');
    }

    // Record coupon usage and update usage count
        if ($coupon_id > 0) {
            $db->query('INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_coupon_usage (coupon_id, order_id, userid, used_time) VALUES (' . $coupon_id . ', ' . $order_id . ', ' . $userid . ', ' . NV_CURRENTTIME . ')');
            $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_coupons SET usage_count = usage_count + 1 WHERE id = ' . $coupon_id);
        }

        // Update stock quantities
        foreach ($cart as $item) {
            $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_books SET stock_quantity = stock_quantity - ' . $item['quantity'] . ' WHERE id = ' . $item['book_id']);
        }

        // Clear cart
        $db->query('DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_cart WHERE userid = ' . $userid);

        return $order_code;
    }

    return false;
}

/**
 * Get user orders
 */
function nv_get_user_orders($userid)
{
    global $db, $module_data;

    $orders = [];
    $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders WHERE userid = ' . intval($userid) . ' ORDER BY add_time DESC';
    $result = $db->query($sql);

    while ($row = $result->fetch()) {
        $orders[] = $row;
    }

    return $orders;
}

/**
* Apply coupon
*/
function nv_apply_coupon($code, $total, $userid = 0)
{
global $db, $module_data;

$code = trim($code);
if (empty($code)) {
return ['valid' => false, 'message' => 'Mã giảm giá không hợp lệ'];
}

$sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_coupons WHERE code = :code AND status = 1 AND start_time <= ' . NV_CURRENTTIME . ' AND end_time >= ' . NV_CURRENTTIME;
$stmt = $db->prepare($sql);
$stmt->bindParam(':code', $code, PDO::PARAM_STR);
$stmt->execute();
$coupon = $stmt->fetch();

if (!$coupon) {
return ['valid' => false, 'message' => 'Mã giảm giá không tồn tại hoặc đã hết hạn'];
}

// Check minimum order amount
if ($coupon['min_order_amount'] > 0 && $total < $coupon['min_order_amount']) {
return ['valid' => false, 'message' => 'Đơn hàng tối thiểu ' . nv_format_price($coupon['min_order_amount']) . ' để sử dụng mã này'];
}

// Check usage limit
if ($coupon['usage_limit'] > 0) {
        $used_count = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_coupon_usage WHERE coupon_id = ' . $coupon['id'])->fetchColumn();
    if ($used_count >= $coupon['usage_limit']) {
        return ['valid' => false, 'message' => 'Mã giảm giá đã đạt giới hạn sử dụng'];
}
}

// Check user usage limit (one per user)
if ($userid > 0) {
$user_used = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_coupon_usage WHERE coupon_id = ' . $coupon['id'] . ' AND userid = ' . $userid)->fetchColumn();
    if ($user_used > 0) {
            return ['valid' => false, 'message' => 'Bạn đã sử dụng mã giảm giá này rồi'];
    }
}

// Calculate discount
if ($coupon['discount_type'] == 'percentage') {
        $discount = $total * ($coupon['discount_value'] / 100);
        if ($coupon['max_discount'] > 0 && $discount > $coupon['max_discount']) {
            $discount = $coupon['max_discount'];
        }
    } else {
        $discount = $coupon['discount_value'];
        if ($discount > $total) {
            $discount = $total;
        }
    }

    return [
        'valid' => true,
        'discount' => $discount,
        'coupon' => $coupon
    ];
}

/**
 * Get coupon by ID
 */
function nv_get_coupon($id)
{
    global $db, $module_data;

    $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_coupons WHERE id = ' . intval($id);
    return $db->query($sql)->fetch();
}

/**
 * Get order by ID
 */
function nv_get_order($order_id, $userid = 0)
{
    global $db, $module_data;

    $sql = 'SELECT o.*, u.username FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders o
    LEFT JOIN ' . NV_USERS_GLOBALTABLE . ' u ON o.userid = u.userid
    WHERE o.id = ' . intval($order_id);

    if ($userid > 0) {
        $sql .= ' AND o.userid = ' . intval($userid);
    }

    return $db->query($sql)->fetch();
}

/**
 * Get order items
 */
function nv_get_order_items($order_id)
{
    global $db, $module_data, $module_upload;

    $items = [];
    $sql = 'SELECT oi.*, b.title, b.image FROM ' . NV_PREFIXLANG . '_' . $module_data . '_order_items oi
    LEFT JOIN ' . NV_PREFIXLANG . '_' . $module_data . '_books b ON oi.book_id = b.id
    WHERE oi.order_id = ' . intval($order_id) . ' AND b.status = 1';

    $result = $db->query($sql);
    while ($item = $result->fetch()) {
        $item['image_url'] = !empty($item['image']) ? NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $item['image'] : '';
        $item['price_format'] = nv_format_price($item['price']);
        $item['subtotal'] = nv_format_price($item['price'] * $item['quantity']);
        $items[] = $item;
    }

    return $items;
}

/**
 * Update order payment status
 */
function nv_update_order_payment_status($order_code, $payment_status)
{
    global $db, $module_data;

    $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_orders SET payment_status = :payment_status WHERE order_code = :order_code';
    $stmt = $db->prepare($sql);
    $stmt->bindParam(':payment_status', $payment_status, PDO::PARAM_INT);
    $stmt->bindParam(':order_code', $order_code, PDO::PARAM_STR);

    return $stmt->execute();
}

/**
 * Send order confirmation email
 */
function nv_send_order_confirmation_email($order_code, $customer_info)
{
    global $db, $module_data, $module_name, $lang_module;

    // Get order details
    $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders WHERE order_code = :order_code';
    $stmt = $db->prepare($sql);
    $stmt->bindParam(':order_code', $order_code, PDO::PARAM_STR);
    $stmt->execute();
    $order = $stmt->fetch();

    if (!$order) {
        return false;
    }

    // Get order items
    $order_items = nv_get_order_items($order['id']);

    // Prepare email content
    $subject = 'Xác nhận đơn hàng ' . $order_code . ' - ' . $lang_module['main'];
    $message = "Kính chào " . $customer_info['name'] . ",

";
    $message .= "Đơn hàng của bạn đã được đặt thành công!

";
    $message .= "Mã đơn hàng: " . $order_code . "
";
    $message .= "Ngày đặt: " . date('d/m/Y H:i', $order['add_time']) . "
";
    $message .= "Tổng tiền: " . nv_format_price($order['total_amount']) . "

";

    $message .= "Chi tiết đơn hàng:
";
    foreach ($order_items as $item) {
        $message .= "- " . $item['title'] . " (x" . $item['quantity'] . ") - " . $item['subtotal'] . "
";
    }

    $message .= "
Thông tin giao hàng:
";
    $message .= "Tên: " . $customer_info['name'] . "
";
    $message .= "Email: " . $customer_info['email'] . "
";
    $message .= "Điện thoại: " . $customer_info['phone'] . "
";
    $message .= "Địa chỉ: " . $customer_info['address'] . "

";

    $message .= "Cảm ơn bạn đã mua hàng!
";
    $message .= "Truy cập " . NV_MY_DOMAIN . " để xem chi tiết đơn hàng.
";

    // Send email using Nukeviet's mail function
    return nv_sendmail([
    'to' => $customer_info['email'],
    'subject' => $subject,
    'message' => $message
    ]);
}

/**
 * Generate VNPay payment URL (placeholder - needs actual VNPay integration)
 */
function nv_generate_vnpay_payment_url($order_code, $amount)
{
    // This is a placeholder for VNPay integration
    // In real implementation, you would:
    // 1. Configure VNPay credentials (vnp_TmnCode, vnp_HashSecret, etc.)
    // 2. Generate payment URL with required parameters
    // 3. Handle return URL and IPN (Instant Payment Notification)

    // For now, return a placeholder URL
    return NV_BASE_SITEURL . 'index.php?payment=success&order=' . $order_code;

    /*
    Example real implementation:

    $vnp_TmnCode = "YOUR_TMNCODE"; // Mã website tại VNPAY
    $vnp_HashSecret = "YOUR_HASHSECRET"; // Chuỗi bí mật
    $vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    $vnp_Returnurl = NV_BASE_SITEURL . "index.php?" . NV_NAME_VARIABLE . "=bookmanager&" . NV_OP_VARIABLE . "=payment_callback";

    $vnp_TxnRef = $order_code; // Mã giao dịch
    $vnp_OrderInfo = "Thanh toan don hang " . $order_code;
    $vnp_OrderType = "billpayment";
    $vnp_Amount = $amount * 100; // VNPay expects amount in smallest currency unit
    $vnp_Locale = "vn";
    $vnp_BankCode = "";
    $vnp_IpAddr = $_SERVER['REMOTE_ADDR'];

    $inputData = array(
        "vnp_Version" => "2.1.0",
        "vnp_TmnCode" => $vnp_TmnCode,
        "vnp_Amount" => $vnp_Amount,
        "vnp_Command" => "pay",
        "vnp_CreateDate" => date('YmdHis'),
        "vnp_CurrCode" => "VND",
        "vnp_IpAddr" => $vnp_IpAddr,
        "vnp_Locale" => $vnp_Locale,
        "vnp_OrderInfo" => $vnp_OrderInfo,
        "vnp_OrderType" => $vnp_OrderType,
        "vnp_ReturnUrl" => $vnp_Returnurl,
        "vnp_TxnRef" => $vnp_TxnRef,
    );

    ksort($inputData);
    $query = "";
    $i = 0;
    $hashdata = "";
    foreach ($inputData as $key => $value) {
        if ($i == 1) {
            $hashdata .= '&' . urlencode($key) . "=" . urlencode($value);
        } else {
            $hashdata .= urlencode($key) . "=" . urlencode($value);
            $i = 1;
        }
        $query .= urlencode($key) . "=" . urlencode($value) . '&';
    }

    $vnp_Url = $vnp_Url . "?" . $query;
    if (isset($vnp_HashSecret)) {
        $vnpSecureHash = hash_hmac('sha512', $hashdata, $vnp_HashSecret);
        $vnp_Url .= 'vnp_SecureHash=' . $vnpSecureHash;
    }

    return $vnp_Url;
    */
}

/**
 * Get book reviews
 */
function nv_get_book_reviews($book_id, $limit = 10, $offset = 0)
{
    global $db, $module_data;

    $reviews = [];
    $sql = 'SELECT r.*, u.username FROM ' . NV_PREFIXLANG . '_' . $module_data . '_reviews r
    LEFT JOIN ' . NV_USERS_GLOBALTABLE . ' u ON r.userid = u.userid
    WHERE r.book_id = ' . intval($book_id) . ' AND r.status = 1
    ORDER BY r.add_time DESC LIMIT ' . intval($limit) . ' OFFSET ' . intval($offset);
    $result = $db->query($sql);

    while ($row = $result->fetch()) {
        $reviews[] = $row;
    }

    return $reviews;
}

/**
 * Get average rating for book
 */
function nv_get_book_rating($book_id)
{
    global $db, $module_data;

    $sql = 'SELECT AVG(rating) as avg_rating, COUNT(*) as total_reviews FROM ' . NV_PREFIXLANG . '_' . $module_data . '_reviews
    WHERE book_id = ' . intval($book_id) . ' AND status = 1';
    $row = $db->query($sql)->fetch();

    return [
        'avg_rating' => round($row['avg_rating'], 1),
        'total_reviews' => intval($row['total_reviews'])
    ];
}

/**
 * Add book review
 */
function nv_add_book_review($book_id, $rating, $title = '', $content = '')
{
    global $db, $module_data, $user_info;

    if (!defined('NV_IS_USER')) {
        return false;
    }

    $userid = $user_info['userid'];

    // Check if user already reviewed this book
    $existing = $db->query('SELECT id FROM ' . NV_PREFIXLANG . '_' . $module_data . '_reviews WHERE book_id = ' . $book_id . ' AND userid = ' . $userid)->fetch();
    if ($existing) {
        return false; // User already reviewed
    }

    $sql = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_reviews (book_id, userid, rating, title, content, add_time, status)
    VALUES (:book_id, :userid, :rating, :title, :content, :add_time, :status)';

    $stmt = $db->prepare($sql);
    $stmt->bindParam(':book_id', $book_id, PDO::PARAM_INT);
    $stmt->bindParam(':userid', $userid, PDO::PARAM_INT);
    $stmt->bindParam(':rating', $rating, PDO::PARAM_INT);
    $stmt->bindParam(':title', $title, PDO::PARAM_STR);
    $stmt->bindParam(':content', $content, PDO::PARAM_STR);
    $stmt->bindValue(':add_time', NV_CURRENTTIME, PDO::PARAM_INT);
    $stmt->bindValue(':status', 1, PDO::PARAM_INT); // Auto approve for now

    return $stmt->execute();
}

/**
 * Get user addresses
 */
function nv_get_user_addresses($userid)
{
    global $db, $module_data;

    $addresses = [];
    $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_addresses WHERE userid = ' . intval($userid) . ' ORDER BY is_default DESC, id ASC';
    $result = $db->query($sql);

    while ($row = $result->fetch()) {
        $addresses[] = $row;
    }

    return $addresses;
}

/**
 * Get default address
 */
function nv_get_default_address($userid)
{
    global $db, $module_data;

    $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_addresses WHERE userid = ' . intval($userid) . ' AND is_default = 1';
    return $db->query($sql)->fetch();
}

/**
 * Add user address
 */
function nv_add_user_address($userid, $full_name, $phone, $address, $is_default = false)
{
    global $db, $module_data;

    // If setting as default, unset other defaults
    if ($is_default) {
        $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_addresses SET is_default = 0 WHERE userid = ' . $userid);
    }

    $sql = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_addresses (userid, full_name, phone, address, is_default)
    VALUES (:userid, :full_name, :phone, :address, :is_default)';

    $stmt = $db->prepare($sql);
    $stmt->bindParam(':userid', $userid, PDO::PARAM_INT);
    $stmt->bindParam(':full_name', $full_name, PDO::PARAM_STR);
    $stmt->bindParam(':phone', $phone, PDO::PARAM_STR);
    $stmt->bindParam(':address', $address, PDO::PARAM_STR);
    $stmt->bindParam(':is_default', $is_default, PDO::PARAM_INT);

    return $stmt->execute();
}
