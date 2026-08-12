<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.util.Calendar, java.util.Vector" %>
<jsp:useBean id="prod" class="product.productBean" />
<%
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
}
String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
String firstDayOfMonth = "2025-01-01";
Vector districtList = prod.getActiveDistrictList();
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
    </style>
</head>
<body>
    <%@ include file="/assets/navbar/navbar.jsp" %>

    <div class="container mt-4" style="max-width: 680px;">
        <h4 class="mb-4"><i class="fas fa-user-plus me-2"></i>Client List Report</h4>

        <div class="card shadow-sm">
            <div class="card-body">
                <form action="<%=contextPath%>/reports/clientList/page0.jsp" method="get" class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">From Date</label>
                        <input type="date" name="fromDate" class="form-control" value="<%=firstDayOfMonth%>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">To Date</label>
                        <input type="date" name="toDate" class="form-control" value="<%=today%>" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label">District</label>
                        <select name="districtId" class="form-select">
                            <option value="0">All Districts</option>
                            <% for (int i = 0; i < districtList.size(); i++) {
                                Vector dist = (Vector) districtList.get(i);
                                int distId = Integer.parseInt(dist.elementAt(0).toString());
                                String distName = dist.elementAt(1).toString();
                            %>
                            <option value="<%= distId %>"><%= distName %></option>
                            <% } %>
                        </select>
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
