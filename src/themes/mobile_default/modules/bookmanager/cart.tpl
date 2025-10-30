<!-- BEGIN: main -->
<div class="container-fluid py-3">
    <!-- Header -->
    <div class="row mb-3">
        <div class="col-12 text-center">
            <h3 class="text-primary mb-2">
                <i class="fas fa-shopping-cart"></i> {LANG.cart}
            </h3>
            <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-outline-secondary btn-sm">
                <i class="fas fa-arrow-left"></i> {LANG.continue_shopping}
            </a>
        </div>
    </div>

    <!-- BEGIN: cart_items -->
    <div class="card">
        <div class="card-header bg-light">
            <h6 class="mb-0">Giỏ hàng ({TOTAL_ITEMS} sản phẩm)</h6>
        </div>

        <div class="card-body p-0">
            <form method="post" action="">
                <!-- BEGIN: item -->
                <div class="border-bottom p-3">
                    <div class="row align-items-center">
                        <div class="col-auto">
                            <!-- BEGIN: image -->
                            <img src="{ITEM.image_url}" alt="{ITEM.title}" class="rounded" style="width: 50px; height: 50px; object-fit: cover;">
                            <!-- END: image -->
                            <!-- BEGIN: no_image -->
                            <div class="bg-light rounded d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                                <i class="fas fa-book text-muted"></i>
                            </div>
                            <!-- END: no_image -->
                        </div>
                        <div class="col">
                            <div class="fw-bold small">{ITEM.title}</div>
                            <div class="text-muted small">{ITEM.author}</div>
                            <div class="text-primary fw-bold">{ITEM.price_format}</div>
                        </div>
                        <div class="col-auto text-end">
                            <div class="d-flex align-items-center gap-2 mb-2">
                                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="changeQuantity('{ITEM.book_id}', -1)">-</button>
                                <input type="number" name="quantity[{ITEM.book_id}]" value="{ITEM.quantity}" min="1" max="{ITEM.stock_quantity}"
                                       class="form-control form-control-sm text-center" style="width: 50px;" onchange="updateTotal()">
                                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="changeQuantity('{ITEM.book_id}', 1)">+</button>
                            </div>
                            <div class="text-success fw-bold small mb-1">{ITEM.subtotal}</div>
                            <a href="{ITEM.remove_link}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Xóa?')">
                                <i class="fas fa-trash"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <!-- END: item -->

                <!-- Cart Actions -->
                <div class="card-footer bg-light">
                    <div class="row">
                        <div class="col-12 mb-3">
                            <div class="d-flex gap-2 justify-content-center">
                                <button type="submit" name="update_cart" class="btn btn-primary btn-sm">
                                    <i class="fas fa-sync"></i> Cập nhật
                                </button>
                                <button type="submit" name="clear_cart" class="btn btn-outline-danger btn-sm" onclick="return confirm('{LANG.confirm_clear_cart}')">
                                    <i class="fas fa-trash"></i> Xóa tất cả
                                </button>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="text-center mb-3">
                                <div class="fs-5 fw-bold text-primary">{TOTAL}</div>
                                <small class="text-muted">Tổng cộng</small>
                            </div>
                            <div class="d-grid">
                                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=checkout"
                                   class="btn btn-success btn-lg">
                                    <i class="fas fa-credit-card me-2"></i>Thanh toán ngay
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- END: cart_items -->

    <!-- BEGIN: empty_cart -->
    <div class="card">
        <div class="card-body text-center py-5">
            <div class="text-muted mb-4">
                <i class="fas fa-shopping-cart fa-3x"></i>
            </div>
            <h5 class="text-muted mb-3">{LANG.cart_empty}</h5>
            <p class="text-muted mb-4 small">{LANG.cart_empty_message}</p>
            <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-primary">
                <i class="fas fa-shopping-bag me-2"></i>{LANG.shop_now}
            </a>
        </div>
    </div>
    <!-- END: empty_cart -->
</div>

<!-- Simple JavaScript -->
<script>
function changeQuantity(bookId, change) {
    var input = document.querySelector('input[name="quantity[' + bookId + ']"]');
    var currentValue = parseInt(input.value);
    var newValue = currentValue + change;

    if (newValue >= 1 && newValue <= parseInt(input.max)) {
        input.value = newValue;
    }
}

function updateTotal() {
    console.log('Quantity updated');
}
</script>
<!-- END: main -->
