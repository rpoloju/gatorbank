<%@ page import="java.sql.*"%>
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

.tab {
	display: inline-block;
	margin-left: 40px;
}

.bgstyle {
	background: url(Back2.jpg) no-repeat center center fixed;
	background-size: cover;
}
</style>

<style>
.tooltip {
	padding-left: 20px;
	position: relative;
	display: inline-block;
	/* border-bottom: 1px dotted black; */
}

.tooltip .tooltiptext {
	visibility: hidden;
	width: 800px;
	background-color: gray;
	color: #ccc;
	text-align: left;
	border-radius: 10px;
	padding: 10px 10px;
	/* Position the tooltip */
	position: absolute;
	z-index: 1;
}

.tooltip:hover .tooltiptext {
	visibility: visible;
}
</style>

<style>
.tooltip1 {
	padding-left: 20px;
	position: relative;
	display: inline-block;
	/* border-bottom: 1px dotted black; */
}

.tooltip1 .tooltiptext {
	visibility: hidden;
	width: 150px;
	background-color: gray;
	color: #ccc;
	text-align: left;
	border-radius: 10px;
	padding: 10px 10px;
	/* Position the tooltip */
	position: absolute;
	z-index: 1;
}

.tooltip1:hover .tooltiptext {
	visibility: visible;
}
</style>
<title>Welcome to GatorBank</title>

</head>
<body class="bgstyle"
	background="${pageContext.request.contextPath}//Back2.jpg">
	<!-- <h1 class="myclass" align="center">Welcome to GatorBank</h1> -->
	<div class="tooltip" align="right">
		<u> About GatorBank </u><span class="tooltiptext"> GatorBank is
			an online banking system that provides facilities to customers such
			as opening an account, making transactions such as depositing funds,
			withdrawal, transferring funds to a different account, generating
			account statements, enrolling to credit cards, viewing/changing
			account information etc. The system also provides security to their
			accounts with authentication facility. </span>
	</div>
	<div class="tooltip1" align="right">
		<u> Developers </u><span class="tooltiptext"> Ravi Teja Poloju
			Anurag Gupta Anushka Gupta Deepak Sreenivasan </span>
	</div>
	<form name="welcomepage" action="redirectWelcomePage.jsp" method="POST"
		onsubmit="return validLogin();">

		<%
			int noOfRecords = 0;
			try {
				Class.forName("oracle.jdbc.OracleDriver");

				String URL = "jdbc:oracle:thin:@//oracle.cise.ufl.edu:1521/orcl";
				String username = "rpoloju";
				String password = "cop5725#";

				Connection connection = null;
				Statement st = null;
				ResultSet rs = null;

				connection = DriverManager.getConnection(URL, username, password);
				int recordsInCurrentTable = 0;
				String sql1 = "select count(*) from ACCOUNT";
				String sql2 = "select count(*) from CLIENT";
				String sql3 = "select count(*) from ORDERS";
				String sql4 = "select count(*) from USERS";
				String sql5 = "select count(*) from DISTRICT";
				String sql6 = "select count(*) from TRANSACTIONS";
				String sql7 = "select count(*) from DISPOSITION";
				String sql8 = "select count(*) from LOGIN_TO";
				String sql9 = "select count(*) from OPENED_AT";
				String sql10 = "select count(*) from CREATES";
				st = connection.createStatement();
				rs = st.executeQuery(sql1);
				if (rs.next()) {
					recordsInCurrentTable += rs.getInt(1);
				}

				rs = st.executeQuery(sql2);
				if (rs.next()) {
					recordsInCurrentTable += rs.getInt(1);
				}

				rs = st.executeQuery(sql3);
				if (rs.next()) {
					recordsInCurrentTable += rs.getInt(1);
				}

				rs = st.executeQuery(sql4);
				if (rs.next()) {
					recordsInCurrentTable += rs.getInt(1);
				}

				rs = st.executeQuery(sql5);
				if (rs.next()) {
					recordsInCurrentTable += rs.getInt(1);
				}

				rs = st.executeQuery(sql6);
				if (rs.next()) {
					recordsInCurrentTable += rs.getInt(1);
				}

				rs = st.executeQuery(sql7);
				if (rs.next()) {
					recordsInCurrentTable += rs.getInt(1);
				}

				rs = st.executeQuery(sql8);
				if (rs.next()) {
					recordsInCurrentTable += rs.getInt(1);
				}

				rs = st.executeQuery(sql9);
				if (rs.next()) {
					recordsInCurrentTable += rs.getInt(1);
				}

				rs = st.executeQuery(sql10);
				if (rs.next()) {
					recordsInCurrentTable += rs.getInt(1);
				}

				noOfRecords = recordsInCurrentTable;

				if (connection != null)
					connection.close();
			} catch (Exception e) {
				out.println("Banking app is temporarily down. Please refresh!");
				e.printStackTrace();
			}
		%>


		<table width="800px" border=0 align="center">
			<tr>
				<td align="right"><input
					onclick="displayResult('<%=noOfRecords%>')" type="button"
					value="Records" id="recordsbutton"></input></td>
			</tr>
		</table>
		<br /> <br /> <br /> <br /> <br /> <br /> <br />
		<table border="0" align="center">
			<tbody>
				<tr>
					<td>Online id :</td>
					<td><input type="text" name="onlineid" value="" size="20"></td>
				</tr>
				<tr>
					<td>PassCode :</td>
					<td><input type="password" name="passcode" value="" size="20"></td>
					<td><input type="submit" value="Sign in" name="signin"></td>
					<td><input type="reset" value="Cancel" name="clear"></td>
				</tr>
			</tbody>
		</table>
		<br />
		<table width="400" border="2" align="center" cellpadding="2"
			cellspacing="2">
			<tr>
				<td><div align="center">
						<a href="forgotpasscode.jsp">Forgot PassCode</a>
					</div></td>
				<td><div align="center">
						<a href="openanaccount.jsp">Open an account</a>
					</div></td>
				<td><div align="center">
						<a href="adminlogin.jsp">Admin Login</a>
					</div></td>
			</tr>
		</table>
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
		<br />
		<br />
		<br />
		<br />
		<br />
		<marquee style="background-color: silver;">
			Gator Bank launches America's first digital application form for
			opening current accounts; enables account opening in a few seconds.<span
				class="tab"><span class="tab">Gator Bank pioneers the
					transformation of cross border payments in the United States.</span></span><span
				class="tab"><span class="tab">Gator Bank enables its
					customers to send money through GatorBanking app.</span></span>
		</marquee>
	</form>
</body>
<script language="javascript">
	function displayResult(records) {
		var elem = document.getElementById("recordsbutton");
		if (elem.value == "Records")
			elem.value = records;
		else
			elem.value = "Records";
	}
</script>
</html>