<!-- BEGIN: main -->
<div style="max-width: 1200px; margin: 0 auto; padding: 20px;">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
        <h1 style="margin: 0; font-size: 28px;">Chi tiết đơn hàng #{ORDER.order_code}</h1>
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" style="display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; border-radius: 4px;">
            <i class="fas fa-arrow-left"></i> Quay lại danh sách
        </a>
    </div>

    <!-- Order Info -->
    <div style="background: white; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 30px;">
        <div style="background: #f8f9fa; padding: 15px; border-bottom: 1px solid #ddd; border-radius: 8px 8px 0 0;">
            <h5 style="margin: 0;">Thông tin đơn hàng</h5>
        </div>
        <div style="padding: 20px;">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                <div>
                    <p style="margin: 5px 0;"><strong>Mã đơn hàng:</strong> {ORDER.order_code}</p>
                    <p style="margin: 5px 0;"><strong>Ngày đặt:</strong> {ORDER.add_time}</p>
                    <p style="margin: 5px 0;"><strong>Trạng thái:</strong> <span style="background: #{ORDER.status_class}; color: white; padding: 2px 6px; border-radius: 4px;">{ORDER.order_status_text}</span></p>
                    <p style="margin: 5px 0;"><strong>Thanh toán:</strong> <span style="background: #{ORDER.payment_class}; color: white; padding: 2px 6px; border-radius: 4px;">{ORDER.payment_status_text}</span></p>
                </div>
                <div>
                    <p style="margin: 5px 0;"><strong>Người nhận:</strong> {ORDER.customer_name}</p>
                    <p style="margin: 5px 0;"><strong>Email:</strong> {ORDER.customer_email}</p>
                    <p style="margin: 5px 0;"><strong>SĐT:</strong> {ORDER.customer_phone}</p>
                    <p style="margin: 5px 0;"><strong>Địa chỉ:</strong> {ORDER.customer_address}</p>
                    <p style="margin: 5px 0;"><strong>PT thanh toán:</strong> {ORDER.payment_method_text}</p>
                </div>
            </div>
            <div style="border-top: 1px solid #eee; padding-top: 15px; margin-top: 15px;">
                <h4 style="color: #007bff;">Tổng tiền: {ORDER.total_amount_format}</h4>
            </div>
        </div>
    </div>

    <!-- Order Items -->
    <div style="background: white; border: 1px solid #ddd; border-radius: 8px;">
        <div style="background: #f8f9fa; padding: 15px; border-bottom: 1px solid #ddd; border-radius: 8px 8px 0 0;">
            <h5 style="margin: 0;">Chi tiết sản phẩm</h5>
        </div>
        <div style="padding: 20px;">
            <!-- BEGIN: item -->
            <div style="display: flex; align-items: center; border-bottom: 1px solid #eee; padding: 15px 0;">
                <div style="flex-shrink: 0; margin-right: 15px;">
                    <!-- BEGIN: image -->
                    <img src="{ITEM.image_url}" alt="{ITEM.title}" style="width: 60px; height: 60px; object-fit: cover; border-radius: 4px;">
                    <!-- END: image -->
                    <!-- BEGIN: no_image -->
                    <div style="width: 60px; height: 60px; background: #f8f9fa; display: flex; align-items: center; justify-content: center; border-radius: 4px;">[SACH]</div>
                    <!-- END: no_image -->
                </div>
                <div style="flex: 1;">
                    <h6 style="margin: 0 0 5px 0;">{ITEM.title}</h6>
                    <small style="color: #666;">Số lượng: {ITEM.quantity}</small>
                </div>
                <div style="text-align: right;">
                    <div style="font-weight: bold; color: #007bff;">{ITEM.subtotal}</div>
                    <small style="color: #666;">{ITEM.price_format} x {ITEM.quantity}</small>
                </div>
            </div>
            <!-- END: item -->
        </div>
    </div>
</div>
<!-- END: main -->
