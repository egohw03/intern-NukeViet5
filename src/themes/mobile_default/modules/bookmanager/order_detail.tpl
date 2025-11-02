<!-- BEGIN: main -->
<div style="max-width: 1200px; margin: 0 auto; padding: 20px;">
    <div style="margin-bottom: 30px;">
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" style="display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; border-radius: 4px; margin-bottom: 15px;">
            <i class="fas fa-arrow-left"></i> Quay lại
        </a>
        <h1 style="margin: 0; font-size: 24px;">Chi tiết đơn hàng #{ORDER.order_code}</h1>
    </div>

    <!-- Order Info -->
    <div style="background: white; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 30px;">
        <div style="background: #f8f9fa; padding: 15px; border-bottom: 1px solid #ddd; border-radius: 8px 8px 0 0;">
            <h5 style="margin: 0;">Thông tin đơn hàng</h5>
        </div>
        <div style="padding: 20px;">
            <p style="margin: 5px 0;"><strong>Mã đơn hàng:</strong> {ORDER.order_code}</p>
            <p style="margin: 5px 0;"><strong>Ngày đặt:</strong> {ORDER.add_time}</p>
            <!-- Enhanced Status Display -->
            <div style="margin: 15px 0; padding: 15px; background: #f8f9fa; border-radius: 8px;">
                <h6 style="margin: 0 0 10px 0; color: #2c3e50;">📊 Trạng thái đơn hàng</h6>

                <!-- Progress Bar -->
                <div style="background: #e9ecef; border-radius: 15px; height: 8px; margin-bottom: 10px; overflow: hidden;">
                    <div style="background: linear-gradient(90deg, {ORDER.status_config.bg} 0%, {ORDER.status_config.bg}DD 100%); height: 100%; width: {ORDER.progress_percentage}%; border-radius: 15px; transition: width 0.8s ease;"></div>
                </div>

                <!-- Status Badges -->
                <div style="display: flex; gap: 10px; flex-wrap: wrap; margin-bottom: 10px;">
                    <span style="display: flex; align-items: center; background: linear-gradient(135deg, {ORDER.status_config.bg} 0%, {ORDER.status_config.bg}DD 100%); color: white; padding: 8px 12px; border-radius: 20px; font-size: 14px; font-weight: 600; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
                        <span style="font-size: 16px; margin-right: 6px;">{ORDER.status_config.icon}</span>
                        {ORDER.status_config.text}
                    </span>
                    <span style="display: flex; align-items: center; background: linear-gradient(135deg, {ORDER.payment_config.bg} 0%, {ORDER.payment_config.bg}DD 100%); color: white; padding: 8px 12px; border-radius: 20px; font-size: 14px; font-weight: 600; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
                        <span style="font-size: 16px; margin-right: 6px;">{ORDER.payment_config.icon}</span>
                        {ORDER.payment_config.text}
                    </span>
                </div>

                <!-- Status Description -->
                <div style="background: white; padding: 10px; border-radius: 6px; border: 1px solid #dee2e6; font-size: 13px; color: #666;">
                    <!-- BEGIN: status_desc_pending -->
                    Đơn hàng đang chờ xử lý. Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất.
                    <!-- END: status_desc_pending -->
                    <!-- BEGIN: status_desc_processing -->
                    Đơn hàng đang được chuẩn bị và sẽ được giao trong thời gian quy định.
                    <!-- END: status_desc_processing -->
                    <!-- BEGIN: status_desc_delivered -->
                    Đơn hàng đã được giao thành công. Cảm ơn bạn đã tin tưởng và sử dụng dịch vụ!
                    <!-- END: status_desc_delivered -->
                    <!-- BEGIN: status_desc_cancelled -->
                    Đơn hàng đã bị hủy. Vui lòng liên hệ bộ phận chăm sóc khách hàng để được hỗ trợ.
                    <!-- END: status_desc_cancelled -->
                </div>
            </div>
            <p style="margin: 5px 0;"><strong>Người nhận:</strong> {ORDER.customer_name}</p>
            <p style="margin: 5px 0;"><strong>Email:</strong> {ORDER.customer_email}</p>
            <p style="margin: 5px 0;"><strong>SĐT:</strong> {ORDER.customer_phone}</p>
            <p style="margin: 5px 0;"><strong>Địa chỉ:</strong> {ORDER.customer_address}</p>
            <p style="margin: 5px 0;"><strong>PT thanh toán:</strong> {ORDER.payment_method_text}</p>
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
