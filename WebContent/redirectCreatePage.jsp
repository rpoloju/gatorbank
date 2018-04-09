<%@ page import="java.sql.*"%>
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
<title>New Account</title>
</head>
<body>

	<h1 class="myclass" align="center">Welcome to GatorBank</h1>
	<table width="800px" border=0 align="center">
		<tr>
			<td align="right"><a href="index.jsp"
				style="color: #000000;">Home</a></td>
		</tr>
	</table>
	<%
	int newAccountId = 0;
	int newAccountIdDisp = 0;
	try {
		Class.forName("oracle.jdbc.OracleDriver");

		String sexFromForm = request.getParameter("sex");
		String dobFromForm = request.getParameter("dob");
		String districtFromForm = request.getParameter("district");
		String passcodeFromForm = request.getParameter("passcode");
		String dispFromForm = request.getParameter("disp");
		String URL = "jdbc:oracle:thin:@//oracle.cise.ufl.edu:1521/orcl";
		String username = "rpoloju";
		String password = "cop5725#";

		Connection connection = null;
		Statement st = null;
		ResultSet rs = null;

		connection = DriverManager.getConnection(URL, username, password);
		String sqllastAccnum = "select max(account_id) from account";
		
		st = connection.createStatement();
		rs = st.executeQuery(sqllastAccnum);
		
		if (rs.next()) {
			newAccountId = Integer.parseInt(rs.getString(1)) + 1;
		} 
		
		if (Integer.parseInt(dispFromForm) == 1) {
			newAccountIdDisp = newAccountId + 1;
		}
		
		
		
		if (connection != null)
			connection.close();
	} catch (Exception e) {
		out.println("Update passcode failed");
		e.printStackTrace();
	}

	%>
	<h3>Your account id is <%=newAccountId %></h3>
	<%if (newAccountIdDisp != 0) { %>
	<h3>Your authorized user account id is <%=newAccountIdDisp %></h3>
	<%} %>
</body>
</html>