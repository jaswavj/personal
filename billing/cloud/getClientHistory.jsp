<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="bean" class="billing.billingBean" scope="page" />
<%
    response.setContentType("application/json");
    Integer uid = (Integer) session.getAttribute("userId");
    if (uid == null) { out.print("{}"); return; }
    String billIdStr = request.getParameter("billId");
    if (billIdStr == null) { out.print("{}"); return; }
    try {
        int billId = Integer.parseInt(billIdStr);
        out.print(bean.getClientHistory(billId));
    } catch (Exception e) {
        e.printStackTrace();
        out.print("{\"error\":\"" + e.getMessage().replace("\"","'") + "\"}");
    }
%>
