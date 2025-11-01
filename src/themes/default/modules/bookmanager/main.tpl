<!-- BEGIN: main -->
<div class="bookmanager-container" style="max-width: 1400px; margin: 0 auto; padding: 40px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; line-height: 1.6;">
<!-- BEGIN: user_logged_in -->
<div style="text-align: center; margin-bottom: 40px; padding: 25px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border-radius: 15px; box-shadow: 0 8px 25px rgba(0,0,0,0.15);">
<div style="margin-bottom: 20px; font-size: 24px; font-weight: 600;">{LANG.welcome_user}, <strong>{USER_NAME}</strong>!</div>
<a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=cart" style="display: inline-block; padding: 15px 30px; margin: 0 15px; background: #28a745; color: white; text-decoration: none; border-radius: 8px; font-size: 18px; font-weight: 600; box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3); transition: all 0.3s ease;">🛒 Giỏ hàng ({CART_COUNT})</a>
<a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=orders" style="display: inline-block; padding: 15px 30px; margin: 0 15px; background: #17a2b8; color: white; text-decoration: none; border-radius: 8px; font-size: 18px; font-weight: 600; box-shadow: 0 4px 15px rgba(23, 162, 184, 0.3); transition: all 0.3s ease;">📋 Đơn hàng</a>
</div>
<!-- END: user_logged_in -->

