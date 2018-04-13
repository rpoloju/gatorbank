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
<title>Detailed Statement</title>
</head>
<body>

	<h1 class="myclass" align="center">Welcome to GatorBank</h1>
	<table width="800px" border=0 align="center">
		<tr>
			<td align="right"><a href="homepage.jsp" style="color: #000000;">Account
					Home</a></td>
		</tr>
	</table>
	<br/>
	<br/>
	<%
		String user = "";
		String startDate = "";
		String endDate = "";
		if (session.getAttribute("userid") != null) {
			user = session.getAttribute("userid").toString();
			startDate = request.getParameter("startDate").toString();
			endDate = request.getParameter("endDate").toString();
			
			System.out.println("Start date is " + startDate);
			System.out.println("End date is " + endDate);
	%>

	<table width="750" border="2" align="center" cellpadding="2"
		cellspacing="2">
		<tr>
			<td width="20"><div align="center">
					<a><b>S.no</b></a>
				</div></td>
			<td width="20"><div align="center">
					<a><b>Trans.ID</b></a>
				</div></td>
			<td width="90"><div align="center">
					<a><b>Date of Trans</b></a>
				</div></td>
			<td width="200"><div align="center">
					<a><b>Transaction details</b></a>
				</div></td>
			<td width="50"><div align="center">
					<a><b>Mode</b></a>
				</div></td>
			<td width="110"><div align="center">
					<a><b>Transaction Value</b></a>
				</div></td>
			<td width="75"><div align="center">
					<a><b>Balance</b></a>
				</div></td>
		</tr>

		<%
		int transactionid = 0;
		int transDate = 0;
		int stDate = 0;
		int eDate = 0;
		String type = "";
		String operation = "";
		float amount = 0;
		float balance = 0;
		int rownum = 1;
			try {
					Class.forName("oracle.jdbc.OracleDriver");

					String URL = "jdbc:oracle:thin:@//oracle.cise.ufl.edu:1521/orcl";
					String username = "rpoloju";
					String password = "cop5725#";

					//Get start and end dates in required formats
					String date1 = startDate.substring(4, 6) + "" + startDate.substring(6, 8) + "" + startDate.substring(0, 4);
					stDate = Integer.parseInt(date1);
					String date2 = endDate.substring(4, 6) + "" + endDate.substring(6, 8) + "" + endDate.substring(0, 4);
					eDate = Integer.parseInt(date2);
					
					
					Connection connection = null;
					Statement st = null;
					ResultSet rs = null;
					connection = DriverManager.getConnection(URL, username, password);
					String sqlminist = "select TRANSACTION_ID, DATE_OF_TRANS, OPERATION, TYPE_OF_TRANS, AMOUNT, BALANCE from TRANSACTIONS " +
								" where account_id = " + Integer.parseInt(user) + " and DATE_OF_TRANS < " + eDate + " and DATE_OF_TRANS > " + 
								stDate + " order by DATE_OF_TRANS desc";
					
					st = connection.createStatement();
					rs = st.executeQuery(sqlminist);
					while (rs.next()) {
						transactionid = rs.getInt(1);
						
						//Get transaction date in the required format
						transDate = rs.getInt(2);
						String tDate = Integer.toString(transDate);
						tDate = tDate.substring(4, 6) + "-" + tDate.substring(6, 8) + "-" + tDate.substring(0, 4);
					
						//Resolve Operation
						operation = rs.getString(3);
						String op = "";
						if (operation == null) {
							op = "Interest Credited";
						} else if (operation.trim().toUpperCase().equals("VYBER KARTOU")) {
							op = "Credit Card Withdrawal";
						} else if (operation.trim().toUpperCase().equals("VKLAD")) {
							op = "Credit in Cash";
						} else if (operation.trim().toUpperCase().equals("PREVOD Z UCTU")) {
							op = "Collected from another bank";
						} else if (operation.trim().toUpperCase().equals("VYBER")) {
							op = "Withdrawal in Cash";
						} else {
							op = "Remittance to another bank";
						}
						
						//Resolve the type
						type = rs.getString(4);
						String transType = "";
						if (type.trim().toUpperCase().equals("PRIJEM")) {
							transType = "Credit";
						} else {
							transType = "Debit";
						}
						
						amount = rs.getFloat(5);
						balance = rs.getFloat(6);
						
						//Display the values in table
						%>

		<tr>
			<td width="20"><div align="center">
					<a><%=rownum%></a>
				</div></td>
			<td width="20"><div align="center">
					<a><%=transactionid %></a>
				</div></td>
			<td width="90"><div align="center">
					<a><%=tDate %></a>
				</div></td>
			<td width="200"><div align="left">
					<a><%=op %></a>
				</div></td>
			<td width="50"><div align="center">
					<a><%=transType %></a>
				</div></td>
			<td width="100"><div align="center">
					<a><%=amount %></a>
				</div></td>
			<td width="75"><div align="center">
					<a><%=balance %></a>
				</div></td>
		</tr>

		<% rownum++;
						
					}
					if (connection != null)
						connection.close();
				} catch (Exception e) {
					out.println("Statement retrieval failed");
					e.printStackTrace();
				}
		%>
	</table>

	<%
		}
	%>
</body>
</html>