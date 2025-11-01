<!-- BEGIN: main -->
<div style="width: 100%; font-size: 20px; line-height: 1.8; padding: 25px; background: #f8f9fa;">
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 35px;">
    <div>
    <h1 style="font-size: 32px; margin: 0; color: #333;">{LANG.add_cat}</h1>
<p style="font-size: 18px; color: #666; margin: 5px 0 0;">Thêm thể loại mới</p>
</div>
</div>

<!-- BEGIN: error -->
<div style="background: #f8d7da; color: #721c24; padding: 20px; border: 2px solid #f5c6cb; border-radius: 8px; margin-bottom: 25px; font-size: 18px;">
<ul style="margin: 0; padding-left: 20px;">
<!-- BEGIN: error_item -->
<li>{ERROR}</li>
<!-- END: error_item -->
</ul>
</div>
<!-- END: error -->

<form method="post" action="" style="background: #fff; border: 3px solid #007bff; padding: 30px; border-radius: 15px; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
<div style="margin-bottom: 25px;">
<label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.title} <span style="color: #dc3545;">*</span></label>
<input type="text" name="title" value="{CAT.title}" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" required />
</div>

<div style="margin-bottom: 25px;">
<label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.description}</label>
<textarea name="description" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px; height: 120px;">{CAT.description}</textarea>
</div>

<div style="margin-bottom: 25px;">
        <label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.parent_category}</label>
<select name="parent_id" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;">
<option value="0">{LANG.root_category}</option>
<!-- BEGIN: parent_option -->
<option value="{PARENT.id}" {PARENT.selected}>{PARENT.title}</option>
        <!-- END: parent_option -->
</select>
</div>

<div style="margin-bottom: 25px;">
<label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">{LANG.weight}</label>
<input type="number" name="weight" value="{CAT.weight}" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 8px; font-size: 18px;" min="1" max="255" />
<small style="font-size: 16px; color: #666; display: block; margin-top: 5px;">Thứ tự hiển thị (số nhỏ hiển thị trước)</small>
</div>

        <div style="margin-bottom: 30px;">
        <label style="display: block; font-size: 20px; font-weight: bold; margin-bottom: 10px; color: #333;">Trạng thái</label>
        <div style="display: flex; gap: 20px; align-items: center;">
        <label style="font-size: 18px; color: #333;">
        <input type="radio" name="status" value="1" {CAT.status_active_checked} style="margin-right: 8px; width: 18px; height: 18px;" /> Hoạt động
        </label>
        <label style="font-size: 18px; color: #333;">
        <input type="radio" name="status" value="0" {CAT.status_inactive_checked} style="margin-right: 8px; width: 18px; height: 18px;" /> Không hoạt động
        </label>
        </div>
        </div>

<div style="text-align: center;">
<button type="submit" name="submit" style="padding: 15px 30px; background: #28a745; color: #fff; border: 2px solid #28a745; border-radius: 8px; font-size: 18px; font-weight: bold; margin-right: 15px;">
{LANG.save}
</button>
        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=categories" style="padding: 15px 30px; background: #6c757d; color: #fff; text-decoration: none; border: 2px solid #6c757d; border-radius: 8px; font-size: 18px; font-weight: bold;">{LANG.cancel}</a>
</div>
</form>
</div>
<!-- END: main -->
