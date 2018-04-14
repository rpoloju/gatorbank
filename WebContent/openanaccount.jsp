<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
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
<title>New Account page</title>
</head>
	
<body class="bgstyle" background="${pageContext.request.contextPath}//Back2.jpg" >
<form name="createaccount" action="redirectCreatePage.jsp" method="POST" onsubmit = "return validnew();">
	<!-- <h1 class="myclass" align="center">Welcome to GatorBank</h1> -->
	<table width="800px" border=0 align="center">
		<tr>
			<td align="right"><a href="index.jsp"
				style="color: #000000;">Home</a></td>
		</tr>
	</table>
	<br/><br/><br/><br/><br/><br/>
	<table border="0" align="center">
			<tbody>
				<tr>
					<td>Gender :</td>
					<td><input type="radio" name="gender" value="0" checked="checked">Female</td>
					<td><input type="radio" name="gender" value="1">Male</td>
				</tr>
				<tr>
					<td>Date of Birth (mmddyyyy) :</td>
					<td><input type="text" name="dob" value="" size="10"></td>
				</tr>
				<tr>
					<td>District :</td>
					<td><select name = "district">
						<%
						List<String> districts = new ArrayList<>();
						try {
							Class.forName("oracle.jdbc.OracleDriver");

							String URL = "jdbc:oracle:thin:@//oracle.cise.ufl.edu:1521/orcl";
							String username = "rpoloju";
							String password = "cop5725#";

							Connection connection = null;
							Statement st = null;
							ResultSet rs = null;

							connection = DriverManager.getConnection(URL, username, password);
							String sqlselectdistricts = "select district_name from district";
							st = connection.createStatement();
							rs = st.executeQuery(sqlselectdistricts);
							while (rs.next()) {
								districts.add(rs.getString(1));
							} 
							if (connection != null)
								connection.close();
						} catch (Exception e) {
							out.println("District retrieval failed");
							e.printStackTrace();
						}
						%>
						
						<%
							for (String s : districts) {
						%>
							<option><%=s %></option> 
						<%} %>
					</select></td>
				</tr>
				<tr>
					<td>PassCode :</td>
					<td><input type="password" name="passcode" value="" size="20"></td>
					<td><input type="submit" value="Create" name="signup"></td>
					<td><input type="reset" value="Clear" name="clear"></td>
				</tr>
				<tr>
					<td>Do you wish to add authorized user ?</td>
					<td><input type="radio" name="disp" value="0" checked="checked">No</td>
					<td><input type="radio" name="disp" value="1">Yes</td>
				</tr>
			</tbody>
		</table>
		<table border="0" align="center">
			<tr>
				<td align="center"><p>Please click on "Create" to get your account id(s)</p></td>
			</tr>
			<tr>
				<td align="center"><p>Your account id/user id will be automatically generated after validating your personal information</p></td>
			</tr>
		</table>
</form>
</body>
</html>