<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<jsp:useBean id="bill" class="billing.billingBean" />
<jsp:useBean id="prod" class="product.productBean" />
<%
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}

String fromDate = request.getParameter("fromDate");
String toDate   = request.getParameter("toDate");
String districtIdStr = request.getParameter("districtId");
int districtId = 0;
if (districtIdStr != null && districtIdStr.matches("\\d+")) {
    districtId = Integer.parseInt(districtIdStr);
}

if (fromDate == null || fromDate.isEmpty() || toDate == null || toDate.isEmpty()) {
    response.sendRedirect(request.getContextPath() + "/reports/clientList/page.jsp");
    return;
}

String districtLabel = "All Districts";
if (districtId > 0) {
    Vector districtList = prod.getActiveDistrictList();
    for (int i = 0; i < districtList.size(); i++) {
        Vector dist = (Vector) districtList.get(i);
        if (Integer.parseInt(dist.elementAt(0).toString()) == districtId) {
            districtLabel = dist.elementAt(1).toString();
            break;
        }
    }
}

Vector clientData = bill.getClientListReport(fromDate, toDate, districtId);
DecimalFormat df = new DecimalFormat("#,##0.00");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Client List Report</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        body { background: #f5f7fa; }
        .client-table thead tr {
            background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
        }
        .client-table thead th {
            font-size: 0.82rem;
            font-weight: 600;
            color: #ffffff !important;
            padding: 0.55rem 0.75rem;
            border-color: #3a5fc8;
            white-space: nowrap;
        }
        .client-table td {
            font-size: 0.83rem;
            vertical-align: middle;
            padding: 0.42rem 0.75rem;
        }
        .client-table tbody tr:hover { background: #eef2ff; cursor: pointer; }
        .total-row td { background: #ebf8f0; font-weight: 700; }
        @media print {
            .no-print { display: none !important; }
            body { background: #fff; }
            .client-table thead tr { background: #4e73df !important; -webkit-print-color-adjust: exact; }
        }
    </style>
</head>
<body>
    <%@ include file="/assets/navbar/navbar.jsp" %>

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-3 no-print">
            <h5 class="mb-0">
                <i class="fas fa-user-plus me-2"></i>Client List Report
                <small class="text-muted ms-2" style="font-size:0.85rem;"><%=fromDate%> to <%=toDate%></small>
                <small class="text-muted ms-1" style="font-size:0.85rem;">| <%=districtLabel%></small>
            </h5>
            <div class="d-flex gap-2">
                <a href="<%=contextPath%>/reports/clientList/page.jsp" class="btn btn-secondary btn-sm">
                    <i class="fas fa-arrow-left me-1"></i>Back
                </a>
                <button class="btn btn-primary btn-sm" onclick="printReport()">
                    <i class="fas fa-print me-1"></i>Print
                </button>
                <button class="btn btn-success btn-sm" onclick="exportTableToExcel('clientTable','Client_List_Report')">
                    <i class="fas fa-file-excel me-1"></i>Excel
                </button>
            </div>
        </div>

        <div class="table-responsive">
            <table id="clientTable" class="table table-bordered table-hover client-table">
                <thead>
                    <tr>
                        <th style="width:50px;">S.No</th>
                        <th style="width:100px;">Date</th>
                        <th>Client Name</th>
                        <th style="width:120px;">District</th>
                        <th style="width:130px;">Phone Number</th>
                        <th style="width:110px; text-align:right;">Payable (&#8377;)</th>
                        <th>Bill Description</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    double grandPayable = 0;
                    for (int i = 0; i < clientData.size(); i++) {
                        Vector row = (Vector) clientData.get(i);
                        String date        = row.get(0) != null ? row.get(0).toString() : "";
                        String cusName     = row.get(1) != null ? row.get(1).toString() : "";
                        String cusPhn      = row.get(2) != null ? row.get(2).toString() : "";
                        double payable     = (Double) row.get(3);
                        String billDesc    = row.get(4).toString();
                        String cusDesc     = row.get(5).toString();
                        String district    = row.get(6) != null ? row.get(6).toString() : "-";
                        grandPayable      += payable;
                    %>
                    <tr onclick="showCusDesc(this)" data-cusdesc="<%=cusDesc.replace("\"", "&quot;")%>" data-cusname="<%=cusName.replace("\"", "&quot;")%>">
                        <td class="text-center"><%=i + 1%></td>
                        <td><%=date%></td>
                        <td><%=cusName%></td>
                        <td><%=district%></td>
                        <td><%=cusPhn%></td>
                        <td class="text-end"><%=df.format(payable)%></td>
                        <td><%=billDesc%></td>
                    </tr>
                    <% } %>

                    <% if (clientData.isEmpty()) { %>
                    <tr>
                        <td colspan="7" class="text-center text-muted py-4">
                            No new clients found for the selected date range.
                        </td>
                    </tr>
                    <% } else { %>
                    <tr class="total-row">
                        <td colspan="5" class="text-end">Grand Total</td>
                        <td class="text-end"><%=df.format(grandPayable)%></td>
                        <td></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

<script>
function printReport() {
    var printArea = document.createElement('div');
    printArea.id = 'printArea';
    fetch('<%=contextPath%>/printHeader.jsp')
        .then(response => response.text())
        .then(headerHtml => {
            printArea.innerHTML = headerHtml;
            var tableContainer = document.querySelector('.container');
            var tableClone = tableContainer.cloneNode(true);
            var noprint = tableClone.querySelector('.no-print');
            if (noprint) noprint.remove();
            printArea.appendChild(tableClone);
            document.body.appendChild(printArea);
            window.print();
            document.body.removeChild(printArea);
        })
        .catch(() => window.print());
}

function exportTableToExcel(tableID, filename) {
    var table = document.getElementById(tableID);
    if (!table) { alert('Table not found!'); return; }
    var html = '<html xmlns:x="urn:schemas-microsoft-com:office:excel"><head><meta charset="UTF-8">' +
               '<style>table{border-collapse:collapse;}td,th{border:1px solid black;padding:5px;}</style>' +
               '</head><body><table border="1">' + table.innerHTML + '</table></body></html>';
    var blob = new Blob(['\ufeff', html], { type: 'application/vnd.ms-excel' });
    var a = document.createElement('a');
    a.href = URL.createObjectURL(blob);
    a.download = (filename || 'report') + '.xls';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
}

function showCusDesc(row) {
    var name = row.getAttribute('data-cusname') || '-';
    var desc = row.getAttribute('data-cusdesc') || '';
    document.getElementById('cusDescModalLabel').textContent = name;
    document.getElementById('cusDescModalBody').textContent = desc || '(No description available)';
    new bootstrap.Modal(document.getElementById('cusDescModal')).show();
}
</script>

<!-- Customer Description Modal -->
<div class="modal fade" id="cusDescModal" tabindex="-1" aria-labelledby="cusDescModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header" style="background: linear-gradient(135deg, #4e73df, #224abe); color:#fff;">
        <h6 class="modal-title" id="cusDescModalLabel"></h6>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="cusDescModalBody" style="white-space:pre-wrap; font-size:0.9rem;"></div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>
