<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
.bgstyle {
	background: url(Back2.jpg) no-repeat center center fixed;
	background-size: cover;
}
</style>
<title>Admin</title>
</head>
<body class="bgstyle"
	background="${pageContext.request.contextPath}//Back2.jpg">

	<table width="800px" border=0 align="center">
		<tr>
			<td align="right"><a href="index.jsp" style="color: #000000;">Home</a></td>
		</tr>
	</table>

	<%
		if (request.getParameter("adminid") == null || request.getParameter("adminpasscode") == null) {
			%>
	<h3 align="center">Login Failed.</h3>
	<%
		} else {
			String adminuser = request.getParameter("adminid").toString();
			String adminpasscode = request.getParameter("adminpasscode").toString();
			if (adminuser.trim().equals("admin") && adminpasscode.trim().equals("admin")) {
				
				String redirectURL = "adminwall.jsp";
				response.sendRedirect(redirectURL);
			} else {
				String redirectURL = "adminlogin.jsp";
				response.sendRedirect(redirectURL);
			}
	%>
	<%} %>
</body>
</html>