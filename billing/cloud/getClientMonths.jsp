<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="bean" class="billing.billingBean" scope="page" />
<%
    response.setContentType("application/json");
    Integer uid = (Integer) session.getAttribute("userId");
    if (uid == null) { out.print("{}"); return; }
    String billIdStr = request.getParameter("billId");
    String yearStr   = request.getParameter("year");
    if (billIdStr == null || yearStr == null) { out.print("{}"); return; }
    try {
        int billId = Integer.parseInt(billIdStr);
        int year   = Integer.parseInt(yearStr);
        out.print(bean.getClientMonths(billId, year));
    } catch (Exception e) {
        e.printStackTrace();
        out.print("{\"error\":\"" + e.getMessage().replace("\"","'") + "\"}");
    }
%>
