<!-- BEGIN: main -->
<style>
.breadcrumbs-wrap { display: none !important; }
.wraper { width: 100% !important; max-width: 100% !important; }
.container { width: 100% !important; max-width: 100% !important; }
.col-md-24 { width: 100% !important; padding-left: 0 !important; padding-right: 0 !important; }
.row { margin-left: 0 !important; margin-right: 0 !important; padding-left: 0 !important; padding-right: 0 !important; }
</style>
<div style="width: 100%; margin: 0 auto; padding: 40px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height: 1.6;">
<div style="display: grid; grid-template-columns: 1fr 2fr; gap: 50px; margin-bottom: 60px;">
<div style="background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%); padding: 35px; border: 4px solid #007bff; border-radius: 20px; text-align: center; box-shadow: 0 15px 40px rgba(0, 123, 255, 0.2);">
<!-- BEGIN: image -->
<img src="{BOOK.image_url}" alt="{BOOK.title}" style="max-height: 350px; max-width: 90%; margin-bottom: 25px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
<!-- END: image -->
<!-- BEGIN: no_image -->
<div style="height: 350px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; margin-bottom: 25px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
<span style="font-size: 96px; color: white; text-shadow: 4px 4px 8px rgba(0,0,0,0.5);">📖</span>
</div>
<!-- END: no_image -->

