<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.util.Calendar" %>
<%
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}
String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
Calendar cal = Calendar.getInstance();
cal.set(Calendar.DAY_OF_MONTH, 1);
String firstDayOfMonth = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ledger Report - Billing App</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="/assets/common/head.jsp" %>
    <style>
        body { background: #f5f7fa; }
    </style>
</head>
<body>
    <%@ include file="/assets/navbar/navbar.jsp" %>

    <div class="container mt-4" style="max-width: 600px;">
        <h4 class="mb-4"><i class="fas fa-book me-2"></i>Ledger Report</h4>

        <div class="card shadow-sm">
            <div class="card-body">
                <form action="<%=contextPath%>/reports/ledger/page0.jsp" method="get" class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">From Date</label>
                        <input type="date" name="fromDate" class="form-control" value="<%=firstDayOfMonth%>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">To Date</label>
                        <input type="date" name="toDate" class="form-control" value="<%=today%>" required>
                    </div>
                    <div class="col-12 d-flex gap-2 justify-content-end">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search me-1"></i>Generate Report
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
