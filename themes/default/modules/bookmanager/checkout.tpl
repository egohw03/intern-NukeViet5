<!-- BEGIN: main -->
<div class="container">
    <!-- BEGIN: success -->
    <div class="alert alert-success">
        <h3>Đặt hàng thành công!</h3>
        <p>Mã đơn hàng của bạn: <strong>{ORDER_CODE}</strong></p>
        <!-- BEGIN: payos -->
        <p>Bạn đã chọn phương thức thanh toán online. Vui lòng thanh toán để hoàn tất đơn hàng.</p>
        <a href="{CHECKOUT_URL}" class="btn btn-primary" target="_blank">Thanh toán ngay</a>
        <!-- END: payos -->
        <!-- BEGIN: cod -->
        <p>Đơn hàng của bạn sẽ được giao trong vòng 3-5 ngày làm việc.</p>
        <!-- END: cod -->
    </div>
    <!-- END: success -->

    <!-- BEGIN: checkout_form -->
    <h2>Thanh toán</h2>
    {MESSAGE}
    <form method="post" action="">
        <div class="row">
            <div class="col-md-8">
                <h3>Thông tin giao hàng</h3>
                <div class="form-group">
                    <label>Họ tên</label>
                    <input type="text" name="customer_name" value="{CUSTOMER_NAME}" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="customer_email" value="{CUSTOMER_EMAIL}" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Số điện thoại</label>
                    <input type="text" name="customer_phone" value="{CUSTOMER_PHONE}" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Địa chỉ</label>
                    <textarea name="customer_address" class="form-control" required>{CUSTOMER_ADDRESS}</textarea>
                </div>
            </div>
            <div class="col-md-4">
                <h3>Giỏ hàng</h3>
                <!-- BEGIN: cart_items -->
                <div class="cart-item">
                    <img src="{ITEM.image_url}" alt="{ITEM.title}" width="50">
                    <p>{ITEM.title} x {ITEM.quantity} = {ITEM.subtotal}</p>
                </div>
                <!-- END: cart_items -->
                <p><strong>Tổng: {TOTAL}</strong></p>

                <h3>Phương thức thanh toán</h3>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="payment_method" value="COD" {COD_CHECKED} id="cod">
                    <label class="form-check-label" for="cod">Thanh toán khi nhận hàng (COD)</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="payment_method" value="PAYOS" {PAYOS_CHECKED} id="payos">
                    <label class="form-check-label" for="payos">Thanh toán online qua PayOS</label>
                </div>

                <button type="submit" name="checkout" class="btn btn-success">Đặt hàng</button>
            </div>
        </div>
    </form>
    <!-- END: checkout_form -->
</div>
<!-- END: main -->
