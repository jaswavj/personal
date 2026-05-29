<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    int curYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cloud Clients</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        body { background: #f0f4f8; }
        .cloud-badge { background:#0ea5e9;color:#fff;border-radius:4px;padding:2px 8px;font-size:11px; }
        .tbl-wrap { overflow-x:auto; }
        table { width:100%; border-collapse:collapse; }
        thead th { background:#1e3a5f;color:#fff;padding:10px 12px;font-size:12px;text-transform:uppercase; }
        tbody tr { cursor:pointer; transition:background .15s; }
        tbody tr:hover td { background:#dbeafe; }
        tbody td { padding:9px 12px;border-bottom:1px solid #e2e8f0;font-size:13px; }
        .badge-open  { background:#dcfce7;color:#166534;border-radius:20px;padding:2px 10px;font-size:11px; }
        .badge-unpaid { background:#fee2e2;color:#991b1b;border-radius:20px;padding:2px 10px;font-size:11px; }
        .row-unpaid td { background:#fff1f1 !important; }
        /* Modal */
        .pay-grid { display:grid;grid-template-columns:repeat(3,1fr);gap:8px; }
        .month-card { border:1.5px solid #e2e8f0;border-radius:8px;padding:10px 12px;background:#f8fafc;transition:border-color .15s; }
        .month-card.paid  { border-color:#22c55e;background:#f0fdf4; }
        .month-card .m-name { font-weight:700;font-size:13px;margin-bottom:4px; }
        .month-card .m-date { font-size:11px;color:#64748b;margin-top:2px; }
        .month-card .m-amt  { font-size:12px;color:#0f172a;margin-top:3px; }
        .pay-btn { font-size:12px;margin-top:6px; }
        @media(max-width:600px){ .pay-grid { grid-template-columns:repeat(2,1fr); } }
    </style>
</head>
<body>
<%@ include file="/assets/navbar/navbar.jsp" %>

<div class="container mt-4">
    <div class="d-flex align-items-center gap-3 mb-3">
        <h4 class="mb-0"><i class="fas fa-cloud me-2 text-info"></i>Cloud Clients</h4>
        <span class="cloud-badge" id="clientCount">–</span>
        <button class="btn btn-sm btn-outline-primary ms-auto" onclick="loadClients()">
            <i class="fas fa-sync-alt me-1"></i>Refresh
        </button>
    </div>

    <div class="card shadow-sm">
        <div class="card-body p-0">
            <div class="tbl-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Bill No</th>
                            <th>Client Name</th>
                            <th>Phone</th>
                            <th>Amount</th>
                            <th>Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody id="clientsBody">
                        <tr><td colspan="7" class="text-center py-4 text-muted">Loading...</td></tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Client Month Modal -->
<div class="modal fade" id="clientModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title"><i class="fas fa-calendar-alt me-2"></i><span id="modalTitle">Client</span></h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <div class="d-flex align-items-center gap-3 mb-3">
            <div>
                <label class="form-label mb-1 fw-bold">Year</label>
                <select id="modalYear" class="form-select form-select-sm" style="width:110px" onchange="loadMonths()">
                    <% for(int y = curYear; y >= curYear-3; y--){ %>
                        <option value="<%=y%>" <%=y==curYear?"selected":""%>><%=y%></option>
                    <% } %>
                </select>
            </div>
            <div id="closedBadge" class="d-none">
                <span class="badge bg-danger fs-6"><i class="fas fa-lock me-1"></i>CLOSED</span>
                <small class="text-muted ms-2" id="closedDateTxt"></small>
            </div>
        </div>
        <div id="monthsGrid" class="pay-grid">
            <div class="text-center py-3 text-muted">Loading...</div>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-danger btn-sm" id="closeCloudBtn" onclick="closeCloud()">
            <i class="fas fa-lock me-1"></i>Close Cloud Service
        </button>
        <button class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div>

<!-- Pay Month Modal -->
<div class="modal fade" id="payModal" tabindex="-1">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <h6 class="modal-title">Record Payment – <span id="payMonthLabel"></span></h6>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <input type="hidden" id="payBillId">
        <input type="hidden" id="payCustomerId">
        <input type="hidden" id="payYear">
        <input type="hidden" id="payMonth">
        <label class="form-label">Amount Paid (₹)</label>
        <input type="number" id="payAmount" class="form-control" min="0" placeholder="0">
      </div>
      <div class="modal-footer">
        <button class="btn btn-success btn-sm" onclick="submitPay()">
            <i class="fas fa-check me-1"></i>Save Payment
        </button>
        <button class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div>

<script>
const contextPath = '<%=request.getContextPath()%>';
let currentBillId = 0, currentCustomerId = 0;

function loadClients() {
    $.get(contextPath + '/cloud/getCloudClients.jsp', function(data) {
        const tbody = document.getElementById('clientsBody');
        if (!data || data.length === 0) {
            tbody.innerHTML = '<tr><td colspan="7" class="text-center text-muted py-4">No active cloud clients</td></tr>';
            document.getElementById('clientCount').textContent = '0';
            return;
        }
        document.getElementById('clientCount').textContent = data.length + ' active';
        tbody.innerHTML = data.map((r,i) => {
            const unpaid = !r.paidThisMonth || !r.paidNextMonth;
            const rowCls = unpaid ? ' class="row-unpaid"' : '';
            const statusBadge = unpaid
                ? `<span class="badge-unpaid"><i class="fas fa-exclamation-circle me-1"></i>Unpaid</span>`
                : `<span class="badge-open"><i class="fas fa-circle me-1" style="font-size:7px;"></i>Paid</span>`;
            return `<tr${rowCls} onclick="openClient(${r.billId}, ${r.customerId}, '${escHtml(r.cusName)}')">
                <td>${i+1}</td>
                <td><strong>${r.billDisplay}</strong></td>
                <td>${escHtml(r.cusName)}</td>
                <td>${escHtml(r.cusPhn)}</td>
                <td>₹${parseFloat(r.payable).toLocaleString('en-IN')}</td>
                <td>${r.date}</td>
                <td>${statusBadge}</td>
            </tr>`;
        }).join('');
    }, 'json');
}

function openClient(billId, customerId, name) {
    currentBillId     = billId;
    currentCustomerId = customerId;
    document.getElementById('modalTitle').textContent = name;
    loadMonths();
    new bootstrap.Modal(document.getElementById('clientModal')).show();
}

function loadMonths() {
    const year = document.getElementById('modalYear').value;
    document.getElementById('monthsGrid').innerHTML = '<div class="text-center py-3 text-muted">Loading...</div>';
    $.get(contextPath + '/cloud/getClientMonths.jsp', {billId: currentBillId, year: year}, function(data) {
        // Closed status
        const closedBadge = document.getElementById('closedBadge');
        const closeBtn    = document.getElementById('closeCloudBtn');
        if (data.isClosed) {
            closedBadge.classList.remove('d-none');
            document.getElementById('closedDateTxt').textContent = 'Closed on ' + (data.closedDate || '');
            closeBtn.disabled = true;
        } else {
            closedBadge.classList.add('d-none');
            closeBtn.disabled = false;
        }

        const months = data.months || [];
        document.getElementById('monthsGrid').innerHTML = months.map(m => {
            if (m.isPaid) {
                return `<div class="month-card paid">
                    <div class="m-name"><i class="fas fa-check-circle text-success me-1"></i>${m.monthName}</div>
                    <div class="m-amt">₹${parseFloat(m.paidAmount).toLocaleString('en-IN')}</div>
                    <div class="m-date"><i class="fas fa-calendar-check me-1"></i>${m.paidDate}</div>
                </div>`;
            } else {
                return `<div class="month-card">
                    <div class="m-name">${m.monthName}</div>
                    <div class="m-date text-muted">Not paid</div>
                    <button class="btn btn-primary pay-btn w-100" onclick="openPay(${m.month},'${m.monthName}')">
                        <i class="fas fa-rupee-sign me-1"></i>Pay
                    </button>
                </div>`;
            }
        }).join('');
    }, 'json');
}

function openPay(month, monthName) {
    document.getElementById('payBillId').value     = currentBillId;
    document.getElementById('payCustomerId').value = currentCustomerId;
    document.getElementById('payYear').value       = document.getElementById('modalYear').value;
    document.getElementById('payMonth').value      = month;
    document.getElementById('payMonthLabel').textContent = monthName + ' ' + document.getElementById('modalYear').value;
    document.getElementById('payAmount').value     = '';
    new bootstrap.Modal(document.getElementById('payModal')).show();
}

function submitPay() {
    const amount = parseFloat(document.getElementById('payAmount').value);
    if (isNaN(amount) || amount < 0) { alert('Enter valid amount'); return; }
    $.post(contextPath + '/cloud/payCloudMonth.jsp', {
        billId:     document.getElementById('payBillId').value,
        customerId: document.getElementById('payCustomerId').value,
        year:       document.getElementById('payYear').value,
        month:      document.getElementById('payMonth').value,
        amount:     amount
    }, function(res) {
        bootstrap.Modal.getInstance(document.getElementById('payModal')).hide();
        if (res.success) {
            loadMonths();
        } else {
            alert('Error: ' + res.msg);
        }
    }, 'json');
}

function closeCloud() {
    if (!confirm('Mark this cloud service as CLOSED? This will remove the client from the active list.')) return;
    $.post(contextPath + '/cloud/closeCloud.jsp', { billId: currentBillId }, function(res) {
        if (res.success) {
            bootstrap.Modal.getInstance(document.getElementById('clientModal')).hide();
            loadClients();
        } else {
            alert('Error: ' + res.msg);
        }
    }, 'json');
}

function escHtml(s) {
    return (s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}

$(document).ready(function(){ loadClients(); });
</script>
</body>
</html>
