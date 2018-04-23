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
.bgstyle {
        background: url(Back2.jpg) no-repeat center center fixed;
        background-size: cover;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Changed passcode</title>
</head>
<body  class="bgstyle" background="${pageContext.request.contextPath}//Back2.jpg" onload="displayResult()">
	<form name = "updatepage">
	<!-- <h1 class="myclass" align="center">Welcome to GatorBank</h1> -->
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
		String dobFromForm = request.getParameter("dob");
		int success = 0;
		int dobtocheck = 0;
		boolean toBeProcessed = false;
		
		String URL = "jdbc:oracle:thin:@//oracle.cise.ufl.edu:1521/orcl";
		String username = "rpoloju";
		String password = "cop5725#";

		Connection connection = null;
		Statement st = null;
		ResultSet rs = null;

		connection = DriverManager.getConnection(URL, username, password);
		st = connection.createStatement();
		
		String userSearch = "select dob from client c join disposition d on c.CLIENT_ID = d.CLIENT_ID and d.ACCOUNT_ID = " + usernameFromForm;
		rs = st.executeQuery(userSearch);
		if (rs.next()) {
			//dobFromdb contains date of format yyyymmdd
			int dobFromdb = rs.getInt(1);
			//If female, month is mm + 50, so adjusting accordingly
			if (dobFromdb % 10000 > 1231) {
				dobFromdb -= 5000;
			}
			
			//Converting the string to mmddyyyy to compare it against form value
			String dobFromdbSt = Integer.toString(dobFromdb);
			dobFromdbSt = dobFromdbSt.substring(4, 6) + "" + dobFromdbSt.substring(6, 8) + ""
					+ dobFromdbSt.substring(0, 4);
			dobFromdb = Integer.parseInt(dobFromdbSt);
			
			//This is dob from form which is already in mmddyyyy format
			dobtocheck = Integer.parseInt(dobFromForm);
			
			if (dobtocheck == dobFromdb) {
				toBeProcessed = true;
			}
		}
		
		if (toBeProcessed) {
			String updatePasscode = "UPDATE USERS SET PASSCODE = " + passcodeFromForm + "WHERE USER_ID = " + usernameFromForm;
			success = st.executeUpdate(updatePasscode);
			connection.commit();
			%>
			
			<input type = "hidden" name = "hidden" value = "<%=success %>"/>
			
			<%
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