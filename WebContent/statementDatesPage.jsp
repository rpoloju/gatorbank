<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="validations.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style type="text/css">
.myclass {
	background-color: #aaa;
	padding: 10px;
}
.bgstyle {
        background: url(Back2.jpg) no-repeat center center fixed;
        background-size: cover;
}
</style>
<title>Detailed Statement</title>
</head>
<body class="bgstyle" background="${pageContext.request.contextPath}//Back2.jpg" >
	<!-- <h1 class="myclass" align="center">Welcome to GatorBank</h1> -->
	<form name="statementDates" action="detailedstatement.jsp" 
	method="POST" onsubmit="return validstDates();">
	<table width="800px" border=0 align="center">
		<tr>
			<td align="right"><a href="homepage.jsp" style="color: #000000;">Account
					Home</a></td>
		</tr>
	</table>
	<br/>
	<%
	String user = "";
	if (session.getAttribute("userid") != null) {
		user = session.getAttribute("userid").toString();
	}
	%>
	<br/><br/><br/><br/><br/>
	<table border="0" align="center">
			<tbody>
				<tr>
					<td width = "25" align="center">Start Date : (mmddyyyy)</td>
					<td><input type="text" name="startDate" value="" size="20"></td>
					<td width = "25" align="center">End Date : (mmddyyyy)</td>
					<td ><input type="text" name="endDate" value="" size="20"></td>
					<td><input type="submit" value="Get Statement" name="getStatement"></td>
					<td><input type="reset" value="Clear" name="clear"></td>
				</tr>
			</tbody>
	</table>
	</form>
</body>
</html>