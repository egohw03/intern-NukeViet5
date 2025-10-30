<!-- BEGIN: main -->
<div class="delete-confirmation">
    <div class="text-center mb-4">
        <i class="fas fa-exclamation-triangle fa-4x text-warning mb-3"></i>
        <h2>{LANG.confirm_delete}</h2>
    </div>

    <div class="card">
        <div class="card-header bg-danger text-white">
            <h5 class="mb-0">{LANG.delete_book}: "{BOOK.title}"</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4 text-center">
                    <!-- BEGIN: image -->
                    <img src="{IMAGE_URL}" alt="{BOOK.title}" class="img-fluid rounded shadow" style="max-width: 200px;">
                    <!-- END: image -->
                    <!-- BEGIN: no_image -->
                    <div class="bg-light rounded d-flex align-items-center justify-content-center" style="width: 200px; height: 200px;">
                        <i class="fas fa-book fa-3x text-muted"></i>
                    </div>
                    <!-- END: no_image -->
                </div>
                <div class="col-md-8">
                    <dl class="row">
                        <dt class="col-sm-4">{LANG.title}:</dt>
                        <dd class="col-sm-8">{BOOK.title}</dd>

                        <dt class="col-sm-4">{LANG.author}:</dt>
                        <dd class="col-sm-8">{BOOK.author}</dd>

                        <dt class="col-sm-4">{LANG.category}:</dt>
                        <dd class="col-sm-8">{BOOK.cat_title}</dd>

                        <dt class="col-sm-4">{LANG.price}:</dt>
                        <dd class="col-sm-8">{BOOK.price_format}</dd>

                        <dt class="col-sm-4">{LANG.stock_quantity}:</dt>
                        <dd class="col-sm-8">{BOOK.stock_quantity} cuốn</dd>
                    </dl>

                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle"></i>
                        <strong>{LANG.warning}:</strong> {LANG.delete_warning_text}
                    </div>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <form method="post" action="">
                <div class="d-flex justify-content-center gap-3">
                    <button type="submit" name="confirm" value="1" class="btn btn-danger btn-lg">
                        <i class="fas fa-trash"></i> {LANG.delete}
                    </button>
                    <a href="{CANCEL_LINK}" class="btn btn-secondary btn-lg">
                        <i class="fas fa-times"></i> {LANG.cancel}
                    </a>
                </div>
            </form>
        </div>
    </div>

    <!-- BEGIN: error -->
    <div class="alert alert-danger mt-3">
        {ERROR}
    </div>
    <!-- END: error -->
</div>
<!-- END: main -->
