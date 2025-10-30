<!-- BEGIN: main -->
<!-- BEGIN: metatags -->
<meta name="{METATAGS.name}" content="{METATAGS.value}" />
<!-- END: metatags -->
<title>{PAGE_TITLE}</title>
<!-- BEGIN: links -->
<link <!-- BEGIN: attr --><!-- BEGIN: val -->{LINKS.key}="{LINKS.value}" <!-- END: val --><!-- END: attr -->/>
<!-- END: links -->
<!-- BEGIN: js -->
<script <!-- BEGIN: ext -->src="{JS.src}"<!-- END: ext --><!-- BEGIN: int -->{JS.content}<!-- END: int --></script>
<!-- END: js -->
{FILE "header_only.tpl"}
{FILE "header_extended.tpl"}
<!-- BEGIN: breadcrumbs -->
<div class="breadcrumbs">
    <ol class="breadcrumb">
        <!-- BEGIN: loop -->
        <li class="breadcrumb-item"><!-- BEGIN: first --><a href="{BREADCRUMBS.link}" title="{BREADCRUMBS.title}"><i class="fa fa-home"></i></a><!-- END: first --><!-- BEGIN: other --><a href="{BREADCRUMBS.link}" title="{BREADCRUMBS.title}">{BREADCRUMBS.title}</a><!-- END: other --></li>
        <!-- END: loop -->
    </ol>
</div>
<!-- END: breadcrumbs -->
<!-- BEGIN: theme_type -->
<div class="theme-type">
    <div class="btn-group">
        <!-- BEGIN: loop -->
        <a href="{STHEME_TYPE}" class="btn btn-default<!-- BEGIN: other --> btn-primary<!-- END: other -->" title="{STHEME_INFO}">{STHEME_TITLE}</a>
        <!-- END: loop -->
    </div>
</div>
<!-- END: theme_type -->
<!-- BEGIN: no_drag_block -->
<div class="no-drag-block"></div>
<!-- END: no_drag_block -->
<div class="row">
	[TOP]
	{MODULE_CONTENT}
	[BOTTOM]
</div>
{FILE "footer_extended.tpl"}
{FILE "footer_only.tpl"}
<!-- END: main -->
