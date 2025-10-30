<!-- BEGIN: main -->
<div class="bookmanager-container" style="max-width: 1200px; margin: 0 auto; padding: 20px;">
    <div style="text-align: center; margin-bottom: 30px;">
        <h1 style="font-size: 28px; margin-bottom: 20px;">Cửa hàng sách</h1>
        <!-- BEGIN: user_logged_in -->
        <div style="margin-bottom: 20px;">
            <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=cart" style="display: inline-block; padding: 10px 20px; margin: 0 10px; background: #007bff; color: white; text-decoration: none; border-radius: 4px;">Giỏ hàng</a>
            <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" style="display: inline-block; padding: 10px 20px; margin: 0 10px; background: #6c757d; color: white; text-decoration: none; border-radius: 4px;">Đơn hàng</a>
        </div>
        <!-- END: user_logged_in -->
    </div>

    <!-- BEGIN: success -->
    <div style="background: #d4edda; color: #155724; padding: 15px; border: 1px solid #c3e6cb; border-radius: 4px; margin-bottom: 20px;">
        {SUCCESS_MESSAGE}
    </div>
    <!-- END: success -->

    <!-- Search and Filter -->
    <div style="background: white; padding: 20px; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 30px;">
        <form method="get" action="{NV_BASE_SITEURL}index.php" style="display: flex; flex-wrap: wrap; gap: 15px; align-items: end;">
            <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
            <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />

            <div style="flex: 1; min-width: 200px;">
                <label style="display: block; margin-bottom: 5px; font-weight: bold;">Danh mục</label>
                <select name="cat_id" style="width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px;" onchange="this.form.submit()">
                    <option value="0">Tất cả danh mục</option>
                    <!-- BEGIN: cat_filter -->
                    <option value="{CAT.id}" {CAT.selected}>{CAT.title}</option>
                    <!-- END: cat_filter -->
                </select>
            </div>

            <div style="flex: 2; min-width: 200px;">
                <label style="display: block; margin-bottom: 5px; font-weight: bold;">Tìm kiếm</label>
                <div style="display: flex;">
                    <input type="text" name="q" value="{SEARCH_QUERY}" style="flex: 1; padding: 8px; border: 1px solid #ccc; border-radius: 4px 0 0 4px;" placeholder="Tên sách, tác giả...">
                    <button type="submit" style="padding: 8px 15px; background: #007bff; color: white; border: none; border-radius: 0 4px 4px 0; cursor: pointer;">Tim</button>
                </div>
            </div>

            <div style="min-width: 120px;">
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 8px 15px; background: #6c757d; color: white; text-decoration: none; border-radius: 4px; width: 100%; text-align: center;">Xoa loc</a>
            </div>
        </form>
    </div>

    <!-- Books Grid -->
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; margin-bottom: 30px;">
        <!-- BEGIN: book_loop -->
        <div style="background: white; border: 1px solid #ddd; border-radius: 8px; overflow: hidden; display: flex; flex-direction: column;">
            <div style="height: 200px; background: #f8f9fa; display: flex; align-items: center; justify-content: center;">
                <!-- BEGIN: image -->
                <img src="{BOOK.image_url}" alt="{BOOK.title}" style="max-height: 180px; max-width: 100%;">
                <!-- END: image -->
                <!-- BEGIN: no_image -->
                <div style="color: #6c757d; font-size: 48px;">[SACH]</div>
                <!-- END: no_image -->
            </div>
            <div style="padding: 15px; flex: 1; display: flex; flex-direction: column;">
                <h3 style="margin: 0 0 10px 0; font-size: 16px; line-height: 1.3;">
                    <a href="{BOOK.link}" style="color: #007bff; text-decoration: none;">{BOOK.title}</a>
                </h3>
                <p style="margin: 0 0 5px 0; color: #666; font-size: 14px;">Tac gia: {BOOK.author}</p>
                <p style="margin: 0 0 15px 0; color: #666; font-size: 14px;">Danh muc: {BOOK.cat_title}</p>
                <div style="margin-top: auto; display: flex; justify-content: space-between; align-items: center;">
                <span style="font-weight: bold; color: #007bff; font-size: 18px;">{BOOK.price_format}</span>
                <a href="{BOOK.link}" style="padding: 6px 12px; background: #007bff; color: white; text-decoration: none; border-radius: 4px; font-size: 14px;">Xem chi tiet</a>
                </div>
                <!-- BEGIN: add_to_cart -->
                <div style="margin-top: 10px;">
                    <form method="post" action="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: flex; gap: 10px; align-items: center;">
                        <input type="hidden" name="book_id" value="{BOOK.id}" />
                        <input type="number" name="quantity" value="1" min="1" max="10" style="width: 60px; padding: 4px; border: 1px solid #ccc; border-radius: 4px;" />
                        <button type="submit" name="add_to_cart" value="1" style="padding: 6px 12px; background: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 14px;">Thêm vào giỏ</button>
                    </form>
                </div>
                <!-- END: add_to_cart -->
            </div>
        </div>
        <!-- END: book_loop -->
    </div>

    <!-- BEGIN: no_books -->
    <div style="text-align: center; padding: 50px 20px; background: white; border: 1px solid #ddd; border-radius: 8px;">
        <div style="color: #6c757d; font-size: 64px; margin-bottom: 20px;">[SACH]</div>
        <h2 style="margin: 0 0 10px 0; color: #333;">Khong tim thay sach nao</h2>
        <p style="margin: 0 0 20px 0; color: #666;">Hay thu tim kiem voi tu khoa khac hoac chon danh muc khac.</p>
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 10px 20px; background: #007bff; color: white; text-decoration: none; border-radius: 4px;">Xem tat ca sach</a>
    </div>
    <!-- END: no_books -->

    <!-- BEGIN: cart_link -->
    <div style=\"text-align: center; margin-top: 30px;\">
        <a href=\"{CART_LINK}\" style=\"display: inline-block; padding: 12px 24px; background: #007bff; color: white; text-decoration: none; border-radius: 4px; font-size: 16px;\">Xem giỏ hàng</a>
    </div>
    <!-- END: cart_link -->
</div>
<!-- END: main -->
