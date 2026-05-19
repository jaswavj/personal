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
    <title>Cloud Settlement Report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        body { background:#f0f4f8; }
        .rep-table { width:100%;border-collapse:collapse; }
        .rep-table th { background:#1e3a5f;color:#fff;padding:10px 14px;font-size:12px;text-transform:uppercase;text-align:left; }
        .rep-table td { padding:9px 14px;border-bottom:1px solid #e2e8f0;font-size:13px;vertical-align:middle; }
        .rep-table tbody tr:nth-child(even) td { background:#f8fafc; }
        .rep-table tfoot td { background:#1e3a5f;color:#fff;font-weight:700;padding:10px 14px; }
        .amt-inp { width:120px;border:1.5px solid #cbd5e1;border-radius:6px;padding:5px 8px;font-size:13px; }
        .amt-inp:focus { outline:none;border-color:#3b82f6;box-shadow:0 0 0 3px rgba(59,130,246,.15); }
        .save-btn { padding:4px 10px;font-size:12px; }
        .profit-pos { color:#16a34a;font-weight:700; }
        .profit-neg { color:#dc2626;font-weight:700; }
        .pending-badge { background:#fef3c7;color:#92400e;border-radius:12px;padding:2px 8px;font-size:11px; }
    </style>
</head>
<body>
<%@ include file="/assets/navbar/navbar.jsp" %>

<div class="container mt-4">
    <div class="d-flex align-items-center gap-3 mb-3">
        <h4 class="mb-0"><i class="fas fa-table me-2 text-info"></i>Cloud Settlement Report</h4>
        <div class="d-flex align-items-center gap-2 ms-auto">
            <label class="fw-bold mb-0">Year:</label>
            <select id="yearSel" class="form-select form-select-sm" style="width:110px" onchange="loadReport()">
                <% for(int y = curYear; y >= curYear-3; y--){ %>
                    <option value="<%=y%>" <%=y==curYear?"selected":""%>><%=y%></option>
                <% } %>
            </select>
            <button class="btn btn-sm btn-outline-primary" onclick="loadReport()">
                <i class="fas fa-sync-alt me-1"></i>Refresh
            </button>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="rep-table">
                    <thead>
                        <tr>
                            <th>Month</th>
                            <th>Cloud Cost (I Paid) <small class="fw-normal opacity-75">₹</small></th>
                            <th>Clients Paid <small class="fw-normal opacity-75">(count / total)</small></th>
                            <th>Client Total <small class="fw-normal opacity-75">₹</small></th>
                            <th>Profit <small class="fw-normal opacity-75">₹</small></th>
                        </tr>
                    </thead>
                    <tbody id="reportBody">
                        <tr><td colspan="5" class="text-center text-muted py-4">Select year to load...</td></tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td>Total</td>
                            <td id="footCloud">–</td>
                            <td></td>
                            <td id="footClient">–</td>
                            <td id="footProfit">–</td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
    <p class="text-muted mt-2" style="font-size:12px"><i class="fas fa-info-circle me-1"></i>Enter the cloud amount you paid each month and click <strong>Save</strong>. Client totals are auto-calculated from payments received.</p>
</div>

<script>
const contextPath = '<%=request.getContextPath()%>';

function loadReport() {
    const year = document.getElementById('yearSel').value;
    document.getElementById('reportBody').innerHTML =
        '<tr><td colspan="5" class="text-center text-muted py-4">Loading...</td></tr>';
    $.get(contextPath + '/cloud/getReport2Data.jsp', {year: year}, function(data) {
        if (!data || data.length === 0) {
            document.getElementById('reportBody').innerHTML =
                '<tr><td colspan="5" class="text-center text-muted py-4">No data</td></tr>';
            return;
        }
        let totalCloud = 0, totalClient = 0, totalProfit = 0;
        document.getElementById('reportBody').innerHTML = data.map(r => {
            totalCloud  += r.cloudAmount;
            totalClient += r.clientPaid;
            totalProfit += r.profit;
            const profitClass = r.profit > 0 ? 'profit-pos' : (r.profit < 0 ? 'profit-neg' : '');
            const profitTxt   = r.cloudAmount === 0
                ? '<span class="text-muted">–</span>'
                : `<span class="${profitClass}">₹${r.profit.toLocaleString('en-IN',{minimumFractionDigits:0,maximumFractionDigits:2})}</span>`;
            const paidInfo = r.totalClients > 0
                ? `<span class="text-success fw-bold">${r.paidCount}</span> / ${r.totalClients}`
                : (r.paidCount > 0 ? r.paidCount : '–');
            const pendingBadge = (r.totalClients > 0 && r.paidCount < r.totalClients)
                ? `<span class="pending-badge ms-1">${r.totalClients - r.paidCount} pending</span>`
                : '';
            return `<tr>
                <td><strong>${r.monthName}</strong></td>
                <td>
                    <input type="number" class="amt-inp" id="cloud_${r.month}" 
                           value="${r.cloudAmount}" min="0" step="0.01"
                           onblur="saveCloudAmt(${r.month}, this.value)">
                </td>
                <td>${paidInfo}${pendingBadge}</td>
                <td>${r.clientPaid > 0 ? '₹' + r.clientPaid.toLocaleString('en-IN',{minimumFractionDigits:0,maximumFractionDigits:2}) : '<span class="text-muted">₹0</span>'}</td>
                <td>${profitTxt}</td>
            </tr>`;
        }).join('');

        const profCls = totalProfit > 0 ? 'text-success' : (totalProfit < 0 ? 'text-danger' : '');
        document.getElementById('footCloud').textContent  = '₹' + totalCloud.toLocaleString('en-IN',{minimumFractionDigits:0,maximumFractionDigits:2});
        document.getElementById('footClient').textContent = '₹' + totalClient.toLocaleString('en-IN',{minimumFractionDigits:0,maximumFractionDigits:2});
        document.getElementById('footProfit').innerHTML   = `<span class="${profCls}">₹${totalProfit.toLocaleString('en-IN',{minimumFractionDigits:0,maximumFractionDigits:2})}</span>`;
    }, 'json');
}

function saveCloudAmt(month, value) {
    const year   = document.getElementById('yearSel').value;
    const amount = parseFloat(value) || 0;
    $.post(contextPath + '/cloud/saveCloudPaid.jsp', {year: year, month: month, amount: amount}, function(res) {
        if (res.success) {
            // Reload to refresh profit
            loadReport();
        } else {
            alert('Save failed: ' + res.msg);
        }
    }, 'json');
}

$(document).ready(function(){ loadReport(); });
</script>
</body>
</html>
