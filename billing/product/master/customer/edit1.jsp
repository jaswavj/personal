<%@page language="java" import="java.util.*" %>
<jsp:useBean id="prod" class="product.productBean" />

<%
String contextPath = request.getContextPath();
	String custName = request.getParameter("custName");
	String custPhn = request.getParameter("custPhn");
	String custAddress = request.getParameter("custAddress");
	String districtName = request.getParameter("districtName");
	int id = Integer.parseInt(request.getParameter("customerId"));
	String block = request.getParameter("block");
	
	if (custAddress == null) custAddress = "";
	if (custPhn == null) custPhn = "";
	if (districtName == null) districtName = "";
	
	if(block != null)
	{
		prod.blockCustomer(id);
		response.sendRedirect(request.getContextPath() + "/product/master/customer/page.jsp?msg=Customer+blocked+successfully&type=success");
	}
	else{
		try
			{	
			int custId	= prod.checkTheCustomerNameExist(custName, id);
			if (custId != 0) 
			{
				response.sendRedirect(request.getContextPath() + "/product/master/customer/page.jsp?msg=Customer+name+already+exists&type=warning");
				return;
			}
			else
			{
				int districtId = prod.resolveDistrictId(districtName);
				prod.editCustomer(id, custName, custPhn, custAddress, "", 0, 0, districtId);
				response.sendRedirect(request.getContextPath() + "/product/master/customer/page.jsp?msg=Customer+updated+successfully&type=success");
			}
		}
		catch (Exception e)
		{
			response.sendRedirect(request.getContextPath() + "/product/master/customer/page.jsp?msg=Error+occurred+while+updating+customer&type=danger");
			return;
		} 			 
	}
%>
