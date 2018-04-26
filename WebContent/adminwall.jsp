<%@ page import="java.sql.*"%>
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

	<%
		try {
			Class.forName("oracle.jdbc.OracleDriver");

			int assets = 0;
			String assetsString = "";
			
			String URL = "jdbc:oracle:thin:@//oracle.cise.ufl.edu:1521/orcl";
			String username = "rpoloju";
			String password = "cop5725#";
			Connection connection = null;
			Statement st = null;
			ResultSet rs = null;
			connection = DriverManager.getConnection(URL, username, password);
			st = connection.createStatement();
			
			String totalassets = "select sum(t1.\"bal\") from ( "
					+ " select t.account_id, balance as \"bal\" from transactions t where t.account_id in "
					+ "(select distinct account_id from transactions) and transaction_id = "
					+ " (select max(transaction_id) from transactions where account_id = t.account_id))t1";
			
			rs = st.executeQuery(totalassets);
			if (rs.next()) {
				assets = rs.getInt(1);
			}
			assetsString = Integer.toString(assets);
			assetsString = assetsString.substring(0, 3) + ", " + assetsString.substring(3, 6) + ", "
					+ assetsString.substring(6, 9);
			if (connection != null)
				connection.close();
	%>
	<h2 align="center">
		Bank Capital - $<%=assetsString %></h2>
	<%
	} catch (Exception e) {
		out.println("Admin page is temporarily down. Please refresh!");
		e.printStackTrace();
	}

	%>


	<h3 align="center">You are now logged in as admin!</h3>
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