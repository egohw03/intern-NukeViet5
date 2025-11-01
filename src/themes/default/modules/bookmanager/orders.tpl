<!-- BEGIN: main -->
<style>
.wraper { width: 100% !important; max-width: 100% !important; }
.container { width: 100% !important; max-width: 100% !important; }
.col-md-24 { width: 100% !important; padding-left: 0 !important; padding-right: 0 !important; }
.row { margin-left: 0 !important; margin-right: 0 !important; padding-left: 0 !important; padding-right: 0 !important; }
</style>
<div style="width: 100%; margin: 0 auto; padding: 40px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height: 1.6;">
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 50px;">
<h1 style="margin: 0; font-size: 42px; color: #2c3e50; font-weight: 700; text-shadow: 2px 2px 4px rgba(0,0,0,0.1);">📋 Đơn hàng của tôi</h1>
<a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 15px 30px; background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; text-decoration: none; border-radius: 10px; font-size: 18px; font-weight: 600; box-shadow: 0 6px 20px rgba(40, 167, 69, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">🛍️ Tiếp tục mua sắm</a>
</div>

    <!-- BEGIN: order_loop -->
    <div style="background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%); border: 4px solid #007bff; border-radius: 20px; margin-bottom: 30px; box-shadow: 0 15px 40px rgba(0, 123, 255, 0.2); overflow: hidden; transition: all 0.4s ease;" onmouseover="this.style.transform='translateY(-5px)'; this.style.boxShadow='0 20px 50px rgba(0, 123, 255, 0.3)';" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 15px 40px rgba(0, 123, 255, 0.2)';">
    <div style="background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); padding: 25px; color: white;">
    <div style="display: grid; grid-template-columns: 1fr auto; align-items: center; gap: 20px;">
    <div>
    <h4 style="margin: 0 0 8px 0; font-size: 24px; font-weight: 700;">📦 Đơn hàng #{ORDER.order_code}</h4>
    <p style="margin: 0; font-size: 16px; opacity: 0.9;">🕒 Ngày đặt: {ORDER.add_time}</p>
    </div>
    <div style="display: flex; gap: 10px;">
    <span style="background: #{ORDER.status_class}; color: white; padding: 8px 16px; border-radius: 20px; font-size: 14px; font-weight: 600; box-shadow: 0 4px 15px rgba(0,0,0,0.2);">{ORDER.order_status_text}</span>
    <span style="background: #{ORDER.payment_class}; color: white; padding: 8px 16px; border-radius: 20px; font-size: 14px; font-weight: 600; box-shadow: 0 4px 15px rgba(0,0,0,0.2);">{ORDER.payment_status_text}</span>
    </div>
    </div>
    </div>
    <div style="padding: 30px;">
    <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 40px;">
    <div style="background: rgba(255,255,255,0.8); padding: 20px; border-radius: 15px; border: 2px solid #e9ecef;">
    <h5 style="margin: 0 0 15px 0; color: #2c3e50; font-size: 20px; font-weight: 700; border-bottom: 2px solid #007bff; padding-bottom: 8px;">👤 Thông tin người nhận</h5>
    <p style="margin: 8px 0; font-size: 16px;"><strong style="color: #17a2b8;">👨‍💼 Tên:</strong> <span style="color: #495057; font-weight: 600;">{ORDER.customer_name}</span></p>
    <p style="margin: 8px 0; font-size: 16px;"><strong style="color: #28a745;">📧 Email:</strong> <span style="color: #495057; font-weight: 600;">{ORDER.customer_email}</span></p>
    <p style="margin: 8px 0; font-size: 16px;"><strong style="color: #ffc107;">📱 SĐT:</strong> <span style="color: #495057; font-weight: 600;">{ORDER.customer_phone}</span></p>
    <p style="margin: 8px 0; font-size: 16px;"><strong style="color: #dc3545;">🏠 Địa chỉ:</strong> <span style="color: #495057; font-weight: 600;">{ORDER.customer_address}</span></p>
        <p style="margin: 8px 0; font-size: 16px;"><strong style="color: #6c757d;">💳 PT thanh toán:</strong> <span style="color: #495057; font-weight: 600;">{ORDER.payment_method}</span></p>
    </div>
    <div style="text-align: center; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); padding: 25px; border-radius: 15px; border: 3px solid #007bff;">
    <div style="margin-bottom: 15px;">
        <div style="font-size: 14px; color: #6c757d; margin-bottom: 5px;">Tổng tiền</div>
        <div style="font-size: 32px; font-weight: 700; color: #dc3545; text-shadow: 2px 2px 4px rgba(220, 53, 69, 0.2);">{ORDER.total_amount_format}</div>
    </div>
    <!-- BEGIN: view_detail -->
    <div>
            <a href="{ORDER.view_detail_link}" style="display: inline-block; padding: 15px 25px; background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); color: white; text-decoration: none; border-radius: 10px; font-size: 16px; font-weight: 600; box-shadow: 0 6px 20px rgba(0, 123, 255, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">👀 Xem chi tiết</a>
            </div>
                <!-- END: view_detail -->
                </div>
            </div>
        </div>
    </div>
    <!-- END: order_loop -->

    <!-- BEGIN: no_orders -->
    <div style="text-align: center; padding: 80px 40px; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); border: 4px solid #6c757d; border-radius: 20px; box-shadow: 0 15px 40px rgba(108, 117, 125, 0.2);">
    <div style="font-size: 96px; margin-bottom: 30px; text-shadow: 4px 4px 8px rgba(0,0,0,0.1);">📋❌</div>
    <h2 style="margin: 0 0 20px 0; color: #2c3e50; font-size: 32px; font-weight: 700;">{LANG.no_orders_title}</h2>
    <p style="margin: 0 0 30px 0; color: #6c757d; font-size: 20px; line-height: 1.6;">{LANG.no_orders_description}</p>
    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 20px 40px; background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); color: white; text-decoration: none; border-radius: 12px; font-size: 20px; font-weight: 600; box-shadow: 0 8px 25px rgba(0, 123, 255, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">🛍️ {LANG.shop_now}</a>
    </div>
    <!-- END: no_orders -->
</div>
<!-- END: main -->
