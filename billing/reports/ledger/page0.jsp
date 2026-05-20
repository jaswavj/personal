<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<jsp:useBean id="prod" class="product.productBean" />
<%
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}

String fromDate = request.getParameter("fromDate");
String toDate   = request.getParameter("toDate");

if (fromDate == null || fromDate.isEmpty() || toDate == null || toDate.isEmpty()) {
    response.sendRedirect(request.getContextPath() + "/reports/ledger/page.jsp");
    return;
}

Vector ledgerData = prod.getLedgerReport(fromDate, toDate);

// First element is the opening balance row
double openingBalance = 0;
if (ledgerData.size() > 0) {
    Vector openingRow = (Vector) ledgerData.get(0);
    openingBalance = (Double) openingRow.get(0);
}

DecimalFormat df = new DecimalFormat("#,##0.00");

// Pre-compute closing balance
double closingBalance = openingBalance;
for (int ci = 1; ci < ledgerData.size(); ci++) {
    Vector crow = (Vector) ledgerData.get(ci);
    double camt = (Double) crow.get(2);
    int ctype   = (Integer) crow.get(3);
    if (ctype == 1) closingBalance += camt;
    else            closingBalance -= camt;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ledger Report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        body { background: #f5f7fa; }
        .ledger-table thead tr {
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
        }
        .ledger-table thead th {
            font-size: 0.85rem;
            font-weight: 600;
            color: #ffffff !important;
            padding: 0.6rem 0.75rem;
            border-color: #3a5fc8;
            white-space: nowrap;
        }
        .ledger-table td {
            font-size: 0.85rem;
            vertical-align: middle;
            padding: 0.45rem 0.75rem;
        }
        .text-in  { color: #1a7a4a; font-weight: 600; }
        .text-out { color: #c53030; font-weight: 600; }
        .opening-row td { background: #edf2f7; font-style: italic; color: #555; }
        .closing-row td { background: #ebf8f0; font-weight: 700; }
        .col-datetime  { width: 160px; }
        .col-content   { }
        .col-amount    { width: 130px; text-align: right; }
        .col-closing   { width: 150px; text-align: right; }
        .summary-cards { display:flex; gap:16px; margin-bottom:1rem; flex-wrap:wrap; }
        .sum-card { flex:1; min-width:180px; border-radius:10px; padding:14px 20px; display:flex; flex-direction:column; gap:4px; }
        .sum-card.open-card  { background:#fff; border:2px solid #4e73df; }
        .sum-card.close-card { background:#fff; border:2px solid #16a34a; }
        .sum-card.cloud-card { background:linear-gradient(135deg,#1e3a5f 0%,#2d5a9e 100%); color:#fff; }
        .sum-icon { font-size:1.1rem; }
        .open-card  .sum-icon { color:#4e73df; }
        .close-card .sum-icon { color:#16a34a; }
        .cloud-card .sum-icon { color:rgba(255,255,255,.8); }
        .sum-label { font-size:0.75rem; font-weight:600; text-transform:uppercase; letter-spacing:.5px; opacity:.7; }
        .close-card .sum-label { color:#555; }
        .open-card  .sum-label { color:#555; }
        .sum-value { font-size:1.25rem; font-weight:700; }
        .open-card  .sum-value { color:#224abe; }
        .close-card .sum-value { color:#15803d; }
        .cloud-card .sum-value { color:#fff; }
        .sum-sub   { font-size:0.7rem; opacity:.65; }
        @media print {
            .no-print { display: none !important; }
            body { background: #fff; }
        }
    </style>
</head>
<body>
    <%@ include file="/assets/navbar/navbar.jsp" %>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-3 no-print">
            <h5 class="mb-0"><i class="fas fa-book me-2"></i>Ledger Report
                <small class="text-muted ms-2" style="font-size:0.85rem;"><%=fromDate%> to <%=toDate%></small>
            </h5>
            <div class="d-flex gap-2">
                <a href="<%=contextPath%>/reports/ledger/page.jsp" class="btn btn-secondary btn-sm">
                    <i class="fas fa-arrow-left me-1"></i>Back
                </a>
                <button class="btn btn-primary btn-sm" onclick="window.print()">
                    <i class="fas fa-print me-1"></i>Print
                </button>
                <button class="btn btn-success btn-sm" onclick="exportTableToExcel('ledgerTable','Ledger_Report')">
                    <i class="fas fa-file-excel me-1"></i>Excel
                </button>
            </div>
        </div>

        <!-- Summary Cards: Opening / Closing / Cloud -->
        <div class="summary-cards">
            <div class="sum-card open-card">
                <div><i class="fas fa-folder-open sum-icon"></i></div>
                <div class="sum-label">Opening Balance</div>
                <div class="sum-value">₹<%=df.format(openingBalance)%></div>
            </div>
            <div class="sum-card close-card">
                <div><i class="fas fa-check-circle sum-icon"></i></div>
                <div class="sum-label">Closing Balance</div>
                <div class="sum-value">₹<%=df.format(closingBalance)%></div>
            </div>
            <div class="sum-card cloud-card">
                <div><i class="fas fa-cloud sum-icon"></i></div>
                <div class="sum-label">Cloud Balance Due</div>
                <div class="sum-value" id="cloudBalVal"><span style="font-size:.9rem;opacity:.7">Loading...</span></div>
                <div class="sum-sub">Unsettled months only</div>
            </div>
        </div>

        <div class="table-responsive">
            <table id="ledgerTable" class="table table-bordered table-hover ledger-table">
                <thead>
                    <tr>
                        <th class="col-datetime">Date &amp; Time</th>
                        <th class="col-content">Content</th>
                        <th class="col-amount">Opening Balance</th>
                        <th class="col-amount">In (Receipt)</th>
                        <th class="col-amount">Out (Expense)</th>
                        <th class="col-closing">Closing Balance</th>
                    </tr>
                </thead>
                <tbody>

                    <%
                    double runningBalance = openingBalance;
                    double totalIn  = 0;
                    double totalOut = 0;

                    for (int i = 1; i < ledgerData.size(); i++) {
                        Vector row = (Vector) ledgerData.get(i);
                        String entryDateTime = row.get(0).toString();
                        String content       = row.get(1).toString();
                        double amount        = (Double) row.get(2);
                        int isReceipt        = (Integer) row.get(3);

                        double rowOpeningBalance = runningBalance;
                        String inAmt  = "";
                        String outAmt = "";

                        if (isReceipt == 1) {
                            inAmt = df.format(amount);
                            runningBalance += amount;
                            totalIn += amount;
                        } else {
                            outAmt = df.format(amount);
                            runningBalance -= amount;
                            totalOut += amount;
                        }
                    %>
                    <tr>
                        <td class="col-datetime"><%=entryDateTime%></td>
                        <td class="col-content"><%=content%></td>
                        <td class="col-amount text-end"><%=df.format(rowOpeningBalance)%></td>
                        <td class="col-amount text-end <%=isReceipt==1 ? "text-in" : ""%>"><%=inAmt.isEmpty() ? "-" : inAmt%></td>
                        <td class="col-amount text-end <%=isReceipt==0 ? "text-out" : ""%>"><%=outAmt.isEmpty() ? "-" : outAmt%></td>
                        <td class="col-closing text-end"><%=df.format(runningBalance)%></td>
                    </tr>
                    <% } %>

                    <!-- Totals Row -->
                    <tr class="closing-row">
                        <td colspan="3" class="text-end">Total</td>
                        <td class="col-amount text-end text-in"><%=df.format(totalIn)%></td>
                        <td class="col-amount text-end text-out"><%=df.format(totalOut)%></td>
                        <td class="col-closing text-end"><%=df.format(runningBalance)%></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <% if (ledgerData.size() <= 1) { %>
        <div class="alert alert-info mt-3">No ledger entries found for the selected date range.</div>
        <% } %>
    </div>

<script>
(function(){
    const contextPath = '<%=request.getContextPath()%>';
    const year = new Date().getFullYear();
    $.get(contextPath + '/cloud/getReport2Data.jsp', {year: year}, function(data) {
        const el = document.getElementById('cloudBalVal');
        if (!data || data.length === 0) { el.textContent = '\u20b90'; return; }
        const total = data
            .filter(r => r.cloudAmount === 0 && r.clientPaid > 0)
            .reduce((s, r) => s + r.clientPaid, 0);
        el.textContent = '\u20b9' + total.toLocaleString('en-IN', {minimumFractionDigits:0, maximumFractionDigits:2});
    }, 'json').fail(function(){ document.getElementById('cloudBalVal').textContent = '\u20b9–'; });
})();
</script>
</body>
</html>