<div style="text-align: center; margin-bottom: 50px;">
<h1 style="font-size: 42px; margin-bottom: 30px; color: #2c3e50; font-weight: 700; text-shadow: 2px 2px 4px rgba(0,0,0,0.1);">📚 Cửa hàng sách</h1>
</div>

    <!-- BEGIN: success -->
    <div style="background: linear-gradient(135deg, #d4edda 0%, #a3d9a4 100%); color: #155724; padding: 25px; border: 3px solid #28a745; border-radius: 12px; margin-bottom: 30px; font-size: 18px; font-weight: 600; box-shadow: 0 6px 20px rgba(40, 167, 69, 0.2);">
    ✅ {SUCCESS_MESSAGE}
    </div>
    <!-- END: success -->

    <!-- BEGIN: error -->
    <div style="background: linear-gradient(135deg, #f8d7da 0%, #f1aeb5 100%); color: #721c24; padding: 25px; border: 3px solid #dc3545; border-radius: 12px; margin-bottom: 30px; font-size: 18px; font-weight: 600; box-shadow: 0 6px 20px rgba(220, 53, 69, 0.2);">
    ❌ {ERROR_MESSAGE}
    </div>
    <!-- END: error -->

    <!-- Search and Filter -->
    <div style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); padding: 35px; border: 3px solid #007bff; border-radius: 15px; margin-bottom: 40px; box-shadow: 0 10px 30px rgba(0, 123, 255, 0.15); font-size: 18px;">
        <h2 style="margin-top: 0; margin-bottom: 25px; color: #007bff; font-size: 28px; font-weight: 700; text-align: center;">🔍 Tìm kiếm & Lọc sách</h2>
        <form method="get" action="{NV_BASE_SITEURL}index.php" style="display: flex; flex-wrap: wrap; gap: 25px; align-items: end; justify-content: center;">
        <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
    <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />

            <div style="flex: 1; min-width: 250px;">
        <label style="display: block; margin-bottom: 12px; font-weight: 700; color: #495057; font-size: 20px;">📂 Danh mục</label>
    <select name="cat_id" style="width: 100%; padding: 15px; border: 3px solid #007bff; border-radius: 8px; font-size: 18px; background: white;" onchange="this.form.submit()">
        <option value="0">🏷️ Tất cả danh mục</option>
    <!-- BEGIN: cat_filter -->
    <option value="{CAT.id}" {CAT.selected}>📚 {CAT.title}</option>
    <!-- END: cat_filter -->
    </select>
    </div>

            <div style="flex: 2; min-width: 300px;">
        <label style="display: block; margin-bottom: 12px; font-weight: 700; color: #495057; font-size: 20px;">🔎 Tìm kiếm</label>
    <div style="display: flex;">
        <input type="text" name="q" value="{SEARCH_QUERY}" style="flex: 1; padding: 15px; border: 3px solid #007bff; border-radius: 8px 0 0 8px; font-size: 18px;" placeholder="Tên sách, tác giả...">
    <button type="submit" style="padding: 15px 25px; background: #007bff; color: white; border: 3px solid #007bff; border-radius: 0 8px 8px 0; cursor: pointer; font-size: 18px; font-weight: 600;">🔍 Tìm</button>
    </div>
    </div>

            <div style="min-width: 150px;">
        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 15px 20px; background: #6c757d; color: white; text-decoration: none; border-radius: 8px; width: 100%; text-align: center; font-size: 18px; font-weight: 600; box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);">🗑️ Xóa lọc</a>
    </div>
    </form>
    </div>

    <!-- Books Grid -->
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 30px; margin-bottom: 50px;">
    <!-- BEGIN: book_loop -->
    <div style="background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%); border: 4px solid #007bff; border-radius: 20px; overflow: hidden; display: flex; flex-direction: column; box-shadow: 0 12px 35px rgba(0, 123, 255, 0.2); transition: all 0.4s ease; transform: translateY(0);" onmouseover="this.style.transform='translateY(-10px)'; this.style.boxShadow='0 20px 45px rgba(0, 123, 255, 0.3)';" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 12px 35px rgba(0, 123, 255, 0.2)';">
    <div style="height: 250px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; position: relative;">
    <!-- BEGIN: image -->
    <img src="{BOOK.image_url}" alt="{BOOK.title}" style="max-height: 220px; max-width: 90%; border-radius: 10px; box-shadow: 0 8px 25px rgba(0,0,0,0.2);">
    <!-- END: image -->
    <!-- BEGIN: no_image -->
    <div style="color: white; font-size: 72px; text-shadow: 3px 3px 6px rgba(0,0,0,0.5);">📖</div>
    <!-- END: no_image -->
        <div style="position: absolute; top: 15px; right: 15px; background: rgba(255,255,255,0.9); padding: 8px 12px; border-radius: 20px; font-size: 16px; font-weight: 600; color: #007bff;">📚 Sách</div>
    </div>
    <div style="padding: 25px; flex: 1; display: flex; flex-direction: column;">
    <h3 style="margin: 0 0 15px 0; font-size: 22px; line-height: 1.3; font-weight: 700; color: #2c3e50;">
        <a href="{BOOK.link}" style="color: #007bff; text-decoration: none; transition: color 0.3s ease;" onmouseover="this.style.color='#0056b3'" onmouseout="this.style.color='#007bff'">{BOOK.title}</a>
    </h3>
    <p style="margin: 0 0 10px 0; color: #495057; font-size: 18px; font-weight: 600;">✍️ Tác giả: <span style="color: #17a2b8;">{BOOK.author}</span></p>
    <p style="margin: 0 0 20px 0; color: #495057; font-size: 18px; font-weight: 600;">📂 Danh mục: <span style="color: #28a745;">{BOOK.cat_title}</span></p>
    <div style="margin-top: auto; display: flex; justify-content: space-between; align-items: center; padding-top: 15px; border-top: 2px solid #e9ecef;">
    <span style="font-weight: 700; color: #dc3545; font-size: 24px; background: linear-gradient(135deg, #dc3545 0%, #c82333 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">{BOOK.price_format}</span>
    <a href="{BOOK.link}" style="padding: 12px 20px; background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); color: white; text-decoration: none; border-radius: 10px; font-size: 16px; font-weight: 600; box-shadow: 0 6px 20px rgba(0, 123, 255, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">👀 Xem chi tiết</a>
    </div>
    <!-- BEGIN: add_to_cart -->
    <div style="margin-top: 15px; padding-top: 15px; border-top: 2px solid #e9ecef;">
    <form method="post" action="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: flex; gap: 15px; align-items: center;">
    <input type="hidden" name="book_id" value="{BOOK.id}" />
    <div style="display: flex; align-items: center; gap: 8px;">
            <label style="font-size: 16px; font-weight: 600; color: #495057;">Số lượng:</label>
                <input type="number" name="quantity" value="1" min="1" max="10" style="width: 70px; padding: 8px; border: 2px solid #007bff; border-radius: 6px; font-size: 16px;" />
            </div>
                <button type="submit" name="add_to_cart" value="1" style="padding: 12px 20px; background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; border: none; border-radius: 10px; cursor: pointer; font-size: 16px; font-weight: 600; box-shadow: 0 6px 20px rgba(40, 167, 69, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">🛒 Thêm vào giỏ</button>
                </form>
            </div>
                <!-- END: add_to_cart -->
            </div>
        </div>
        <!-- END: book_loop -->
    </div>

    <!-- BEGIN: no_books -->
    <div style="text-align: center; padding: 80px 40px; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); border: 4px solid #6c757d; border-radius: 20px; box-shadow: 0 15px 40px rgba(108, 117, 125, 0.2);">
    <div style="color: #6c757d; font-size: 96px; margin-bottom: 30px; text-shadow: 4px 4px 8px rgba(0,0,0,0.1);">📚❌</div>
    <h2 style="margin: 0 0 20px 0; color: #2c3e50; font-size: 32px; font-weight: 700;">Không tìm thấy sách nào</h2>
    <p style="margin: 0 0 30px 0; color: #6c757d; font-size: 20px; line-height: 1.6;">Hãy thử tìm kiếm với từ khóa khác hoặc chọn danh mục khác.</p>
    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="display: inline-block; padding: 20px 40px; background: linear-gradient(135deg, #007bff 0%, #0056b3 100%); color: white; text-decoration: none; border-radius: 12px; font-size: 20px; font-weight: 600; box-shadow: 0 8px 25px rgba(0, 123, 255, 0.3); transition: all 0.3s ease;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">🔄 Xem tất cả sách</a>
    </div>
    <!-- END: no_books -->

    <!-- BEGIN: generate_page -->
    <div style="text-align: center; margin-top: 50px; padding: 30px; background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%); border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1);">
    <h3 style="margin-bottom: 20px; color: #2c3e50; font-size: 24px; font-weight: 700;">📄 Phân trang</h3>
        {GENERATE_PAGE}
    </div>
    <!-- END: generate_page -->
</div>
<!-- END: main -->
