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
<title>Customer Ranking</title>
</head>
<body class="bgstyle"
	background="${pageContext.request.contextPath}//Back2.jpg">
	<table width="800px" border=0 align="center">
		<tr>
			<td align="right"><a href="adminwall.jsp"
				style="color: #000000;">Admin Home</a></td>
		</tr>
	</table>
	<br />
	<br />
	<br />
	<br />
	<br />
	<h3 align="center">Customer Ranking based on banking activity</h3>
	
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
					<a><b>District</b></a>
				</div></td>
			<td width="15"><div align="center">
					<a><b>Transactions</b></a>
				</div></td>
		</tr>

		<%
			int rownum = 1;
				int accountid = 0;
				int transcount = 0;
				String dist = "";
				try {
					Class.forName("oracle.jdbc.OracleDriver");

					String URL = "jdbc:oracle:thin:@//oracle.cise.ufl.edu:1521/orcl";
					String username = "rpoloju";
					String password = "cop5725#";

					Connection connection = null;
					Statement st = null;
					ResultSet rs = null;
					connection = DriverManager.getConnection(URL, username, password);
					
					String sqlrank = "select t1.*, t2.district_name from ( " + " select t.* from ( "
						+ " select account_id, count(*) as \"countoftrans\" from transactions where account_id in ( "
						+ " select distinct account_id from transactions) " + " group by account_id)t "
						+ " order by t.\"countoftrans\" desc )t1, "
						+ " (select d.district_name, acc.account_id from district d join account acc on acc.district_id = d.district_id)t2 "
						+ "where t2.account_id = t1.account_id and rownum < 11";

				st = connection.createStatement();
				rs = st.executeQuery(sqlrank);
				while (rs.next()) {
					accountid = rs.getInt(1);

					transcount = rs.getInt(2);

					dist = rs.getString(3);

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
					<a><%=dist%></a>
				</div></td>
			<td width="15"><div align="center">
					<a><%=transcount%></a>
				</div></td>
		</tr>

		<%
			rownum++;

					}
					if (connection != null)
						connection.close();
				} catch (Exception e) {
					out.println("Unable to fetch ranking records");
					e.printStackTrace();
				}
		%>
	</table>
</body>
</html>