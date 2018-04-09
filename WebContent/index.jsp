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
</style>

<style>
.tooltip {
	position: relative;
	display: inline-block;
	border-bottom: 1px dotted black;
}

.tooltip .tooltiptext {
	visibility: hidden;
	width: 800px;
	background-color: gray;
	color: #ccc;
	text-align: left;
	border-radius: 10px;
	padding: 10px 10px;
	/* Position the tooltip */
	position: absolute;
	z-index: 1;
}

.tooltip:hover .tooltiptext {
	visibility: visible;
}
</style>
<title>Welcome to GatorBank</title>

</head>
<body>
	<h1 class="myclass" align="center">Welcome to GatorBank</h1>
	<div class="tooltip" align="right">
		About us <span class="tooltiptext"> GatorBank is an online
			banking system that provides facilities to customers such as opening
			an account, making transactions such as depositing funds, withdrawal,
			transferring funds to a different account, generating account
			statements, enrolling to credit cards, viewing/changing account
			information etc. The system also provides security to their accounts
			with authentication facility. </span>
	</div>
	<form name="welcomepage" action="redirectWelcomePage.jsp" method="POST" onsubmit = "return validLogin();">
		<table border="0" align="center">
			<tbody>
				<tr>
					<td>Online id :</td>
					<td><input type="text" name="onlineid" value="" size="20"></td>
				</tr>
				<tr>
					<td>PassCode :</td>
					<td><input type="password" name="passcode" value="" size="20"></td>
					<td><input type="submit" value="Sign in" name="signin"></td>
					<td><input type="reset" value="Cancel" name="clear"></td>
				</tr>
			</tbody>
		</table>
		<br />
		<table width="400" border="2" align="center" cellpadding="2"
			cellspacing="2">
			<tr>
				<td><div align="center">
						<a href="forgotpasscode.jsp">Forgot PassCode</a>
					</div></td>
				<td><div align="center">
						<a href="openanaccount.jsp">Open an account</a>
					</div></td>
				<td><div align="center">
						<a href="adminlogin.jsp">Admin Login</a>
					</div></td>
			</tr>
		</table>
	</form>
</body>
</html>