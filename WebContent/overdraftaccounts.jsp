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
img {
	display: block;
	margin-left: auto;
	margin-right: auto;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Over draft accounts</title>
</head>
<body>
<body>
<img align="middle"
		src="${pageContext.request.contextPath}//statement.JPG" />

	<table width="800px" border=0 align="center">
		<tr>
			<td align="right"><a href="adminwall.jsp"
				style="color: #000000;">Admin Home</a></td>
		</tr>
	</table>
	<h3 align="center">Accounts with current balance less than 300</h3>

	<table width="500" border="2" align="center" cellpadding="2"
		cellspacing="2">
		<tr>
			<td width="20"><div align="center">
					<a><b>S.no</b></a>
				</div></td>
			<td width="20"><div align="center">
					<a><b>Account ID</b></a>
				</div></td>
			<td width="90"><div align="center">
					<a><b>Last date of Trans</b></a>
				</div></td>
			<td width="20"><div align="center">
					<a><b>Balance</b></a>
				</div></td>
		</tr>

		<%
			int rownum = 1;
				int accountid = 0;
				int transDate = 0;
				float balance = 0;
				try {
					Class.forName("oracle.jdbc.OracleDriver");

					String URL = "jdbc:oracle:thin:@//oracle.cise.ufl.edu:1521/orcl";
					String username = "rpoloju";
					String password = "cop5725#";

					Connection connection = null;
					Statement st = null;
					ResultSet rs = null;
					connection = DriverManager.getConnection(URL, username, password);
					String sqloverdraft = "SELECT t1.account_id, t1.DATE_OF_TRANS, t1.BALANCE "
							+ "FROM transactions t1 " + "LEFT OUTER JOIN transactions t2 "
							+ "ON (t1.account_id = t2.account_id AND t1.transaction_id < t2.transaction_id) "
							+ "WHERE t2.account_id IS NULL and t1.balance < 300 order by t1.account_id desc";

					st = connection.createStatement();
					rs = st.executeQuery(sqloverdraft);
					while (rs.next()) {
						accountid = rs.getInt(1);

						//Get transaction date in the required format
						transDate = rs.getInt(2);
						String tDate = Integer.toString(transDate);
						tDate = tDate.substring(4, 6) + "-" + tDate.substring(6, 8) + "-" + tDate.substring(0, 4);

						balance = rs.getFloat(3);

						//Display the values in table
		%>

		<tr>
			<td width="20"><div align="center">
					<a><%=rownum%></a>
				</div></td>
			<td width="20"><div align="center">
					<a><%=accountid%></a>
				</div></td>
			<td width="90"><div align="center">
					<a><%=tDate%></a>
				</div></td>
			<td width="20"><div align="right">
					<a><%=balance%></a>
				</div></td>
		</tr>

		<%
			rownum++;

					}
					if (connection != null)
						connection.close();
				} catch (Exception e) {
					out.println("Unable to fetch over draft records");
					e.printStackTrace();
				}
		%>
	</table>


</body>
</html>