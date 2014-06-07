<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="database.*"   import="java.util.*" errorPage="" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sales Anaytics3</title>
<script type="text/javascript" src="js/js.js" language="javascript"></script>
</head>
<body>
<h1 align="center">Sales Anaytics3</h1>


 <%


Hashtable<String, Integer> states_sales = new Hashtable<String, Integer>();
states_sales.put("Alabama", 0);
states_sales.put("Alaska", 0);
states_sales.put("Arizona", 0);
states_sales.put("Arkansas", 0);
states_sales.put("California", 0);
states_sales.put("Colorado", 0);
states_sales.put("Connecticut", 0);
states_sales.put("Delaware", 0);
states_sales.put("Florida", 0);
states_sales.put("Georgia", 0);
states_sales.put("Hawaii", 0);
states_sales.put("Idaho", 0);
states_sales.put("Illinois", 0);
states_sales.put("Indiana", 0);
states_sales.put("Iowa", 0);
states_sales.put("Kansas", 0);
states_sales.put("Kentucky", 0);
states_sales.put("Louisiana", 0);
states_sales.put("Maine", 0);
states_sales.put("Maryland", 0);
states_sales.put("Massachusetts", 0);
states_sales.put("Michigan", 0);
states_sales.put("Minnesota", 0);
states_sales.put("Mississippi", 0);
states_sales.put("Missouri", 0);
states_sales.put("Montana", 0);
states_sales.put("Nebraska", 0);
states_sales.put("Nevada", 0);
states_sales.put("New Hampshire", 0);
states_sales.put("New Jersey", 0);
states_sales.put("New Mexico", 0);
states_sales.put("New York", 0);
states_sales.put("North Carolina", 0);
states_sales.put("North Dakata", 0);
states_sales.put("Ohio", 0);
states_sales.put("Oklahoma", 0);
states_sales.put("Oregon", 0);
states_sales.put("Pennsylvania", 0);
states_sales.put("Rhode Island", 0);
states_sales.put("South Carolina", 0);
states_sales.put("South Dakota", 0);
states_sales.put("Tennessee", 0);
states_sales.put("Texas", 0);
states_sales.put("Utah", 0);
states_sales.put("Vermont", 0);
states_sales.put("Virginia", 0);
states_sales.put("Washington", 0);
states_sales.put("West Virginia", 0);
states_sales.put("Wisconsin", 0);
states_sales.put("Wyoming", 0);


String statesarray[]={"Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado","Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho","Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana","Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi","Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey","New Mexico", "New York", "North Carolina", "North Dakata", "Ohio", "Oklahoma","Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee","Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia","Wisconsin", "Wyoming"}; 
int num_states = 50;
int num_p = 0;
int num_co = 10;
int num_row = 20;
Connection conn=null;
Statement stmt_3,stmt_cate, stmt_temp;
PreparedStatement pstmt, pstmt2, pstmt_p, pstmt_cell, pstmt_check, pstmt_checkq;
ResultSet rs=null,rs_2=null,rs_3=null,rs_cate=null,rs_p=null, rs_cell=null, rs_temp=null, rs_check=null, rs_checkq;
// String SQL=null;
String rowtype=null, state=null, startcount=null;
int cateid=-2;
try { rowtype=request.getParameter("rowtype"); }catch(Exception e) { rowtype=null; }
try { state=request.getParameter("state"); }catch(Exception e) { state=null; }
try { cateid=Integer.parseInt(request.getParameter("cateid")); }catch(Exception e) { cateid=-2; }

