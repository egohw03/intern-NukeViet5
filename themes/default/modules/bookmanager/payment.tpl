<!-- BEGIN: main -->
<div class="payment-container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <!-- Success Message -->
            <!-- BEGIN: success -->
            <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                <i class="fas fa-check-circle"></i> {SUCCESS_MESSAGE}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <!-- END: success -->

            <!-- Error Message -->
            <!-- BEGIN: error -->
            <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                <i class="fas fa-exclamation-triangle"></i> {ERROR_MESSAGE}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <!-- END: error -->

            <!-- BEGIN: order_details -->
            <div class="card">
                <div class="card-header">
                    <h4 class="mb-0">
                        <i class="fas fa-credit-card"></i> Thông tin thanh toán - {LANG.order_code}: {ORDER_CODE}
                    </h4>
                </div>
                <div class="card-body">
                    <!-- Order Summary -->
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <p><strong>Khách hàng:</strong> {ORDER.customer_name}</p>
                            <p><strong>Email:</strong> {ORDER.customer_email}</p>
                            <p><strong>Số điện thoại:</strong> {ORDER.customer_phone}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Địa chỉ:</strong> {ORDER.customer_address}</p>
                            <p><strong>Thời gian đặt:</strong> {ORDER.add_time_format}</p>
                            <p><strong>Tổng tiền:</strong> <span class="text-primary fw-bold">{ORDER.total_amount_format}</span></p>
                        </div>
                    </div>

                    <!-- Payment Status -->
                    <div class="mb-4">
                        <h5>Trạng thái thanh toán:</h5>
                        {PAYMENT_STATUS}
                    </div>

                    <!-- COD Payment -->
                    <!-- BEGIN: cod -->
                    <div class="alert alert-info">
                        <h6><i class="fas fa-truck"></i> Thanh toán khi nhận hàng (COD)</h6>
                        <p class="mb-0">Bạn sẽ thanh toán bằng tiền mặt khi nhận hàng tại địa chỉ đã cung cấp.</p>
                    </div>
                    <!-- END: cod -->

                    <!-- Bank Transfer -->
                    <!-- BEGIN: bank_transfer -->
                    <div class="alert alert-warning">
                        <h6><i class="fas fa-university"></i> Chuyển khoản ngân hàng</h6>
                        <p>Vui lòng chuyển khoản theo thông tin sau:</p>

                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <tr>
                                    <td><strong>Ngân hàng:</strong></td>
                                    <td>{BANK_NAME}</td>
                                </tr>
                                <tr>
                                    <td><strong>Số tài khoản:</strong></td>
                                    <td>{ACCOUNT_NUMBER}</td>
                                </tr>
                                <tr>
                                    <td><strong>Tên tài khoản:</strong></td>
                                    <td>{ACCOUNT_HOLDER}</td>
                                </tr>
                                <tr>
                                    <td><strong>Số tiền:</strong></td>
                                    <td class="text-primary fw-bold">{AMOUNT_FORMAT}</td>
                                </tr>
                                <tr>
                                    <td><strong>Nội dung:</strong></td>
                                    <td>{CONTENT}</td>
                                </tr>
                            </table>
                        </div>

                        <!-- BEGIN: bank_transfer_pending -->
                        <div class="text-center mt-3">
                            <p><em>Sau khi chuyển khoản thành công, vui lòng nhấn nút xác nhận bên dưới hoặc liên hệ bộ phận hỗ trợ.</em></p>
                            <a href="{CONFIRM_LINK}" class="btn btn-success" onclick="return confirm('Bạn xác nhận đã chuyển khoản thành công?')">
                                <i class="fas fa-check"></i> Xác nhận đã thanh toán
                            </a>
                        </div>
                        <!-- END: bank_transfer_pending -->
                    </div>
                    <!-- END: bank_transfer -->
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="text-center mt-4">
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" class="btn btn-primary me-2">
                    <i class="fas fa-list"></i> {LANG.view_orders}
                </a>
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-outline-primary">
                    <i class="fas fa-shopping-cart"></i> Tiếp tục mua sắm
                </a>
            </div>
            <!-- END: order_details -->

            <!-- No Order -->
            <!-- BEGIN: no_order -->
            <div class="card">
                <div class="card-body text-center py-5">
                    <i class="fas fa-credit-card fa-4x text-muted mb-3"></i>
                    <h4 class="text-muted">Không tìm thấy thông tin thanh toán</h4>
                    <p class="text-muted">Vui lòng kiểm tra lại mã đơn hàng hoặc liên hệ bộ phận hỗ trợ.</p>
                    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders"
                       class="btn btn-primary">
                        <i class="fas fa-arrow-left"></i> Quay lại đơn hàng
                    </a>
                </div>
            </div>
            <!-- END: no_order -->
        </div>
    </div>
</div>
<!-- END: main -->
