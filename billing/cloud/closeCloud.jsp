<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="bean" class="billing.billingBean" scope="page" />
<%
    response.setContentType("application/json");
    Integer uid = (Integer) session.getAttribute("userId");
    if (uid == null) { out.print("{\"success\":false,\"msg\":\"Session expired\"}"); return; }
    try {
        int billId = Integer.parseInt(request.getParameter("billId"));
        bean.closeCloud(billId);
        out.print("{\"success\":true}");
    } catch (Exception e) {
        out.print("{\"success\":false,\"msg\":\"" + e.getMessage().replace("\"","'") + "\"}");
    }
%>
