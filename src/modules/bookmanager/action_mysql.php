<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Oct 19, 2025
 */

if (!defined('NV_IS_FILE_MODULES'))
    die('Stop!!!');

/*
INSTRUCTIONS FOR TESTING:

After module installation, you will have:
- Sample book categories and books for testing
- Empty cart and orders tables (ready for user data)
*/

$sql_drop_module = array();
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_cart";
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_orders";
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_order_items";
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_reviews";
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_coupons";
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_addresses";
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_categories";
$sql_drop_module[] = "DROP TABLE IF EXISTS " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_books";

$sql_create_module = $sql_drop_module;

// Categories table
$sql_create_module[] = "CREATE TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_categories (
id INT(11) NOT NULL AUTO_INCREMENT,
title VARCHAR(255) NOT NULL,
alias VARCHAR(255) NOT NULL,
description TEXT DEFAULT NULL,
parent_id INT(11) NOT NULL DEFAULT 0,
weight INT(11) NOT NULL DEFAULT 0,
status TINYINT(1) NOT NULL DEFAULT 1,
PRIMARY KEY (id),
KEY idx_parent_id (parent_id),
KEY idx_status (status),
KEY idx_weight (weight)
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

// Books table (updated with category_id)
$sql_create_module[] = "CREATE TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_books (
id INT(11) NOT NULL AUTO_INCREMENT,
cat_id INT(11) NOT NULL DEFAULT 0,
title VARCHAR(255) NOT NULL,
alias VARCHAR(255) NOT NULL,
author VARCHAR(255) NOT NULL,
publisher VARCHAR(255) DEFAULT NULL,
publish_year INT(4) DEFAULT NULL,
isbn VARCHAR(20) DEFAULT NULL,
description TEXT DEFAULT NULL,
image VARCHAR(255) DEFAULT NULL,
price DECIMAL(15,2) NOT NULL DEFAULT 0.00,
stock_quantity INT(11) NOT NULL DEFAULT 0,
add_time INT(11) NOT NULL,
edit_time INT(11) DEFAULT NULL,
status TINYINT(1) NOT NULL DEFAULT 1,
PRIMARY KEY (id),
KEY idx_cat_id (cat_id),
KEY idx_status (status),
KEY idx_add_time (add_time),
KEY idx_alias (alias)
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

// Orders table
$sql_create_module[] = "CREATE TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_orders (
id INT(11) NOT NULL AUTO_INCREMENT,
userid INT(11) NOT NULL DEFAULT 0,
order_code VARCHAR(50) NOT NULL,
customer_name VARCHAR(255) NOT NULL,
customer_email VARCHAR(255) NOT NULL,
customer_phone VARCHAR(20) DEFAULT NULL,
customer_address TEXT NOT NULL,
total_amount DECIMAL(15,2) NOT NULL DEFAULT 0.00,
coupon_code VARCHAR(50) DEFAULT NULL,
discount_amount DECIMAL(15,2) NOT NULL DEFAULT 0.00,
transaction_id VARCHAR(100) DEFAULT NULL,
payment_info TEXT DEFAULT NULL,
order_status TINYINT(1) NOT NULL DEFAULT 0,
payment_status TINYINT(1) NOT NULL DEFAULT 0,
payment_method VARCHAR(50) DEFAULT NULL,
order_note TEXT DEFAULT NULL,
add_time INT(11) NOT NULL,
edit_time INT(11) DEFAULT NULL,
PRIMARY KEY (id),
KEY idx_userid (userid),
KEY idx_order_code (order_code),
KEY idx_order_status (order_status),
KEY idx_payment_status (payment_status),
KEY idx_add_time (add_time)
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

