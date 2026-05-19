<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="bean" class="billing.billingBean" scope="page" />
<%
    response.setContentType("application/json");
    Integer uid = (Integer) session.getAttribute("userId");
    if (uid == null) { out.print("{}"); return; }
    int year = 2026;
    try { year = Integer.parseInt(request.getParameter("year")); } catch(Exception e){}
    try {
        out.print(bean.getReport2Data(year));
    } catch (Exception e) {
        e.printStackTrace();
        out.print("[]");
    }
%>
