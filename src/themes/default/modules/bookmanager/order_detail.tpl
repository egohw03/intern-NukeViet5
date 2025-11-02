<!-- BEGIN: main -->
<div style="width: 100%; font-size: 20px; line-height: 1.8; padding: 25px; background: #f8f9fa;">
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 35px;">
<div>
<h1 style="font-size: 32px; margin: 0; color: #333;">Chi tiết đơn hàng #{ORDER.order_code}</h1>
<p style="font-size: 18px; color: #666; margin: 5px 0 0;">Xem chi tiết sản phẩm và thông tin đơn hàng</p>
</div>
<a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" style="display: inline-block; padding: 15px 30px; background: #6c757d; color: white; text-decoration: none; border-radius: 10px; font-size: 18px; font-weight: 600; box-shadow: 0 6px 20px rgba(108, 117, 125, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">Quay lại danh sách</a>
</div>

    <!-- Order Info -->
    <div style="background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%); border: 4px solid #007bff; border-radius: 20px; margin-bottom: 30px; box-shadow: 0 15px 40px rgba(0, 123, 255, 0.2); overflow: hidden; transition: all 0.4s ease;" onmouseover="this.style.transform='translateY(-5px)'; this.style.boxShadow='0 20px 50px rgba(0, 123, 255, 0.3)';" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 15px 40px rgba(0, 123, 255, 0.2)';">
    <div style="background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); padding: 25px; color: white;">
    <h4 style="margin: 0 0 8px 0; font-size: 24px; font-weight: 700;">📦 Thông tin đơn hàng</h4>
        <p style="margin: 0; font-size: 16px; opacity: 0.9;">🕒 Đặt vào: {ORDER.add_time}</p>
    </div>
    <div style="padding: 30px;">
    <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 40px;">
    <div style="background: rgba(255,255,255,0.8); padding: 20px; border-radius: 15px; border: 2px solid #e9ecef;">
    <h5 style="margin: 0 0 15px 0; color: #2c3e50; font-size: 20px; font-weight: 700; border-bottom: 2px solid #007bff; padding-bottom: 8px;">👤 Thông tin người nhận</h5>
    <p style="margin: 8px 0; font-size: 16px; display: flex; align-items: flex-start;"><strong style="color: #17a2b8; width: 80px; flex-shrink: 0; margin-right: 10px;">👨‍💼 Tên:</strong> <span style="color: #495057; font-weight: 600; flex: 1;">{ORDER.customer_name}</span></p>
    <p style="margin: 8px 0; font-size: 16px; display: flex; align-items: flex-start;"><strong style="color: #28a745; width: 80px; flex-shrink: 0; margin-right: 10px;">📧 Email:</strong> <span style="color: #495057; font-weight: 600; flex: 1;">{ORDER.customer_email}</span></p>
        <p style="margin: 8px 0; font-size: 16px; display: flex; align-items: flex-start;"><strong style="color: #ffc107; width: 80px; flex-shrink: 0; margin-right: 10px;">📱 SĐT:</strong> <span style="color: #495057; font-weight: 600; flex: 1;">{ORDER.customer_phone}</span></p>
        <p style="margin: 8px 0; font-size: 16px; display: flex; align-items: flex-start;"><strong style="color: #dc3545; width: 80px; flex-shrink: 0; margin-right: 10px;">🏠 Địa chỉ:</strong> <span style="color: #495057; font-weight: 600; flex: 1;">{ORDER.customer_address}</span></p>
    <p style="margin: 8px 0; font-size: 16px; display: flex; align-items: flex-start;"><strong style="color: #6c757d; width: 80px; flex-shrink: 0; margin-right: 10px;">💳 PT TT:</strong> <span style="color: #495057; font-weight: 600; flex: 1;">{ORDER.payment_method_text}</span></p>
    <div style="margin-top: 20px; padding-top: 20px; border-top: 3px solid #007bff;">
    <!-- Status Overview -->
    <div style="margin-bottom: 20px;">
    <h5 style="margin: 0 0 15px 0; color: #2c3e50; font-size: 18px; font-weight: 700;">📊 Trạng thái đơn hàng</h5>

    <!-- Progress Bar -->
            <div style="background: #e9ecef; border-radius: 25px; height: 12px; margin-bottom: 15px; overflow: hidden; box-shadow: inset 0 2px 4px rgba(0,0,0,0.1);">
                <div style="background: linear-gradient(90deg, {ORDER.status_config.bg} 0%, {ORDER.status_config.bg}DD 100%); height: 100%; width: {ORDER.progress_percentage}%; border-radius: 25px; transition: width 0.8s ease; position: relative;">
                    <div style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); font-size: 10px; color: white; font-weight: bold; text-shadow: 1px 1px 2px rgba(0,0,0,0.5);">{ORDER.progress_percentage}%</div>
                </div>
            </div>

            <!-- Status Badges -->
            <div style="display: flex; gap: 15px; flex-wrap: wrap; margin-bottom: 15px;">
                <!-- Order Status -->
                <div style="display: flex; align-items: center; background: linear-gradient(135deg, {ORDER.status_config.bg} 0%, {ORDER.status_config.bg}DD 100%); color: white; padding: 12px 20px; border-radius: 25px; font-size: 16px; font-weight: 600; box-shadow: 0 6px 20px rgba(0,0,0,0.15); white-space: nowrap; min-width: 150px; justify-content: center;">
                    <span style="font-size: 20px; margin-right: 8px;">{ORDER.status_config.icon}</span>
                    <span>{ORDER.status_config.text}</span>
                </div>

                <!-- Payment Status -->
                <div style="display: flex; align-items: center; background: linear-gradient(135deg, {ORDER.payment_config.bg} 0%, {ORDER.payment_config.bg}DD 100%); color: white; padding: 12px 20px; border-radius: 25px; font-size: 16px; font-weight: 600; box-shadow: 0 6px 20px rgba(0,0,0,0.15); white-space: nowrap; min-width: 150px; justify-content: center;">
                    <span style="font-size: 20px; margin-right: 8px;">{ORDER.payment_config.icon}</span>
                    <span>{ORDER.payment_config.text}</span>
                </div>
            </div>

            <!-- Status Description -->
            <div style="background: rgba(255,255,255,0.9); padding: 15px; border-radius: 15px; border: 2px solid #e9ecef;">
                <div style="display: flex; align-items: center; margin-bottom: 8px;">
                    <span style="font-size: 18px; margin-right: 10px;">{ORDER.status_config.icon}</span>
                    <strong style="color: #2c3e50; font-size: 16px;">{ORDER.order_status_text}</strong>
                </div>
                <p style="margin: 0; color: #666; font-size: 14px; line-height: 1.5;">
                    <!-- BEGIN: status_desc_pending -->
                    Đơn hàng đang chờ xử lý. Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất.
                    <!-- END: status_desc_pending -->
                    <!-- BEGIN: status_desc_shipping -->
                    Đơn hàng đang được giao đến địa chỉ của bạn. Vui lòng chuẩn bị để nhận hàng.
                    <!-- END: status_desc_shipping -->
                    <!-- BEGIN: status_desc_delivered -->
                    Đơn hàng đã được giao thành công. Cảm ơn bạn đã tin tưởng và sử dụng dịch vụ!
                    <!-- END: status_desc_delivered -->
                    <!-- BEGIN: status_desc_cancelled -->
                    Đơn hàng đã bị hủy. Vui lòng liên hệ bộ phận chăm sóc khách hàng để được hỗ trợ.
                    <!-- END: status_desc_cancelled -->
                </p>
            </div>
        </div>
    </div>
        </div>
    <div style="text-align: center; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); padding: 25px; border-radius: 15px; border: 3px solid #007bff;">
            <div style="margin-bottom: 15px;">
                    <div style="font-size: 14px; color: #6c757d; margin-bottom: 5px;">Tổng tiền</div>
                        <div style="font-size: 32px; font-weight: 700; color: #dc3545; text-shadow: 2px 2px 4px rgba(220, 53, 69, 0.2);">{ORDER.total_amount_format}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Order Items -->
    <div style="background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%); border: 4px solid #28a745; border-radius: 20px; box-shadow: 0 15px 40px rgba(40, 167, 69, 0.2); overflow: hidden; transition: all 0.4s ease;" onmouseover="this.style.transform='translateY(-5px)'; this.style.boxShadow='0 20px 50px rgba(40, 167, 69, 0.3)';" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 15px 40px rgba(40, 167, 69, 0.2)';">
    <div style="background: linear-gradient(135deg, #28a745 0%, #20c997 100%); padding: 25px; color: white;">
    <h4 style="margin: 0 0 8px 0; font-size: 24px; font-weight: 700;">📚 Chi tiết sản phẩm</h4>
        <p style="margin: 0; font-size: 16px; opacity: 0.9;">Danh sách sách đã đặt</p>
    </div>
    <div style="padding: 30px;">
    <!-- BEGIN: item -->
    <div style="display: flex; align-items: center; background: rgba(255,255,255,0.9); border-radius: 15px; padding: 20px; margin-bottom: 20px; border: 2px solid #e9ecef; transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.02)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.1)';" onmouseout="this.style.transform='scale(1)'; this.style.boxShadow='none';">
    <div style="flex-shrink: 0; margin-right: 20px;">
    <!-- BEGIN: image -->
    <img src="{ITEM.image_url}" alt="{ITEM.title}" style="width: 80px; height: 80px; object-fit: cover; border-radius: 10px; border: 3px solid #28a745; cursor: pointer;" onclick="openFullImage('{ITEM.image_url}', '{ITEM.title}')">
    <!-- END: image -->
    <!-- BEGIN: no_image -->
    <div style="width: 80px; height: 80px; background: #f8f9fa; display: flex; align-items: center; justify-content: center; border-radius: 10px; border: 3px solid #28a745; font-size: 24px; color: #28a745;">📖</div>
    <!-- END: no_image -->
    </div>
    <div style="flex: 1;">
    <h5 style="margin: 0 0 10px 0; color: #2c3e50; font-size: 20px; font-weight: 700;">{ITEM.title}</h5>
        <div style="font-size: 16px; color: #666;">
            <strong style="color: #28a745;">Số lượng:</strong> {ITEM.quantity}<br>
        <strong style="color: #007bff;">Đơn giá:</strong> {ITEM.price_format}
    </div>
    </div>
        <div style="text-align: center; background: linear-gradient(135deg, #28a745 0%, #20c997 100%); padding: 20px; border-radius: 15px; border: 3px solid #28a745; min-width: 150px;">
            <div style="font-size: 14px; color: rgba(255,255,255,0.8); margin-bottom: 5px;">Thành tiền</div>
                <div style="font-size: 24px; font-weight: 700; color: white; text-shadow: 2px 2px 4px rgba(0,0,0,0.2);">{ITEM.subtotal}</div>
                </div>
            </div>
            <!-- END: item -->
        </div>
    </div>
