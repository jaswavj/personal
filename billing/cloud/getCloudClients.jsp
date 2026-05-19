<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="bean" class="billing.billingBean" scope="page" />
<%
    response.setContentType("application/json");
    Integer uid = (Integer) session.getAttribute("userId");
    if (uid == null) { out.print("[]"); return; }
    try {
        out.print(bean.getCloudClients());
    } catch (Exception e) {
        e.printStackTrace();
        out.print("[]");
    }
%>
