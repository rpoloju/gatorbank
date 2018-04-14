<%@page import="java.util.Date"%>
<%@ page import="java.sql.*,java.util.*"%>
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
<title>New Account</title>
</head>
<body class="bgstyle" background="${pageContext.request.contextPath}//Back2.jpg" >

	<!-- <h1 class="myclass" align="center">Welcome to GatorBank</h1> -->
	<table width="800px" border=0 align="center">
		<tr>
			<td align="right"><a href="index.jsp" style="color: #000000;">Home</a></td>
		</tr>
	</table>
	<%
		int newAccountId = 0;
		int newAccountIdDisp = 0;
		int newClientId = 0;
		int newDispId = 0;
		int districtId = 2;
		try {
			Class.forName("oracle.jdbc.OracleDriver");

			String genderFromForm = request.getParameter("gender");
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

			//Selecting the maximum account id from account table
			String sqllastAccnum = "select max(account_id) from account";
			st = connection.createStatement();
			rs = st.executeQuery(sqllastAccnum);
			if (rs.next()) {
				newAccountId = Integer.parseInt(rs.getString(1)) + 1;
			}

			//If disposition is selected, incrementing the account id by 1 for disponent id
			if (Integer.parseInt(dispFromForm) == 1) {
				newAccountIdDisp = newAccountId + 1;
			}

			//Selecting the maximum client id from client table
			String sqllastClientnum = "select max(client_id) from client";
			rs = st.executeQuery(sqllastClientnum);
			if (rs.next()) {
				newClientId = Integer.parseInt(rs.getString(1)) + 1;
			}

			//Selecting the maximum disposition id from disposition table
			String sqllastDispId = "select max(disp_id) from disposition";
			rs = st.executeQuery(sqllastDispId);
			if (rs.next()) {
				newDispId = Integer.parseInt(rs.getString(1)) + 1;
			}

			//Getting the district id from district table
			String sqlDistrictId = "select district_id from district where district_name = " + "'"
					+ districtFromForm + "'";
			rs = st.executeQuery(sqlDistrictId);
			if (rs.next()) {
				districtId = Integer.parseInt(rs.getString(1));
			}

			//Creating account opening date
			java.util.Date date = new java.util.Date();
			java.text.SimpleDateFormat ft = new java.text.SimpleDateFormat("yyyyMMdd");
			String dateOfJoining = ft.format(date);

			
			//Determine date of birth based on gender
			String dob = dobFromForm.substring(4, 8) + dobFromForm.substring(0, 2) + dobFromForm.substring(2, 4);
			int dateOfBirth = Integer.parseInt(dob);
			if (Integer.parseInt(genderFromForm) == 0) {
				dateOfBirth += 5000;
			}
			
			//Inserting client id to client table
			String sqlInsertClient = "INSERT INTO CLIENT VALUES (" + newClientId + "," + dateOfBirth + ")";
			//st.executeUpdate(sqlInsertClient);
			System.out.println("Done CLIENT" + newClientId);

			//Inserting owner account id to account table
			String sqlInsertAccount1 = "INSERT INTO ACCOUNT VALUES (" + newAccountId + "," + districtId + ","
					+ dateOfJoining + ")";
			//st.executeUpdate(sqlInsertAccount1);
			System.out.println("Done Account1");

			//Inserting userid of owner to user table
			String sqlInsertUsers1 = "INSERT INTO USERS VALUES (" + newAccountId + "," + "'" + passcodeFromForm
					+ "'" + "," + newAccountId + ")";
			//st.executeUpdate(sqlInsertUsers1);
			System.out.println("Done Users1");

			//Inserting owner details to disposition table
			String sqlInsertDisponent1 = "INSERT INTO DISPOSITION VALUES (" + newDispId + "," + newAccountId + ","
					+ newClientId + "," + "'OWNER')";
			//st.executeUpdate(sqlInsertDisponent1);
			System.out.println("Done disponent1");

			//Inserting owner details to login_to table
			String sqlInsertloginto1 = "INSERT INTO LOGIN_TO VALUES (" + newAccountId + "," + newAccountId + ")";
			//st.executeUpdate(sqlInsertloginto1);
			System.out.println("Done loginto1");

			//Inserting owner details to opened_at table
			String sqlInsertopenedat1 = "INSERT INTO OPENED_AT VALUES (" + newAccountId + "," + districtId + ")";
			//st.executeUpdate(sqlInsertopenedat1);
			System.out.println("Done openedat1");

			//If disponent is selected
			if (Integer.parseInt(dispFromForm) == 1) {
				//Inserting desponent account id to account table
				String sqlInsertAccount2 = "INSERT INTO ACCOUNT VALUES (" + newAccountIdDisp + "," + districtId
						+ "," + dateOfJoining + ")";
				//st.executeUpdate(sqlInsertAccount2);
				System.out.println("Done account2");

				//Inserting user id of disponent to user table
				String dispPasscode = Integer.toString(newAccountIdDisp);
				String sqlInsertUsers2 = "INSERT INTO USERS VALUES (" + newAccountIdDisp + "," + "'" + dispPasscode
						+ "'" + "," + newAccountIdDisp + ")";
				//st.executeUpdate(sqlInsertUsers2);
				System.out.println("Done users2");

				//Inserting disponent details to disposition table
				String sqlInsertDisponent2 = "INSERT INTO DISPOSITION VALUES (" + newDispId + "," + newAccountIdDisp
						+ "," + newClientId + "," + "'DISPONENT')";
				//st.executeUpdate(sqlInsertDisponent2);
				System.out.println("Done disp2");

				//Inserting disponent details to login_to table
				String sqlInsertloginto2 = "INSERT INTO LOGIN_TO VALUES (" + newAccountIdDisp + ","
						+ newAccountIdDisp + ")";
				//st.executeUpdate(sqlInsertloginto2);
				System.out.println("Done loginto2");

				//Inserting disponent details to opened_at table
				String sqlInsertopenedat2 = "INSERT INTO OPENED_AT VALUES (" + newAccountIdDisp + "," + districtId
						+ ")";
				//st.executeUpdate(sqlInsertopenedat2);
				System.out.println("Done openedat2");
			}

			if (connection != null)
				connection.close();
		} catch (Exception e) {
			out.println("Create account failed");
			e.printStackTrace();
		}
	%>
	<br/><br/><br/><br/><br/>
	<h3 align="center">
		Your account id is
		<%=newAccountId%></h3>
	<%
		if (newAccountIdDisp != 0) {
	%>
	<h3 align="center">
		Your authorized user account id is
		<%=newAccountIdDisp%></h3>
	<%
		}
	%>
	<h4 align="center">Please click on Home button and login to
		continue</h4>
</body>
</html>