<!-- BEGIN: main -->
<div style="width: 100%; font-size: 20px; line-height: 1.8; padding: 25px; background: #f8f9fa;">
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 35px;">
        <div>
        <h1 style="font-size: 32px; margin: 0; color: #333;">{LANG.coupons}</h1>
    <p style="font-size: 18px; color: #666; margin: 5px 0 0;"><!-- BEGIN: edit_mode -->Chỉnh sửa<!-- END: edit_mode --><!-- BEGIN: add_mode -->Thêm mới<!-- END: add_mode --> mã giảm giá</p>
</div>
</div>

<!-- BEGIN: error -->
<div style="background: #f8d7da; color: #721c24; padding: 20px; border: 2px solid #f5c6cb; border-radius: 8px; margin-bottom: 25px; font-size: 18px;">{ERROR}</div>
<!-- END: error -->

<form action="{FORM_ACTION}" method="post" enctype="multipart/form-data" style="background: #fff; border: 3px solid #007bff; padding: 30px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
<div style="margin-bottom: 25px;">
<label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">Mã giảm giá <span style="color: #dc3545;">*</span></label>
<input type="text" name="code" value="{FORM_DATA.code}" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" required />
</div>

<div style="margin-bottom: 25px;">
<label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">Giá trị giảm <span style="color: #dc3545;">*</span></label>
    <input type="number" step="0.01" name="discount_value" value="{FORM_DATA.discount_value}" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" required />
        </div>

<div style="margin-bottom: 25px;">
<label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">Loại giảm</label>
<select name="discount_type" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;">
<option value="percentage" {FORM_DATA.percentage_selected}>Phần trăm (%)</option>
<option value="fixed" {FORM_DATA.fixed_selected}>Số tiền cố định (VNĐ)</option>
</select>
</div>

<div style="margin-bottom: 25px;">
<label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">Giới hạn sử dụng</label>
<input type="number" name="usage_limit" value="{FORM_DATA.usage_limit}" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" placeholder="Để trống nếu không giới hạn" />
</div>

<div style="margin-bottom: 25px;">
<label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">Thời gian bắt đầu <span style="color: #dc3545;">*</span></label>
<input type="datetime-local" name="start_time" value="{FORM_DATA.start_time}" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" required />
</div>

<div style="margin-bottom: 25px;">
<label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">Thời gian kết thúc <span style="color: #dc3545;">*</span></label>
<input type="datetime-local" name="end_time" value="{FORM_DATA.end_time}" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" required />
</div>

<div style="margin-bottom: 30px;">
<label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">Trạng thái</label>
<div style="display: flex; gap: 20px; align-items: center;">
<label style="font-size: 18px; color: #333;">
<input type="radio" name="status" value="1" {FORM_DATA.status_active_checked} style="margin-right: 8px; width: 18px; height: 18px;" /> Kích hoạt
</label>
<label style="font-size: 18px; color: #333;">
<input type="radio" name="status" value="0" {FORM_DATA.status_inactive_checked} style="margin-right: 8px; width: 18px; height: 18px;" /> Vô hiệu hóa
</label>
</div>
</div>

<div style="text-align: center;">
<button type="submit" name="save_coupon" style="padding: 15px 30px; background: #28a745; color: #fff; border: 2px solid #28a745; border-radius: 8px; font-size: 18px; font-weight: bold; margin-right: 15px;">Lưu</button>
<a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=coupons" style="padding: 15px 30px; background: #6c757d; color: #fff; text-decoration: none; border: 2px solid #6c757d; border-radius: 8px; font-size: 18px; font-weight: bold;">Hủy</a>
</div>
</form>

<div style="background: #fff; border: 3px solid #17a2b8; padding: 30px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.15); margin-top: 25px;">
<h3 style="font-size: 24px; margin-bottom: 20px; color: #17a2b8;">Hướng dẫn</h3>
<ul style="font-size: 18px; line-height: 1.6;">
<li>Mã giảm giá phải là duy nhất</li>
<li>Thời gian bắt đầu phải trước thời gian kết thúc</li>
<li>Để trống giới hạn sử dụng nếu không muốn giới hạn</li>
</ul>
</div>
</div>
<!-- END: main -->