try
{
	try{Class.forName("org.postgresql.Driver");}catch(Exception e){System.out.println("Driver error");}
	String url="jdbc:postgresql://127.0.0.1:5432/P3R";
	String user="postgres";
	String password="Hh_2010";
	conn =DriverManager.getConnection(url, user, password);
	
/*  	stmt_2 =conn.createStatement();
 */	stmt_3 =conn.createStatement();
	stmt_cate =conn.createStatement();	
	rs_cate = stmt_cate.executeQuery("SELECT id, name FROM categories"); 
%>
	
<form action="sales_analytics3.jsp" method="POST">
		<strong>Row:</strong>
		<select name="rowtype">
					<option value="Customers"></option>
					<%if(request.getParameter("rowtype")!=null && ((String)(request.getParameter("rowtype"))).equals("Customers")) {%>
			  		<option selected>Customers</option>
			  		<%} else { %>
			  		<option>Customers</option>
			  		<%} %>
					<%if(request.getParameter("rowtype")!=null && ((String)(request.getParameter("rowtype"))).equals("States")) {%>
			  		<option selected>States</option>
			  		<%} else { %>
			  		<option>States</option>
			  		<%} %>
		</select>
		<br>

		<strong>State:</strong>
		<select name="state">
			<option value="All"></option>
			<% if(request.getParameter("state")!=null && ((String)(request.getParameter("state"))).equals("All")){
				%>
				<option selected>All</option> 
				<%} else {
					%>
				<option>All</option> 
					<% 
				}
			for(int i=0; i < num_states; i++) {
				if(request.getParameter("state")!=null && ((String)(request.getParameter("state"))).equals(statesarray[i])){
				%>
				<option selected><%=statesarray[i]%></option> 
				<%} else {
					%>
				<option><%=statesarray[i]%></option> 
					<% 
				}
			}
			%>
		</select>

		<strong>Category:</strong>
		<select name="cateid">
			<option value=-1></option>
			<% if(request.getParameter("cateid")!=null && Integer.parseInt(request.getParameter("cateid"))==-1){
				%>
				<option selected value=-1>All Categories</option> 
				<%} else {
					%>
				<option value=-1>All Categories</option> 
					<% 
				}
 			while(rs_cate.next()) {
				if(request.getParameter("cateid")!=null && Integer.parseInt(request.getParameter("cateid"))==rs_cate.getInt("id")){
				%>
				<option selected value=<%= rs_cate.getInt("id")%>><%=rs_cate.getString("name")%></option>
			  	<%
				} else {
				%>
				<option value=<%= rs_cate.getInt("id") %>><%=rs_cate.getString("name")%></option>
		  		<%
				}
		  	}
  			%>
		</select>

		<br>
		<input type="submit" value="Run Query">
</form>

<%
	
	if(rowtype!=null && state!=null && cateid!=-2)
	{	
		String SQL_1=null, SQL_2=null, SQL_3=null;
		
		//Products Query(the fist row)
		
		Timestamp d = new Timestamp(System.currentTimeMillis()); 
		%>
		<%= d%>
		<%
		SQL_1 = "select name, amount, s.pid from ";
		if(state.equals("All")) {
			SQL_1 += "prec_pid s ";
		} else {
			SQL_1 += "prec_state_pid s ";
		}
		SQL_1 += "left join products p on p.id = s.pid ";
		if(state.equals("All")) {
			if(cateid != -1){
				SQL_1 += "where p.cid = " + cateid + " ";
			}
		} else {
			SQL_1 += "where state = ? ";
			if(cateid != -1){
				SQL_1 += "and p.cid = " + cateid + " ";
			}
		}
		SQL_1 += "order by amount desc limit " + num_co;
		pstmt=conn.prepareStatement(SQL_1);
		if(!state.equals("All")){
			pstmt.setString(1, state);
		}
		rs=pstmt.executeQuery();
	
		String SQL_p ="select count(*) from (" + SQL_1 + ") number";
		PreparedStatement pstmt_num_p = conn.prepareStatement(SQL_p);
		if(!state.equals("All")){
			pstmt_num_p.setString(1, state);
		}
		rs_p= pstmt_num_p.executeQuery();
		rs_p.next();
		//products number
		num_p = rs_p.getInt("count");  	
		
		
		
	//Customers or States query
	if(rowtype.equals("States")) {
		SQL_2 = "select state, amount from ";
		if(cateid == -1) {
			SQL_2 += "prec_state ";
			if(!state.equals("All")) {
				SQL_2 += "where state = ? ";
			}
		} else {
			SQL_2 += "prec_state_cid where cid = " + cateid + " ";
			if(!state.equals("All")) {
				SQL_2 += "and state = ? ";
			}
		}
		SQL_2 += "order by amount desc limit " + num_row;
		pstmt2=conn.prepareStatement(SQL_2);
		if(!state.equals("All")){
			pstmt2.setString(1, state);
		}
		rs_2=pstmt2.executeQuery();//state not id, many users in one state
		while(rs_2.next()) {
			states_sales.put(rs_2.getString(1), (Integer)(rs_2.getInt(2)));
		}
		rs_2=pstmt2.executeQuery();
	} else if (rowtype.equals("Customers")){
		SQL_2 = "select name, amount, uid from ";
		if(cateid == -1) {
			SQL_2 += "prec_uid left join users u on uid = u.id ";
			if(!state.equals("All")) {
				SQL_2 += "where state = ? ";
			}
		} else {
			SQL_2 += "prec_uid_cid left join users u on uid = u.id where cid = " + cateid + " ";
			if(!state.equals("All")) {
				SQL_2 += "and state = ? ";
			}
		}
		SQL_2 += "order by amount desc limit " + num_row;
		
		pstmt2=conn.prepareStatement(SQL_2);
		if(!state.equals("All")){
			pstmt2.setString(1, state);
		}
		rs_2=pstmt2.executeQuery();
		
	}
		
		
		
		
		
		int i=0, j=0, pindex=0;
		int[] pidarray = new int[10];
	%>
		<table align="center" width="98%" border="1">
			<tr align="center">
				<%
				if(rowtype.equals("States")){
				%>
				<td size=10><strong><font color="#FF0000">STATE</font></strong></td>
				<%
				} else if (rowtype.equals("Customers")) {
				%>
				<td size=10><strong><font color="#FF0000">CUSTOMER</font></strong></td>
				<%
				}
				while(rs.next()) {%>
				<td><strong><%=rs.getString(1)%><br>[<%=rs.getInt(2)%>]</strong></td>
				<%
					pidarray[pindex++] = rs.getInt(3);
				}
				%>
				
				
			</tr>
			
			<%
			if (rowtype.equals("Customers")){
				SQL_3 = "select p3.uid, p3.pid, p3.amount from ";
				if(cateid != -1 || !state.equals("All")) {
					SQL_3 += "(select uid, amount from ";
					if(!state.equals("All") && cateid == -1) {
						SQL_3 += "prec_uid p1, ";
					} else {
						SQL_3 += "prec_uid_cid p1, ";
					}
					SQL_3 += "users u where uid=u.id ";
					if(cateid!=-1) {
						SQL_3 += "and cid = " + cateid + " ";
					} 
					if(!state.equals("All")) {
						SQL_3 += "and u.state = ? ";
					}		
					SQL_3 += "order by amount desc limit 20) p1, ";
					if(cateid!=-1 && state.equals("All")) {
						SQL_3 += "(select * from prec_pid p2, products p ";
					} else {
						SQL_3 += "(select pid, amount from prec_state_pid p2, products p ";
					}
					SQL_3 += "where pid =p.id ";
					if(cateid!=-1) {
						SQL_3 += "and cid = " + cateid + " ";
					} 
					if(!state.equals("All")) {
						SQL_3 += "and state = ? ";
					}
					SQL_3 += "order by amount desc limit 10) p2, " +
							"(select uid, pid, amount from " +
							"prec_uid_pid p3, users u, products p " +
							"where p3.uid = u.id and p3.pid = p.id ";		
					if(cateid!=-1) {
						SQL_3 += "and p.cid = " + cateid + " ";
					} 
					if(!state.equals("All")) {
						SQL_3 += "and u.state = ? ";
					}
					SQL_3 += ")p3 ";

				} else {
					SQL_3 += "(select * from prec_uid p1 order by amount desc limit 20)p1, " +
							"(select * from prec_pid p2 order by amount desc limit 10)p2, " +
							"prec_uid_pid p3 ";
				}
				SQL_3 += "where p1.uid = p3.uid and p2.pid = p3.pid order by p1.amount desc, p2.amount desc";
				pstmt_cell=conn.prepareStatement(SQL_3);
				if(!state.equals("All")){
					pstmt_cell.setString(1, state);
					pstmt_cell.setString(2, state);
					pstmt_cell.setString(3, state);
				}
				rs_cell=pstmt_cell.executeQuery();
				rs_cell.next();
			} else if (rowtype.equals("States")) {
				if(!state.equals("All")) {
					SQL_3 = "select state, pid, amount from prec_state_pid p2, products p " +
							"where pid =p.id and state = ? ";
					if(cateid!=-1) {
						SQL_3 += "and cid = " + cateid + " ";
					} 
					SQL_3 += "order by amount desc limit 10";
				} else {
					SQL_3 = "select p3.state, p3.pid, p3.amount from ";
					if(cateid == -1){
						SQL_3 += "(select * from prec_state p1 order by amount desc limit 20)p1, " +
								"(select * from prec_pid p2 order by amount desc limit 10)p2, " +
								"prec_state_pid p3 ";
						
					} else {
						SQL_3 += "(select state, amount from prec_state_cid p1 " +
								"where cid = " + cateid + " " + 
								"order by amount desc limit 20) p1, ";
						SQL_3 += "(select pid, amount from prec_pid p2, products p " +
								"where pid =p.id and cid = " + cateid + " " + 
								"order by amount desc limit 10) p2, ";
						SQL_3 += "(select state, pid, amount from prec_state_pid p3, products p " +
								"where p3.pid = p.id " +
								"and p.cid = " + cateid + ")p3 ";
						
					}
					SQL_3 += "where p1.state = p3.state and p2.pid = p3.pid " +
							"order by p1.amount desc, p2.amount desc";
				}
				
						
				pstmt_cell=conn.prepareStatement(SQL_3);
				if(!state.equals("All")){
					pstmt_cell.setString(1, state);
				}
				rs_cell=pstmt_cell.executeQuery();
				rs_cell.next();
			}
			
			while(rs_2.next()){
				
			%> 		
			<tr>
				<td><strong><%=rs_2.getString(1)%>[<%=rs_2.getInt(2)%>]</strong></td>
				<%
			
				if(rowtype.equals("States")){
						String cur_state = rs_2.getString(1);
						boolean hasnext =true;
						for(i = 0; i < num_p; i++) {
							if(hasnext && rs_cell.getString(1).equals(cur_state) && rs_cell.getInt(2) == pidarray[i]) {
								%><td><font color='#0000ff'><%=rs_cell.getInt(3)%></font></td><%
								if(!rs_cell.next()) hasnext = false;
							} else {
								%><td><font color='#ff0000'>0</font></td><% 
							}
						}
						%></tr><%
				} else if (rowtype.equals("Customers")){
						int cur_uid = rs_2.getInt(3);
						boolean hasnext = true;
						for(i = 0; i < num_p; i++) {
							if(hasnext && rs_cell.getInt(1) == cur_uid && rs_cell.getInt(2) == pidarray[i]) {
								%><td><font color='#0000ff'><%=rs_cell.getInt(3)%></font></td><%
								if(!rs_cell.next()) hasnext = false;
							} else {
								%><td><font color='#ff0000'>0</font></td><% 
							}
						}
						%></tr><%
					
		
				}
			%>
			</tr>
			<%
			}
			%>
			</tr>
		</table>
			<%
			Timestamp d2 = new Timestamp(System.currentTimeMillis()); 
			%>
			<%= d2%>
			<%
	

	}
}
catch(Exception e)
{
	//out.println("<font color='#ff0000'>Error.<br><a href=\"login.jsp\" target=\"_self\"><i>Go Back to Home Page.</i></a></font><br>");
  out.println(e.getMessage());
}
finally
{
	conn.close();
}	
%>	
</body>
</html>