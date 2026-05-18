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
        .ob-card {
            background: #fff;
            border: 2px solid #4e73df;
            border-radius: 8px;
            padding: 0.6rem 1.2rem;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
        }
        .ob-label { font-size: 0.85rem; color: #555; font-weight: 500; }
        .ob-value { font-size: 1.1rem; font-weight: 700; color: #224abe; }
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

        <!-- Opening Balance Card -->
        <div class="ob-card">
            <i class="fas fa-wallet" style="color:#4e73df; font-size:1.2rem;"></i>
            <span class="ob-label">Opening Balance</span>
            <span class="ob-value"><%=df.format(openingBalance)%></span>
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
</body>
</html>
