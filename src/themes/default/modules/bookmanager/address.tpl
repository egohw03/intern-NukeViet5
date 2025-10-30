<!-- BEGIN: main -->
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h2>{LANG.addresses}</h2>

            <!-- Message -->
            <!-- BEGIN: message -->
            <div class="alert alert-info">{MESSAGE}</div>
            <!-- END: message -->

            <div class="row">
                <!-- Address Form -->
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <!-- BEGIN: edit_mode -->{LANG.edit_address}<!-- END: edit_mode -->
                                <!-- BEGIN: add_mode -->{LANG.add_address}<!-- END: add_mode -->
                            </h5>
                        </div>
                        <div class="card-body">
                            <form method="post" action="">
                                <div class="mb-3">
                                    <label for="full_name" class="form-label">{LANG.customer_name}</label>
                                    <input type="text" class="form-control" id="full_name" name="full_name" value="{FORM_DATA.full_name}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="phone" class="form-label">{LANG.customer_phone}</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" value="{FORM_DATA.phone}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="address" class="form-label">{LANG.customer_address}</label>
                                    <textarea class="form-control" id="address" name="address" rows="3" required>{FORM_DATA.address}</textarea>
                                </div>
                                <div class="mb-3 form-check">
                                    <input type="checkbox" class="form-check-input" id="is_default" name="is_default" value="1" {FORM_DATA.is_default_checked}>
                                    <label class="form-check-label" for="is_default">{LANG.default_address}</label>
                                </div>
                                <button type="submit" name="save_address" class="btn btn-primary">{LANG.save}</button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Address List -->
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">{LANG.addresses}</h5>
                        </div>
                        <div class="card-body">
                            <!-- BEGIN: addresses -->
                            <!-- BEGIN: address_loop -->
                            <div class="address-item border-bottom pb-3 mb-3">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <strong>{ADDRESS.full_name}</strong>
                                        <!-- BEGIN: is_default -->
                                        <span class="badge bg-primary ms-2">{LANG.default_address}</span>
                                        <!-- END: is_default -->
                                        <br>
                                        <span class="text-muted">{ADDRESS.phone}</span><br>
                                        <span class="text-muted">{ADDRESS.address}</span>
                                    </div>
                                    <div>
                                        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=address&edit={ADDRESS.id}" class="btn btn-sm btn-outline-primary me-1">{LANG.edit}</a>
                                        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=address&delete={ADDRESS.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('{LANG.confirm_delete}');">{LANG.delete}</a>
                                    </div>
                                </div>
                            </div>
                            <!-- END: address_loop -->
                            <!-- END: addresses -->

                            <!-- BEGIN: no_addresses -->
                            <div class="text-center text-muted">
                                <p>{LANG.no_addresses}</p>
                                <p>{LANG.no_addresses_message}</p>
                            </div>
                            <!-- END: no_addresses -->
                        </div>
                    </div>
                </div>
            </div>

            <div class="mt-4">
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" class="btn btn-secondary">{LANG.back_to_orders}</a>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
