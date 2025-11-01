<!-- INCLUDE: shared_styles.tpl -->

<!-- BEGIN: main -->
<div style="width: 100%; font-size: 20px; line-height: 1.8; padding: 25px; background: #f8f9fa;">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 35px;">
    <div>
    <h1 style="font-size: 32px; margin: 0; color: #333;">Quản lý sách</h1>
    <p style="font-size: 18px; color: #666; margin: 5px 0 0;">Tổng cộng: {TOTAL_BOOKS} cuốn sách</p>
    </div>
    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=add" style="padding: 12px 24px; background: #28a745; color: #fff; text-decoration: none; border-radius: 8px; font-size: 18px; font-weight: bold;">Thêm sách mới</a>
    </div>

    



    <!-- Quick Filters -->
    <div style="background: #fff; border: 3px solid #007bff; padding: 25px; border-radius: 15px; margin-bottom: 35px; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
        <form method="get" action="{NV_BASE_ADMINURL}index.php" style="display: grid; grid-template-columns: 1fr 1fr 2fr 1fr; gap: 20px; align-items: end;">
            <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
            <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />

            <div>
                <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 8px; color: #333;">Danh mục</label>
                <select name="cat_id" onchange="this.form.submit()" style="width: 100%; padding: 12px; border: 2px solid #007bff; border-radius: 8px; font-size: 16px;">
                    <option value="0">Tất cả danh mục</option>
                    <!-- BEGIN: cat_filter -->
                    <option value="{CAT.id}" {CAT.selected}>{CAT.title}</option>
                    <!-- END: cat_filter -->
                </select>
            </div>

            <div>
                <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 8px; color: #333;">Trạng thái</label>
                <select name="status" onchange="this.form.submit()" style="width: 100%; padding: 12px; border: 2px solid #28a745; border-radius: 8px; font-size: 16px;">
                    <option value="-1" {STATUS_ALL}>Tất cả</option>
                    <option value="1" {STATUS_ACTIVE}>Đang hoạt động</option>
                    <option value="0" {STATUS_INACTIVE}>Tạm ngưng</option>
                </select>
            </div>

            <div>
                <label style="display: block; font-size: 18px; font-weight: bold; margin-bottom: 8px; color: #333;">Tìm kiếm</label>
                <div style="display: flex;">
                    <input type="text" name="q" value="{SEARCH_QUERY}" placeholder="Tên sách, tác giả..." style="flex: 1; padding: 12px; border: 2px solid #ffc107; border-radius: 8px 0 0 8px; font-size: 16px;" />
                    <button type="submit" style="padding: 12px 20px; background: #ffc107; color: #333; border: 2px solid #ffc107; border-radius: 0 8px 8px 0; font-size: 16px; font-weight: bold;">Tìm</button>
                </div>
            </div>

            <div style="text-align: right;">
                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" style="padding: 12px 20px; background: #6c757d; color: #fff; text-decoration: none; border-radius: 8px; font-size: 16px;">Xóa lọc</a>
            </div>
        </form>
    </div>

    <!-- Books Table -->
    <div style="background: #fff; border: 3px solid #333; border-radius: 15px; overflow: hidden; box-shadow: 0 5px 10px rgba(0,0,0,0.15);">
        <div style="padding: 25px; background: #f8f9fa; border-bottom: 2px solid #333;">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <h2 style="font-size: 24px; margin: 0; color: #333;">Danh sách sách</h2>
                <p style="font-size: 18px; color: #666; margin: 0;">Hiển thị {TOTAL_BOOKS} cuốn sách</p>
            </div>
        </div>

        <div style="overflow-x: auto;">
            <table style="width: 100%; border-collapse: collapse; font-size: 18px;">
                <thead>
                    <tr style="background: #007bff; color: #fff;">
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 80px;">Ảnh</th>
                        <th style="padding: 20px; font-size: 20px;">Sách & Tác giả</th>
                        <th style="padding: 20px; font-size: 20px; width: 150px;">Danh mục</th>
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 120px;">Giá</th>
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 100px;">Tồn kho</th>
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 120px;">Trạng thái</th>
                        <th style="padding: 20px; text-align: center; font-size: 20px; width: 180px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- BEGIN: book_loop -->
                    <tr style="background: #f9f9f9; border-bottom: 1px solid #ddd;">
                        <td style="padding: 20px; text-align: center;">
                            <!-- BEGIN: image -->
                            <img src="{BOOK.image_url}" alt="{BOOK.title}" style="width: 50px; height: 50px; object-fit: cover; border: 2px solid #ddd; border-radius: 8px;" />
                            <!-- END: image -->
                            <!-- BEGIN: no_image -->
                            <div style="width: 50px; height: 50px; background: #f8f9fa; border: 2px solid #ddd; border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 24px;">📖</div>
                            <!-- END: no_image -->
                        </td>
                        <td style="padding: 20px;">
                            <div style="font-size: 20px; font-weight: bold; color: #333; margin-bottom: 5px;">{BOOK.title}</div>
                            <div style="font-size: 16px; color: #666;">{BOOK.author}</div>
                        </td>
                        <td style="padding: 20px;">
                            <span style="background: #e9ecef; color: #333; padding: 8px 12px; border-radius: 6px; font-size: 16px;">{BOOK.cat_title}</span>
                        </td>
                        <td style="padding: 20px; text-align: center; font-size: 18px; font-weight: bold; color: #007bff;">{BOOK.price_format}</td>
                        <td style="padding: 20px; text-align: center;">
                            <span style="color: {BOOK.stock_color}; font-size: 18px; font-weight: bold;">{BOOK.stock_quantity}</span>
                        </td>
                        <td style="padding: 20px; text-align: center;">
                            <span style="color: {BOOK.status_color}; font-size: 18px; font-weight: bold;">{BOOK.status_text}</span>
                        </td>
                        <td style="padding: 20px; text-align: center;">
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=edit&id={BOOK.id}" style="padding: 8px 16px; background: #28a745; color: #fff; text-decoration: none; border-radius: 6px; font-size: 16px; margin-right: 10px;">Sửa</a>
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=delete&id={BOOK.id}" onclick="return confirm('Bạn có chắc chắn muốn xóa cuốn sách này?')" style="padding: 8px 16px; background: #dc3545; color: #fff; text-decoration: none; border-radius: 6px; font-size: 16px;">Xóa</a>
                        </td>
                    </tr>
                    <!-- END: book_loop -->
                </tbody>
            </table>
        </div>

        <!-- BEGIN: no_books -->
        <div style="text-align: center; padding: 50px;">
            <div style="font-size: 48px; color: #6c757d; margin-bottom: 20px;">📚</div>
            <h3 style="color: #333; margin-bottom: 10px;">Chưa có cuốn sách nào</h3>
            <p style="font-size: 18px; color: #666; margin-bottom: 20px;">Hãy thêm cuốn sách đầu tiên của bạn</p>
            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=add" style="padding: 12px 24px; background: #28a745; color: #fff; text-decoration: none; border-radius: 8px; font-size: 18px; font-weight: bold;">Thêm sách đầu tiên</a>
        </div>
        <!-- END: no_books -->
    </div>

    <!-- BEGIN: generate_page -->
    <div style="text-align: center; margin-top: 30px;">
        <nav aria-label="Page navigation">
            <ul style="list-style: none; display: inline-flex; gap: 10px;">
                <!-- BEGIN: prev -->
                <li style="{PREV.style}">
                    <a href="{PREV.link}" style="padding: 12px 18px; text-decoration: none; border: 2px solid #007bff; border-radius: 8px; color: {PREV.color}; font-size: 18px; font-weight: bold;" {PREV.attr}>Trước</a>
                </li>
                <!-- END: prev -->

                <!-- BEGIN: page -->
                <li style="{PAGE.style}">
                    <a href="{PAGE.link}" style="padding: 12px 18px; text-decoration: none; border: 2px solid {PAGE.border}; border-radius: 8px; color: {PAGE.color}; font-size: 18px; font-weight: bold;">{PAGE.num}</a>
                </li>
                <!-- END: page -->

                <!-- BEGIN: next -->
                <li style="{NEXT.style}">
                    <a href="{NEXT.link}" style="padding: 12px 18px; text-decoration: none; border: 2px solid #007bff; border-radius: 8px; color: {NEXT.color}; font-size: 18px; font-weight: bold;" {NEXT.attr}>Sau</a>
                </li>
                <!-- END: next -->
            </ul>
        </nav>
    </div>
    <!-- END: generate_page -->

    <!-- INCLUDE: admin_scripts.tpl -->
</div>
<!-- END: main -->
