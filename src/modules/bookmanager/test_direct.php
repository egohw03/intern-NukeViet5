<?php
// Test direct access to cart.php
echo "<h1>DIRECT ACCESS TEST</h1>";
echo "<p>This tests if we can access cart.php directly.</p>";

// Simulate NukeViet environment
if (!defined('NV_ROOTDIR')) {
    define('NV_ROOTDIR', dirname(dirname(dirname(__DIR__))));
}

if (!defined('NV_BASE_SITEURL')) {
    define('NV_BASE_SITEURL', '/');
}

echo "<p>NV_ROOTDIR: " . NV_ROOTDIR . "</p>";
echo "<p>Current file: " . __FILE__ . "</p>";

// Try to include cart.php directly
echo "<h2>Trying to include cart.php...</h2>";

try {
    // This might not work due to missing NukeViet framework
    include_once 'funcs/cart.php';
    echo "<p style='color:green'>cart.php included successfully!</p>";
} catch (Exception $e) {
    echo "<p style='color:red'>Error including cart.php: " . $e->getMessage() . "</p>";
}

// Check if functions file exists
$functions_file = 'funcs/functions.php';
if (file_exists($functions_file)) {
    echo "<p style='color:green'>functions.php exists</p>";
    include_once $functions_file;
    echo "<p style='color:green'>functions.php included</p>";
} else {
    echo "<p style='color:red'>functions.php not found</p>";
}
?>
