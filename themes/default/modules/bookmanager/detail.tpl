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

    <!-- Tabs Section -->
    <div class="row mt-5">
        <div class="col-12">
            <ul class="nav nav-tabs" id="bookTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="description-tab" data-bs-toggle="tab" data-bs-target="#description" type="button" role="tab" aria-controls="description" aria-selected="true">{LANG.description}</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews" type="button" role="tab" aria-controls="reviews" aria-selected="false">{LANG.reviews} ({TOTAL_REVIEWS})</button>
                </li>
            </ul>
            <div class="tab-content mt-3" id="bookTabsContent">
                <div class="tab-pane fade show active" id="description" role="tabpanel" aria-labelledby="description-tab">
                    <!-- BEGIN: description -->
                    <div class="book-description">
                        {BOOK.description}
                    </div>
                    <!-- END: description -->
                    <!-- BEGIN: no_description -->
                    <p class="text-muted">Chưa có mô tả cho cuốn sách này.</p>
                    <!-- END: no_description -->
                </div>
                <div class="tab-pane fade" id="reviews" role="tabpanel" aria-labelledby="reviews-tab">
                    <!-- BEGIN: reviews -->
                    <div class="reviews-section">
                        <div class="average-rating mb-4">
                            <h4>{LANG.average_rating}: {AVG_RATING}/5 ★</h4>
                            <small class="text-muted">{TOTAL_REVIEWS} {LANG.total_reviews}</small>
                        </div>

                        <!-- BEGIN: review_loop -->
                        <div class="review-item mb-4 p-3 border rounded">
                            <div class="review-header d-flex justify-content-between align-items-start mb-2">
                                <div>
                                    <strong>{REVIEW.username}</strong>
                                    <div class="rating">
                                        {REVIEW.rating}/5 ★
                                    </div>
                                </div>
                                <small class="text-muted">{REVIEW.add_time_format}</small>
                            </div>
                            <!-- BEGIN: review_title -->
                            <h6 class="review-title">{REVIEW.title}</h6>
                            <!-- END: review_title -->
                            <div class="review-content">
                                {REVIEW.content}
                            </div>
                        </div>
                        <!-- END: review_loop -->
                    </div>
                    <!-- END: reviews -->

                    <!-- BEGIN: no_reviews -->
                    <div class="no-reviews text-center py-4">
                        <i class="fas fa-comments fa-3x text-muted mb-3"></i>
                        <p class="text-muted">{LANG.no_reviews}</p>
                    </div>
                    <!-- END: no_reviews -->

                    <!-- BEGIN: review_form -->
                    <div class="review-form mt-4">
                        <h5>{LANG.write_review}</h5>
                        <form method="post" action="">
                            <div class="mb-3">
                                <label class="form-label">{LANG.rating}</label>
                                <select name="rating" class="form-select" required>
                                    <option value="">{LANG.select_rating}</option>
                                    <option value="5">5 ★ - Xuất sắc</option>
                                    <option value="4">4 ★ - Tốt</option>
                                    <option value="3">3 ★ - Bình thường</option>
                                    <option value="2">2 ★ - Tệ</option>
                                    <option value="1">1 ★ - Rất tệ</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">{LANG.review_title} ({LANG.optional})</label>
                                <input type="text" name="review_title" class="form-control" maxlength="255">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">{LANG.review_content}</label>
                                <textarea name="review_content" class="form-control" rows="4" required></textarea>
                            </div>
                            <button type="submit" name="submit_review" class="btn btn-primary">{LANG.submit_review}</button>
                        </form>
                    </div>
                    <!-- END: review_form -->
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
