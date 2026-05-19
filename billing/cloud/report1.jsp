<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cloud Client History</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        body { background: #f0f4f8; }
        .hist-table { width:100%;border-collapse:collapse; }
        .hist-table th { background:#1e3a5f;color:#fff;padding:9px 12px;font-size:12px;text-transform:uppercase; }
        .hist-table td { padding:8px 12px;border-bottom:1px solid #e2e8f0;font-size:13px; }
        .hist-table tbody tr:nth-child(even) td { background:#f8fafc; }
        .ac-wrap { position:relative; }
        .ac-drop { position:absolute;top:100%;left:0;right:0;background:#fff;border:1px solid #cbd5e1;border-radius:6px;z-index:9999;max-height:200px;overflow-y:auto;box-shadow:0 4px 14px rgba(0,0,0,.12); }
        .ac-item { padding:9px 12px;cursor:pointer;font-size:13px; }
        .ac-item:hover { background:#f1f5f9; }
        .info-grid { display:grid;grid-template-columns:repeat(auto-fill,minmax(160px,1fr));gap:12px;margin-bottom:18px; }
        .info-card { background:#fff;border-radius:8px;padding:12px 14px;box-shadow:0 1px 4px rgba(0,0,0,.07); }
        .info-card .lbl { font-size:11px;color:#64748b;text-transform:uppercase;font-weight:700; }
        .info-card .val { font-size:16px;font-weight:800;margin-top:2px; }
    </style>
</head>
<body>
<%@ include file="/assets/navbar/navbar.jsp" %>

<div class="container mt-4" style="max-width:800px">
    <h4 class="mb-3"><i class="fas fa-user-circle me-2 text-info"></i>Cloud Client History</h4>

    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <label class="form-label fw-bold">Search Cloud Client</label>
            <div class="ac-wrap">
                <input type="text" id="clientSearch" class="form-control" placeholder="Type client name or phone..." autocomplete="off">
                <div id="acDrop" class="ac-drop d-none"></div>
            </div>
        </div>
    </div>

    <div id="historyPanel" class="d-none">
        <div class="info-grid" id="infoGrid"></div>

        <div class="card shadow-sm">
            <div class="card-header bg-white fw-bold">
                <i class="fas fa-history me-2"></i>Payment History
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="hist-table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Year</th>
                                <th>Month</th>
                                <th>Paid Amount</th>
                                <th>Paid Date</th>
                            </tr>
                        </thead>
                        <tbody id="histBody"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="noData" class="d-none text-center text-muted py-4">No payment records found for this client.</div>
</div>

<script>
const contextPath = '<%=request.getContextPath()%>';
let acTimer;

document.getElementById('clientSearch').addEventListener('input', function() {
    clearTimeout(acTimer);
    const q = this.value.trim();
    if (q.length < 2) { document.getElementById('acDrop').classList.add('d-none'); return; }
    acTimer = setTimeout(() => fetchAC(q), 280);
});

function fetchAC(q) {
    $.get(contextPath + '/cloud/cloudAutocomplete.jsp', {query: q}, function(data) {
        const drop = document.getElementById('acDrop');
        if (!data || data.length === 0) { drop.classList.add('d-none'); return; }
        drop.innerHTML = data.map(r =>
            `<div class="ac-item" onclick="selectClient(${r.billId},'${escHtml(r.cusName)}')">
                <strong>${escHtml(r.cusName)}</strong>
                <span class="text-muted ms-2" style="font-size:11px">${escHtml(r.cusPhn)} · Bill ${escHtml(r.billDisplay)}</span>
            </div>`
        ).join('');
        drop.classList.remove('d-none');
    }, 'json');
}

function selectClient(billId, name) {
    document.getElementById('clientSearch').value = name;
    document.getElementById('acDrop').classList.add('d-none');
    loadHistory(billId);
}

function loadHistory(billId) {
    $.get(contextPath + '/cloud/getClientHistory.jsp', {billId: billId}, function(d) {
        if (!d || d.error) { return; }
        // Info grid
        const closedHtml = d.isClosed
            ? `<span class="badge bg-danger">CLOSED ${d.closedDate}</span>`
            : `<span class="badge bg-success">ACTIVE</span>`;
        document.getElementById('infoGrid').innerHTML = `
            <div class="info-card"><div class="lbl">Bill No</div><div class="val">${escHtml(d.billDisplay)}</div></div>
            <div class="info-card"><div class="lbl">Client</div><div class="val" style="font-size:13px">${escHtml(d.cusName)}</div></div>
            <div class="info-card"><div class="lbl">Phone</div><div class="val" style="font-size:13px">${escHtml(d.cusPhn)}</div></div>
            <div class="info-card"><div class="lbl">Amount</div><div class="val">₹${parseFloat(d.payable).toLocaleString('en-IN')}</div></div>
            <div class="info-card"><div class="lbl">Start Date</div><div class="val" style="font-size:13px">${d.startDate}</div></div>
            <div class="info-card"><div class="lbl">Status</div><div class="val">${closedHtml}</div></div>
        `;

        const payments = d.payments || [];
        if (payments.length === 0) {
            document.getElementById('historyPanel').classList.add('d-none');
            document.getElementById('noData').classList.remove('d-none');
            return;
        }
        document.getElementById('noData').classList.add('d-none');
        document.getElementById('historyPanel').classList.remove('d-none');

        const total = payments.reduce((s,p) => s + parseFloat(p.paidAmount), 0);
        document.getElementById('histBody').innerHTML =
            payments.map((p,i) => `
                <tr>
                    <td>${i+1}</td>
                    <td>${p.year}</td>
                    <td>${p.monthName}</td>
                    <td>₹${parseFloat(p.paidAmount).toLocaleString('en-IN')}</td>
                    <td>${p.paidDate}</td>
                </tr>
            `).join('') +
            `<tr style="background:#f0fdf4;font-weight:700">
                <td colspan="3">Total Paid</td>
                <td>₹${total.toLocaleString('en-IN')}</td>
                <td></td>
            </tr>`;
    }, 'json');
}

document.addEventListener('click', function(e) {
    if (!e.target.closest('.ac-wrap')) document.getElementById('acDrop').classList.add('d-none');
});

function escHtml(s) {
    return (s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}
</script>
</body>
</html>
