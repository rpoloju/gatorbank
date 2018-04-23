<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
.bgstyle {
	background: url(Back2.jpg) no-repeat center center fixed;
	background-size: cover;
}
</style>
<title>Insert title here</title>
</head>
<body class="bgstyle"
	background="${pageContext.request.contextPath}//Back2.jpg" >
	<table width="800px" border=0 align="center">
		<tr>
			<td align="right"><a href="homepage.jsp" style="color: #000000;">Account
					Home</a></td>
		</tr>
	</table>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<%
		String user = "";
		if (session.getAttribute("userid") != null) {
			user = session.getAttribute("userid").toString();
		}
	%>
	<%
		int toAccount = 0;
		float transferAmount = 0;
		String toBank = "";
		int newOrderId = 0;
		boolean doesUserExist = false;
		try {
			Class.forName("oracle.jdbc.OracleDriver");

			String transferToFromForm = request.getParameter("transferto");
			String transferAmountFromForm = request.getParameter("transferAmount");
			String bankToFromForm = request.getParameter("bankTo");
			float checkBalance = 0;
			float targetBalance = 0;

			//Get the parameters from form in the required format
			transferAmount = Float.parseFloat(transferAmountFromForm);
			toAccount = Integer.parseInt(transferToFromForm);
			String[] splits = bankToFromForm.split("-");
			toBank = splits[0].trim();

			String URL = "jdbc:oracle:thin:@//oracle.cise.ufl.edu:1521/orcl";
			String username = "rpoloju";
			String password = "cop5725#";

			Connection connection = null;
			Statement st = null;
			ResultSet rs = null;

			connection = DriverManager.getConnection(URL, username, password);
			st = connection.createStatement();

			//Create transaction date
			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat ft = new java.text.SimpleDateFormat("yyyyMMdd");
			String dateOftrans = ft.format(date);

			//Get new order id
			String sqllastOrder = "select max(order_id) from orders";
			rs = st.executeQuery(sqllastOrder);
			if (rs.next()) {
				newOrderId = Integer.parseInt(rs.getString(1)) + 1;
			}

			//Check if the account id of the payee exists
			String checkuser = "select * from account where account_id = " + toAccount;
			rs = st.executeQuery(checkuser);
			if (rs.next()) {
				doesUserExist = true;
			}

			//Get balance available to validate against transfer amount if the user exists
			if (doesUserExist) {
				String sqlBal = "select balance from transactions where account_id = " + user
						+ "and date_of_trans = (select max(date_of_trans) from transactions where account_id ="
						+ user + ") order by transaction_id desc";
				rs = st.executeQuery(sqlBal);
				if (rs.next()) {
					checkBalance = rs.getFloat(1);
				}
			}
			rs = null;

			if (checkBalance >= transferAmount && !toBank.trim().toUpperCase().equals("GATORBANK")
					&& doesUserExist) {
				//Case 1: if this is an interbank transfer, update Orders and Tranactions tables
				//Inserting into order table
				String sqlOrder = "insert into orders values((select max(order_id) from orders) + 1, " + user + ",'"
						+ toBank + "'," + toAccount + "," + transferAmount + ")";
				int order1 = st.executeUpdate(sqlOrder);

				//Inserting into transactions table
				String sqltrans = "insert into transactions values((select max(transaction_id) from transactions)+1, "
						+ user + "," + dateOftrans + ",'VYDAJ', 'PREVOD NA UCET'," + transferAmount + ","
						+ (checkBalance - transferAmount) + "," + toAccount + ",'" + toBank + "')";
				int trans = st.executeUpdate(sqltrans);

				//Inserting into Creates table
				String sqlCreates1 = "insert into creates values(" + user + ","
						+ "(select max(order_id) from orders),-1)";
				int creates1 = st.executeUpdate(sqlCreates1);

				String sqlCreates2 = "insert into creates values(" + user
						+ ",-1,(select max(transaction_id) from transactions))";
				int creates2 = st.executeUpdate(sqlCreates2);

				//Get the transaction id from the transaction table
				int tid = 0;
				String sqltid = "select max(transaction_id) from transactions";
				rs = st.executeQuery(sqltid);
				if (rs.next()) {
					tid = rs.getInt(1);
				}

				if (order1 > 0 && trans > 0 && creates1 > 0 && creates2 > 0) {
					int status = 1;
					connection.commit();
					session.setAttribute("tid", tid);
					session.setAttribute("status", status);
					String redirectURL = "transferstatus.jsp";
					response.sendRedirect(redirectURL);
				}

			} else if (checkBalance >= transferAmount && toBank.trim().toUpperCase().equals("GATORBANK")) {
				//Initially get the balance of the target account
				String sqltargetbal = "select balance from transactions where account_id = " + toAccount
						+ "and date_of_trans = (select max(date_of_trans) from transactions where account_id ="
						+ toAccount + ")";
				rs = st.executeQuery(sqltargetbal);
				if (rs.next()) {
					targetBalance = rs.getFloat(1);
				}

				//Case 2: If this is an intra bank transfer, update transactions table with 2 rows
				//Inserting into transactions table - sender record
				String sqltrans1 = "insert into transactions values((select max(transaction_id) from transactions)+1, "
						+ user + "," + dateOftrans + ",'VYDAJ', 'VYBER'," + transferAmount + ","
						+ (checkBalance - transferAmount) + ",-1,'-1')";
				int trans1 = st.executeUpdate(sqltrans1);

				//Inserting into creates table				
				String sqlCreates1 = "insert into creates values(" + user
						+ ",-1,(select max(transaction_id) from transactions))";
				int creates1 = st.executeUpdate(sqlCreates1);

				//Inserting into transactions table - receiver record
				String sqltrans2 = "insert into transactions values((select max(transaction_id) from transactions)+1, "
						+ toAccount + "," + dateOftrans + ",'PRIJEM', 'VKLAD'," + transferAmount + ","
						+ (targetBalance + transferAmount) + ",-1,'-1')";
				int trans2 = st.executeUpdate(sqltrans2);

				//Inserting into creates table
				String sqlCreates2 = "insert into creates values(" + user
						+ ",-1,(select max(transaction_id) from transactions))";
				int creates2 = st.executeUpdate(sqlCreates2);

				//Get the transaction id from the transaction table
				int tid = 0;
				String sqltid = "select max(transaction_id) from transactions";
				rs = st.executeQuery(sqltid);
				if (rs.next()) {
					tid = rs.getInt(1) - 1;
				}

				if (trans1 > 0 && trans2 > 0 && creates1 > 0 && creates2 > 0) {
					int status = 1;
					connection.commit();
					session.setAttribute("tid", tid);
					session.setAttribute("status", status);
					String redirectURL = "transferstatus.jsp";
					response.sendRedirect(redirectURL);
				}
			} else {
				session.setAttribute("tid", 0);
				session.setAttribute("status", 0);
				String redirectURL = "transferstatus.jsp";
				response.sendRedirect(redirectURL);
			}

			if (connection != null)
				connection.close();
		} catch (Exception e) {
			out.println("Transfer failed");
			e.printStackTrace();
		}
	%>
</body>
</html>