<h2 style="color: #dc3545; margin: 0 0 15px 0; font-size: 32px; font-weight: 700; background: linear-gradient(135deg, #dc3545 0%, #c82333 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">{BOOK.price_format}</h2>
<p style="color: #28a745; margin: 0; font-size: 20px; font-weight: 600;">📦 Còn {BOOK.stock_quantity} cuốn trong kho</p>
</div>

        <div>
        <div style="background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%); padding: 35px; border: 4px solid #17a2b8; border-radius: 20px; margin-bottom: 30px; box-shadow: 0 15px 40px rgba(23, 162, 184, 0.2);">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px;">
        <h1 style="margin: 0; font-size: 36px; color: #2c3e50; font-weight: 700; text-shadow: 2px 2px 4px rgba(0,0,0,0.1);">📖 {BOOK.title}</h1>
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 12px 24px; background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%); color: white; text-decoration: none; border-radius: 10px; font-size: 16px; font-weight: 600; box-shadow: 0 6px 20px rgba(108, 117, 125, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">⬅️ Quay về</a>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px; background: rgba(255,255,255,0.8); padding: 25px; border-radius: 15px; border: 2px solid #e9ecef;">
        <div style="font-size: 18px; line-height: 1.6;"><strong style="color: #17a2b8; font-size: 20px;">✍️ Tác giả:</strong> <span style="color: #495057; font-weight: 600;">{BOOK.author}</span></div>
        <div style="font-size: 18px; line-height: 1.6;"><strong style="color: #28a745; font-size: 20px;">🏢 Nhà xuất bản:</strong> <span style="color: #495057; font-weight: 600;">{BOOK.publisher}</span></div>
        <div style="font-size: 18px; line-height: 1.6;"><strong style="color: #ffc107; font-size: 20px;">📅 Năm xuất bản:</strong> <span style="color: #495057; font-weight: 600;">{BOOK.publish_year}</span></div>
        <div style="font-size: 18px; line-height: 1.6;"><strong style="color: #6c757d; font-size: 20px;">📚 ISBN:</strong> <span style="color: #495057; font-weight: 600;">{BOOK.isbn}</span></div>
        <div style="font-size: 18px; line-height: 1.6;"><strong style="color: #007bff; font-size: 20px;">📂 Danh mục:</strong> <span style="color: #495057; font-weight: 600;">{BOOK.cat_title}</span></div>
        <div style="font-size: 18px; line-height: 1.6;"><strong style="color: #dc3545; font-size: 20px;">🕒 Ngày thêm:</strong> <span style="color: #495057; font-weight: 600;">{BOOK.add_time}</span></div>
        </div>

        <!-- BEGIN: success -->
        <div style="background: linear-gradient(135deg, #d4edda 0%, #a3d9a4 100%); color: #155724; padding: 20px; border: 3px solid #28a745; border-radius: 12px; margin-bottom: 25px; font-size: 18px; font-weight: 600; box-shadow: 0 6px 20px rgba(40, 167, 69, 0.2);">
        ✅ [OK] {SUCCESS_MESSAGE}
        </div>
        <!-- END: success -->

        <!-- BEGIN: add_to_cart -->
        <form method="post" action="" style="display: flex; gap: 20px; align-items: end; margin-bottom: 25px;">
        <div style="flex: 1;">
        <label style="display: block; margin-bottom: 10px; font-weight: 700; color: #495057; font-size: 20px;">🔢 Số lượng</label>
        <input type="number" name="quantity" value="1" min="1" max="{BOOK.stock_quantity}" style="width: 100%; padding: 15px; border: 3px solid #007bff; border-radius: 10px; font-size: 18px; background: white;">
        </div>
        <div style="flex: 2;">
        <button type="submit" name="add_to_cart" style="width: 100%; padding: 15px; background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; border: none; border-radius: 10px; cursor: pointer; font-size: 20px; font-weight: 600; box-shadow: 0 6px 20px rgba(40, 167, 69, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
        🛒 Thêm vào giỏ hàng
        </button>
        </div>
        </form>
        <!-- END: add_to_cart -->

        <!-- BEGIN: login_required -->
        <div style="background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%); color: #856404; padding: 20px; border: 3px solid #ffc107; border-radius: 12px; margin-bottom: 25px; font-size: 18px; font-weight: 600; box-shadow: 0 6px 20px rgba(255, 193, 7, 0.2);">
        ℹ️ [INFO] Bạn cần <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;nv=users&amp;nvredir={NV_REDIRECT}" style="color: #856404; font-weight: 700; text-decoration: underline;">đăng nhập</a> để thêm sách vào giỏ hàng.
        </div>
        <!-- END: login_required -->
        </div>

            <!-- Description -->
            <!-- BEGIN: description -->
            <div style="background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%); padding: 35px; border: 4px solid #6c757d; border-radius: 20px; margin-bottom: 30px; box-shadow: 0 15px 40px rgba(108, 117, 125, 0.2);">
            <h3 style="margin: 0 0 20px 0; font-size: 28px; color: #2c3e50; font-weight: 700; border-bottom: 3px solid #6c757d; padding-bottom: 10px;">📝 Mô tả sách</h3>
            <div style="font-size: 18px; line-height: 1.8; color: #495057;">{BOOK.description}</div>
            </div>
            <!-- END: description -->

            <!-- Reviews Section -->
            <div style="background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%); padding: 35px; border: 4px solid #ffc107; border-radius: 20px; margin-top: 30px; box-shadow: 0 15px 40px rgba(255, 193, 7, 0.2);">
            <h3 style="margin: 0 0 20px 0; font-size: 28px; color: #2c3e50; font-weight: 700; border-bottom: 3px solid #ffc107; padding-bottom: 10px;">⭐ Đánh giá sách</h3>

                <!-- Average Rating -->
                <div style="display: flex; align-items: center; margin-bottom: 30px; background: rgba(255,255,255,0.8); padding: 20px; border-radius: 15px; border: 2px solid #e9ecef;">
                <div style="font-size: 36px; font-weight: 700; margin-right: 15px; color: #ffc107; background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">{BOOK.avg_rating}/5</div>
                <div style="flex: 1;">
                <div style="display: flex; margin-bottom: 10px; gap: 2px;">
                <!-- BEGIN: star -->
                <span style="color: #ffc107; font-size: 24px; text-shadow: 1px 1px 2px rgba(0,0,0,0.3);">⭐</span>
                <!-- END: star -->
                </div>
                <div style="font-size: 18px; color: #6c757d; font-weight: 600;">📊 {BOOK.total_reviews} đánh giá</div>
                </div>
                </div>

                <!-- Review Form for logged-in users -->
                <!-- BEGIN: review_form -->
                <div style="border: 3px solid #007bff; padding: 25px; border-radius: 15px; margin-bottom: 25px; background: rgba(0, 123, 255, 0.05);">
                <h4 style="margin-bottom: 20px; color: #007bff; font-size: 24px; font-weight: 700;">✍️ Viết đánh giá</h4>
                <form method="post" action="">
                <div style="margin-bottom: 20px;">
                <label style="display: block; margin-bottom: 12px; font-weight: 700; color: #495057; font-size: 18px;">⭐ Đánh giá của bạn:</label>
                <div style="display: flex; gap: 15px; flex-wrap: wrap;">
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; padding: 10px; border: 2px solid #ffc107; border-radius: 10px; background: white; transition: all 0.3s ease;" for="rating5">
                    <input type="radio" name="rating" value="5" id="rating5" style="display: none;" checked>
                    <span style="font-size: 20px;">⭐⭐⭐⭐⭐</span>
                    <span style="font-size: 16px; font-weight: 600;">5 sao</span>
                </label>
                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; padding: 10px; border: 2px solid #e9ecef; border-radius: 10px; background: white; transition: all 0.3s ease;" for="rating4">
                    <input type="radio" name="rating" value="4" id="rating4" style="display: none;">
                    <span style="font-size: 20px;">⭐⭐⭐⭐☆</span>
                    <span style="font-size: 16px; font-weight: 600;">4 sao</span>
                </label>
                    <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; padding: 10px; border: 2px solid #e9ecef; border-radius: 10px; background: white; transition: all 0.3s ease;" for="rating3">
                            <input type="radio" name="rating" value="3" id="rating3" style="display: none;">
                            <span style="font-size: 20px;">⭐⭐⭐☆☆</span>
                        <span style="font-size: 16px; font-weight: 600;">3 sao</span>
                    </label>
                        <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; padding: 10px; border: 2px solid #e9ecef; border-radius: 10px; background: white; transition: all 0.3s ease;" for="rating2">
                            <input type="radio" name="rating" value="2" id="rating2" style="display: none;">
                        <span style="font-size: 20px;">⭐⭐☆☆☆</span>
                        <span style="font-size: 16px; font-weight: 600;">2 sao</span>
                        </label>
                        <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; padding: 10px; border: 2px solid #e9ecef; border-radius: 10px; background: white; transition: all 0.3s ease;" for="rating1">
                                <input type="radio" name="rating" value="1" id="rating1" style="display: none;">
                                    <span style="font-size: 20px;">⭐☆☆☆☆</span>
                                    <span style="font-size: 16px; font-weight: 600;">1 sao</span>
                                </label>
                            </div>
                        </div>
                        <div style="margin-bottom: 20px;">
                        <label style="display: block; margin-bottom: 12px; font-weight: 700; color: #495057; font-size: 18px;">📝 Tiêu đề đánh giá:</label>
                            <input type="text" name="review_title" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 10px; font-size: 16px;" placeholder="Tiêu đề đánh giá (tùy chọn)">
                        </div>
                        <div style="margin-bottom: 20px;">
                            <label style="display: block; margin-bottom: 12px; font-weight: 700; color: #495057; font-size: 18px;">💬 Nội dung đánh giá:</label>
                            <textarea name="review_content" rows="5" style="width: 100%; padding: 15px; border: 2px solid #007bff; border-radius: 10px; font-size: 16px; resize: vertical;" placeholder="Chia sẻ trải nghiệm của bạn với cuốn sách này..."></textarea>
                        </div>
                    <button type="submit" name="submit_review" style="padding: 15px 30px; background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); color: white; border: none; border-radius: 10px; cursor: pointer; font-size: 18px; font-weight: 600; box-shadow: 0 6px 20px rgba(0, 123, 255, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">📤 Gửi đánh giá</button>
                    </form>
                </div>
                <script>
                // Star rating selection
                $(document).ready(function() {
                    $('input[name="rating"]').change(function() {
                        // Remove selected style from all labels
                        $('label[for^="rating"]').css({
                            'border-color': '#e9ecef',
                            'background': 'white'
                        });
                        // Add selected style to checked label
                        var checkedId = $(this).attr('id');
                        $('label[for="' + checkedId + '"]').css({
                            'border-color': '#ffc107',
                            'background': '#fff3cd'
                        });
                    });
                    // Set initial selected
                    var initialChecked = $('input[name="rating"]:checked');
                    if (initialChecked.length) {
                        $('label[for="' + initialChecked.attr('id') + '"]').css({
                            'border-color': '#ffc107',
                            'background': '#fff3cd'
                        });
                    }
                });
                </script>
                <!-- END: review_form -->

                <!-- Review Success Message -->
                <!-- BEGIN: review_success -->
                <div style="background: linear-gradient(135deg, #d4edda 0%, #a3d9a4 100%); color: #155724; padding: 20px; border: 3px solid #28a745; border-radius: 12px; margin-bottom: 20px; font-size: 18px; font-weight: 600; box-shadow: 0 6px 20px rgba(40, 167, 69, 0.2);">
                    ✅ {SUCCESS_MESSAGE}
                </div>
                <!-- END: review_success -->

                <!-- Review Error Message -->
                <!-- BEGIN: review_error -->
                <div style="background: linear-gradient(135deg, #f8d7da 0%, #f1aeb5 100%); color: #721c24; padding: 20px; border: 3px solid #dc3545; border-radius: 12px; margin-bottom: 20px; font-size: 18px; font-weight: 600; box-shadow: 0 6px 20px rgba(220, 53, 69, 0.2);">
                    ❌ {REVIEW_ERROR}
                </div>
                <!-- END: review_error -->

                <!-- Reviews List -->
                <!-- BEGIN: reviews -->
                <div class="reviews-list" style="margin-top: 30px;">
                <h4 style="margin-bottom: 20px; color: #2c3e50; font-size: 24px; font-weight: 700; border-bottom: 3px solid #ffc107; padding-bottom: 10px;">💬 Các đánh giá</h4>
                <!-- BEGIN: review_loop -->
                <div style="border: 2px solid #e9ecef; border-radius: 15px; padding: 20px; margin-bottom: 20px; background: rgba(255,255,255,0.8); box-shadow: 0 4px 15px rgba(0,0,0,0.05);">
                <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px solid #dee2e6;">
                <div style="font-weight: 700; font-size: 18px; color: #007bff;">👤 {REVIEW.username}</div>
                    <div style="color: #6c757d; font-size: 16px; font-weight: 600;">🕒 {REVIEW.add_time_format}</div>
                </div>
                <div style="display: flex; align-items: center; margin-bottom: 12px;">
                <div style="display: flex; margin-right: 10px;">
                    <!-- BEGIN: review_star -->
                    <span style="color: #ffc107; font-size: 20px; text-shadow: 1px 1px 2px rgba(0,0,0,0.3);">⭐</span>
                        <!-- END: review_star -->
                    </div>
                    <span style="font-weight: 700; font-size: 18px; color: #495057;">{REVIEW.rating}/5</span>
                </div>
                <!-- BEGIN: review_title -->
                    <div style="font-weight: 700; margin-bottom: 10px; font-size: 20px; color: #2c3e50;">📌 {REVIEW.title}</div>
                    <!-- END: review_title -->
                        <div style="font-size: 16px; line-height: 1.6; color: #495057;">{REVIEW.content}</div>
                    </div>
                    <!-- END: review_loop -->
                </div>
                <!-- END: reviews -->

                <!-- No Reviews -->
                <!-- BEGIN: no_reviews -->
                <div style="text-align: center; color: #6c757d; padding: 60px 40px; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); border: 4px solid #6c757d; border-radius: 20px; margin-top: 30px; box-shadow: 0 15px 40px rgba(108, 117, 125, 0.2);">
                    <div style="font-size: 72px; margin-bottom: 20px; text-shadow: 4px 4px 8px rgba(0,0,0,0.1);">📝❌</div>
                    <h4 style="margin: 0 0 15px 0; color: #2c3e50; font-size: 24px; font-weight: 700;">Chưa có đánh giá nào</h4>
                    <p style="margin: 0; font-size: 18px; line-height: 1.6;">Hãy là người đầu tiên đánh giá cuốn sách này!</p>
                </div>
                <!-- END: no_reviews -->
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
