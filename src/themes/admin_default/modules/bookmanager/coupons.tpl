<!-- INCLUDE: shared_styles.tpl -->

<!-- BEGIN: main -->
<div style="width: 100%; font-size: 20px; line-height: 1.8; padding: 25px; background: #f8f9fa;">
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 35px;">
    <div>
        <h1 style="font-size: 32px; margin: 0; color: #333;">{LANG.coupons}</h1>
        <p style="font-size: 18px; color: #666; margin: 5px 0 0;">Danh sách tất cả mã giảm giá</p>
    </div>
    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=coupons&action=add" style="padding: 12px 24px; background: #28a745; color: #fff; text-decoration: none; border-radius: 8px; font-size: 18px; font-weight: bold;">{LANG.add_coupon}</a>
</div>

    <!-- Coupons Table -->
    <div style="background: #fff; border: 3px solid #333; border-radius: 15px; overflow: hidden; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
        <div style="padding: 25px; background: #f8f9fa; border-bottom: 2px solid #333;">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <h2 style="font-size: 24px; margin: 0; color: #333;">{LANG.coupons}</h2>
                <p style="font-size: 18px; color: #666; margin: 0;">Hiển thị {TOTAL_COUPONS} mã giảm giá</p>
            </div>
        </div>

        <div style="overflow-x: auto;">
    <table style="width: 100%; border-collapse: collapse; font-size: 18px;">
                <thead>
            <tr style="background: #007bff; color: #fff;">
                <th style="padding: 20px; text-align: center; font-size: 20px;">{LANG.code}</th>
            <th style="padding: 20px; font-size: 20px;">{LANG.discount}</th>
                        <th style="padding: 20px; font-size: 20px;">{LANG.valid_period}</th>
                        <th style="padding: 20px; font-size: 20px;">{LANG.usage_stats}</th>
                        <th style="padding: 20px; font-size: 20px;">{LANG.status}</th>
                        <th style="padding: 20px; text-align: center; font-size: 20px;">{LANG.actions}</th>
            </tr>
    </thead>
                    <tbody>
                        <!-- BEGIN: coupon_loop -->
                        <tr style="background: #f9f9f9; border-bottom: 1px solid #ddd;">
                        <td style="padding: 20px;">
                        <div style="display: flex; align-items: center;">

                        <div>
                        <strong style="color: #007bff; font-size: 16px;">{COUPON.code}</strong>
                        <br>
                        <small style="color: #666;">ID: {COUPON.id}</small>
                        </div>
                        </div>
                        </td>
                            <td style="padding: 15px; border-bottom: 1px solid #eee;">
                            <div>
                            <strong style="color: #28a745; font-size: 16px;">{COUPON.value_format}</strong>
                            <br>
                            <small style="color: #666;">{COUPON.type_text}</small>
                            </div>
                            </td>
                            <td style="padding: 15px; border-bottom: 1px solid #eee;">
                            <div>
                            <small style="color: #666;">
                            {COUPON.start_time}
                            </small>
                            <br>
                            <small style="color: #666;">
                            {COUPON.end_time}
                            </small>
                            </div>
                            </td>
                            <td style="padding: 15px; border-bottom: 1px solid #eee;">
                            <div style="display: flex; align-items: center;">
                            <div>
                            <strong style="font-size: 16px;">{COUPON.used_count}</strong>
                            <small style="color: #666; display: block;">lần sử dụng</small>
                            </div>
                            </div>
                            </td>
                            <td style="padding: 15px; border-bottom: 1px solid #eee;">
                            <span style="background: {COUPON.status_color}; color: white; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: bold;">{COUPON.status_text}</span>
                            </td>
                            <td style="padding: 15px; border-bottom: 1px solid #eee; text-align: center;">
                            <div style="display: flex; gap: 5px; justify-content: center;">
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=coupons&action=edit&id={COUPON.id}" style="padding: 8px 12px; background: transparent; color: #007bff; text-decoration: none; border: 1px solid #007bff; border-radius: 4px; font-size: 14px;" title="{GLANG.edit}">
                            Sửa
                            </a>
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=coupons&action=delete&id={COUPON.id}" style="padding: 8px 12px; background: transparent; color: #dc3545; text-decoration: none; border: 1px solid #dc3545; border-radius: 4px; font-size: 14px;" title="{GLANG.delete}" onclick="return confirm('{LANG.confirm_delete}')">
                            Xóa
                            </a>
                            </div>
                            </td>
                        </tr>
                        <!-- END: coupon_loop -->
                    </tbody>
                </table>
            </div>

            <!-- No Coupons -->
            <!-- BEGIN: no_coupons -->
            <div style="text-align: center; padding: 60px 20px;">
            <h4 style="margin: 0 0 10px 0;">{LANG.no_coupons}</h4>
            <p style="color: #666; margin: 0;">{LANG.no_coupons_message}</p>
            </div>
            <!-- END: no_coupons -->
        </div>
    </div>

    <!-- Pagination -->
    <!-- BEGIN: pagination -->
    <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
            <!-- BEGIN: page -->
            <li class="page-item {PAGE.current}">
                <a class="page-link" href="{PAGE.link}">{PAGE.num}</a>
            </li>
            <!-- END: page -->
        </ul>
    </nav>
    <!-- END: pagination -->

    <!-- INCLUDE: admin_scripts.tpl -->
</div>
<!-- END: main -->
