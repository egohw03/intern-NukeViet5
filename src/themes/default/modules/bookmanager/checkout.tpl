<!-- BEGIN: main -->
<div style="width: 100%; margin: 0 auto; padding: 40px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height: 1.6;">
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 50px;">
<h1 style="margin: 0; font-size: 42px; color: #2c3e50; font-weight: 700; text-shadow: 2px 2px 4px rgba(0,0,0,0.1);">💳 Thanh toán</h1>
<a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=cart" style="display: inline-block; padding: 15px 30px; background: linear-gradient(135deg, #6c757d 0%, #495057 100%); color: white; text-decoration: none; border-radius: 10px; font-size: 18px; font-weight: 600; box-shadow: 0 6px 20px rgba(108, 117, 125, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">⬅️ Quay lại giỏ hàng</a>
</div>

    <!-- BEGIN: success -->
    <div style="background: linear-gradient(135deg, #d4edda 0%, #a3d9a4 100%); padding: 50px; border: 4px solid #28a745; border-radius: 20px; text-align: center; box-shadow: 0 15px 40px rgba(40, 167, 69, 0.2);">
    <div style="font-size: 96px; margin-bottom: 30px; text-shadow: 4px 4px 8px rgba(0,0,0,0.1);">✅</div>
    <h2 style="color: #28a745; margin: 0 0 20px 0; font-size: 36px; font-weight: 700;">🎉 Đặt hàng thành công!</h2>
    <p style="margin: 0 0 30px 0; font-size: 20px; color: #155724;">Cảm ơn bạn đã đặt hàng. Mã đơn hàng của bạn là: <strong style="color: #007bff; font-size: 24px; background: rgba(0,123,255,0.1); padding: 5px 10px; border-radius: 5px;">{ORDER_CODE}</strong></p>
    <div style="display: flex; justify-content: center; gap: 25px;">
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" style="display: inline-block; padding: 18px 35px; background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); color: white; text-decoration: none; border-radius: 12px; font-size: 18px; font-weight: 600; box-shadow: 0 8px 25px rgba(0, 123, 255, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">📋 Xem đơn hàng</a>
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 18px 35px; background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; text-decoration: none; border-radius: 12px; font-size: 18px; font-weight: 600; box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">🛍️ Tiếp tục mua sắm</a>
    </div>
    </div>
    <!-- END: success -->

    <!-- BEGIN: checkout_form -->
    <form method="post" action="">
    <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 50px;">
    <div>
    <!-- Customer Information -->
    <div style="background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%); border: 4px solid #17a2b8; border-radius: 20px; margin-bottom: 40px; box-shadow: 0 15px 40px rgba(23, 162, 184, 0.2);">
    <div style="background: linear-gradient(135deg, #17a2b8 0%, #138496 100%); padding: 25px; color: white; border-radius: 16px 16px 0 0; display: flex; justify-content: space-between; align-items: center;">
    <h4 style="margin: 0; font-size: 24px; font-weight: 700;">📍 Thông tin giao hàng</h4>
    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=address" style="padding: 12px 20px; background: rgba(255,255,255,0.2); color: white; text-decoration: none; border: 2px solid white; border-radius: 8px; font-size: 16px; font-weight: 600; transition: all 0.3s ease;" onmouseover="this.style.background='white'; this.style.color='#17a2b8';" onmouseout="this.style.background='rgba(255,255,255,0.2)'; this.style.color='white';">📒 Quản lý địa chỉ</a>
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
                                <select name="payment_method" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
                                <option value="COD" <!-- BEGIN: cod_selected -->selected<!-- END: cod_selected -->>Thanh toán khi nhận hàng (COD)</option>
                                <option value="bank_transfer" <!-- BEGIN: bank_selected -->selected<!-- END: bank_selected -->>Chuyển khoản ngân hàng</option>
                                <option value="card" <!-- BEGIN: card_selected -->selected<!-- END: card_selected -->>Thẻ tín dụng</option>
                                </select>
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

var select = document.querySelector('select[name="saved_address"]');
var option = select.querySelector('option[value="' + addressId + '"]');

if (option) {
var name = option.getAttribute('data-name');
var phone = option.getAttribute('data-phone');
var address = option.getAttribute('data-address');

document.querySelector('input[name="customer_name"]').value = name;
document.querySelector('input[name="customer_phone"]').value = phone;
document.querySelector('textarea[name="customer_address"]').value = address;
}
}

// Fill address on page load if selected
document.addEventListener('DOMContentLoaded', function() {
    var select = document.querySelector('select[name="saved_address"]');
    if (select && select.value) {
        fillAddress(select.value);
    }
});
</script>
<!-- END: main -->
