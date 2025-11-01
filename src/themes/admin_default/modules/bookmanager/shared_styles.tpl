<!-- Admin Shared Styles for BookManager Module -->
<style>
/* Global Styles */
.bookmanager-admin {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

/* Simplified Page Header - Table Focused */
.page-header {
    background: #f8f9fa;
    border-bottom: 2px solid #dee2e6;
    padding: 1rem 0;
    margin: -1.5rem -1.5rem 1rem -1.5rem;
}

.page-header .header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.page-header .header-title {
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.page-header .header-title i {
    font-size: 1.5rem;
    color: #495057;
}

.page-header .header-title h1 {
    margin: 0;
    font-size: 1.5rem;
    font-weight: 600;
    color: #495057;
}

.page-header .header-subtitle {
    color: #6c757d;
    font-size: 0.875rem;
    margin-top: 0.125rem;
}

.page-header .header-actions .btn {
    font-weight: 500;
    transition: all 0.2s ease;
}

/* Stats Cards */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.stat-card {
    background: white;
    border-radius: 1rem;
    padding: 1.5rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
    border: 1px solid rgba(0, 0, 0, 0.05);
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.stat-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, var(--stat-color), var(--stat-color-light));
}

.stat-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

.stat-card .stat-icon {
    width: 3rem;
    height: 3rem;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.2rem;
    margin-bottom: 1rem;
    color: white;
}

.stat-card .stat-value {
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 0.25rem;
    color: var(--stat-color);
}

.stat-card .stat-label {
    font-size: 0.9rem;
    color: #6c757d;
    font-weight: 500;
}

/* Table-Centric Data Display */
.data-table-container {
    background: white;
    border-radius: 0.5rem;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    overflow: hidden;
    border: 1px solid #dee2e6;
    margin-bottom: 1rem;
}

.data-table-header {
    background: #f8f9fa;
    padding: 1rem 1.5rem;
    border-bottom: 2px solid #dee2e6;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.data-table-header h5 {
    margin: 0;
    color: #495057;
    font-weight: 600;
    font-size: 1.1rem;
}

.data-table-header .header-actions {
    display: flex;
    gap: 0.5rem;
}

.data-table {
    width: 100%;
    margin: 0;
    border-collapse: collapse;
    font-size: 0.875rem;
}

.data-table th {
    background: #f8f9fa;
    color: #495057;
    font-weight: 600;
    font-size: 0.8rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    padding: 0.75rem 1rem;
    text-align: left;
    border-bottom: 2px solid #dee2e6;
    position: sticky;
    top: 0;
    z-index: 10;
}

.data-table td {
    padding: 0.75rem 1rem;
    border-bottom: 1px solid #dee2e6;
    vertical-align: middle;
    line-height: 1.4;
}

.data-table tbody tr:hover {
    background: #f1f3f4;
    cursor: pointer;
}

.data-table tbody tr:last-child td {
    border-bottom: none;
}

/* Status Badges */
.status-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.375rem 0.75rem;
    border-radius: 2rem;
    font-size: 0.8rem;
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.status-badge.status-active {
    background: rgba(25, 135, 84, 0.1);
    color: #198754;
    border: 1px solid rgba(25, 135, 84, 0.2);
}

.status-badge.status-inactive {
    background: rgba(220, 53, 69, 0.1);
    color: #dc3545;
    border: 1px solid rgba(220, 53, 69, 0.2);
}

.status-badge.status-pending {
    background: rgba(255, 193, 7, 0.1);
    color: #ffc107;
    border: 1px solid rgba(255, 193, 7, 0.2);
}

.status-badge.status-completed {
    background: rgba(25, 135, 84, 0.1);
    color: #198754;
    border: 1px solid rgba(25, 135, 84, 0.2);
}

.status-badge.status-cancelled {
    background: rgba(220, 53, 69, 0.1);
    color: #dc3545;
    border: 1px solid rgba(220, 53, 69, 0.2);
}

/* Action Buttons */
.action-buttons {
    display: flex;
    gap: 0.5rem;
    flex-wrap: wrap;
}

.action-buttons .btn {
    padding: 0.375rem 0.75rem;
    font-size: 0.8rem;
    border-radius: 0.375rem;
    transition: all 0.2s ease;
}

.action-buttons .btn:hover {
    transform: translateY(-1px);
}

/* Form Styles */
.admin-form {
    background: white;
    border-radius: 1rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
    overflow: hidden;
    border: 1px solid rgba(0, 0, 0, 0.05);
}

.form-header {
    background: #f8f9fa;
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
}

.form-header h5 {
    margin: 0;
    color: #495057;
    font-weight: 600;
}

.form-body {
    padding: 2rem;
}

.form-group {
    margin-bottom: 1.5rem;
}

.form-label {
    font-weight: 600;
    color: #495057;
    margin-bottom: 0.5rem;
    display: block;
    font-size: 1.1rem;
}

.form-control {
    border: 2px solid #e9ecef;
    border-radius: 0.5rem;
    padding: 0.75rem;
    font-size: 1rem;
    transition: all 0.3s ease;
}

.form-control:focus {
    border-color: #007bff;
    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}

.form-check-label {
    font-size: 1.1rem;
    font-weight: 600;
}

.form-actions {
    background: #f8f9fa;
    padding: 1.5rem;
    border-top: 1px solid #e9ecef;
    display: flex;
    justify-content: flex-end;
    gap: 1rem;
}

/* Responsive Design */
@media (max-width: 768px) {
    .page-header .header-content {
        flex-direction: column;
        gap: 1rem;
        text-align: center;
    }

    .stats-grid {
        grid-template-columns: 1fr;
    }

    .data-table th,
    .data-table td {
        padding: 0.5rem;
        font-size: 0.8rem;
    }

    .action-buttons {
        flex-direction: column;
    }

    .action-buttons .btn {
        width: 100%;
    }
}

/* Animations */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

.fade-in {
    animation: fadeIn 0.5s ease-out;
}

/* Utility Classes */
.text-truncate-2 {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.hover-lift {
    transition: all 0.3s ease;
}

.hover-lift:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}
</style>
