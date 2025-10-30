<?php
// Test creating sample orders
define('NV_ROOTDIR', dirname(__FILE__));
define('NV_UPLOADS_DIR', '/uploads');
define('NV_FILES_DIR', '/files');
define('NV_LOGS_DIR', '/logs');
define('NV_CACHEDIR', '/cache');
define('NV_SESSION_SAVE_PATH', '/tmp');
define('NV_COOKIE_PREFIX', 'nv5');
define('NV_LANG_DATA', 'vi');
define('NV_LANG_INTERFACE', 'vi');
define('NV_NAME_VARIABLE', 'nv');
define('NV_OP_VARIABLE', 'op');
define('NV_LANG_VARIABLE', 'language');
define('NV_CURRENTTIME', time());
define('NV_CHECK_SESSION', 0);

require_once NV_ROOTDIR . '/includes/constants.php';
require_once NV_ROOTDIR . '/includes/ini.php';

$db_config = array(
    'dbhost' => 'localhost',
    'dbport' => '',
    'dbname' => 'nukeviet5_db',
    'dbuname' => 'root',
    'dbpass' => '',
    'dbtype' => 'mysql',
    'prefix' => 'nv5',
    'persistent' => false,
    'charset' => 'utf8mb4'
);

try {
    $db = new PDO('mysql:host=' . $db_config['dbhost'] . ';dbname=' . $db_config['dbname'] . ';charset=' . $db_config['charset'], $db_config['dbuname'], $db_config['dbpass']);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Create sample order
    $order_code = 'ORD' . date('ymdHis') . rand(100, 999);
    $userid = 1; // Test user ID

    // Insert order
    $sql = "INSERT INTO nv5_vi_bookmanager_orders
        (userid, order_code, customer_name, customer_email, customer_phone, customer_address, total_amount, discount_amount, coupon_id, order_status, payment_status, payment_method, add_time)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    $stmt = $db->prepare($sql);
    $stmt->execute([
        $userid,
        $order_code,
        'Nguyễn Văn Test',
        'test@example.com',
        '0123456789',
        '123 Đường ABC, Quận XYZ, TP.HCM',
        10000,
        0,
        0,
        0, // Pending
        0, // Unpaid
        'COD',
        time()
    ]);

    $order_id = $db->lastInsertId();

    // Insert order item
    $sql_item = "INSERT INTO nv5_vi_bookmanager_order_items (order_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";
    $stmt_item = $db->prepare($sql_item);
    $stmt_item->execute([$order_id, 34, 1, 10000]); // Assuming book ID 34 exists

    echo "<h2>Sample Order Created!</h2>";
    echo "<p>Order Code: $order_code</p>";
    echo "<p>Order ID: $order_id</p>";
    echo "<p><a href='src/vi/bookmanager/orders/'>View Orders</a></p>";

} catch (PDOException $e) {
    echo "Database error: " . $e->getMessage();
}
?>
