<?php

/**
 * Database upgrade script for BookManager module
 * Run this after updating the module to apply database changes
 */

if (!defined('NV_IS_FILE_MODULES')) {
    die('Stop!!!');
}

$db = $db_config['db'];



// Check if addresses table has add_time column
$result = $db->query("SHOW COLUMNS FROM " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_addresses LIKE 'add_time'");
if ($result->rowCount() == 0) {
    // Add add_time column to addresses table
    $db->query("ALTER TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_addresses ADD COLUMN add_time INT(11) NOT NULL AFTER is_default");
}



echo "Database upgrade completed successfully!";
