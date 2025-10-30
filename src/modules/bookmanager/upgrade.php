<?php

/**
 * Database upgrade script for BookManager module
 * Run this after updating the module to apply database changes
 */

if (!defined('NV_IS_FILE_MODULES')) {
    die('Stop!!!');
}

$db = $db_config['db'];

// Check if coupon_usage table exists, if not create it
$result = $db->query("SHOW TABLES LIKE '" . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_coupon_usage'");
if ($result->rowCount() == 0) {
    // Create coupon_usage table
    $sql = "CREATE TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_coupon_usage (
        id INT(11) NOT NULL AUTO_INCREMENT,
        coupon_id INT(11) NOT NULL,
        order_id INT(11) NOT NULL,
        userid INT(11) NOT NULL,
        used_time INT(11) NOT NULL,
        PRIMARY KEY (id),
        KEY idx_coupon_id (coupon_id),
        KEY idx_order_id (order_id),
        KEY idx_userid (userid)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8";
    $db->query($sql);
}

// Check if orders table has coupon_id column
$result = $db->query("SHOW COLUMNS FROM " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_orders LIKE 'coupon_id'");
if ($result->rowCount() == 0) {
    // Add coupon_id column to orders table
    $db->query("ALTER TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_orders ADD COLUMN coupon_id INT(11) DEFAULT NULL AFTER total_amount");
    $db->query("ALTER TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_orders ADD KEY idx_coupon_id (coupon_id)");
}

// Check if addresses table has add_time column
$result = $db->query("SHOW COLUMNS FROM " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_addresses LIKE 'add_time'");
if ($result->rowCount() == 0) {
    // Add add_time column to addresses table
    $db->query("ALTER TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_addresses ADD COLUMN add_time INT(11) NOT NULL AFTER is_default");
}

// Update coupons table structure if needed
$result = $db->query("SHOW COLUMNS FROM " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_coupons LIKE 'discount_type'");
if ($result->rowCount() == 0) {
    // Update coupons table structure
    $db->query("ALTER TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_coupons
        CHANGE type discount_type ENUM('percentage','fixed') NOT NULL DEFAULT 'percentage',
        ADD COLUMN max_discount DECIMAL(15,2) DEFAULT NULL AFTER discount_value,
        ADD COLUMN usage_limit INT(11) DEFAULT NULL AFTER max_discount,
        ADD COLUMN usage_count INT(11) NOT NULL DEFAULT 0 AFTER usage_limit,
        ADD COLUMN min_order_amount DECIMAL(15,2) DEFAULT NULL AFTER usage_count");

    $db->query("ALTER TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_coupons ADD KEY idx_status (status)");
}

// Update sample coupons data
$db->query("UPDATE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_coupons SET
    discount_type = 'percentage',
    max_discount = NULL,
    usage_limit = 100,
    min_order_amount = 100000.00
    WHERE code = 'WELCOME10'");

$db->query("UPDATE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_coupons SET
    discount_type = 'percentage',
    max_discount = 200000.00,
    usage_limit = 50,
    min_order_amount = 200000.00
    WHERE code = 'SUMMER20'");

$db->query("UPDATE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_coupons SET
    discount_type = 'fixed',
    max_discount = NULL,
    usage_limit = 200,
    min_order_amount = 150000.00
    WHERE code = 'SAVE50K'");

echo "Database upgrade completed successfully!";
