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
<title>Insert title here</title>
</head>
<body class="bgstyle"
	background="${pageContext.request.contextPath}//Back2.jpg">
	<table width="800px" border=0 align="center">
		<tr>
			<td align="right"><a href="homepage.jsp" style="color: #000000;">Account
					Home</a></td>
		</tr>
	</table>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />

	<%
		int status = 0;
		if (session.getAttribute("status") != null) {
			status = Integer.parseInt(session.getAttribute("status").toString());
		}
	%>

	<%if (status > 0) { %>
	<h3 align="center">Transfer Successful. Press on the home button to continue.</h3>
	<%} else { %>
	<h3 align="center">Transfer Failed. Press on the home button to continue.</h3>
	<%} %>
</body>
</html>