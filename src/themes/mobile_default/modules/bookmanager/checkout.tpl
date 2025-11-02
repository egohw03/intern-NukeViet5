<!-- BEGIN: main -->
<div style="max-width: 1200px; margin: 0 auto; padding: 20px;">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
        <h1 style="margin: 0; font-size: 28px;">Thanh toán</h1>
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=cart" style="display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; border-radius: 4px;">
            <i class="fas fa-arrow-left"></i> Quay lại giỏ hàng
        </a>
    </div>

    <!-- BEGIN: success -->
    <div style="background: white; padding: 20px; border: 1px solid #ddd; border-radius: 8px; text-align: center;">
        <div style="color: #28a745; margin-bottom: 20px;">
            <i class="fas fa-check-circle" style="font-size: 64px;"></i>
        </div>
        <h4 style="color: #28a745; margin: 0 0 15px 0;">Đặt hàng thành công!</h4>
        <p style="margin: 0 0 20px 0;">Cảm ơn bạn đã đặt hàng. Mã đơn hàng của bạn là: <strong style="color: #007bff;">{ORDER_CODE}</strong></p>
        <div style="display: flex; justify-content: center; gap: 15px;">
            <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" style="display: inline-block; padding: 10px 20px; background: #007bff; color: white; text-decoration: none; border-radius: 4px;">
                <i class="fas fa-list"></i> Xem đơn hàng
            </a>
            <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; border-radius: 4px;">
                <i class="fas fa-shopping-bag"></i> Tiếp tục mua sắm
            </a>
        </div>
    </div>
    <!-- END: success -->

    <!-- BEGIN: checkout_form -->
    <form method="post" action="">
        <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 30px;">
            <div>
                <!-- Customer Information -->
                <div style="background: white; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 30px;">
                    <div style="background: #f8f9fa; padding: 15px; border-bottom: 1px solid #ddd; border-radius: 8px 8px 0 0; display: flex; justify-content: space-between; align-items: center;">
                        <h5 style="margin: 0;">Thông tin giao hàng</h5>
                        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=address" style="padding: 6px 12px; background: transparent; color: #007bff; text-decoration: none; border: 1px solid #007bff; border-radius: 4px; font-size: 14px;">
                            <i class="fas fa-address-book"></i> Quản lý địa chỉ
                        </a>
                    </div>
                    <div style="padding: 20px;">
                    <!-- BEGIN: saved_addresses -->
                        <div style="margin-bottom: 20px;">
                            <label style="display: block; margin-bottom: 5px; font-weight: bold;">Chọn địa chỉ giao hàng đã lưu</label>
                            <select name="saved_address" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;" onchange="fillAddress(this.value)">
                                <option value="">-- Chọn địa chỉ --</option>
                                <!-- BEGIN: address -->
                                <option value="{ADDRESS.id}" selected="{ADDRESS.selected}" data-name="{ADDRESS.full_name}" data-phone="{ADDRESS.phone}" data-address="{ADDRESS.address}">
                                    {ADDRESS.full_name} - {ADDRESS.phone} ({ADDRESS.address_truncated})
                                    <!-- BEGIN: default --> [Mặc định]<!-- END: default -->
                                </option>
                                <!-- END: address -->
                            </select>
                        </div>
                        <!-- END: saved_addresses -->
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 20px;">
                            <div>
                                <label style="display: block; margin-bottom: 5px; font-weight: bold;">Họ tên <span style="color: #dc3545;">*</span></label>
                                <input type="text" name="customer_name" value="{CUSTOMER_NAME}" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;" required>
                            </div>
                            <div>
                                <label style="display: block; margin-bottom: 5px; font-weight: bold;">Email <span style="color: #dc3545;">*</span></label>
                                <input type="email" name="customer_email" value="{CUSTOMER_EMAIL}" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;" required>
                            </div>
                        </div>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 20px;">
                            <div>
                                <label style="display: block; margin-bottom: 5px; font-weight: bold;">Số điện thoại <span style="color: #dc3545;">*</span></label>
                                <input type="tel" name="customer_phone" value="{CUSTOMER_PHONE}" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;" required>
                            </div>
                            <div>
                            <label style="display: block; margin-bottom: 5px; font-weight: bold;">Phương thức thanh toán</label>
                            <input type="hidden" name="payment_method" value="COD">
                            <div style="padding: 8px; background: #e9ecef; border: 1px solid #ccc; border-radius: 4px; font-weight: bold; color: #495057;">Thanh toán khi nhận hàng (COD)</div>
                            </div>
                        </div>
                        <div style="margin-bottom: 20px;">
                        <label style="display: block; margin-bottom: 5px; font-weight: bold;">Địa chỉ giao hàng <span style="color: #dc3545;">*</span></label>
                        <textarea name="customer_address" rows="3" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;" placeholder="Nhập địa chỉ chi tiết..." required>{CUSTOMER_ADDRESS}</textarea>
                        </div>
                        </div>
                        </div>

                <!-- Coupon -->
                <div style="background: white; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 30px;">
                    <div style="background: #f8f9fa; padding: 15px; border-bottom: 1px solid #ddd; border-radius: 8px 8px 0 0;">
                        <h5 style="margin: 0;">Mã giảm giá</h5>
                    </div>
                    <div style="padding: 20px;">
                        <div style="display: flex; margin-bottom: 20px;">
                            <input type="text" name="coupon_code" value="{COUPON_CODE}" style="flex: 1; padding: 8px; border: 1px solid #ccc; border-radius: 4px 0 0 4px;" placeholder="Nhập mã giảm giá">
                            <button type="submit" name="apply_coupon" style="padding: 8px 15px; background: #007bff; color: white; border: none; border-radius: 0 4px 4px 0; cursor: pointer;">Áp dụng</button>
                        </div>
                        <!-- BEGIN: coupon_message -->
                        <div style="background: #d1ecf1; color: #0c5460; padding: 10px; border-radius: 4px;">{COUPON_MESSAGE}</div>
                        <!-- END: coupon_message -->
                    </div>
                </div>
            </div>

            <div>
                <!-- Order Summary -->
                <div style="background: white; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 30px;">
                    <div style="background: #f8f9fa; padding: 15px; border-bottom: 1px solid #ddd; border-radius: 8px 8px 0 0;">
                        <h5 style="margin: 0;">Tóm tắt đơn hàng</h5>
                    </div>
                    <div style="padding: 20px;">
                        <div style="overflow-x: auto;">
                            <table style="width: 100%; border-collapse: collapse;">
                                <tbody>
                                    <!-- BEGIN: cart_items -->
                                    <tr>
                                        <td style="padding: 8px 0; border-bottom: 1px solid #eee;">
                                            <div style="font-weight: bold;">{ITEM.title}</div>
                                            <small style="color: #666;">x{ITEM.quantity}</small>
                                        </td>
                                        <td style="padding: 8px 0; border-bottom: 1px solid #eee; text-align: right;">{ITEM.subtotal}</td>
                                    </tr>
                                    <!-- END: cart_items -->
                                </tbody>
                                <tfoot>
                                <tr>
                                <th style="text-align: right; padding: 10px 0;">Tạm tính:</th>
                                <th style="text-align: right; padding: 10px 0;">{TOTAL}</th>
                                </tr>
                                    <!-- BEGIN: discount_row -->
                                    <tr>
                                        <th style="text-align: right; padding: 10px 0;">Giảm giá:</th>
                                        <th style="text-align: right; padding: 10px 0; color: #28a745;">-{DISCOUNT}</th>
                                    </tr>
                                    <!-- END: discount_row -->
                                    <tr style="border-top: 1px solid #ddd;">
                                        <th style="text-align: right; padding: 10px 0;">Tổng cộng:</th>
                                        <th style="text-align: right; padding: 10px 0; color: #007bff;">{FINAL_TOTAL}</th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>

                        <div style="margin-top: 20px;">
                            <button type="submit" name="checkout" style="width: 100%; padding: 15px; background: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 18px;">
                                <i class="fas fa-check"></i> Đặt hàng
                            </button>
                        </div>
                    </div>
                </div>

                <div style="background: #d1ecf1; color: #0c5460; padding: 15px; border-radius: 4px;">
                    <i class="fas fa-info-circle"></i>
                    <small>Sau khi đặt hàng thành công, bạn sẽ nhận được mã đơn hàng để theo dõi.</small>
                </div>
            </div>
        </div>
    </form>
    <!-- END: checkout_form -->
</div>

<script>
function fillAddress(addressId) {
    if (!addressId) return;

    var select = document.querySelector('select[name=\"saved_address\"]');
    var option = select.querySelector('option[value=\"' + addressId + '\"]');

    if (option) {
        var name = option.getAttribute('data-name');
        var phone = option.getAttribute('data-phone');
        var address = option.getAttribute('data-address');

        document.querySelector('input[name=\"customer_name\"]').value = name;
        document.querySelector('input[name=\"customer_phone\"]').value = phone;
        document.querySelector('textarea[name=\"customer_address\"]').value = address;
    }
}

// Fill address on page load if selected
document.addEventListener('DOMContentLoaded', function() {
    var select = document.querySelector('select[name=\"saved_address\"]');
    if (select && select.value) {
        fillAddress(select.value);
    }
});
</script>
<!-- END: main -->
