<?php
// Check database tables for bookmanager module
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

    echo "<h2>Bookmanager Database Tables Check</h2>";

    // Check all bookmanager tables
    $tables = $db->query("SHOW TABLES LIKE 'nv5_vi_bookmanager%'")->fetchAll(PDO::FETCH_COLUMN);

    echo "<h3>Existing Tables:</h3>";
    if (empty($tables)) {
        echo "<p style='color:red'>❌ No bookmanager tables found!</p>";
        echo "<p>Need to create database schema for the module.</p>";
    } else {
        echo "<ul>";
        foreach ($tables as $table) {
            echo "<li>$table</li>";
        }
        echo "</ul>";

        // Check orders table specifically
        if (in_array('nv5_vi_bookmanager_orders', $tables)) {
            echo "<h3>✅ Orders table exists</h3>";
            $orders_count = $db->query("SELECT COUNT(*) FROM nv5_vi_bookmanager_orders")->fetchColumn();
            echo "<p>Orders count: $orders_count</p>";

            if ($orders_count > 0) {
                echo "<h4>Sample orders:</h4>";
                $orders = $db->query("SELECT id, order_code, customer_name, total_amount, order_status, payment_status FROM nv5_vi_bookmanager_orders LIMIT 3")->fetchAll(PDO::FETCH_ASSOC);
                echo "<pre>";
                print_r($orders);
                echo "</pre>";
            }
        } else {
            echo "<h3 style='color:red'>❌ Orders table missing!</h3>";
        }

        // Check books table
        if (in_array('nv5_vi_bookmanager_books', $tables)) {
            echo "<h3>✅ Books table exists</h3>";
            $books_count = $db->query("SELECT COUNT(*) FROM nv5_vi_bookmanager_books WHERE status = 1")->fetchColumn();
            echo "<p>Active books count: $books_count</p>";
        } else {
            echo "<h3 style='color:red'>❌ Books table missing!</h3>";
        }
    }

    // Test nv_get_user_orders function
    echo "<h3>Testing nv_get_user_orders function</h3>";
    if (function_exists('nv_get_user_orders')) {
        echo "<p>✅ Function exists</p>";
        $test_orders = nv_get_user_orders(1);
        echo "<p>Orders for user ID 1: " . count($test_orders) . "</p>";
    } else {
        echo "<p style='color:red'>❌ Function nv_get_user_orders not found!</p>";
    }

} catch (PDOException $e) {
    echo "<h2 style='color:red'>Database Error</h2>";
    echo "<p>" . $e->getMessage() . "</p>";
}
?>
