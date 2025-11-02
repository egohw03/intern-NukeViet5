<!-- BEGIN: main -->
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h2><i class="fas fa-eye"></i> {LANG.view_order}: {ORDER.order_code}</h2>
            <a href="{BACK_LINK}" class="btn btn-secondary mb-3">
                <i class="fas fa-arrow-left"></i> {GLANG.back}
            </a>

            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">{LANG.order_info}</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>{LANG.order_code}:</strong> {ORDER.order_code}</p>
                            <p><strong>{LANG.add_time}:</strong> {ORDER.add_time_format}</p>
                            <p><strong>{LANG.total_amount}:</strong> {ORDER.total_amount_format}</p>
                            <p><strong>{LANG.payment_method}:</strong> {ORDER.payment_method}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>{LANG.customer_name}:</strong> {ORDER.customer_name}</p>
                            <p><strong>{LANG.customer_email}:</strong> {ORDER.customer_email}</p>
                            <p><strong>{LANG.customer_phone}:</strong> {ORDER.customer_phone}</p>
                            <p><strong>{LANG.customer_address}:</strong> {ORDER.customer_address}</p>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <p><strong>{LANG.order_status}:</strong>
                                <span class="badge bg-{ORDER.order_status_class} <!-- BEGIN: order_status_text_white -->text-white<!-- END: order_status_text_white --> <!-- BEGIN: order_status_text_dark -->text-dark<!-- END: order_status_text_dark -->">{ORDER.order_status_text}</span>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>{LANG.payment_status}:</strong>
                                <span class="badge bg-{ORDER.payment_status_class} <!-- BEGIN: payment_status_text_white -->text-white<!-- END: payment_status_text_white --> <!-- BEGIN: payment_status_text_dark -->text-dark<!-- END: payment_status_text_dark -->">{ORDER.payment_status_text}</span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- BEGIN: order_items -->
            <div class="card mt-3">
                <div class="card-header">
                    <h5 class="mb-0">{LANG.order_items}</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>{LANG.book_title}</th>
                                    <th>{LANG.quantity}</th>
                                    <th>{LANG.price}</th>
                                    <th>{LANG.total}</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- BEGIN: loop -->
                                <tr>
                                    <td>{ITEM.book_title}</td>
                                    <td>{ITEM.quantity}</td>
                                    <td>{ITEM.price_format}</td>
                                    <td>{ITEM.total_format}</td>
                                </tr>
                                <!-- END: loop -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- END: order_items -->

            <!-- BEGIN: no_items -->
            <div class="alert alert-warning mt-3">
                {LANG.no_items}
            </div>
            <!-- END: no_items -->
        </div>
    </div>
</div>
<!-- END: main -->
