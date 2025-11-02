<?php
echo 'Bắt đầu kiểm tra cURL...<br><br>';

// ======================================
// Test 1: Kết nối Google (HTTP)
// ======================================
echo '<b>Kiểm tra Google (Port 80)...</b><br>';
$ch_google = curl_init('http://www.google.com'); // Dùng http để test port 80
curl_setopt($ch_google, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch_google, CURLOPT_CONNECTTIMEOUT, 5); // Chờ 5 giây
$res_google = curl_exec($ch_google);

if (curl_errno($ch_google)) {
    echo '<span style="color: red;">LỖI khi kết nối Google: ' . curl_error($ch_google) . '</span><br><br>';
} else {
    echo '<span style="color: green;">Thành công! Kết nối Google (HTTP) hoạt động tốt.</span><br><br>';
}
curl_close($ch_google);

// ======================================
// Test 2: Kết nối PayOS (HTTPS - Port 443)
// ======================================
echo '<b>Kiểm tra PayOS Sandbox (Port 443)...</b><br>';
$ch_payos = curl_init('https://api-sandbox.payos.vn');
curl_setopt($ch_payos, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch_payos, CURLOPT_CONNECTTIMEOUT, 5); // Chờ 5 giây
// Bỏ qua xác thực SSL (Rất quan trọng cho localhost)
curl_setopt($ch_payos, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch_payos, CURLOPT_SSL_VERIFYHOST, false);

$res_payos = curl_exec($ch_payos);

if (curl_errno($ch_payos)) {
    echo '<span style="color: red;">LỖI khi kết nối PayOS: ' . curl_error($ch_payos) . '</span><br>';
    echo '(Lỗi này y hệt lỗi bạn đang gặp khi checkout)<br><br>';
} else {
    echo '<span style="color: green;">Thành công! Kết nối được đến PayOS Sandbox.</span><br>';
    echo '(Nếu bạn thấy dòng này, nghĩa là Tường lửa đã được mở, và lỗi nằm ở đâu đó trong code checkout)<br>';
    echo 'Phản hồi từ PayOS (lỗi JSON 401 là BÌNH THƯỜNG): <pre>' . $res_payos . '</pre><br><br>';
}
curl_close($ch_payos);

echo '...Kiểm tra hoàn tất.';
?>