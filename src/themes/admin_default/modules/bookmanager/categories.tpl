<!-- BEGIN: main -->
<div style="width: 100%; font-size: 20px; line-height: 1.8; padding: 25px; background: #f8f9fa;">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 35px;">
        <div>
            <h1 style="font-size: 32px; margin: 0; color: #333;">{LANG.categories} ({CATEGORIES_COUNT})</h1>
            <p style="font-size: 18px; color: #666; margin: 5px 0 0;">Danh sách các thể loại sách</p>
        </div>
        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=add_cat" style="padding: 12px 24px; background: #28a745; color: #fff; text-decoration: none; border-radius: 8px; font-size: 18px; font-weight: bold;">{LANG.add_cat}</a>
    </div>

    <!-- BEGIN: error -->
    <div style="background: #f8d7da; color: #721c24; padding: 15px; border: 1px solid #f5c6cb; border-radius: 4px; margin-bottom: 20px;">{ERROR}</div>
    <!-- END: error -->

    <!-- Categories List -->
    <div style="background: #fff; border: 3px solid #333; border-radius: 15px; overflow: hidden; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
        <div style="padding: 25px; background: #f8f9fa; border-bottom: 2px solid #333;">
            <h2 style="font-size: 24px; margin: 0; color: #333;">Danh sách thể loại</h2>
        </div>

        <div style="overflow-x: auto;">
            <table style="width: 100%; border-collapse: collapse; font-size: 18px;">
                <thead>
                    <tr style="background: #007bff; color: #fff;">
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 80px;">ID</th>
                        <th style="padding: 20px; font-size: 20px;">Tên thể loại</th>
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 120px;">Số sách</th>
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 100px;">Thứ tự</th>
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 120px;">Trạng thái</th>
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 180px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- BEGIN: category_loop -->
                    <tr style="background: #f9f9f9; border-bottom: 1px solid #ddd;">
                        <td style="padding: 20px; text-align: center; font-size: 18px; font-weight: bold; color: #007bff;">{CAT.id}</td>
                        <td style="padding: 20px;">
                            <div style="font-size: 20px; font-weight: bold; color: #333; margin-bottom: 5px;">{CAT.title}</div>
                            <!-- BEGIN: has_subcats -->
                            <div style="font-size: 16px; color: #666;">({CAT.subcat_count} thể loại con)</div>
                            <!-- END: has_subcats -->
                        </td>
                        <td style="padding: 20px; text-align: center; font-size: 18px; font-weight: bold; color: #28a745;">{CAT.book_count}</td>
                        <td style="padding: 20px; text-align: center; font-size: 18px;">{CAT.weight}</td>
                        <td style="padding: 20px; text-align: center;">
                        <span style="color: {CAT.status_color}; font-size: 18px; font-weight: bold;">{CAT.status_text}</span>
                        </td>
                        <td style="padding: 20px; text-align: center;">
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=edit_cat&id={CAT.id}" style="padding: 8px 16px; background: #28a745; color: #fff; text-decoration: none; border-radius: 6px; font-size: 16px; margin-right: 10px;">{LANG.edit}</a>
                            <!-- BEGIN: delete_allowed -->
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=del_cat&id={CAT.id}" onclick="return confirm('{LANG.confirm_delete}')" style="padding: 8px 16px; background: #dc3545; color: #fff; text-decoration: none; border-radius: 6px; font-size: 16px;">{LANG.delete}</a>
                            <!-- END: delete_allowed -->
                            <!-- BEGIN: delete_disabled -->
                            <button style="padding: 8px 16px; background: #6c757d; color: #fff; border: none; border-radius: 6px; font-size: 16px; cursor: not-allowed;" title="Có sách - không thể xóa">{LANG.delete}</button>
                            <!-- END: delete_disabled -->
                        </td>
                    </tr>
                    <!-- END: category_loop -->
                </tbody>
            </table>
        </div>

        <!-- BEGIN: no_categories -->
        <div style="text-align: center; padding: 50px;">
            <div style="font-size: 48px; color: #6c757d; margin-bottom: 20px;">📂</div>
            <h3 style="color: #333; margin-bottom: 10px;">{LANG.no_categories}</h3>
            <p style="font-size: 18px; color: #666; margin-bottom: 20px;">Hãy thêm thể loại đầu tiên của bạn</p>
            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=add_cat" style="padding: 12px 24px; background: #28a745; color: #fff; text-decoration: none; border-radius: 8px; font-size: 18px; font-weight: bold;">{LANG.add_first_category}</a>
        </div>
        <!-- END: no_categories -->
    </div>
</div>
<!-- END: main -->
