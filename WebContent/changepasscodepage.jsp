<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="validations.js" type="text/javascript"></script>
<style type="text/css">
.myclass {
	background-color: #aaa;
	padding: 10px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Changed passcode</title>
</head>
<body onload="displayResult()">
	<form name = "updatepage">
	<h1 class="myclass" align="center">Welcome to GatorBank</h1>
	<table width="800px" border=0 align="center">
		<tr>
			<td align="right"><a href="index.jsp"
				style="color: #000000;">Home</a></td>
		</tr>
	</table>
	<%
	try {
		Class.forName("oracle.jdbc.OracleDriver");

		String usernameFromForm = request.getParameter("onlineid");
		String passcodeFromForm = request.getParameter("passcode1");
		String URL = "jdbc:oracle:thin:@//oracle.cise.ufl.edu:1521/orcl";
		String username = "rpoloju";
		String password = "cop5725#";

		Connection connection = null;
		Statement st = null;
		ResultSet rs = null;

		connection = DriverManager.getConnection(URL, username, password);
		String sqlUserNamePassword = "select * from USERS WHERE USER_ID = " + usernameFromForm;
		st = connection.createStatement();
		rs = st.executeQuery(sqlUserNamePassword);
		if (rs.next()) {
			String updatePasscode = "UPDATE USERS SET PASSCODE = " + passcodeFromForm + "WHERE USER_ID = " + usernameFromForm;
			int success = st.executeUpdate(updatePasscode);
			connection.commit();
			if (success > 0) {
				%>
				
				<input type = "hidden" name = "hidden" value = "<%=success %>"/>
				
				<%
			}
		} else {
			response.sendRedirect("forgotpasscode.jsp");
		}
		if (connection != null)
			connection.close();
	} catch (Exception e) {
		out.println("Update passcode failed");
		e.printStackTrace();
	}

	%>
	</form>
</body>
<script language="javascript">
	function displayResult() {
		if (document.updatepage.hidden.value > 0) {
			alert("Successfully updated");
		} else {
			alert("Please try again");
		}
	}
</script>
</html>