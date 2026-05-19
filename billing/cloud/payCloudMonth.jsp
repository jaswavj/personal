<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="bean" class="billing.billingBean" scope="page" />
<%
    response.setContentType("application/json");
    Integer uid = (Integer) session.getAttribute("userId");
    if (uid == null) { out.print("{\"success\":false,\"msg\":\"Session expired\"}"); return; }
    try {
        int billId     = Integer.parseInt(request.getParameter("billId"));
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int year       = Integer.parseInt(request.getParameter("year"));
        int month      = Integer.parseInt(request.getParameter("month"));
        double amount  = Double.parseDouble(request.getParameter("amount"));
        bean.payCloudMonth(billId, customerId, year, month, amount);
        out.print("{\"success\":true}");
    } catch (Exception e) {
        out.print("{\"success\":false,\"msg\":\"" + e.getMessage().replace("\"","'") + "\"}");
    }
%>
