<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import= "java.util.*"%>
<%
// Prevent caching
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<jsp:useBean id="user" class="user.userBean" />
<%
    Integer uids = (Integer) session.getAttribute("userId");
    
    // Check if user is logged in
    if (uids == null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
    
    String contextPath = request.getContextPath();
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BILLING APP</title>
    <script src="../dist/js/jquery-3.6.0.min.js"></script>
</head>
<body>
    
<iframe 
                    src="billing.jsp" 
                    width="100%" 
                    height="100%" 
                    frameborder="0"
                    style="margin:0; padding:0; display:block; height: calc(107vh - 60px);">
                </iframe>
    
    <br><br><br><br><br><br><br>
</body>
</html>