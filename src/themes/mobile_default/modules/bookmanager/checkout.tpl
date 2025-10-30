<!-- BEGIN: main -->
<div class="checkout">
    <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="h3 mb-0">Thanh toán</h1>
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=cart" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left"></i> Quay lại giỏ hàng
                </a>
            </div>
        </div>
    </div>

    <!-- BEGIN: success -->
    <div class="card">
        <div class="card-body text-center py-5">
            <div class="text-success mb-3">
                <i class="fas fa-check-circle fa-4x"></i>
            </div>
            <h4 class="text-success">Đặt hàng thành công!</h4>
            <p class="mb-3">Cảm ơn bạn đã đặt hàng. Mã đơn hàng của bạn là: <strong class="text-primary">{ORDER_CODE}</strong></p>
            <div class="d-flex justify-content-center gap-2">
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" class="btn btn-primary">
                    <i class="fas fa-list"></i> Xem đơn hàng
                </a>
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-outline-primary">
                    <i class="fas fa-shopping-bag"></i> Tiếp tục mua sắm
                </a>
            </div>
        </div>
    </div>
    <!-- END: success -->

    <!-- BEGIN: checkout_form -->
    <form method="post" action="">
        <div class="row">
            <div class="col-lg-8 mb-4">
                <!-- Customer Information -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Thông tin giao hàng</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Họ tên <span class="text-danger">*</span></label>
                                <input type="text" name="customer_name" value="{CUSTOMER_NAME}" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                <input type="email" name="customer_email" value="{CUSTOMER_EMAIL}" class="form-control" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                <input type="tel" name="customer_phone" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Phương thức thanh toán</label>
                                <select name="payment_method" class="form-select">
                                    <option value="COD">Thanh toán khi nhận hàng (COD)</option>
                                    <option value="Bank Transfer">Chuyển khoản ngân hàng</option>
                                    <option value="Credit Card">Thẻ tín dụng</option>
                                </select>
                            </div>
                        </div>
                        <div class="mb-3">
                        <label class="form-label">Địa chỉ giao hàng <span class="text-danger">*</span></label>
                        <textarea name="customer_address" rows="3" class="form-control" placeholder="Nhập địa chỉ chi tiết..." required></textarea>
                        </div>
                        </div>
                        </div>

                <!-- Coupon -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Mã giảm giá</h5>
                    </div>
                    <div class="card-body">
                        <div class="input-group mb-3">
                            <input type="text" name="coupon_code" class="form-control" placeholder="Nhập mã giảm giá">
                            <button type="submit" name="apply_coupon" class="btn btn-outline-primary">Áp dụng</button>
                        </div>
                        <!-- BEGIN: coupon_message -->
                        <div class="alert alert-info">{COUPON_MESSAGE}</div>
                        <!-- END: coupon_message -->
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <!-- Order Summary -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0">Tóm tắt đơn hàng</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <tbody>
                                    <!-- BEGIN: cart_items -->
                                    <tr>
                                        <td>
                                            <div class="fw-semibold">{ITEM.title}</div>
                                            <small class="text-muted">x{ITEM.quantity}</small>
                                        </td>
                                        <td class="text-end">{ITEM.subtotal}</td>
                                    </tr>
                                    <!-- END: cart_items -->
                                </tbody>
                                <tfoot>
                                <tr>
                                <th class="text-end">Tạm tính:</th>
                                <th class="text-end">{TOTAL}</th>
                                </tr>
                                    <!-- BEGIN: discount_row -->
                                    <tr>
                                        <th class="text-end">Giảm giá:</th>
                                        <th class="text-end text-success">-{DISCOUNT}</th>
                                    </tr>
                                    <!-- END: discount_row -->
                                    <tr class="border-top">
                                        <th class="text-end">Tổng cộng:</th>
                                        <th class="text-end text-primary">{FINAL_TOTAL}</th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>

                        <div class="d-grid mt-3">
                            <button type="submit" name="checkout" class="btn btn-success btn-lg">
                                <i class="fas fa-check"></i> Đặt hàng
                            </button>
                        </div>
                    </div>
                </div>

                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i>
                    <small>Sau khi đặt hàng thành công, bạn sẽ nhận được mã đơn hàng để theo dõi.</small>
                </div>
            </div>
        </div>
    </form>
    <!-- END: checkout_form -->
</div>
<!-- END: main -->
