<!-- BEGIN: main -->
<div style="max-width: 1200px; margin: 0 auto; padding: 20px;">
    <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 30px; margin-bottom: 30px;">
        <div style="background: white; padding: 20px; border: 1px solid #ddd; border-radius: 8px; text-align: center;">
            <!-- BEGIN: image -->
            <img src="{BOOK.image_url}" alt="{BOOK.title}" style="max-height: 300px; max-width: 100%; margin-bottom: 20px;">
            <!-- END: image -->
            <!-- BEGIN: no_image -->
            <div style="height: 300px; background: #f8f9fa; display: flex; align-items: center; justify-content: center; margin-bottom: 20px;">
                <span style="font-size: 72px; color: #6c757d;">[SACH]</span>
            </div>
            <!-- END: no_image -->

            <h2 style="color: #007bff; margin: 0 0 10px 0;">{BOOK.price_format}</h2>
            <p style="color: #666; margin: 0;">Con {BOOK.stock_quantity} cuon trong kho</p>
        </div>

        <div>
            <div style="background: white; padding: 20px; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 20px;">
                <h1 style="margin: 0 0 20px 0; font-size: 24px;">{BOOK.title}</h1>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 20px;">
                    <div><strong>Tac gia:</strong> {BOOK.author}</div>
                    <div><strong>Nha xuat ban:</strong> {BOOK.publisher}</div>
                    <div><strong>Nam xuat ban:</strong> {BOOK.publish_year}</div>
                    <div><strong>ISBN:</strong> {BOOK.isbn}</div>
                    <div><strong>Danh muc:</strong> {BOOK.cat_title}</div>
                    <div><strong>Ngay them:</strong> {BOOK.add_time}</div>
                </div>

                <!-- BEGIN: success -->
                <div style="background: #d4edda; color: #155724; padding: 10px; border-radius: 4px; margin-bottom: 20px;">
                    [OK] {SUCCESS_MESSAGE}
                </div>
                <!-- END: success -->

                <!-- BEGIN: add_to_cart -->
                <form method="post" action="" style="display: flex; gap: 15px; align-items: end;">
                    <div style="flex: 1;">
                        <label style="display: block; margin-bottom: 5px; font-weight: bold;">So luong</label>
                        <input type="number" name="quantity" value="1" min="1" max="{BOOK.stock_quantity}" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;">
                    </div>
                    <div style="flex: 2;">
                        <button type="submit" name="add_to_cart" style="width: 100%; padding: 10px; background: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px;">
                            Them vao gio hang
                        </button>
                    </div>
                </form>
                <!-- END: add_to_cart -->

                <!-- BEGIN: login_required -->
                <div style="background: #fff3cd; color: #856404; padding: 10px; border-radius: 4px; margin-bottom: 20px;">
                    [INFO] Ban can <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;nv=users&amp;nvredir={NV_REDIRECT}" style="color: #856404;">dang nhap</a> de them sach vao gio hang.
                </div>
                <!-- END: login_required -->
            </div>

            <!-- Description -->
            <!-- BEGIN: description -->
            <div style="background: white; padding: 20px; border: 1px solid #ddd; border-radius: 8px;">
                <h3 style="margin: 0 0 15px 0;">Mo ta sach</h3>
                <div>{BOOK.description}</div>
            </div>
            <!-- END: description -->

                    <!-- Reviews Section -->
            <div style="background: white; padding: 20px; border: 1px solid #ddd; border-radius: 8px; margin-top: 20px;">
                <h3 style="margin: 0 0 15px 0;">Đánh giá sách</h3>

                <!-- Average Rating -->
                <div style="display: flex; align-items: center; margin-bottom: 20px;">
                    <div style="font-size: 24px; font-weight: bold; margin-right: 10px;">{BOOK.avg_rating}/5</div>
                    <div style="flex: 1;">
                        <div style="display: flex; margin-bottom: 5px;">
                            <!-- BEGIN: star -->
                            <span style="color: #ffc107; font-size: 18px;">★</span>
                            <!-- END: star -->
                        </div>
                        <div style="font-size: 14px; color: #666;">{BOOK.total_reviews} đánh giá</div>
                    </div>
                </div>

                <!-- Review Form for logged-in users -->
                <!-- BEGIN: review_form -->
                <div style="border: 1px solid #eee; padding: 15px; border-radius: 8px; margin-bottom: 20px;">
                    <h5>Viết đánh giá</h5>
                    <form method="post" action="">
                        <div style="margin-bottom: 10px;">
                            <label style="display: block; margin-bottom: 5px; font-weight: bold;">Đánh giá:</label>
                            <div style="display: flex; gap: 5px;">
                                <input type="radio" name="rating" value="5" id="rating5" checked>
                                <label for="rating5">★★★★★</label>
                                <input type="radio" name="rating" value="4" id="rating4">
                                <label for="rating4">★★★★☆</label>
                                <input type="radio" name="rating" value="3" id="rating3">
                                <label for="rating3">★★★☆☆</label>
                                <input type="radio" name="rating" value="2" id="rating2">
                                <label for="rating2">★★☆☆☆</label>
                                <input type="radio" name="rating" value="1" id="rating1">
                                <label for="rating1">★☆☆☆☆</label>
                            </div>
                        </div>
                        <div style="margin-bottom: 10px;">
                            <label style="display: block; margin-bottom: 5px; font-weight: bold;">Tiêu đề đánh giá:</label>
                            <input type="text" name="review_title" class="form-control" placeholder="Tiêu đề đánh giá (tùy chọn)">
                        </div>
                        <div style="margin-bottom: 10px;">
                            <label style="display: block; margin-bottom: 5px; font-weight: bold;">Nội dung đánh giá:</label>
                            <textarea name="review_content" rows="4" class="form-control" placeholder="Chia sẻ trải nghiệm của bạn với cuốn sách này..."></textarea>
                        </div>
                        <button type="submit" name="submit_review" class="btn btn-primary">Gửi đánh giá</button>
                    </form>
                </div>
                <!-- END: review_form -->

                <!-- Review Success Message -->
                <!-- BEGIN: review_success -->
                <div style="background: #d4edda; color: #155724; padding: 10px; border-radius: 4px; margin-bottom: 20px;">
                    {SUCCESS_MESSAGE}
                </div>
                <!-- END: review_success -->

                <!-- Review Error Message -->
                <!-- BEGIN: review_error -->
                <div style="background: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 20px;">
                    {REVIEW_ERROR}
                </div>
                <!-- END: review_error -->

                <!-- Reviews List -->
                <!-- BEGIN: reviews -->
                <div class="reviews-list">
                    <!-- BEGIN: review_loop -->
                    <div style="border-bottom: 1px solid #eee; padding: 15px 0;">
                        <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 10px;">
                            <div style="font-weight: bold;">{REVIEW.username}</div>
                            <div style="color: #666; font-size: 14px;">{REVIEW.add_time_format}</div>
                        </div>
                        <div style="display: flex; align-items: center; margin-bottom: 5px;">
                            <!-- BEGIN: review_star -->
                            <span style="color: #ffc107;">★</span>
                            <!-- END: review_star -->
                            <span style="margin-left: 5px; font-weight: bold;">{REVIEW.rating}/5</span>
                        </div>
                        <!-- BEGIN: review_title -->
                        <div style="font-weight: bold; margin-bottom: 5px;">{REVIEW.title}</div>
                        <!-- END: review_title -->
                        <div>{REVIEW.content}</div>
                    </div>
                    <!-- END: review_loop -->
                </div>
                <!-- END: reviews -->

                <!-- No Reviews -->
                <!-- BEGIN: no_reviews -->
                <div style="text-align: center; color: #666; padding: 20px;">
                    Chưa có đánh giá nào cho cuốn sách này.
                </div>
                <!-- END: no_reviews -->
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
