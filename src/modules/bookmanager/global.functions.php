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
 * Create order
 */
function nv_create_order($customer_info, $payment_method = 'COD')
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
    $total_amount = nv_get_cart_total();
    $order_code = 'ORD' . date('ymdHis') . rand(100, 999);

    // Insert order
    $sql = 'INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_orders
    (userid, order_code, customer_name, customer_email, customer_phone, customer_address, total_amount, order_status, payment_status, payment_method, add_time)
    VALUES (:userid, :order_code, :customer_name, :customer_email, :customer_phone, :customer_address, :total_amount, 0, 0, :payment_method, :add_time)';

    $stmt = $db->prepare($sql);
    $stmt->bindParam(':userid', $userid, PDO::PARAM_INT);
    $stmt->bindParam(':order_code', $order_code, PDO::PARAM_STR);
    $stmt->bindParam(':customer_name', $customer_info['name'], PDO::PARAM_STR);
    $stmt->bindParam(':customer_email', $customer_info['email'], PDO::PARAM_STR);
    $stmt->bindParam(':customer_phone', $customer_info['phone'], PDO::PARAM_STR);
    $stmt->bindParam(':customer_address', $customer_info['address'], PDO::PARAM_STR);
    $stmt->bindParam(':total_amount', $total_amount, PDO::PARAM_STR);
    $stmt->bindParam(':payment_method', $payment_method, PDO::PARAM_STR);
    $stmt->bindValue(':add_time', NV_CURRENTTIME, PDO::PARAM_INT);

    if ($stmt->execute()) {
        $order_id = $db->lastInsertId();

        // Insert order items
        foreach ($cart as $item) {
            $db->query('INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_order_items (order_id, book_id, quantity, price) VALUES (' . $order_id . ', ' . $item['book_id'] . ', ' . $item['quantity'] . ', ' . $item['price'] . ')');
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
