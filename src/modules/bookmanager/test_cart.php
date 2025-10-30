<?php
// Test script to check cart functionality
require_once '../../../includes/mainfile.php';

if (!defined('NV_IS_USER')) {
    echo "Please login first";
    exit;
}

echo "<h1>Cart Test</h1>";

// Check if cart has items
$cart = nv_get_cart();
echo "<p>Cart items: " . count($cart) . "</p>";

if (!empty($cart)) {
    echo "<p>Checkout button should be visible</p>";
    echo '<a href="' . NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=bookmanager&' . NV_OP_VARIABLE . '=checkout" class="btn btn-success btn-lg">
        <i class="fas fa-credit-card"></i> Thanh toán
    </a>';
} else {
    echo "<p>Cart is empty - add some books first</p>";
    echo '<a href="' . NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=bookmanager">Browse Books</a>';
}
?>
