<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style type="text/css">
.myclass {
	background-color: #aaa;
	padding: 10px;
}
</style>
<title>Detailed Statement</title>
</head>
<body>

	<h1 class="myclass" align="center">Welcome to GatorBank</h1>
	<table width="800px" border=0 align="center">
		<tr>
			<td align="right"><a href="homepage.jsp" style="color: #000000;">Account
					Home</a></td>
		</tr>
	</table>
	<br/>
	<br/>
	<%
		String user = "";
		String startDate = "";
		String endDate = "";
		if (session.getAttribute("userid") != null) {
			user = session.getAttribute("userid").toString();
			
			
			
	%>
	<table border="0" align="center">
			<tbody>
				<tr>
					<td>Start Date :</td>
					<td><input type="text" name="onlineid" value="" size="20"></td>
					<td>End Date :</td>
					<td><input type="password" name="passcode" value="" size="20"></td>
					<td><input type="submit" value="Sign in" name="signin"></td>
					<td><input type="reset" value="Cancel" name="clear"></td>
				</tr>
			</tbody>
		</table>
	
	
	
	<%
			session.setAttribute("userid", user);
			session.setAttribute("startDate", startDate);
			session.setAttribute("endDate", endDate);
			String redirectURL = "detailedstatement.jsp";
			response.sendRedirect(redirectURL);
	%>



<%} %>
</body>
</html>