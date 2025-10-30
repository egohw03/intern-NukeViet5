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
        </div>
    </div>
</div>
<!-- END: main -->
