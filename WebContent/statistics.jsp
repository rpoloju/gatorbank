<%@ page import="java.sql.*"%>
<%@page import="java.awt.Color"%>
<%-- <%@page import="java.io.*"%> --%>
<%@page import="org.jfree.chart.JFreeChart"%>
<%@page import="org.jfree.chart.ChartFactory"%>
<%@page import="org.jfree.chart.ChartRenderingInfo"%>
<%@page import="org.jfree.chart.ChartUtilities"%>
<%@page import="org.jfree.chart.plot.PiePlot"%>
<%@page import="org.jfree.chart.entity.StandardEntityCollection"%>
<%@page import="org.jfree.data.general.DefaultPieDataset"%>

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
<style>
.chartstyle {
	img: url(piechart.png) no-repeat center center fixed;
}
</style>
<title>Statistics</title>
</head>
<body class="bgstyle"
	background="${pageContext.request.contextPath}//Back2.jpg">
	<table width="800px" border=0 align="center">
		<tr>
			<td align="right"><a href="homepage.jsp" style="color: #000000;">Account
					Home</a></td>
		</tr>
	</table>

	<%
		String user = "";
		if (session.getAttribute("userid") != null) {
			user = session.getAttribute("userid").toString();
			System.out.println(user);

			int[] trans = new int[12];
			int start = 199801;
			try {
				Class.forName("oracle.jdbc.OracleDriver");

				String URL = "jdbc:oracle:thin:@//oracle.cise.ufl.edu:1521/orcl";
				String username = "rpoloju";
				String password = "cop5725#";

				Connection connection = null;
				Statement st = null;
				ResultSet rs = null;
				connection = DriverManager.getConnection(URL, username, password);

				st = connection.createStatement();
				int count = 0;
				int i = 0;
				while (start <= 199812) {
					String sqlmonthly = "select count(*) from transactions where account_id = " + user
							+ " and floor(date_of_trans/100) = " + start + " order by date_of_trans";
					rs = st.executeQuery(sqlmonthly);
					if (rs.next()) {
						trans[i] = rs.getInt(1);
						System.out.println(trans[i]);
					}
					i++;
					start++;
				}

				DefaultPieDataset pieDataset = new DefaultPieDataset();
				pieDataset.setValue("Jan", new Integer(trans[0]));
				pieDataset.setValue("Feb", new Integer(trans[1]));
				pieDataset.setValue("Mar", new Integer(trans[2]));
				pieDataset.setValue("Apr", new Integer(trans[3]));
				pieDataset.setValue("May", new Integer(trans[4]));
				pieDataset.setValue("Jun", new Integer(trans[5]));
				pieDataset.setValue("Jul", new Integer(trans[6]));
				pieDataset.setValue("Aug", new Integer(trans[7]));
				pieDataset.setValue("Sep", new Integer(trans[8]));
				pieDataset.setValue("Oct", new Integer(trans[9]));
				pieDataset.setValue("Nov", new Integer(trans[10]));
				pieDataset.setValue("Dec", new Integer(trans[11]));

				if (connection != null)
					connection.close();

				JFreeChart chart = ChartFactory.createPieChart("Transactions by month - 1998", pieDataset, true,
						true, false);
				//chart.setBackgroundPaint(new Color(0xFF, 0xFF, 0xFF, 0));
				final PiePlot plot = (PiePlot) chart.getPlot();
				//plot.setBackgroundPaint(new Color(0xFF, 0xFF, 0xFF, 0));
				plot.setCircular(true);

				final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
				final java.io.File file1 = new java.io.File(getServletContext().getRealPath(".") + "/piechart.png");
				file1.createNewFile();

				ChartUtilities.saveChartAsPNG(file1, chart, 600, 400, info);
			} catch (Exception e) {
				out.println("Statistics page is temporarily down. Please refresh!");
				e.printStackTrace();

			}
	%>
	<%
		}
	%>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<div style="display: flex; justify-content: center;">
		<img src="piechart.png" />
	</div>
	<!-- <img class="chartstyle" SRC="piechart.png" align="middle" USEMAP="#chart"> -->
</body>
</html>