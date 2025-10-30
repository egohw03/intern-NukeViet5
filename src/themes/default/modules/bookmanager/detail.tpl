<!-- BEGIN: main -->
<div class="book-detail">
    <div class="row">
        <!-- Book Image -->
        <div class="col-md-4">
            <!-- BEGIN: image -->
            <img src="{BOOK.image_url}" alt="{BOOK.title}" class="img-fluid rounded shadow">
            <!-- END: image -->
            <!-- BEGIN: no_image -->
            <div class="bg-light rounded p-5 text-center">
                <i class="fas fa-book fa-5x text-muted"></i>
            </div>
            <!-- END: no_image -->
        </div>

        <!-- Book Info -->
        <div class="col-md-8">
            <h1 class="mb-3">{BOOK.title}</h1>
            <p class="text-muted mb-2"><strong>{LANG.author}:</strong> {BOOK.author}</p>
            <p class="text-muted mb-2"><strong>{LANG.category}:</strong> {BOOK.category}</p>
            <p class="h4 text-primary mb-3"><strong>{BOOK.price_format}</strong></p>

            <!-- Stock Status -->
            <!-- BEGIN: in_stock -->
            <p class="text-success"><i class="fas fa-check-circle"></i> {LANG.in_stock} ({BOOK.stock_quantity})</p>
            <form method="post" class="mb-3">
                <div class="row g-2">
                    <div class="col-auto">
                        <input type="number" name="quantity" value="1" min="1" max="{BOOK.stock_quantity}" class="form-control">
                    </div>
                    <div class="col-auto">
                        <button type="submit" name="add_to_cart" class="btn btn-primary">
                            <i class="fas fa-cart-plus"></i> {LANG.add_to_cart}
                        </button>
                    </div>
                </div>
            </form>
            <!-- END: in_stock -->

            <!-- BEGIN: out_of_stock -->
            <p class="text-danger"><i class="fas fa-times-circle"></i> {LANG.out_of_stock}</p>
            <!-- END: out_of_stock -->

            <!-- BEGIN: login_required -->
            <div class="alert alert-warning">
                <i class="fas fa-info-circle"></i> {LANG.login_required}
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}=users" class="btn btn-primary btn-sm ms-2">
                    {GLANG.login}
                </a>
            </div>
            <!-- END: login_required -->
        </div>
    </div>

    <!-- Description -->
    <div class="row mt-4">
        <div class="col-12">
            <h3>{LANG.description}</h3>
            <!-- BEGIN: description -->
            <div class="mt-3">{BOOK.description}</div>
            <!-- END: description -->
            <!-- BEGIN: no_description -->
            <p class="text-muted">{LANG.no_description}</p>
            <!-- END: no_description -->
        </div>
    </div>
</div>
<!-- END: main -->
