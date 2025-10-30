<!-- BEGIN: main -->
<div class="order-detail">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="mb-0">{LANG.view_order}: {ORDER.order_code}</h1>
        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> {LANG.back_to_orders}
        </a>
    </div>

    <div class="row">
        <!-- Order Info -->
        <div class="col-lg-8">
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">{LANG.order_info}</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>{LANG.order_code}:</strong> {ORDER.order_code}</p>
                            <p><strong>{LANG.add_time}:</strong> {ORDER.add_time_format}</p>
                            <p><strong>{LANG.order_status}:</strong>
                                <span class="badge bg-{ORDER.order_status_class}">{ORDER.order_status_text}</span>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>{LANG.payment_method}:</strong> {ORDER.payment_method}</p>
                            <p><strong>{LANG.payment_status}:</strong>
                                <span class="badge bg-{ORDER.payment_status_class}">{ORDER.payment_status_text}</span>
                            </p>
                            <!-- BEGIN: transaction_id -->
                            <p><strong>Mã giao dịch:</strong> {ORDER.transaction_id}</p>
                            <!-- END: transaction_id -->
                        </div>
                    </div>
                </div>
            </div>

            <!-- Order Items -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">{LANG.order_details}</h5>
                </div>
                <div class="card-body">
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
                                <!-- BEGIN: order_items -->
                                <tr>
                                    <td>
                                        <strong>{ITEM.book_title}</strong>
                                    </td>
                                    <td class="text-center">{ITEM.quantity}</td>
                                    <td class="text-end">{ITEM.price_format}</td>
                                    <td class="text-end"><strong>{ITEM.total_format}</strong></td>
                                </tr>
                                <!-- END: order_items -->
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="3" class="text-end"><strong>{LANG.subtotal}:</strong></td>
                                    <td class="text-end"><strong>{ORDER.subtotal_format}</strong></td>
                                </tr>
                                <!-- BEGIN: discount_row -->
                                <tr>
                                    <td colspan="3" class="text-end"><strong>{LANG.discount} ({ORDER.coupon_code}):</strong></td>
                                    <td class="text-end text-danger"><strong>-{ORDER.discount_amount_format}</strong></td>
                                </tr>
                                <!-- END: discount_row -->
                                <tr class="table-primary">
                                    <td colspan="3" class="text-end"><strong>{LANG.total_amount}:</strong></td>
                                    <td class="text-end"><strong class="text-primary h5">{ORDER.total_amount_format}</strong></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Customer Info -->
        <div class="col-lg-4">
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">{LANG.customer_info}</h5>
                </div>
                <div class="card-body">
                    <p><strong>{LANG.customer_name}:</strong> {ORDER.customer_name}</p>
                    <p><strong>{LANG.customer_email}:</strong> {ORDER.customer_email}</p>
                    <p><strong>{LANG.customer_phone}:</strong> {ORDER.customer_phone}</p>
                    <p><strong>{LANG.customer_address}:</strong><br>{ORDER.customer_address}</p>
                    <!-- BEGIN: order_note -->
                    <p><strong>{LANG.order_note}:</strong><br>{ORDER.order_note}</p>
                    <!-- END: order_note -->
                </div>
            </div>

            <!-- Update Status -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">{LANG.update_order_status}</h5>
                </div>
                <div class="card-body">
                    <form method="post" action="">
                        <div class="mb-3">
                            <label class="form-label">{LANG.order_status}</label>
                            <select name="order_status" class="form-select">
                                <option value="0" {ORDER.selected_0}>{LANG.order_pending}</option>
                                <option value="1" {ORDER.selected_1}>{LANG.order_processing}</option>
                                <option value="2" {ORDER.selected_2}>{LANG.order_delivered}</option>
                                <option value="3" {ORDER.selected_3}>{LANG.order_cancelled}</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">{LANG.payment_status}</label>
                            <select name="payment_status" class="form-select">
                                <option value="0" {PAYMENT.selected_0}>{LANG.payment_pending}</option>
                                <option value="1" {PAYMENT.selected_1}>{LANG.payment_paid}</option>
                            </select>
                        </div>
                        <button type="submit" name="update_status" class="btn btn-primary w-100">
                            <i class="fas fa-save"></i> {LANG.update}
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
