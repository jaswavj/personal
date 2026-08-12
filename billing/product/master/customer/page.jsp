<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*"%>
<jsp:useBean id="prod" class="product.productBean" />
<%
String msg  = request.getParameter("msg");
String type = request.getParameter("type");
Vector vec = prod.getCustomerDetails();
int totalCustomers = vec.size();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer - Billing App</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        :root {
            --cust-primary: #4e73df;
            --cust-primary-dark: #3d5fc7;
            --cust-bg: #f0f4f8;
            --cust-card: #ffffff;
            --cust-border: #e2e8f0;
            --cust-muted: #64748b;
            --cust-text: #0f172a;
        }
        body { background: var(--cust-bg); color: var(--cust-text); }

        .cust-page { max-width: 1280px; margin: 0 auto; padding: 1rem 1rem 2rem; }

        .page-header {
            background: linear-gradient(135deg, var(--cust-primary-dark), var(--cust-primary));
            color: #fff;
            border-radius: 12px;
            padding: 1rem 1.25rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            flex-wrap: wrap;
        }
        .page-header h4 { margin: 0; font-size: 1.15rem; font-weight: 700; }
        .page-header small { opacity: .85; font-size: .8rem; display: block; margin-top: 2px; }
        .count-badge {
            background: rgba(255,255,255,.18);
            border: 1px solid rgba(255,255,255,.25);
            border-radius: 999px;
            padding: 4px 12px;
            font-size: .78rem;
            font-weight: 600;
            white-space: nowrap;
        }

        .alert-wrap { margin-bottom: 1rem; }

        .layout-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1rem;
            align-items: start;
        }
        @media (min-width: 992px) {
            .layout-grid { grid-template-columns: 360px 1fr; gap: 1.25rem; }
            .form-panel { position: sticky; top: 12px; }
        }

        .panel {
            background: var(--cust-card);
            border-radius: 12px;
            box-shadow: 0 1px 8px rgba(15,23,42,.07);
            border: 1px solid var(--cust-border);
            overflow: hidden;
        }
        .panel-head {
            padding: .85rem 1rem;
            border-bottom: 1px solid var(--cust-border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 8px;
            background: #f8fafc;
        }
        .panel-head h5 {
            margin: 0;
            font-size: .92rem;
            font-weight: 700;
            color: var(--cust-text);
        }
        .panel-body { padding: 1rem; }

        .form-toggle {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            border: none;
            background: var(--cust-primary);
            color: #fff;
            border-radius: 8px;
            padding: 6px 12px;
            font-size: .8rem;
            font-weight: 600;
        }
        @media (min-width: 992px) { .form-toggle { display: none; } }

        .form-panel.collapsed .panel-body { display: none; }
        @media (min-width: 992px) { .form-panel.collapsed .panel-body { display: block; } }

        .field-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: .85rem;
        }
        @media (min-width: 576px) {
            .form-panel .field-grid.two-col { grid-template-columns: 1fr 1fr; }
        }

        .input-outline textarea.form-control { min-height: 88px; resize: vertical; }

        .field-block { display: flex; flex-direction: column; gap: 6px; }
        .field-label {
            font-size: .84rem;
            font-weight: 600;
            color: #334155;
            margin: 0;
        }
        .field-hint {
            font-size: .75rem;
            color: var(--cust-muted);
            margin: 4px 0 0;
        }
        .field-block .form-control {
            border-radius: 10px;
            border-color: rgb(96, 52, 114);
        }
        .field-block.district-wrap { position: relative; }
        .district-wrap .ui-autocomplete {
            z-index: 1050;
            max-height: 220px;
            overflow-y: auto;
            font-size: .88rem;
            border-radius: 8px;
            box-shadow: 0 4px 14px rgba(15,23,42,.12);
        }
        .district-wrap .ui-menu-item-wrapper {
            padding: 8px 12px !important;
        }

        .option-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            padding: .65rem .75rem;
            background: #f8fafc;
            border: 1px solid var(--cust-border);
            border-radius: 8px;
        }
        .option-row label { margin: 0; font-size: .84rem; font-weight: 600; color: #334155; }

        .form-actions {
            display: flex;
            flex-wrap: wrap;
            gap: .5rem;
            margin-top: .25rem;
        }
        .form-actions .btn { min-width: 120px; font-weight: 600; }

        .list-toolbar {
            display: flex;
            flex-wrap: wrap;
            gap: .65rem;
            align-items: center;
            margin-bottom: .85rem;
        }
        .search-box {
            flex: 1 1 220px;
            position: relative;
        }
        .search-box i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--cust-muted);
            font-size: .85rem;
        }
        .search-box input {
            width: 100%;
            border: 1px solid var(--cust-border);
            border-radius: 8px;
            padding: .55rem .75rem .55rem 2.2rem;
            font-size: .88rem;
            background: #fff;
        }
        .search-box input:focus {
            outline: none;
            border-color: var(--cust-primary);
            box-shadow: 0 0 0 3px rgba(78,115,223,.15);
        }
        .result-hint { font-size: .78rem; color: var(--cust-muted); white-space: nowrap; }

        .table-wrap { overflow-x: auto; display: none; }
        @media (min-width: 768px) { .table-wrap { display: block; } }

        .cust-table { width: 100%; border-collapse: collapse; font-size: .86rem; min-width: 560px; }
        .cust-table thead th {
            background: #1e3a5f;
            color: #fff;
            padding: 10px 12px;
            font-size: .75rem;
            text-transform: uppercase;
            letter-spacing: .4px;
            white-space: nowrap;
        }
        .cust-table tbody tr { border-bottom: 1px solid var(--cust-border); transition: background .15s; }
        .cust-table tbody tr:hover { background: #f1f5f9; }
        .cust-table tbody td { padding: 10px 12px; vertical-align: middle; color: #334155; }
        .cust-table .name-cell { font-weight: 600; color: var(--cust-text); }
        .cust-table .addr-cell {
            max-width: 180px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            color: var(--cust-muted);
        }

        .mobile-list { display: grid; gap: .65rem; }
        @media (min-width: 768px) { .mobile-list { display: none; } }

        .cust-card {
            border: 1px solid var(--cust-border);
            border-radius: 10px;
            padding: .85rem;
            background: #fff;
        }
        .cust-card-head {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 10px;
            margin-bottom: .55rem;
        }
        .cust-card-head .name { font-weight: 700; font-size: .95rem; line-height: 1.3; }
        .cust-card-head .idx { color: var(--cust-muted); font-size: .75rem; font-weight: 600; }
        .cust-meta { display: grid; gap: .35rem; font-size: .82rem; color: #475569; margin-bottom: .65rem; }
        .cust-meta span { display: flex; align-items: center; gap: 6px; }
        .cust-meta i { width: 14px; color: var(--cust-muted); text-align: center; }
        .badge-row { display: flex; flex-wrap: wrap; gap: 6px; margin-bottom: .65rem; }
        .tag {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            border-radius: 999px;
            padding: 2px 9px;
            font-size: .72rem;
            font-weight: 600;
        }
        .cust-table .edit-cell { width: 72px; }
        .tag-district { background: #e0f2fe; color: #0369a1; }

        .btn-edit-sm {
            border: none;
            background: #fef3c7;
            color: #92400e;
            border-radius: 8px;
            padding: 6px 12px;
            font-size: .78rem;
            font-weight: 700;
            white-space: nowrap;
        }
        .btn-edit-sm:hover { background: #fde68a; }

        .empty-state {
            text-align: center;
            padding: 2rem 1rem;
            color: var(--cust-muted);
            font-size: .9rem;
        }
        .empty-state i { font-size: 1.6rem; margin-bottom: .5rem; opacity: .45; display: block; }

        .no-results { display: none; text-align: center; padding: 1.5rem; color: var(--cust-muted); font-size: .88rem; }
        .no-results.show { display: block; }
    </style>
</head>
<body>

<%@ include file="/assets/navbar/navbar.jsp" %>

<div class="cust-page">
    <div class="page-header">
        <div>
            <h4><i class="fas fa-users me-2"></i>Customer Master</h4>
            <small>Manage customer details and district</small>
        </div>
        <span class="count-badge"><i class="fas fa-user me-1"></i><span id="totalCount"><%= totalCustomers %></span> customers</span>
    </div>

    <% if (msg != null) { %>
    <div class="alert-wrap">
        <div class="alert alert-<%= (type != null ? type : "info") %> alert-dismissible fade show mb-0" role="alert">
            <%= msg %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </div>
    <% } %>

    <div class="layout-grid">
        <!-- Form Panel -->
        <div class="panel form-panel collapsed" id="formPanel">
            <div class="panel-head">
                <h5 id="formCardTitle"><i class="fas fa-user-plus me-1 text-primary"></i>Add Customer</h5>
                <button type="button" class="form-toggle" id="formToggleBtn" onclick="toggleFormPanel()">
                    <i class="fas fa-chevron-down" id="formToggleIcon"></i><span id="formToggleText">Show Form</span>
                </button>
            </div>
            <div class="panel-body">
                <form id="customerForm" action="<%=contextPath%>/product/master/customer/page1.jsp" method="post">
                    <div class="field-grid two-col">
                        <div class="input-outline">
                            <input type="text" name="custName" id="custnameInput" class="form-control" placeholder="" required>
                            <label>Customer Name</label>
                        </div>
                        <div class="input-outline">
                            <input type="number" name="custPhn" id="custPhnInput" class="form-control" placeholder="">
                            <label>Phone Number</label>
                        </div>
                    </div>

                    <div class="field-grid two-col mt-3">
                        <div class="field-block district-wrap">
                            <label class="field-label" for="districtInput">District</label>
                            <input type="text" name="districtName" id="districtInput" class="form-control" placeholder="Type to search district" autocomplete="off">
                            <p class="field-hint">Pick from list or type a new district name</p>
                        </div>
                        <div class="field-block">
                            <label class="field-label" for="custAddressArea">Address</label>
                            <textarea name="custAddress" id="custAddressArea" class="form-control" rows="3" placeholder="Enter address"></textarea>
                        </div>
                    </div>

                    <div class="form-actions mt-3">
                        <input type="hidden" name="customerId" id="customerId" value="">
                        <button type="submit" id="submitBtn" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i>Add Customer
                        </button>
                        <button type="button" id="cancelBtn" class="btn btn-outline-secondary" style="display:none;" onclick="resetFormToAdd()">Cancel</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- List Panel -->
        <div class="panel list-panel">
            <div class="panel-head">
                <h5><i class="fas fa-list me-1 text-primary"></i>Customer List</h5>
            </div>
            <div class="panel-body">
                <div class="list-toolbar">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="search" id="searchInput" placeholder="Search name, phone, district, address..." autocomplete="off">
                    </div>
                    <span class="result-hint"><span id="visibleCount"><%= totalCustomers %></span> shown</span>
                </div>

                <div class="no-results" id="noResults">
                    <i class="fas fa-search mb-2"></i>No customers match your search.
                </div>

                <% if (totalCustomers == 0) { %>
                <div class="empty-state">
                    <i class="fas fa-users"></i>
                    No customers yet. Add your first customer using the form.
                </div>
                <% } else { %>

                <!-- Desktop table -->
                <div class="table-wrap">
                    <table class="cust-table" id="customerTable">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th></th>
                                <th>Name</th>
                                <th>Phone</th>
                                <th>District</th>
                                <th>Address</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            for (int i = 0; i < vec.size(); i++) {
                                Vector vec1 = (Vector) vec.get(i);
                                String Name = vec1.elementAt(0).toString();
                                int id = Integer.parseInt(vec1.elementAt(1).toString());
                                String address = vec1.elementAt(2).toString();
                                String phn = vec1.elementAt(3).toString();
                                String district = vec1.elementAt(7).toString();
                                String safeName = Name.replace("\\", "\\\\").replace("'", "\\'").replace("\n", " ");
                                String safeAddress = address.replace("\\", "\\\\").replace("'", "\\'").replace("\n", " ").replace("\r", "");
                                String safePhn = phn.replace("'", "\\'");
                                String safeDistrict = district.replace("\\", "\\\\").replace("'", "\\'").replace("\n", " ");
                                String searchText = (Name + " " + phn + " " + district + " " + address).toLowerCase();
                            %>
                            <tr class="cust-row" data-search="<%= searchText.replace("\"", "&quot;") %>">
                                <td><%= i + 1 %></td>
                                <td class="edit-cell">
                                    <button type="button" class="btn-edit-sm" onclick="populateForm(<%= id %>, '<%= safeName %>', '<%= safePhn %>', '<%= safeAddress %>', '<%= safeDistrict %>')">
                                        <i class="fas fa-pen"></i>
                                    </button>
                                </td>
                                <td class="name-cell"><%= Name %></td>
                                <td><%= phn %></td>
                                <td>
                                    <% if (!district.equals("-")) { %>
                                    <span class="tag tag-district"><%= district %></span>
                                    <% } else { %>
                                    <span class="text-muted">—</span>
                                    <% } %>
                                </td>
                                <td class="addr-cell" title="<%= address %>"><%= address %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Mobile cards -->
                <div class="mobile-list" id="mobileList">
                    <%
                    for (int i = 0; i < vec.size(); i++) {
                        Vector vec1 = (Vector) vec.get(i);
                        String Name = vec1.elementAt(0).toString();
                        int id = Integer.parseInt(vec1.elementAt(1).toString());
                        String address = vec1.elementAt(2).toString();
                        String phn = vec1.elementAt(3).toString();
                        String district = vec1.elementAt(7).toString();
                        String safeName = Name.replace("\\", "\\\\").replace("'", "\\'").replace("\n", " ");
                        String safeAddress = address.replace("\\", "\\\\").replace("'", "\\'").replace("\n", " ").replace("\r", "");
                        String safePhn = phn.replace("'", "\\'");
                        String safeDistrict = district.replace("\\", "\\\\").replace("'", "\\'").replace("\n", " ");
                        String searchText = (Name + " " + phn + " " + district + " " + address).toLowerCase();
                        String phoneHref = phn.equals("-") ? "" : "tel:" + phn.replaceAll("[^0-9+]", "");
                    %>
                    <div class="cust-card cust-row" data-search="<%= searchText.replace("\"", "&quot;") %>">
                        <div class="cust-card-head">
                            <div class="d-flex align-items-start gap-2">
                                <span class="idx">#<%= i + 1 %></span>
                                <button type="button" class="btn-edit-sm" onclick="populateForm(<%= id %>, '<%= safeName %>', '<%= safePhn %>', '<%= safeAddress %>', '<%= safeDistrict %>')">
                                    <i class="fas fa-pen"></i>
                                </button>
                                <div class="name"><%= Name %></div>
                            </div>
                        </div>
                        <div class="cust-meta">
                            <% if (!phn.equals("-")) { %>
                            <span><i class="fas fa-phone"></i>
                                <% if (!phoneHref.isEmpty()) { %><a href="<%= phoneHref %>" class="text-decoration-none"><%= phn %></a><% } else { %><%= phn %><% } %>
                            </span>
                            <% } %>
                            <% if (!district.equals("-")) { %>
                            <span><i class="fas fa-map"></i><span class="tag tag-district"><%= district %></span></span>
                            <% } %>
                            <% if (!address.equals("-")) { %>
                            <span><i class="fas fa-map-marker-alt"></i><%= address %></span>
                            <% } %>
                        </div>
                    </div>
                    <% } %>
                </div>

                <% } %>
            </div>
        </div>
    </div>
</div>

<script>
var contextPath = "<%=contextPath%>";

function toggleFormPanel(forceOpen) {
    var panel = document.getElementById('formPanel');
    var icon = document.getElementById('formToggleIcon');
    var text = document.getElementById('formToggleText');
    var open = typeof forceOpen === 'boolean' ? forceOpen : panel.classList.contains('collapsed');
    panel.classList.toggle('collapsed', !open);
    icon.className = open ? 'fas fa-chevron-up' : 'fas fa-chevron-down';
    text.textContent = open ? 'Hide Form' : 'Show Form';
}

function populateForm(id, name, phn, address, district) {
    document.getElementById('customerForm').action = contextPath + '/product/master/customer/edit1.jsp';
    document.getElementById('custnameInput').value = name;
    document.getElementById('custPhnInput').value = (phn === '-') ? '' : phn;
    document.getElementById('custAddressArea').value = (address === '-') ? '' : address;
    document.getElementById('districtInput').value = (district === '-') ? '' : district;
    document.getElementById('customerId').value = id;
    document.getElementById('submitBtn').innerHTML = '<i class="fas fa-save me-1"></i>Update Customer';
    document.getElementById('cancelBtn').style.display = 'inline-block';
    document.getElementById('formCardTitle').innerHTML = '<i class="fas fa-user-edit me-1 text-primary"></i>Edit Customer';
    toggleFormPanel(true);
    document.getElementById('formPanel').scrollIntoView({ behavior: 'smooth', block: 'start' });
    document.getElementById('custnameInput').focus();
}

function resetFormToAdd() {
    document.getElementById('customerForm').action = contextPath + '/product/master/customer/page1.jsp';
    document.getElementById('customerForm').reset();
    document.getElementById('customerId').value = '';
    document.getElementById('districtInput').value = '';
    document.getElementById('submitBtn').innerHTML = '<i class="fas fa-save me-1"></i>Add Customer';
    document.getElementById('cancelBtn').style.display = 'none';
    document.getElementById('formCardTitle').innerHTML = '<i class="fas fa-user-plus me-1 text-primary"></i>Add Customer';
}

function filterCustomers() {
    var q = document.getElementById('searchInput').value.trim().toLowerCase();
    var isDesktop = window.innerWidth >= 768;
    var allRows = document.querySelectorAll('.cust-row');
    var visible = 0;

    allRows.forEach(function(row) {
        var match = !q || (row.getAttribute('data-search') || '').indexOf(q) !== -1;
        row.style.display = match ? '' : 'none';
    });

    document.querySelectorAll(isDesktop ? '#customerTable .cust-row' : '#mobileList .cust-row').forEach(function(row) {
        if (row.style.display !== 'none') visible++;
    });

    document.getElementById('visibleCount').textContent = visible;
    document.getElementById('noResults').classList.toggle('show', q.length > 0 && visible === 0);
}

document.addEventListener('DOMContentLoaded', function() {
    if (window.innerWidth >= 992 || <%= totalCustomers %> === 0) toggleFormPanel(true);

    document.getElementById('searchInput').addEventListener('input', filterCustomers);
    window.addEventListener('resize', filterCustomers);

    $('#districtInput').autocomplete({
        minLength: 0,
        delay: 200,
        source: function(request, response) {
            $.getJSON(contextPath + '/product/master/customer/districtAutocomplete.jsp', { term: request.term }, function(data) {
                response(data);
            }).fail(function() { response([]); });
        },
        select: function(event, ui) {
            $(this).val(ui.item.value);
            return false;
        }
    }).focus(function() {
        $(this).autocomplete('search', $(this).val());
    });

    if (window.innerWidth >= 992) {
        document.getElementById('custnameInput').focus();
    }
});

document.addEventListener('contextmenu', function(e) { e.preventDefault(); });
</script>
</body>
</html>
