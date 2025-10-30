<!-- BEGIN: main -->
<div class="shopping-cart">
    <h1 class="mb-4">{LANG.cart}</h1>

    <!-- BEGIN: checkout -->
    <div class="row">
        <!-- Cart Items -->
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">{LANG.cart_items}</h5>
                </div>
                <div class="card-body">
                    <form method="post" action="">
                        <!-- BEGIN: item -->
                        <div class="row mb-3 align-items-center">
                            <div class="col-md-2">
                                <!-- BEGIN: image -->
                                <img src="{ITEM.image_url}" alt="{ITEM.title}" class="img-fluid rounded">
                                <!-- END: image -->
                            </div>
                            <div class="col-md-4">
                                <h6><a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=detail&id={ITEM.book_id}">{ITEM.title}</a></h6>
                                <small class="text-muted">{LANG.author}: {ITEM.author}</small>
                            </div>
                            <div class="col-md-2">
                                <input type="number" name="quantity[{ITEM.id}]" value="{ITEM.quantity}" min="1" max="{ITEM.stock_quantity}" class="form-control">
                            </div>
                            <div class="col-md-2">
                                <strong>{ITEM.price_format}</strong>
                            </div>
                            <div class="col-md-2">
                                <strong>{ITEM.subtotal_format}</strong>
                                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=cart&remove={ITEM.id}" class="btn btn-sm btn-outline-danger ms-2">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </div>
                        </div>
                        <!-- END: item -->

                        <div class="d-flex justify-content-between">
                            <button type="submit" name="update_cart" class="btn btn-secondary">
                                <i class="fas fa-sync"></i> {LANG.update_cart}
                            </button>
                            <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-outline-primary">
                                {LANG.continue_shopping}
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Order Summary -->
        <div class="col-lg-4">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">{LANG.order_summary}</h5>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between mb-2">
                        <span>{LANG.subtotal}:</span>
                        <strong>{TOTAL}</strong>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <span>{LANG.total}:</span>
                        <strong class="text-primary h5">{TOTAL}</strong>
                    </div>
                    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=checkout" class="btn btn-success btn-lg w-100">
                        <i class="fas fa-credit-card"></i> {LANG.checkout_now}
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- END: checkout -->

    <!-- Empty Cart -->
    <!-- BEGIN: empty_cart -->
    <div class="text-center py-5">
        <i class="fas fa-shopping-cart fa-5x text-muted mb-3"></i>
        <h3>{LANG.cart_empty}</h3>
        <p class="text-muted">{LANG.cart_empty_message}</p>
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-primary">
            {LANG.continue_shopping}
        </a>
    </div>
    <!-- END: empty_cart -->
</div>
<!-- END: main -->
