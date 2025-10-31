<!-- BEGIN: main -->
<div style="max-width: 1200px; margin: 0 auto; padding: 20px;">
    <h2 style="margin-bottom: 20px;">{LANG.addresses}</h2>

    <!-- Message -->
    <!-- BEGIN: message -->
    <div style="background: #d1ecf1; color: #0c5460; padding: 10px; border-radius: 4px; margin-bottom: 20px;">{MESSAGE}</div>
    <!-- END: message -->

    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
        <!-- Address Form -->
        <div>
            <div style="background: white; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 30px;">
                <div style="background: #f8f9fa; padding: 15px; border-bottom: 1px solid #ddd; border-radius: 8px 8px 0 0;">
                    <h5 style="margin: 0;">
                        <!-- BEGIN: edit_mode -->{LANG.edit_address}<!-- END: edit_mode -->
                        <!-- BEGIN: add_mode -->{LANG.add_address}<!-- END: add_mode -->
                    </h5>
                </div>
                <div style="padding: 20px;">
                    <form method="post" action="">
                        <div style="margin-bottom: 20px;">
                            <label for="full_name" style="display: block; margin-bottom: 5px; font-weight: bold;">{LANG.customer_name}</label>
                            <input type="text" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;" id="full_name" name="full_name" value="{FORM_DATA.full_name}" required>
                        </div>
                        <div style="margin-bottom: 20px;">
                            <label for="phone" style="display: block; margin-bottom: 5px; font-weight: bold;">{LANG.customer_phone}</label>
                            <input type="tel" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;" id="phone" name="phone" value="{FORM_DATA.phone}" required>
                        </div>
                        <div style="margin-bottom: 20px;">
                            <label for="address" style="display: block; margin-bottom: 5px; font-weight: bold;">{LANG.customer_address}</label>
                            <textarea style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;" id="address" name="address" rows="3" required>{FORM_DATA.address}</textarea>
                        </div>
                        <div style="margin-bottom: 20px;">
                            <input type="checkbox" id="is_default" name="is_default" value="1" {FORM_DATA.is_default_checked}>
                            <label for="is_default" style="margin-left: 5px;">{LANG.default_address}</label>
                        </div>
                        <button type="submit" name="save_address" style="padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer;">{LANG.save}</button>
                    </form>
                        </div>
                    </div>
                </div>

        <!-- Address List -->
        <div>
            <div style="background: white; border: 1px solid #ddd; border-radius: 8px;">
                <div style="background: #f8f9fa; padding: 15px; border-bottom: 1px solid #ddd; border-radius: 8px 8px 0 0;">
                    <h5 style="margin: 0;">{LANG.addresses}</h5>
                </div>
                <div style="padding: 20px;">
                    <!-- BEGIN: addresses -->
                    <!-- BEGIN: address_loop -->
                    <div style="border-bottom: 1px solid #eee; padding-bottom: 15px; margin-bottom: 15px;">
                        <div style="display: flex; justify-content: space-between; align-items: start;">
                            <div>
                                <strong>{ADDRESS.full_name}</strong>
                                <!-- BEGIN: is_default -->
                                <span style="background: #007bff; color: white; padding: 2px 6px; border-radius: 4px; font-size: 12px; margin-left: 10px;">{LANG.default_address}</span>
                                <!-- END: is_default -->
                                <br>
                                <span style="color: #666;">{ADDRESS.phone}</span><br>
                                <span style="color: #666;">{ADDRESS.address}</span>
                            </div>
                            <div>
                                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=address&edit={ADDRESS.id}" style="padding: 6px 12px; background: transparent; color: #007bff; text-decoration: none; border: 1px solid #007bff; border-radius: 4px; font-size: 14px; margin-right: 5px;">{LANG.edit}</a>
                                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=address&delete={ADDRESS.id}" style="padding: 6px 12px; background: transparent; color: #dc3545; text-decoration: none; border: 1px solid #dc3545; border-radius: 4px; font-size: 14px;" onclick="return confirm('{LANG.confirm_delete}');">{LANG.delete}</a>
                            </div>
                        </div>
                    </div>
                    <!-- END: address_loop -->
                    <!-- END: addresses -->

                    <!-- BEGIN: no_addresses -->
                    <div style="text-align: center; color: #666;">
                        <p>{LANG.no_addresses}</p>
                        <p>{LANG.no_addresses_message}</p>
                    </div>
                    <!-- END: no_addresses -->
                </div>
            </div>
        </div>
            </div>

    <div style="margin-top: 30px;">
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" style="display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; border-radius: 4px;">{LANG.back_to_orders}</a>
    </div>
</div>
<!-- END: main -->
