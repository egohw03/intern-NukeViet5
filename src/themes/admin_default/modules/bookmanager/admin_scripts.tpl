<script>
// Table-Focused Admin Scripts for BookManager Module
document.addEventListener('DOMContentLoaded', function() {
    // Table row hover effects - enhanced for table-centric design
    const tableRows = document.querySelectorAll('.data-table tbody tr');
    tableRows.forEach(row => {
        row.addEventListener('mouseenter', function() {
            this.style.backgroundColor = '#f1f3f4';
            this.style.cursor = 'pointer';
        });
        row.addEventListener('mouseleave', function() {
            this.style.backgroundColor = '';
        });
    });

    // Search input with table focus
    const searchInputs = document.querySelectorAll('input[name="q"]');
    searchInputs.forEach(input => {
        let timeout;
        input.addEventListener('input', function() {
            clearTimeout(timeout);
            timeout = setTimeout(() => {
                if (this.value.length >= 2) {
                    // Submit search immediately for table data
                    this.closest('form').submit();
                }
            }, 500);
        });
    });

    // Filter select enhancement for table filtering
    const filterSelects = document.querySelectorAll('select[name="cat_id"], select[name="status"]');
    filterSelects.forEach(select => {
        select.addEventListener('change', function() {
            // Immediate submit for table filtering
            this.closest('form').submit();
        });
    });

    // Confirm delete actions with table context
    const deleteButtons = document.querySelectorAll('a[onclick*="confirm"]');
    deleteButtons.forEach(btn => {
        btn.addEventListener('click', function(e) {
            if (!confirm('Bạn có chắc chắn muốn xóa mục này?')) {
                e.preventDefault();
                return false;
            }
        });
    });

    // Keyboard shortcuts for table navigation
    document.addEventListener('keydown', function(e) {
        // Ctrl + F for search focus in table views
        if (e.ctrlKey && e.key === 'f') {
            e.preventDefault();
            const searchInput = document.querySelector('input[name="q"]');
            if (searchInput) {
                searchInput.focus();
                searchInput.select();
            }
        }

        // Escape to clear search in table context
        if (e.key === 'Escape') {
            const searchInput = document.querySelector('input[name="q"]');
            if (searchInput && document.activeElement === searchInput) {
                searchInput.value = '';
                searchInput.closest('form').submit();
            }
        }
    });

    // Auto-hide alerts in table context
    const alerts = document.querySelectorAll('.alert-success, .alert-info');
    alerts.forEach(alert => {
        setTimeout(() => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }, 3000); // Shorter for table-focused interface
    });

    console.log('BookManager Table-Focused Admin Interface Loaded');
});
</script>
