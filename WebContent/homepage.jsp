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

.bgstyle {
	background: url(Back2.jpg) no-repeat center center fixed;
	background-size: cover;
}
</style>
<title>Your Account home</title>
</head>
<body class="bgstyle"
	background="${pageContext.request.contextPath}//Back2.jpg">
	<!-- <h1 class="myclass" align="center">Welcome to GatorBank</h1> -->
	<br />

	<%
		if (session.getAttribute("userid") != null) {
			String user = session.getAttribute("userid").toString();
	%>

	<h3>
		Your online id is:
		<%=user%></h3>
	<%
		int dateOfTrans = 0;
			float accountBalance = 0;
			try {
				Class.forName("oracle.jdbc.OracleDriver");

				String URL = "jdbc:oracle:thin:@//oracle.cise.ufl.edu:1521/orcl";
				String username = "rpoloju";
				String password = "cop5725#";

				Connection connection = null;
				Statement st = null;
				ResultSet rs = null;

				connection = DriverManager.getConnection(URL, username, password);
				String balance = "select date_of_trans, balance from transactions where account_id = " + user
						+ "and date_of_trans = (select max(date_of_trans) from transactions where account_id ="
						+ user + ") order by transaction_id desc";
				st = connection.createStatement();
				rs = st.executeQuery(balance);
				if (rs.next()) {
					dateOfTrans = rs.getInt(1);
					accountBalance = rs.getFloat(2);
				}
				if (connection != null)
					connection.close();
			} catch (Exception e) {
				out.println("Customer homepage is temporarily down. Please refresh!");
				e.printStackTrace();
			}
	%>
	<%
		if (dateOfTrans != 0) {
	%>
	<h3>
		Last transaction is made on:
		<%
		String lastDate = Integer.toString(dateOfTrans);
			String day = Character.toString(lastDate.charAt(6)) + Character.toString(lastDate.charAt(7));
			String month = Character.toString(lastDate.charAt(4)) + Character.toString(lastDate.charAt(5));
			String year = Character.toString(lastDate.charAt(0)) + Character.toString(lastDate.charAt(1))
					+ Character.toString(lastDate.charAt(2)) + Character.toString(lastDate.charAt(3));
	%>
		<%=month + "-" + day + "-" + year%></h3>
	<%} else { %>
	<h3>No transactions for this account.</h3>
	<%} %>
	<br />
	<br />
	<br />
	<table border="0" align="center">
		<tbody>
			<tr>
				<td>Available Balance : <%=accountBalance%></td>
			</tr>
		</tbody>
	</table>
	<table width="400" border="2" align="center" cellpadding="2"
		cellspacing="2">
		<tr>
			<td><div align="center">
					<a href="ministatement.jsp">Mini Statement</a>
				</div></td>
			<td><div align="center">
					<a href="statementDatesPage.jsp">Detailed Statement</a>
				</div></td>
			<td><div align="center">
					<a href="transferfunds.jsp">Transfer funds</a>
				</div></td>
			<td><div align="center">
					<a href="statistics.jsp">Statistics</a>
				</div></td>
			<td><div align="center">
					<a href="index.jsp">Logout</a>
				</div></td>
		</tr>
	</table>
	<%
		}
	%>

</body>
</html>