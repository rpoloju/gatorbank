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
<title>Welcome to GatorBank</title>
</head>
<body>
	<h1 class="myclass" align="center">Welcome to GatorBank</h1>

	<%
		try {
			Class.forName("oracle.jdbc.OracleDriver");

			String usernameFromForm = request.getParameter("onlineid");
			String passcodeFromForm = request.getParameter("passcode");
			String URL = "jdbc:oracle:thin:@//oracle.cise.ufl.edu:1521/orcl";
			String username = "rpoloju";
			String password = "cop5725#";

			Connection connection = null;
			PreparedStatement st = null;
			ResultSet rs = null;

			connection = DriverManager.getConnection(URL, username, password);
			String sqlUserNamePassword = "select USER_ID, PASSCODE from USERS WHERE USER_ID = ?";
			st = connection.prepareStatement(sqlUserNamePassword);
			st.setString(1, usernameFromForm);
			rs = st.executeQuery();
			Integer usernameFromDB = null;
			String passcodeFromDB = null;
			if (rs.next()) {
				usernameFromDB = rs.getInt(1);
				passcodeFromDB = rs.getString(2);
			}
			if (usernameFromDB == Integer.parseInt(usernameFromForm) && passcodeFromDB.equals(passcodeFromForm)) {
				session.setAttribute("userid", usernameFromForm);
				String redirectURL = "homepage.jsp";
				response.sendRedirect(redirectURL);
			} else {
				response.sendRedirect("index.jsp");
			}
			if (connection != null)
				connection.close();
		} catch (Exception e) {
			out.println("Login failed");
			e.printStackTrace();
		}
	%>
</body>
</html>