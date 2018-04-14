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
<title>Forgot passcode</title>
</head>
<body class="bgstyle" background="${pageContext.request.contextPath}//Back2.jpg" >
	<form name="changepasscode" action="changepasscodepage.jsp" method="POST" onsubmit="return forgotpasscodecheck();">
	<!-- <h1 class="myclass" align="center">Welcome to GatorBank</h1> -->
	<table width="800px" border=0 align="center">
		<tr>
			<td align="right"><a href="index.jsp"
				style="color: #000000;">Home</a></td>
		</tr>
	</table>
	<br/><br/><br/><br/><br/><br/><br/>
	<table border="0" align="center">
			<tbody>
				<tr>
					<td>Online id :</td>
					<td><input type="text" name="onlineid" value="" size="20"></td>
				</tr>
				<tr>
					<td>New PassCode :</td>
					<td><input type="password" name="passcode1" value="" size="20"></td>
				</tr>
				<tr>
					<td><input type="submit" value="Update" name="updatePassCode"></td>
					<td><input type="reset" value="Clear" name="clear"></td>
				</tr>
			</tbody>
		</table>
	</form>
</body>
</html>