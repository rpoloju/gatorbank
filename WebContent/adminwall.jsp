<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
.bgstyle {
	background: url(Back2.jpg) no-repeat center center fixed;
	background-size: cover;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin page</title>
</head>
<body>
<body class="bgstyle"
	background="${pageContext.request.contextPath}//Back2.jpg">

	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<table width="500" border="2" align="center" cellpadding="2"
		cellspacing="2">
		<tr>
			<td><div align="center">
					<a href="adminstatistics.jsp">Statistics</a>
				</div></td>
			<td><div align="center">
					<a href="overdraftaccounts.jsp">Over draft accounts</a>
				</div></td>
			<td><div align="center">
					<a href="customerranking.jsp">Customer Ranking</a>
				</div></td>
			<td><div align="center">
					<a href="adminlogin.jsp">Logout</a>
				</div></td>
		</tr>
	</table>
</body>
</html>