// Order items table
$sql_create_module[] = "CREATE TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_order_items (
id INT(11) NOT NULL AUTO_INCREMENT,
order_id INT(11) NOT NULL,
book_id INT(11) NOT NULL,
quantity INT(11) NOT NULL,
price DECIMAL(15,2) NOT NULL,
PRIMARY KEY (id),
KEY idx_order_id (order_id),
KEY idx_book_id (book_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

// Shopping cart table
$sql_create_module[] = "CREATE TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_cart (
id INT(11) NOT NULL AUTO_INCREMENT,
userid INT(11) NOT NULL,
book_id INT(11) NOT NULL,
quantity INT(11) NOT NULL,
add_time INT(11) NOT NULL,
PRIMARY KEY (id),
KEY idx_userid (userid),
KEY idx_book_id (book_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

// Reviews table
$sql_create_module[] = "CREATE TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_reviews (
id INT(11) NOT NULL AUTO_INCREMENT,
book_id INT(11) NOT NULL,
userid INT(11) NOT NULL,
rating TINYINT(1) NOT NULL DEFAULT 5,
title VARCHAR(255) DEFAULT NULL,
content TEXT DEFAULT NULL,
add_time INT(11) NOT NULL,
status TINYINT(1) NOT NULL DEFAULT 0,
PRIMARY KEY (id),
KEY idx_book_id (book_id),
KEY idx_status (status)
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

// Coupons table
$sql_create_module[] = "CREATE TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_coupons (
id INT(11) NOT NULL AUTO_INCREMENT,
code VARCHAR(50) NOT NULL UNIQUE,
type TINYINT(1) NOT NULL DEFAULT 0,
value DECIMAL(15,2) NOT NULL,
start_time INT(11) NOT NULL,
end_time INT(11) NOT NULL,
status TINYINT(1) NOT NULL DEFAULT 1,
PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

// User addresses table
$sql_create_module[] = "CREATE TABLE " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_addresses (
id INT(11) NOT NULL AUTO_INCREMENT,
userid INT(11) NOT NULL,
full_name VARCHAR(255) NOT NULL,
phone VARCHAR(20) NOT NULL,
address TEXT NOT NULL,
is_default TINYINT(1) NOT NULL DEFAULT 0,
PRIMARY KEY (id),
KEY idx_userid (userid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

// Insert sample categories (Vietnamese)
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_categories (title, alias, description, weight, status) VALUES
('Lap trinh', 'lap-trinh', 'Sach ve lap trinh va phat trien phan mem', 1, 1),
('Phat trien Web', 'phat-trien-web', 'Sach ve cac cong nghe phat trien web', 2, 1),
('Co so du lieu', 'co-so-du-lieu', 'Sach ve quan ly co so du lieu', 3, 1),
('Van hoc', 'van-hoc', 'Sach van hoc va tieu thuyet', 4, 1),
('Kinh te', 'kinh-te', 'Sach ve kinh te va quan tri', 5, 1),
('Khoa hoc', 'khoa-hoc', 'Sach khoa hoc va cong nghe', 6, 1),
('Lich su', 'lich-su', 'Sach lich su va xa hoi', 7, 1),
('Giao duc', 'giao-duc', 'Sach giao duc va hoc thuat', 8, 1),
('Ngoai ngu', 'ngoai-ngu', 'Sach hoc ngoai ngu', 9, 1),
('Ky nang song', 'ky-nang-song', 'Sach ve ky nang song va phat trien ban than', 10, 1)";

// Insert sample books (Vietnamese - 30 books)
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_books (cat_id, title, alias, author, publisher, publish_year, isbn, description, price, stock_quantity, add_time, status) VALUES
(1, 'Code sach: Huong dan ve craftsmanship phan mem linh hoat', 'code-sach-huong-dan-craftsmanship-phan-mem-linh-hoat', 'Robert C. Martin', 'NXB Khoa hoc va Ky thuat', 2010, '978-6041100000', 'Sach phai doc cho nha phat trien phan mem.', 180000.00, 12, " . NV_CURRENTTIME . ", 1),
(1, 'Lap trinh vien thuc dung', 'lap-trinh-vien-thuc-dung', 'David Thomas, Andrew Hunt', 'NXB Thong tin va Truyen thong', 2005, '978-6041200000', 'Loi khuyen vinh cuu cho lap trinh vien.', 140000.00, 10, " . NV_CURRENTTIME . ", 1),
(1, 'Mau thiet ke', 'mau-thiet-ke', 'Gang of Four', 'NXB Bach khoa Ha Noi', 2000, '978-6041300000', 'Sach kinh dien ve mau thiet ke.', 120000.00, 8, " . NV_CURRENTTIME . ", 1),
(1, 'Python cho nguoi moi bat dau', 'python-cho-nguoi-moi-bat-dau', 'Mark Lutz', 'NXB Bach khoa', 2021, '978-6042800000', 'Huong dan lap trinh Python co ban.', 110000.00, 22, " . NV_CURRENTTIME . ", 1),
(1, 'JavaScript: Huong dan toan dien', 'javascript-huong-dan-toan-dien', 'David Flanagan', 'NXB Giao duc Viet Nam', 2022, '978-6041500000', 'Huong dan toan dien ve JavaScript.', 220000.00, 15, " . NV_CURRENTTIME . ", 1),
(1, 'Hoc lap trinh C++ tu co ban den nang cao', 'hoc-lap-trinh-cpp-tu-co-ban-den-nang-cao', 'Bjarne Stroustrup', 'NXB Khoa hoc va Ky thuat', 2019, '978-6041180000', 'Sach hoc C++ day du va chi tiet.', 190000.00, 14, " . NV_CURRENTTIME . ", 1),
(2, 'HTML va CSS: Thiet ke va xay dung website', 'html-css-thiet-ke-xay-dung-website', 'Jon Duckett', 'NXB Lao dong', 2015, '978-6041400000', 'Hoc HTML va CSS voi huong dan truc quan.', 100000.00, 20, " . NV_CURRENTTIME . ", 1),
(2, 'React.js: Xay dung giao dien nguoi dung', 'react-js-xay-dung-giao-dien-nguoi-dung', 'Alex Banks', 'NXB Cong nghe Thong tin', 2020, '978-6042900000', 'Hoc React de phat trien web hien dai.', 210000.00, 8, " . NV_CURRENTTIME . ", 1),
(2, 'Node.js va Express: Xay dung ung dung web', 'nodejs-va-express-xay-dung-ung-dung-web', 'Jonathan Wexler', 'NXB Khoa hoc va Ky thuat', 2021, '978-6041190000', 'Huong dan xay dung server voi Node.js.', 175000.00, 11, " . NV_CURRENTTIME . ", 1),
(2, 'Vue.js 3: Huong dan day du', 'vue-js-3-huong-dan-day-du', 'John Au-Yeung', 'NXB Cong nghe Thong tin', 2022, '978-6041170000', 'Hoc Vue.js 3 tu co ban den nang cao.', 195000.00, 9, " . NV_CURRENTTIME . ", 1),
(3, 'MySQL: Huong dan quan tri co so du lieu', 'mysql-huong-dan-quan-tri-co-so-du-lieu', 'Paul DuBois', 'NXB Khoa hoc Xa hoi', 2018, '978-6041600000', 'Hoc quan tri MySQL hieu qua.', 160000.00, 6, " . NV_CURRENTTIME . ", 1),
(3, 'MongoDB: Co so du lieu NoSQL', 'mongodb-co-so-du-lieu-nosql', 'Kristina Chodorow', 'NXB Khoa hoc va Ky thuat', 2019, '978-6043000000', 'Huong dan su dung MongoDB.', 140000.00, 4, " . NV_CURRENTTIME . ", 1),
(3, 'PostgreSQL: Huong dan su dung', 'postgresql-huong-dan-su-dung', 'Simon Riggs', 'NXB Khoa hoc Xa hoi', 2020, '978-6041160000', 'Hoc PostgreSQL cho nguoi moi bat dau.', 170000.00, 7, " . NV_CURRENTTIME . ", 1),
(4, 'Chiec luoc nga', 'chiec-luoc-nga', 'Nam Cao', 'NXB Van hoc', 1943, '978-6041700000', 'Tac pham kinh dien cua van hoc Viet Nam.', 50000.00, 25, " . NV_CURRENTTIME . ", 1),
(4, 'Tat den', 'tat-den', 'Ngo Tat To', 'NXB Van hoc', 1939, '978-6041800000', 'Tieu thuyet noi tieng ve nong thon Viet Nam.', 60000.00, 18, " . NV_CURRENTTIME . ", 1),
(4, 'So do', 'so-do', 'Vu Trong Phung', 'NXB Van hoc', 1936, '978-6041900000', 'Buc tranh xa hoi Viet Nam dau the ky 20.', 70000.00, 14, " . NV_CURRENTTIME . ", 1),
(4, 'Truyen Kieu', 'truyen-kieu', 'Nguyen Du', 'NXB Van hoc', 1820, '978-6043100000', 'Kiet tac cua van hoc Viet Nam.', 80000.00, 30, " . NV_CURRENTTIME . ", 1),
(4, 'Vo nhat thanh', 'vo-nhat-thanh', 'Hoang Ngoc Phach', 'NXB Van hoc', 1941, '978-6041110000', 'Tieu thuyet kinh dien ve tinh yeu.', 55000.00, 20, " . NV_CURRENTTIME . ", 1),
(4, 'Dat rung phuong nam', 'dat-rung-phuong-nam', 'Doan Gioi', 'NXB Van hoc', 1957, '978-6041120000', 'Tac pham noi tieng ve mien nam Viet Nam.', 65000.00, 16, " . NV_CURRENTTIME . ", 1),
(5, 'Kinh te vi mo', 'kinh-te-vi-mo', 'N. Gregory Mankiw', 'NXB Tai chinh', 2020, '978-6042000000', 'Giao trinh kinh te vi mo co ban.', 200000.00, 9, " . NV_CURRENTTIME . ", 1),
(5, 'Quan tri kinh doanh', 'quan-tri-kinh-doanh', 'Peter Drucker', 'NXB Thuong mai', 2015, '978-6042100000', 'Nhung nguyen tac quan tri kinh doanh.', 180000.00, 11, " . NV_CURRENTTIME . ", 1),
(5, 'Marketing 4.0', 'marketing-4-0', 'Philip Kotler', 'NXB Tai chinh', 2017, '978-6041130000', 'Sach marketing trong ky nguyen so.', 220000.00, 13, " . NV_CURRENTTIME . ", 1),
(5, 'Kinh te hoc hanh vi', 'kinh-te-hoc-hanh-vi', 'Richard Thaler', 'NXB Tai chinh', 2018, '978-6043200000', 'Kham pha kinh te tu goc nhin tam ly.', 230000.00, 6, " . NV_CURRENTTIME . ", 1),
(6, 'Vu tru trong vo hat de', 'vu-tru-trong-vo-hat-de', 'Stephen Hawking', 'NXB Tre', 2018, '978-6042200000', 'Kham pha vu tru tu goc nhin khoa hoc.', 250000.00, 7, " . NV_CURRENTTIME . ", 1),
(6, 'DNA: Bi mat cuoc song', 'dna-bi-mat-cuoc-song', 'James D. Watson', 'NXB Khoa hoc va Ky thuat', 2016, '978-6042300000', 'Hanh trinh kham pha cau truc DNA.', 190000.00, 13, " . NV_CURRENTTIME . ", 1),
(6, 'Ly thuyet tuong doi', 'ly-thuyet-tuong-doi', 'Albert Einstein', 'NXB Khoa hoc va Ky thuat', 1916, '978-6043300000', 'Cong trinh vi dai cua vat ly hien dai.', 100000.00, 3, " . NV_CURRENTTIME . ", 1),
(6, 'Vat ly luong tu', 'vat-ly-luong-tu', 'Richard Feynman', 'NXB Khoa hoc va Ky thuat', 1965, '978-6041140000', 'Sach kinh dien ve vat ly luong tu.', 280000.00, 5, " . NV_CURRENTTIME . ", 1),
(7, 'Lich su Viet Nam', 'lich-su-viet-nam', 'Dao Duy Anh', 'NXB Giao duc', 2008, '978-6042400000', 'Tong quan lich su dan toc Viet Nam.', 120000.00, 16, " . NV_CURRENTTIME . ", 1),
(7, 'Lich su the gioi', 'lich-su-the-gioi', 'William McNeill', 'NXB Khoa hoc Xa hoi', 2015, '978-6043400000', 'Tong quan lich su nhan loai.', 260000.00, 9, " . NV_CURRENTTIME . ", 1),
(8, 'Phuong phap day hoc', 'phuong-phap-day-hoc', 'Jean Piaget', 'NXB Dai hoc Quoc gia', 2019, '978-6042600000', 'Nhung nguyen tac day hoc hien dai.', 130000.00, 19, " . NV_CURRENTTIME . ", 1),
(9, 'English Grammar in Use', 'english-grammar-in-use', 'Raymond Murphy', 'Cambridge University Press', 2019, '978-1108457651', 'Sach ngu phap Tieng Anh kinh dien.', 150000.00, 25, " . NV_CURRENTTIME . ", 1),
(10, 'Dac nhan tam', 'dac-nhan-tam', 'Dale Carnegie', 'NXB Lao dong Xa hoi', 2016, '978-6041150000', 'Sach kinh dien ve phat trien ky nang giao tiep.', 90000.00, 35, " . NV_CURRENTTIME . ", 1)";

// Insert sample orders (without user dependencies for demo)
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_orders (userid, order_code, customer_name, customer_email, customer_phone, customer_address, total_amount, coupon_code, discount_amount, transaction_id, payment_info, order_status, payment_status, payment_method, order_note, add_time, edit_time) VALUES
(0, 'ORD001', 'Nguyen Van A', 'nguyenvana@example.com', '0123456789', '123 Duong ABC, Ha Noi', 500000.00, '', 0.00, NULL, NULL, 2, 1, 'COD', 'Giao hang nhanh', " . (NV_CURRENTTIME - 86400*2) . ", " . NV_CURRENTTIME . "),
(0, 'ORD002', 'Tran Thi B', 'tranthib@example.com', '0987654321', '456 Duong XYZ, TP.HCM', 320000.00, 'WELCOME10', 32000.00, 'TXN001', 'Payment processed via bank transfer', 2, 1, 'Bank Transfer', 'Goi ky', " . (NV_CURRENTTIME - 86400*1) . ", " . NV_CURRENTTIME . "),
(0, 'ORD003', 'Le Van C', 'levanc@example.com', '0111111111', '789 Duong DEF, Da Nang', 180000.00, '', 0.00, NULL, NULL, 0, 0, 'COD', 'Dang xu ly', " . NV_CURRENTTIME . ", NULL),
(0, 'ORD004', 'Pham Thi D', 'phamthid@example.com', '0222222222', '321 Duong GHI, Can Tho', 750000.00, 'SUMMER20', 150000.00, 'TXN002', 'Credit card payment successful', 2, 1, 'Credit Card', 'Thanh toan online', " . (NV_CURRENTTIME - 86400*3) . ", " . NV_CURRENTTIME . "),
(0, 'ORD005', 'Hoang Van E', 'hoangvane@example.com', '0333333333', '654 Duong JKL, Hai Phong', 400000.00, '', 0.00, NULL, NULL, 3, 0, 'COD', 'Khach hang huy', " . (NV_CURRENTTIME - 86400*7) . ", " . NV_CURRENTTIME . "),
(0, 'ORD006', 'Test Customer', 'test@example.com', '0444444444', 'Test Address', 220000.00, '', 0.00, NULL, NULL, 1, 0, 'COD', 'Dang van chuyen', " . (NV_CURRENTTIME - 86400*5) . ", " . NV_CURRENTTIME . ")";

// Insert sample order items
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_order_items (order_id, book_id, quantity, price) VALUES
(1, 1, 2, 150000.00),
(1, 4, 1, 200000.00),
(2, 3, 1, 120000.00),
(2, 7, 1, 200000.00),
(3, 2, 1, 180000.00),
(4, 6, 1, 190000.00),
(4, 9, 2, 280000.00),
(4, 11, 1, 400000.00),
(5, 10, 1, 400000.00),
(6, 12, 1, 220000.00)";

// Insert sample coupons
$sql_create_module[] = "INSERT INTO " . $db_config['prefix'] . "_" . $lang . "_" . $module_data . "_coupons (code, type, value, start_time, end_time, status) VALUES
('WELCOME10', 0, 10.00, " . NV_CURRENTTIME . ", " . (NV_CURRENTTIME + 2592000) . ", 1),
('SUMMER20', 0, 20.00, " . NV_CURRENTTIME . ", " . (NV_CURRENTTIME + 2592000) . ", 1),
('SAVE50K', 1, 50000.00, " . NV_CURRENTTIME . ", " . (NV_CURRENTTIME + 2592000) . ", 1)";


