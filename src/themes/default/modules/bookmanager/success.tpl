<!-- BEGIN: main -->
<div class="order-success">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="text-center mb-5">
                    <i class="fas fa-check-circle fa-5x text-success mb-3"></i>
                    <h1 class="text-success mb-3">{LANG.order_success}</h1>
                    <p class="lead text-muted">{LANG.thank_you}</p>
                </div>

                <div class="card mb-4">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-receipt"></i> {LANG.order_details}
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>{LANG.order_code}:</strong> <span class="badge bg-primary fs-6">{ORDER_CODE}</span></p>
                                <p><strong>{LANG.order_date}:</strong> {ORDER_DATE}</p>
                                <p><strong>{LANG.customer_name}:</strong> {CUSTOMER_NAME}</p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>{LANG.customer_email}:</strong> {CUSTOMER_EMAIL}</p>
                                <p><strong>{LANG.customer_phone}:</strong> {CUSTOMER_PHONE}</p>
                                <p><strong>{LANG.payment_method}:</strong> {PAYMENT_METHOD}</p>
                            </div>
                        </div>

                        <hr>

                        <h6>{LANG.order_items}:</h6>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>{LANG.title}</th>
                                        <th class="text-center">{LANG.quantity}</th>
                                        <th class="text-end">{LANG.unit_price}</th>
                                        <th class="text-end">{LANG.subtotal}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- BEGIN: order_item -->
                                    <tr>
                                        <td>{ITEM.title}</td>
                                        <td class="text-center">{ITEM.quantity}</td>
                                        <td class="text-end">{ITEM.price_format}</td>
                                        <td class="text-end">{ITEM.subtotal_format}</td>
                                    </tr>
                                    <!-- END: order_item -->
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="3" class="text-end"><strong>{LANG.subtotal}:</strong></td>
                                        <td class="text-end"><strong>{SUBTOTAL}</strong></td>
                                    </tr>
                                    <!-- BEGIN: discount_row -->
                                    <tr>
                                        <td colspan="3" class="text-end"><strong>{LANG.discount}:</strong></td>
                                        <td class="text-end text-success"><strong>-{DISCOUNT}</strong></td>
                                    </tr>
                                    <!-- END: discount_row -->
                                    <tr class="table-primary">
                                        <td colspan="3" class="text-end"><strong>{LANG.total_amount}:</strong></td>
                                        <td class="text-end"><strong class="h5">{TOTAL}</strong></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>

                        <!-- BEGIN: order_note -->
                        <div class="mt-3">
                            <strong>{LANG.order_note}:</strong>
                            <p class="text-muted">{ORDER_NOTE}</p>
                        </div>
                        <!-- END: order_note -->
                    </div>
                </div>

                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i>
                    <strong>{LANG.order_confirmation}:</strong> {LANG.order_confirmation_text}
                    <br>
                    <small class="text-muted">{LANG.contact_support}</small>
                </div>

                <div class="text-center">
                    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-primary btn-lg me-3">
                        <i class="fas fa-shopping-bag"></i> {LANG.continue_shopping}
                    </a>
                    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}=users&nv_redirect={NV_REDIRECT}" class="btn btn-outline-primary btn-lg">
                        <i class="fas fa-user"></i> {LANG.view_orders}
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Auto redirect after 10 seconds -->
<script>
setTimeout(function() {
    window.location.href = '{CONTINUE_SHOPPING_URL}';
}, 10000);
</script>
<!-- END: main -->
