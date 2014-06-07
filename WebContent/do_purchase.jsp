<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="database.*"   import="java.util.*" errorPage="" %>
<%@include file="welcome.jsp" %>
<%
if(session.getAttribute("name")!=null)
{

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CSE135</title>
</head>

<body>

<div style="width:20%; position:absolute; top:50px; left:0px; height:90%; border-bottom:1px; border-bottom-style:solid;border-left:1px; border-left-style:solid;border-right:1px; border-right-style:solid;border-top:1px; border-top-style:solid;">
	<table width="100%">
		<tr><td><a href="products_browsing.jsp" target="_self">Show Produts</a></td></tr>
		<tr><td><a href="buyShoppingCart.jsp" target="_self">Buy Shopping Cart</a></td></tr>
	</table>	
</div>
<div style="width:79%; position:absolute; top:50px; right:0px; height:90%; border-bottom:1px; border-bottom-style:solid;border-left:1px; border-left-style:solid;border-right:1px; border-right-style:solid;border-top:1px; border-top-style:solid;">
<p><table align="center" width="80%" style="border-bottom-width:2px; border-top-width:2px; border-bottom-style:solid; border-top-style:solid">
	<tr><td align="left"><font size="+3">
	<%
	String uName=(String)session.getAttribute("name");
	int userID  = (Integer)session.getAttribute("userID");
	String role = (String)session.getAttribute("role");
	String card=null;
	int card_num=0;
	try {card=request.getParameter("card"); }catch(Exception e){card=null;}
	try
	{
		 card_num    = Integer.parseInt(card);
		 if(card_num>0)
		 {
	
				Connection conn=null;
				Statement stmt=null;
				try
				{
					
					
					
					try{Class.forName("org.postgresql.Driver");}catch(Exception e){System.out.println("Driver error");}
					String url="jdbc:postgresql://127.0.0.1:5432/P3";
					String user="postgres";
					String password="Hh_2010";
					conn =DriverManager.getConnection(url, user, password);
					stmt =conn.createStatement();
					String SQL_copy="INSERT INTO sales (uid, pid, quantity, price) select c.uid, c.pid, c.quantity, c.price from carts c where c.uid="+userID+";";
					//Project3
					Statement stmt_carts = conn.createStatement(); 	
					
					String SQL_carts = "SELECT uid, pid, c.quantity * c.price amount, cid, state " +
										"FROM carts c, users u, products p " +
										"WHERE uid = u.id and pid = p.id and c.uid = " + userID;
					ResultSet rs_carts= stmt_carts.executeQuery(SQL_carts);
					String SQL_up = "", SQL_uc = "", SQL_sp = "", SQL_sc = "", SQL_u = "", SQL_s = "", SQL_p = "";
					String SQL_upi = "", SQL_uci = "", SQL_spi = "", SQL_sci = "", SQL_ui = "", SQL_si = "", SQL_pi = "";
					String SQL="delete from carts where uid="+userID+";";
					
					
					try{
					
							conn.setAutoCommit(false);
							/**record log,i.e., sales table**/
							stmt.execute(SQL_copy);
							//Project3
							 while(rs_carts.next()) {
								int rowCount = 1;
						
								PreparedStatement pstmt_up = conn.prepareStatement("UPDATE prec_uid_pid SET amount = amount + " + rs_carts.getInt(3) + 
										" WHERE uid = " + rs_carts.getInt(1) + " AND pid = " + rs_carts.getInt(2) + ";");
								rowCount = pstmt_up.executeUpdate();
								if(rowCount == 0) {
									PreparedStatement pstmt_upi = conn.prepareStatement("INSERT INTO prec_uid_pid VALUES(" +
											rs_carts.getInt(1) + "," + rs_carts.getInt(2) + "," + rs_carts.getInt(3) + ");");
									pstmt_upi.executeUpdate();
								} 
								
								rowCount = 1;
								PreparedStatement pstmt_uc = conn.prepareStatement("UPDATE prec_uid_cid SET amount = amount+" + rs_carts.getInt(3) + 
										" WHERE uid = " + rs_carts.getInt(1) + " AND cid = " + rs_carts.getInt(4) + ";");
								rowCount = pstmt_uc.executeUpdate();
								if(rowCount == 0) {
									PreparedStatement pstmt_uci = conn.prepareStatement("INSERT INTO prec_uid_cid VALUES(" +
											rs_carts.getInt(1) + "," + rs_carts.getInt(4) + "," + rs_carts.getInt(3) + ");");
									pstmt_uci.executeUpdate();
								}
								
								rowCount = 1;
								PreparedStatement pstmt_sp = conn.prepareStatement("UPDATE prec_state_pid SET amount = amount+" + rs_carts.getInt(3) + " WHERE state = ? AND pid = " + rs_carts.getInt(2) + ";");
								pstmt_sp.setString(1, rs_carts.getString(5)); 
								rowCount = pstmt_sp.executeUpdate();
								if(rowCount == 0) {
									PreparedStatement pstmt_spi = conn.prepareStatement("INSERT INTO prec_state_pid VALUES(?" + "," + rs_carts.getInt(2) + "," + rs_carts.getInt(3) + ");");
									pstmt_spi.setString(1, rs_carts.getString(5));
									pstmt_spi.executeUpdate();
								} 
		 						
								rowCount = 1;
								PreparedStatement pstmt_sc = conn.prepareStatement("UPDATE prec_state_cid SET amount = amount+" + rs_carts.getInt(3) + 
										" WHERE state = ? AND cid = " + rs_carts.getInt(4) + ";");
								pstmt_sc.setString(1, rs_carts.getString(5));
								rowCount = pstmt_sc.executeUpdate();
								if(rowCount == 0) {
									pstmt_sc = conn.prepareStatement("INSERT INTO prec_state_cid VALUES(?," + rs_carts.getInt(4) + "," + rs_carts.getInt(3) + ");");
									pstmt_sc.setString(1, rs_carts.getString(5));
									pstmt_sc.executeUpdate();
								} 
								
								rowCount = 1;
								PreparedStatement pstmt_s = conn.prepareStatement("UPDATE prec_state SET amount = amount+" + rs_carts.getInt(3) + " WHERE state = ?;");
								pstmt_s.setString(1, rs_carts.getString(5));
								rowCount = pstmt_s.executeUpdate();
								if(rowCount == 0) {
										pstmt_s = conn.prepareStatement("INSERT INTO prec_state VALUES(?" +
												"," + rs_carts.getInt(3) + ");");
										pstmt_s.setString(1, rs_carts.getString(5));
										pstmt_s.executeUpdate();
								} 
								
								rowCount = 1;
								PreparedStatement pstmt_u = conn.prepareStatement("UPDATE prec_uid SET amount = amount+" + rs_carts.getInt(3) + 
										" WHERE uid = " + rs_carts.getInt(1));
								rowCount = pstmt_u.executeUpdate();
								if(rowCount == 0) {
										pstmt_u = conn.prepareStatement("INSERT INTO prec_uid VALUES(" +
												rs_carts.getInt(1) + "," + rs_carts.getInt(3) + ");");
										pstmt_u.executeUpdate();
								} 
								
								rowCount = 1;		
								PreparedStatement pstmt_p = conn.prepareStatement("UPDATE prec_pid SET amount = amount+" + rs_carts.getInt(3) + 
										" WHERE pid = " + rs_carts.getInt(2));
								rowCount = pstmt_p.executeUpdate();
								if(rowCount == 0) {
										pstmt_p = conn.prepareStatement("INSERT INTO prec_pid VALUES(" +
												rs_carts.getInt(2) + "," + rs_carts.getInt(3) + ");");
										pstmt_p.executeUpdate();
								} 
							
								
							} 
							stmt.execute(SQL);
							conn.commit();
							
							conn.setAutoCommit(true);
							out.println("Dear customer '"+uName+"', Thanks for your purchasing.<br> Your card '"+card+"' has been successfully proved. <br>We will ship the products soon.");
							out.println("<br><font size=\"+2\" color=\"#990033\"> <a href=\"products_browsing.jsp\" target=\"_self\">Continue purchasing</a></font>");
					}
					catch(Exception e)
					{
						out.println("Fail! Please try again <a href=\"purchase.jsp\" target=\"_self\">Purchase page</a>.<br><br>");
						
					}
					conn.close();
				}
				catch(Exception e)
				{
						out.println("<font color='#ff0000'>Error.<br><a href=\"purchase.jsp\" target=\"_self\"><i>Go Back to Purchase Page.</i></a></font><br>");
						
				}
			}
			else
			{
			
				out.println("Fail! Please input valid credit card numnber.  <br> Please <a href=\"purchase.jsp\" target=\"_self\">buy it</a> again.");
			}
		}
	catch(Exception e) 
	{ 
		out.println("Fail! Please input valid credit card numnber.  <br> Please <a href=\"purchase.jsp\" target=\"_self\">buy it</a> again.");
	}
%>
	
	</font><br>
</td></tr>
</table>
</div>
</body>
</html>
<%}%>