</div>

<!-- Modal for full size image -->
<div id="imageModal" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background: linear-gradient(135deg, rgba(0,123,255,0.9) 0%, rgba(0,86,179,0.9) 100%); backdrop-filter: blur(10px);">
    <span style="position: absolute; top: 15px; right: 35px; color: #fff; font-size: 40px; font-weight: bold; cursor: pointer; text-shadow: 2px 2px 4px rgba(0,0,0,0.5);" onclick="closeModal()">&times;</span>
    <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%); border: 4px solid #007bff; border-radius: 20px; padding: 20px; box-shadow: 0 15px 40px rgba(0, 123, 255, 0.3); max-width: 90%; max-height: 90%; overflow: hidden;">
        <img id="fullImage" style="width: 100%; height: auto; max-height: 70vh; object-fit: contain; border-radius: 15px; display: block;">
        <div id="caption" style="text-align: center; color: #333; padding: 15px 0 0 0; font-size: 20px; font-weight: 700; text-shadow: 1px 1px 2px rgba(0,0,0,0.1);"></div>
    </div>
</div>

<script>
function openFullImage(src, title) {
    document.getElementById('fullImage').src = src;
    document.getElementById('caption').innerHTML = title;
    document.getElementById('imageModal').style.display = 'block';
}

function closeModal() {
    document.getElementById('imageModal').style.display = 'none';
}

// Close modal when clicking outside the image
document.getElementById('imageModal').onclick = function(event) {
    if (event.target == this) {
        closeModal();
    }
}
</script>
<!-- END: main -->
