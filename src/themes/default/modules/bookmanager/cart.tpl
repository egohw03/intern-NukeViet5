<!-- BEGIN: main -->
<div class="container my-4">
    <!-- Header -->
    <div class="row mb-4">
        <div class="col-12 text-center">
            <h2 class="text-primary mb-2">
                <i class="fas fa-shopping-cart"></i> {LANG.cart}
            </h2>
            <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-outline-secondary btn-sm">
                <i class="fas fa-arrow-left"></i> {LANG.continue_shopping}
            </a>
        </div>
    </div>

    <!-- BEGIN: cart_items -->
    <div class="card">
        <div class="card-header bg-light">
            <h5 class="mb-0">Giỏ hàng của bạn</h5>
        </div>

        <div class="card-body p-0">
            <form method="post" action="">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="border-0" width="60">Ảnh</th>
                            <th class="border-0">Sản phẩm</th>
                            <th class="border-0 text-center" width="120">Đơn giá</th>
                            <th class="border-0 text-center" width="140">Số lượng</th>
                            <th class="border-0 text-center" width="120">Thành tiền</th>
                            <th class="border-0 text-center" width="60">Xóa</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- BEGIN: item -->
                        <tr>
                            <td class="align-middle">
                                <!-- BEGIN: image -->
                                <img src="{ITEM.image_url}" alt="{ITEM.title}" class="rounded" style="width: 50px; height: 50px; object-fit: cover;">
                                <!-- END: image -->
                                <!-- BEGIN: no_image -->
                                <div class="bg-light rounded d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                                    <i class="fas fa-book text-muted"></i>
                                </div>
                                <!-- END: no_image -->
                            </td>
                            <td class="align-middle">
                                <div class="fw-bold">{ITEM.title}</div>
                                <small class="text-muted">{ITEM.author}</small>
                            </td>
                            <td class="align-middle text-center fw-bold text-primary">
                                {ITEM.price_format}
                            </td>
                            <td class="align-middle text-center">
                                <div class="input-group input-group-sm" style="width: 120px; margin: 0 auto;">
                                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="changeQuantity('{ITEM.book_id}', -1)">-</button>
                                    <input type="number" name="quantity[{ITEM.book_id}]" value="{ITEM.quantity}" min="1" max="{ITEM.stock_quantity}"
                                           class="form-control form-control-sm text-center" onchange="updateTotal()">
                                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="changeQuantity('{ITEM.book_id}', 1)">+</button>
                                </div>
                            </td>
                            <td class="align-middle text-center fw-bold text-success">
                                {ITEM.subtotal}
                            </td>
                            <td class="align-middle text-center">
                                <a href="{ITEM.remove_link}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Xóa sản phẩm này?')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <!-- END: item -->
                    </tbody>
                </table>

                <!-- Cart Actions -->
                <div class="card-footer bg-light">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <div class="d-flex gap-2">
                                <button type="submit" name="update_cart" class="btn btn-primary btn-sm">
                                    <i class="fas fa-sync"></i> {LANG.update_cart}
                                </button>
                                <button type="submit" name="clear_cart" class="btn btn-outline-danger btn-sm" onclick="return confirm('{LANG.confirm_clear_cart}')">
                                    <i class="fas fa-trash"></i> {LANG.clear_cart}
                                </button>
                            </div>
                        </div>
                        <div class="col-md-6 text-end">
                            <div class="d-flex align-items-center justify-content-end gap-3">
                                <div>
                                    <strong class="text-primary fs-5">{TOTAL}</strong>
                                    <small class="text-muted d-block">Tổng cộng</small>
                                </div>
                                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=checkout"
                                   class="btn btn-success btn-lg">
                                    <i class="fas fa-credit-card me-2"></i>Thanh toán
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
                <i class="fas fa-shopping-cart fa-4x"></i>
            </div>
            <h4 class="text-muted mb-3">{LANG.cart_empty}</h4>
            <p class="text-muted mb-4">{LANG.cart_empty_message}</p>
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
    // Simple form submission for now
    console.log('Quantity updated');
}
</script>
<!-- END: main -->
