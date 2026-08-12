<%@page language="java" import="java.util.*" %>
<jsp:useBean id="prod" class="product.productBean" />

<%
String contextPath = request.getContextPath();
String custName = request.getParameter("custName");
String custAddress = request.getParameter("custAddress");
String custPhn  = request.getParameter("custPhn");
String districtName = request.getParameter("districtName");

if (custAddress == null) custAddress = "";
if (custPhn == null) custPhn = "";
if (districtName == null) districtName = "";

try {
    int existing = prod.checkTheCustomerNameExist(custName);

    if (existing != 0) {
        response.sendRedirect(request.getContextPath() + "/product/master/customer/page.jsp?msg=Customer+name+already+exists!&type=warning");
        return;
    }

    int districtId = prod.resolveDistrictId(districtName);
    prod.AddCustomer(custName, custAddress, custPhn, "", 0, 0, districtId);
    response.sendRedirect(request.getContextPath() + "/product/master/customer/page.jsp?msg=Customer+added+successfully!&type=success");

} catch (Exception e) {
    response.sendRedirect(
        "page.jsp?msg=Error+occurred+while+adding+customer:+"
        + java.net.URLEncoder.encode(e.getMessage(), "UTF-8")
        + "&type=danger"
    );
}
%>
