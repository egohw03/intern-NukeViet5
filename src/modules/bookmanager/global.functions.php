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
