<!-- BEGIN: main -->
<div class="checkout-page">
    <div class="container">
        <h1 class="mb-4">{LANG.checkout}</h1>

        <!-- BEGIN: error -->
        <div class="alert alert-danger mb-4">
            <ul class="mb-0">
                <!-- BEGIN: error_item -->
                <li>{ERROR}</li>
                <!-- END: error_item -->
            </ul>
        </div>
        <!-- END: error -->

        <form method="post" action="">
            <div class="row">
                <!-- Customer Information -->
                <div class="col-lg-8 mb-4">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">{LANG.customer_info}</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">{LANG.customer_name} <span class="text-danger">*</span></label>
                                        <input type="text" name="customer_name" value="{CUSTOMER.name}" class="form-control" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">{LANG.customer_email} <span class="text-danger">*</span></label>
                                        <input type="email" name="customer_email" value="{CUSTOMER.email}" class="form-control" required>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">{LANG.customer_phone} <span class="text-danger">*</span></label>
                                        <input type="tel" name="customer_phone" value="{CUSTOMER.phone}" class="form-control" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">{LANG.payment_method} <span class="text-danger">*</span></label>
                                        <select name="payment_method" class="form-select" required>
                                            <option value="">{LANG.select_payment_method}</option>
                                            <option value="COD" {PAYMENT.cod_selected}>{LANG.cod}</option>
                                            <option value="Bank Transfer" {PAYMENT.bank_selected}>{LANG.bank_transfer}</option>
                                            <option value="Credit Card" {PAYMENT.card_selected}>{LANG.credit_card}</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">{LANG.customer_address} <span class="text-danger">*</span></label>
                                <textarea name="customer_address" class="form-control" rows="3" required>{CUSTOMER.address}</textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">{LANG.order_note}</label>
                                <textarea name="order_note" class="form-control" rows="2" placeholder="{LANG.order_note_placeholder}"></textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Order Summary -->
                <div class="col-lg-4">
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0">{LANG.order_summary}</h5>
                        </div>
                        <div class="card-body">
                            <!-- Order Items -->
                            <div class="order-items mb-3">
                                <!-- BEGIN: item -->
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <div class="flex-grow-1">
                                        <small class="fw-bold">{ITEM.title}</small>
                                        <br>
                                        <small class="text-muted">{ITEM.quantity} x {ITEM.price_format}</small>
                                    </div>
                                    <div class="text-end">
                                        <strong>{ITEM.subtotal_format}</strong>
                                    </div>
                                </div>
                                <!-- END: item -->
                            </div>

                            <hr>

                            <div class="d-flex justify-content-between mb-2">
                                <span>{LANG.subtotal}:</span>
                                <strong>{SUBTOTAL}</strong>
                            </div>

                            <!-- BEGIN: discount -->
                            <div class="d-flex justify-content-between mb-2 text-success">
                                <span>{LANG.discount} ({COUPON_CODE}):</span>
                                <strong>-{DISCOUNT}</strong>
                            </div>
                            <!-- END: discount -->

                            <div class="d-flex justify-content-between mb-3 border-top pt-3">
                                <span class="fw-bold">{LANG.total_amount}:</span>
                                <strong class="text-primary h5">{TOTAL}</strong>
                            </div>

                            <button type="submit" name="place_order" class="btn btn-success btn-lg w-100">
                            {LANG.place_order}
                            </button>

                            <small class="text-muted text-center d-block mt-2">
                                {LANG.secure_payment}
                            </small>
                        </div>
                    </div>

                    <!-- Payment Info -->
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0">{LANG.payment_info}</h6>
                        </div>
                        <div class="card-body">
                            <!-- BEGIN: cod_info -->
                            <div class="alert alert-info">
                            <strong>{LANG.cod}:</strong> {LANG.cod_description}
                            </div>
                            <!-- END: cod_info -->

                            <!-- BEGIN: bank_info -->
                            <div class="alert alert-info">
                            <strong>{LANG.bank_transfer}:</strong>
                            <br>Ngân hàng: Vietcombank
                            <br>Số tài khoản: 1234567890
                            <br>Chủ tài khoản: CONG TY TNHH BOOKSTORE
                            </div>
                            <!-- END: bank_info -->

                            <!-- BEGIN: card_info -->
                            <div class="alert alert-info">
                            <strong>{LANG.credit_card}:</strong> {LANG.card_description}
                            </div>
                            <!-- END: card_info -->
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- END: main -->
