<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, org.json.*" %>
<jsp:useBean id="prod" class="product.productBean" />
<%
    request.setCharacterEncoding("UTF-8");
    String term = request.getParameter("term");
    if (term == null) term = request.getParameter("q");
    if (term == null) term = "";

    JSONArray results = new JSONArray();
    try {
        Vector districts = prod.searchDistricts(term);
        for (int i = 0; i < districts.size(); i++) {
            results.put(districts.elementAt(i).toString());
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    out.print(results.toString());
%>
