
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
    global $db, $module_data, $module_name, $lang_module, $global_config;

    // Skip sending email if in development mode
    if (defined('NV_IS_DEVELOPMENT') && NV_IS_DEVELOPMENT === true) {
        error_log('Email sending skipped in development mode for order: ' . $order_code);
        return true;
    }

    // Get order details
    $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_orders WHERE order_code = :order_code';
    $stmt = $db->prepare($sql);
    $stmt->bindParam(':order_code', $order_code, PDO::PARAM_STR);
    $stmt->execute();
    $order = $stmt->fetch();

    if (!$order) {
        return null;
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
    $from = $global_config['site_email'];
    $result = nv_sendmail($from, $customer_info['email'], $subject, $message);

    // Log if email sending failed
    if (!$result) {
        error_log('Failed to send order confirmation email for order: ' . $order_code . ' to: ' . $customer_info['email']);
    }

    return $result;
}

/**
 * Tạo link thanh toán PayOS bằng cURL (Không cần SDK)
 */
function nv_payos_create_payment_link($order_id, $amount, $description, $return_url, $cancel_url)
{
    $api_url = 'https://api-merchant.payos.vn/v2/payment-requests';

    // 1. Dữ liệu
    $data = [
        'orderCode' => $order_id, // Phải là SỐ (int)
        'amount' => (int) $amount,
        'description' => $description,
        'cancelUrl' => $cancel_url,
        'returnUrl' => $return_url
    ];

    // 2. Sắp xếp data theo alphabet
    ksort($data);

    // 3. Tạo data_to_sign
    $data_to_sign = '';
    foreach ($data as $key => $value) {
        $data_to_sign .= $key . '=' . $value . '&';
    }
    $data_to_sign = rtrim($data_to_sign, '&');

    // 4. Tạo Signature
    $signature = hash_hmac('sha256', $data_to_sign, PAYOS_CHECKSUM_KEY);

    // 5. Gọi cURL
    $headers = [
        'x-client-id: ' . PAYOS_CLIENT_ID,
        'x-api-key: ' . PAYOS_API_KEY,
        'Content-Type: application/json'
    ];
    $data['signature'] = $signature; // Thêm signature vào body

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $api_url);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

    $response = curl_exec($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($http_code == 200) {
        $result = json_decode($response, true);
        if ($result['code'] == '00') {
            return $result['data']['checkoutUrl'];
        }
    }

    // Ghi log lỗi
    error_log("PayOS Create Link Failed: " . $response);
    return false;
}

/**
 * Xác thực Webhook PayOS bằng cURL (Không cần SDK)
 */
function nv_payos_verify_webhook($checksum_key = null)
{
    // Load PayOS config if checksum_key not provided
    if ($checksum_key === null) {
        require_once __DIR__ . '/payos_config.php';
        $checksum_key = PAYOS_CHECKSUM_KEY;
    }

    // 1. Lấy dữ liệu
    $raw_body = file_get_contents('php://input');
    $payos_signature = $_SERVER['HTTP_PAYOS_SIGNATURE'] ?? '';

    if (empty($payos_signature)) {
        return null;
    }

    // 2. Tạo signature từ phía mình
    $my_signature = hash_hmac('sha256', $raw_body, $checksum_key);

    // 3. So sánh
    if (hash_equals($my_signature, $payos_signature)) {
        // Chữ ký hợp lệ, trả về dữ liệu
        return json_decode($raw_body, true);
    }

    // Chữ ký không hợp lệ
    return null;
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
 * Get user addresses
 */
function nv_get_user_addresses($userid)
{
    global $db, $module_data;

    $addresses = [];
    $sql = 'SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_addresses WHERE userid = ' . intval($userid) . ' ORDER BY is_default DESC, add_time DESC';
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
    $addresses = nv_get_user_addresses($userid);
    foreach ($addresses as $address) {
        if ($address['is_default']) {
            return $address;
        }
    }
    return $addresses[0] ?? null;
}

/**
 * Add user address
 */
function nv_add_user_address($userid, $data)
{
    global $db, $module_data;

    // If this is default, unset other defaults
    if ($data['is_default']) {
        $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_addresses SET is_default = 0 WHERE userid = ' . $userid);
    }

    $sql = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_addresses
    (userid, full_name, phone, address, is_default, add_time)
    VALUES (:userid, :full_name, :phone, :address, :is_default, :add_time)';

    $stmt = $db->prepare($sql);
    $stmt->bindParam(':userid', $userid, PDO::PARAM_INT);
    $stmt->bindParam(':full_name', $data['full_name'], PDO::PARAM_STR);
    $stmt->bindParam(':phone', $data['phone'], PDO::PARAM_STR);
    $stmt->bindParam(':address', $data['address'], PDO::PARAM_STR);
    $stmt->bindParam(':is_default', $data['is_default'], PDO::PARAM_INT);
    $stmt->bindValue(':add_time', NV_CURRENTTIME, PDO::PARAM_INT);

    return $stmt->execute();
}

/**
 * Update user address
 */
function nv_update_user_address($userid, $address_id, $data)
{
    global $db, $module_data;

    // Check ownership
    $address = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_addresses WHERE id = ' . intval($address_id) . ' AND userid = ' . $userid)->fetch();
    if (!$address) {
        return false;
    }

    // If this is default, unset other defaults
    if ($data['is_default']) {
        $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_addresses SET is_default = 0 WHERE userid = ' . $userid);
    }

    $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_addresses SET
    full_name = :full_name, phone = :phone, address = :address, is_default = :is_default
    WHERE id = :id AND userid = :userid';

    $stmt = $db->prepare($sql);
    $stmt->bindParam(':full_name', $data['full_name'], PDO::PARAM_STR);
    $stmt->bindParam(':phone', $data['phone'], PDO::PARAM_STR);
    $stmt->bindParam(':address', $data['address'], PDO::PARAM_STR);
    $stmt->bindParam(':is_default', $data['is_default'], PDO::PARAM_INT);
    $stmt->bindParam(':id', $address_id, PDO::PARAM_INT);
    $stmt->bindParam(':userid', $userid, PDO::PARAM_INT);

    return $stmt->execute();
}

/**
 * Delete user address
 */
function nv_delete_user_address($userid, $address_id)
{
    global $db, $module_data;

    // Check ownership
    $address = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_addresses WHERE id = ' . intval($address_id) . ' AND userid = ' . $userid)->fetch();
    if (!$address) {
        return false;
    }

    return $db->query('DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_addresses WHERE id = ' . intval($address_id) . ' AND userid = ' . $userid);
}

/**
 * Add book review
 */
function nv_add_book_review($book_id, $userid, $rating, $title = '', $content = '')
{
    global $db, $module_data;

    // Check if user already reviewed this book
    $existing = $db->query('SELECT id FROM ' . NV_PREFIXLANG . '_' . $module_data . '_reviews WHERE book_id = ' . $book_id . ' AND userid = ' . $userid)->fetch();
    if ($existing) {
        return null; // User already reviewed
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
    $stmt->bindValue(':status', 0, PDO::PARAM_INT); // Pending approval

    return $stmt->execute();
}
?>
