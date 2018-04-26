<%@ page import="java.sql.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
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
<title>Transfer funds</title>
</head>
<body class="bgstyle"
	background="${pageContext.request.contextPath}//Back2.jpg">
	<!-- <h1 class="myclass" align="center">Welcome to GatorBank</h1> -->
	<form name="transferPage" action="redirecttransferPage.jsp"
		method="POST" onsubmit="return validTransfer();">
		<table width="800px" border=0 align="center">
			<tr>
				<td align="right"><a href="homepage.jsp"
					style="color: #000000;">Account Home</a></td>
			</tr>
		</table>
		<br />
		<%
			Map<String, String> banks = new HashMap<>();
			String user = "";
			if (session.getAttribute("userid") != null) {
				user = session.getAttribute("userid").toString();
			}
			/*
				MN-JPMorgan Chase
				UV-Bank of America
				OP-Wells Fargo
				YZ-Citi
				CD-Goldman Sachs
				KL-Morgan Stanley
				IJ-U.S. Bancorp
				WX-PNC Financial Services
				EF-Bank of New York Mellon
				QR-Capital One
				ST-State Street
				GH-SunTrust Banks
				AB-HSBC USA
			*/
			banks.put("MN", "JPMorgan Chase");
			banks.put("UV", "Bank of America");
			banks.put("OP", "Wells Fargo");
			banks.put("YZ", "Citi");
			banks.put("CD", "Goldman Sachs");
			banks.put("KL", "Morgan Stanley");
			banks.put("IJ", "U.S. Bancorp");
			banks.put("WX", "PNC Financial Services");
			banks.put("EF", "Bank of New York Mellon");
			banks.put("QR", "Capital One");
			banks.put("ST", "State Street");
			banks.put("GH", "SunTrust Banks");
			banks.put("AB", "HSBC USA");
			String bal = "0.0";
			try {
				Class.forName("oracle.jdbc.OracleDriver");

				String URL = "jdbc:oracle:thin:@//oracle.cise.ufl.edu:1521/orcl";
				String username = "rpoloju";
				String password = "cop5725#";

				Connection connection = null;
				Statement st = null;
				ResultSet rs = null;

				connection = DriverManager.getConnection(URL, username, password);
				String sqlBal = "select balance from transactions where account_id = " + user
						+ "and date_of_trans = (select max(date_of_trans) from transactions where account_id =" + user
						+ ") order by transaction_id desc";
				st = connection.createStatement();
				rs = st.executeQuery(sqlBal);
				if (rs.next()) {
					bal = Float.toString(rs.getFloat(1));
				}
				if (connection != null)
					connection.close();
			} catch (Exception e) {
				out.println("Transfer page is temporarily down. Please refresh!");
				e.printStackTrace();
			}
		%>
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<table border="0" align="center">
			<tbody>
				<tr>
					<td>Transfer to</td>
					<td><input type="text" name="transferto" value="" size="20"></td>
				</tr>
				<tr>
					<td>Amount</td>
					<td><input type="text" name="transferAmount" value=""
						size="20"></td>
					<td><a>Balance : <%=bal%></a></td>
				</tr>
				<tr>
					<td>Bank :</td>
					<td><select name="bankTo">
							<option>GatorBank</option>
							<%
								for (Map.Entry<String, String> entry : banks.entrySet()) {
							%>
							<option><%=entry.getKey() + " - " + entry.getValue()%></option>

							<%
								}
							%>

					</select></td>
				</tr>
				<tr>
					<td><input type="submit" value="Transfer" name="transferFunds"></td>
					<td><input type="reset" value="Clear" name="clear"></td>
				</tr>
			</tbody>
		</table>
	</form>
</body>
</html>