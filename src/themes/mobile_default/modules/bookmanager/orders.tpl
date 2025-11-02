<!-- BEGIN: main -->
<div style="max-width: 1200px; margin: 0 auto; padding: 20px;">
    <div style="margin-bottom: 30px;">
        <h1 style="margin: 0 0 15px 0; font-size: 24px;">Đơn hàng của tôi</h1>
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 10px 20px; background: transparent; color: #007bff; text-decoration: none; border: 1px solid #007bff; border-radius: 4px;">
            <i class="fas fa-shopping-bag"></i> Tiếp tục mua sắm
        </a>
    </div>

    <!-- BEGIN: order_loop -->
    <div style="background: white; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 20px;">
        <div style="background: #f8f9fa; padding: 15px; border-bottom: 1px solid #ddd; border-radius: 8px 8px 0 0;">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h6 style="margin: 0 0 5px 0;">Đơn hàng #{ORDER.order_code}</h6>
                    <small style="color: #666;">Ngày đặt: {ORDER.add_time}</small>
                </div>
                <div style="text-align: right;">
                <div style="display: flex; gap: 5px; justify-content: flex-end; flex-wrap: wrap; margin-bottom: 5px;">
                    <span style="display: flex; align-items: center; background: linear-gradient(135deg, {ORDER.status_config.bg} 0%, {ORDER.status_config.bg}DD 100%); color: white; padding: 4px 8px; border-radius: 12px; font-size: 11px; font-weight: 600; box-shadow: 0 2px 8px rgba(0,0,0,0.1); white-space: nowrap;">
                            <span style="font-size: 12px; margin-right: 4px;">{ORDER.status_config.icon}</span>
                            {ORDER.status_config.text}
                        </span>
                        <span style="display: flex; align-items: center; background: linear-gradient(135deg, {ORDER.payment_config.bg} 0%, {ORDER.payment_config.bg}DD 100%); color: white; padding: 4px 8px; border-radius: 12px; font-size: 11px; font-weight: 600; box-shadow: 0 2px 8px rgba(0,0,0,0.1); white-space: nowrap;">
                            <span style="font-size: 12px; margin-right: 4px;">{ORDER.payment_config.icon}</span>
                            {ORDER.payment_config.text}
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div style="padding: 20px;">
            <div style="margin-bottom: 15px;">
                <p style="margin: 5px 0;"><strong>Người nhận:</strong> {ORDER.customer_name}</p>
                <p style="margin: 5px 0;"><strong>Email:</strong> {ORDER.customer_email}</p>
                <p style="margin: 5px 0;"><strong>SĐT:</strong> {ORDER.customer_phone}</p>
                <p style="margin: 5px 0;"><strong>Địa chỉ:</strong> {ORDER.customer_address}</p>
                <p style="margin: 5px 0;"><strong>PT thanh toán:</strong> {ORDER.payment_method}</p>
            </div>
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <h5 style="color: #007bff; margin: 0 0 5px 0;">{ORDER.total_amount_format}</h5>
                    <small style="color: #666;">Tổng tiền</small>
                </div>
                <!-- BEGIN: view_detail -->
                <div>
                    <a href="{ORDER.view_detail_link}" style="display: inline-block; padding: 10px 16px; background: #007bff; color: white; text-decoration: none; border-radius: 4px; font-weight: bold;">Xem chi tiết</a>
                </div>
                <!-- END: view_detail -->
            </div>
        </div>
    </div>
    <!-- END: order_loop -->

    <!-- BEGIN: no_orders -->
    <div style="background: white; border: 1px solid #ddd; border-radius: 8px; text-align: center; padding: 60px 20px;">
        <div style="color: #666; margin-bottom: 20px;">
            <i class="fas fa-receipt" style="font-size: 64px;"></i>
        </div>
        <h4 style="margin: 0 0 10px 0;">{LANG.no_orders_title}</h4>
        <p style="margin: 0 0 20px 0; color: #666;">{LANG.no_orders_description}</p>
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 12px 24px; background: #007bff; color: white; text-decoration: none; border-radius: 4px; font-weight: bold;">
            <i class="fas fa-shopping-bag"></i> {LANG.shop_now}
        </a>
    </div>
    <!-- END: no_orders -->
</div>
<!-- END: main -->
