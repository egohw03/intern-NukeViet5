<!-- INCLUDE: shared_styles.tpl -->

<!-- BEGIN: main -->
<div class="bookmanager-admin">
    <div style="background: white; border-bottom: 1px solid #ddd; padding: 20px 0;">
    <div style="max-width: 1200px; margin: 0 auto; padding: 0 20px;">
    <div style="display: flex; justify-content: space-between; align-items: center;">
    <div style="display: flex; align-items: center;">
    <div>
    <h1 style="margin: 0 0 5px 0; font-size: 24px;">{LANG.coupons}</h1>
    <div style="color: #666; font-size: 14px;">Danh sách tất cả mã giảm giá</div>
    </div>
    </div>
    <div>
    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=coupons&action=add" style="display: inline-block; padding: 10px 20px; background: #f8f9fa; color: #333; text-decoration: none; border: 1px solid #ddd; border-radius: 4px;">
    {LANG.add_coupon}
    </a>
    </div>
    </div>
    </div>
    </div>

    <div style="max-width: 1200px; margin: 0 auto; padding: 20px;">

    <!-- Coupons Table -->
    <div style="background: white; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 20px;">
    <div style="background: #f8f9fa; padding: 15px; border-bottom: 1px solid #ddd; border-radius: 8px 8px 0 0;">
    <h5 style="margin: 0;">{LANG.coupons}</h5>
    </div>
    <div style="overflow-x: auto;">
    <table style="width: 100%; border-collapse: collapse;">
    <thead>
            <tr style="background: #f8f9fa;">
                    <th style="padding: 12px; text-align: left; border-bottom: 1px solid #ddd;">{LANG.code}</th>
                    <th style="padding: 12px; text-align: left; border-bottom: 1px solid #ddd;">{LANG.discount}</th>
            <th style="padding: 12px; text-align: left; border-bottom: 1px solid #ddd;">{LANG.valid_period}</th>
    <th style="padding: 12px; text-align: left; border-bottom: 1px solid #ddd;">{LANG.usage_stats}</th>
    <th style="padding: 12px; text-align: left; border-bottom: 1px solid #ddd;">{LANG.status}</th>
    <th style="padding: 12px; text-align: center; border-bottom: 1px solid #ddd;">{LANG.actions}</th>
    </tr>
    </thead>
                    <tbody>
                        <!-- BEGIN: coupon_loop -->
                        <tr style="border-bottom: 1px solid #eee; background: white;">
                            <td style="padding: 12px; border-bottom: 1px solid #eee;">
                            <div style="display: flex; align-items: center;">
                            
                            <div>
                            <strong style="color: #007bff; font-size: 16px;">{COUPON.code}</strong>
                            <br>
                            <small style="color: #666;">ID: {COUPON.id}</small>
                            </div>
                            </div>
                            </td>
                            <td style="padding: 12px; border-bottom: 1px solid #eee;">
                            <div>
                            <strong style="color: #28a745; font-size: 16px;">{COUPON.value_format}</strong>
                            <br>
                            <small style="color: #666;">{COUPON.type_text}</small>
                            </div>
                            </td>
                            <td style="padding: 12px; border-bottom: 1px solid #eee;">
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
                            <td style="padding: 12px; border-bottom: 1px solid #eee;">
                            <div style="display: flex; align-items: center;">
                            <div>
                            <strong>{COUPON.used_count}</strong>
                            <small style="color: #666; display: block;">lần sử dụng</small>
                            </div>
                            </div>
                            </td>
                            <td style="padding: 12px; border-bottom: 1px solid #eee;">
                            <span style="background: #{COUPON.status_class}; color: white; padding: 2px 6px; border-radius: 4px; font-size: 12px;">{COUPON.status_text}</span>
                            </td>
                            <td style="padding: 12px; border-bottom: 1px solid #eee; text-align: center;">
                            <div style="display: flex; gap: 5px; justify-content: center;">
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=coupons&action=edit&id={COUPON.id}" style="padding: 6px 12px; background: transparent; color: #007bff; text-decoration: none; border: 1px solid #007bff; border-radius: 4px; font-size: 14px;" title="{GLANG.edit}">
                            Sửa
                            </a>
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=coupons&action=delete&id={COUPON.id}" style="padding: 6px 12px; background: transparent; color: #dc3545; text-decoration: none; border: 1px solid #dc3545; border-radius: 4px; font-size: 14px;" title="{GLANG.delete}" onclick="return confirm('{LANG.confirm_delete}')">
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
