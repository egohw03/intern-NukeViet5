<!-- BEGIN: main -->
<div class="container">
    <div class="row">
        <div class="col-12">
            <h4 class="mb-4">{LANG.addresses}</h4>

            <!-- Message -->
            <!-- BEGIN: message -->
            <div class="alert alert-info">{MESSAGE}</div>
            <!-- END: message -->

            <!-- Address Form -->
            <div class="card mb-4">
                <div class="card-header">
                    <h6 class="mb-0">
                        <!-- BEGIN: edit_mode -->{LANG.edit_address}<!-- END: edit_mode -->
                        <!-- BEGIN: add_mode -->{LANG.add_address}<!-- END: add_mode -->
                    </h6>
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
                        <button type="submit" name="save_address" class="btn btn-primary w-100">{LANG.save}</button>
                    </form>
                </div>
            </div>

            <!-- Address List -->
            <div class="card">
                <div class="card-header">
                    <h6 class="mb-0">{LANG.addresses}</h6>
                </div>
                <div class="card-body">
                    <!-- BEGIN: addresses -->
                    <!-- BEGIN: address_loop -->
                    <div class="address-item border-bottom pb-3 mb-3">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <div>
                                <strong>{ADDRESS.full_name}</strong>
                                <!-- BEGIN: is_default -->
                                <span class="badge bg-primary ms-2 small">{LANG.default_address}</span>
                                <!-- END: is_default -->
                            </div>
                            <div>
                                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=address&edit={ADDRESS.id}" class="btn btn-sm btn-outline-primary me-1">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=address&delete={ADDRESS.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('{LANG.confirm_delete}');">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </div>
                        </div>
                        <div class="text-muted small">
                            <div>{ADDRESS.phone}</div>
                            <div>{ADDRESS.address}</div>
                        </div>
                    </div>
                    <!-- END: address_loop -->
                    <!-- END: addresses -->

                    <!-- BEGIN: no_addresses -->
                    <div class="text-center text-muted py-4">
                        <i class="fas fa-map-marker-alt fa-3x mb-3"></i>
                        <p>{LANG.no_addresses}</p>
                        <p class="small">{LANG.no_addresses_message}</p>
                    </div>
                    <!-- END: no_addresses -->
                </div>
            </div>

            <div class="mt-4">
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" class="btn btn-secondary w-100">{LANG.back_to_orders}</a>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
