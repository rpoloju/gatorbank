<%@ page import="java.sql.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@page import="java.awt.Color"%>
<%-- <%@page import="java.io.*"%> --%>
<%@page import="org.jfree.chart.JFreeChart"%>
<%@page import="org.jfree.chart.plot.PlotOrientation"%>
<%@page import="org.jfree.chart.ChartFactory"%>
<%@page import="org.jfree.chart.ChartPanel"%>
<%@page import="org.jfree.chart.ChartRenderingInfo"%>
<%@page import="org.jfree.chart.ChartUtilities"%>
<%@page import="org.jfree.chart.plot.PiePlot"%>
<%@page import="org.jfree.chart.entity.StandardEntityCollection"%>
<%@page import="org.jfree.data.general.DefaultPieDataset"%>
<%@page import="org.jfree.data.category.DefaultCategoryDataset"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
.column {
	float: left;
	width: 33.33%;
}

/* Clear floats after the columns */
.row:after {
	content: "";
	display: table;
	clear: both;
}

.bgstyle {
	background: url(Back2.jpg) no-repeat center center fixed;
	background-size: cover;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Statistics</title>
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
	<br />
	<br />



	<%
		Map<String, Integer> regionMap = new HashMap<>();
		int totalacc = 0;
		int totalfemale = 0;
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

			//This section is for accounts based on region pie chart
			String sqlregion = "select d.region, count(a.ACCOUNT_ID) from account a join district d on a.district_id = d.district_id group by d.region";
			rs = st.executeQuery(sqlregion);
			while (rs.next()) {
				regionMap.put(rs.getString(1), rs.getInt(2));
			}

			DefaultPieDataset pieDataset1 = new DefaultPieDataset();
			for (Map.Entry<String, Integer> entry : regionMap.entrySet()) {
				pieDataset1.setValue(entry.getKey(), entry.getValue());
			}

			JFreeChart chart1 = ChartFactory.createPieChart("Accounts based on region", pieDataset1, false, true,
					false);
			//chart.setBackgroundPaint(new Color(0xFF, 0xFF, 0xFF, 0));
			final PiePlot plot1 = (PiePlot) chart1.getPlot();
			//plot.setBackgroundPaint(new Color(0xFF, 0xFF, 0xFF, 0));
			plot1.setCircular(true);

			final ChartRenderingInfo info1 = new ChartRenderingInfo(new StandardEntityCollection());
			final java.io.File file1 = new java.io.File(
					getServletContext().getRealPath(".") + "/regionaccounts.png");
			file1.createNewFile();
			ChartUtilities.saveChartAsPNG(file1, chart1, 450, 300, info1);

			//This section is for accounts based on gender
			//Calculate total accounts first
			String sqlacc = "select count(*) from client";
			rs = st.executeQuery(sqlacc);
			if (rs.next()) {
				totalacc = rs.getInt(1);
			}

			//Calculate female accounts 
			String sqlfem = "select count(*) from client where MOD(DOB,10000) > 1231";
			rs = st.executeQuery(sqlfem);
			if (rs.next()) {
				totalfemale = rs.getInt(1);
			}

			DefaultPieDataset pieDataset2 = new DefaultPieDataset();
			pieDataset2.setValue("Female", new Integer(totalfemale));
			pieDataset2.setValue("Male", new Integer(totalacc - totalfemale));

			JFreeChart chart2 = ChartFactory.createPieChart("Accounts based on gender", pieDataset2, false, true,
					false);
			//chart.setBackgroundPaint(new Color(0xFF, 0xFF, 0xFF, 0));
			final PiePlot plot2 = (PiePlot) chart2.getPlot();
			//plot.setBackgroundPaint(new Color(0xFF, 0xFF, 0xFF, 0));
			plot2.setCircular(true);

			final ChartRenderingInfo info2 = new ChartRenderingInfo(new StandardEntityCollection());
			final java.io.File file2 = new java.io.File(
					getServletContext().getRealPath(".") + "/genderaccounts.png");
			file2.createNewFile();
			ChartUtilities.saveChartAsPNG(file2, chart2, 450, 300, info2);

			//This section is to get the transactions by month over the last financial year
			int count = 0;
			int i = 0;
			while (start <= 199812) {
				String sqlmonthly = "select count(*) from transactions where floor(date_of_trans/100) = " + start
						+ " order by date_of_trans";
				rs = st.executeQuery(sqlmonthly);
				if (rs.next()) {
					trans[i] = rs.getInt(1);
				}
				i++;
				start++;
			}

			DefaultCategoryDataset pieDataset3 = new DefaultCategoryDataset();
			pieDataset3.addValue(new Integer(trans[0]), "Jan", "Jan");
			pieDataset3.addValue(new Integer(trans[1]), "Feb", "Feb");
			pieDataset3.addValue(new Integer(trans[2]), "Mar", "Mar");
			pieDataset3.addValue(new Integer(trans[3]), "Apr", "Apr");
			pieDataset3.addValue(new Integer(trans[4]), "May", "May");
			pieDataset3.addValue(new Integer(trans[5]), "Jun", "Jun");
			pieDataset3.addValue(new Integer(trans[6]), "Jul", "Jul");
			pieDataset3.addValue(new Integer(trans[7]), "Aug", "Aug");
			pieDataset3.addValue(new Integer(trans[8]), "Sep", "Sep");
			pieDataset3.addValue(new Integer(trans[9]), "Oct", "Oct");
			pieDataset3.addValue(new Integer(trans[10]), "Nov", "Nov");
			pieDataset3.addValue(new Integer(trans[11]), "Dec", "Dec");

			JFreeChart chart3 = ChartFactory.createBarChart("Transactions by month in the last fin. year", "Month",
					"Transactions", pieDataset3, PlotOrientation.VERTICAL, false, true, false);
			//chart.setBackgroundPaint(new Color(0xFF, 0xFF, 0xFF, 0));
			final ChartPanel plot3 = new ChartPanel(chart3);
			//plot.setBackgroundPaint(new Color(0xFF, 0xFF, 0xFF, 0));
			//plot3.setCircular(true);

			final ChartRenderingInfo info3 = new ChartRenderingInfo(new StandardEntityCollection());
			final java.io.File file3 = new java.io.File(getServletContext().getRealPath(".") + "/trans.png");
			file3.createNewFile();
			ChartUtilities.saveChartAsPNG(file3, chart3, 450, 300, info3);

			//Close the connection
			if (connection != null)
				connection.close();
		} catch (Exception e) {
			out.println("Statistics page is temporarily down. Please refresh!");
			e.printStackTrace();

		}
	%>

	<div class="row">
		<div class="column">
			<img src="regionaccounts.png">
		</div>
		<div class="column">
			<img src="genderaccounts.png">
		</div>
		<div class="column">
			<img src="trans.png">
		</div>
	</div>
</body>
</html>