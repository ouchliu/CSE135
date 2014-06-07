<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="database.*"   import="java.util.*" errorPage="" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sales Anaytics</title>
<script type="text/javascript" src="js/js.js" language="javascript"></script>
</head>
<body>
<h1 align="center">Sales Anaytics</h1>
<%-- <%=session.getAttribute("rowtype")) %> --%>
<%-- <%=(Integer.parseInt((String)(session.getAttribute("cateid"))))+4%>
 --%>
<!--  (Integer)(session.getAttribute("cateid"))+5 -->
<!-- Integer.parseInt(request.getParameter("cateid")) -->
<%-- <%=request.getParameter("rowtype")%>
<%=request.getParameter("state")%>
<%=request.getParameter("cateid")%>
<%=request.getParameter("age")%>
<%=request.getParameter("startcount") %>
<%=request.getParameter("offset_c")%>
offset_s<%=request.getParameter("offset_s")%> --%>


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
Connection conn=null;
Statement stmt_3,stmt_cate, stmt_temp;
PreparedStatement pstmt, pstmt2, pstmt_p, pstmt_cell, pstmt_check, pstmt_checkq;
ResultSet rs=null,rs_2=null,rs_3=null,rs_cate=null,rs_p=null, rs_cell=null, rs_temp=null, rs_check=null, rs_checkq;
// String SQL=null;
String rowtype=null, state=null, startcount=null;
int cateid=-2, age=-2;
try { rowtype=request.getParameter("rowtype"); }catch(Exception e) { rowtype=null; }
try { state=request.getParameter("state"); }catch(Exception e) { state=null; }
try { cateid=Integer.parseInt(request.getParameter("cateid")); }catch(Exception e) { cateid=-2; }
try { age=Integer.parseInt(request.getParameter("age")); }catch(Exception e) { age=-2; }

try
{
	try{Class.forName("org.postgresql.Driver");}catch(Exception e){System.out.println("Driver error");}
	String url="jdbc:postgresql://127.0.0.1:5432/P1";
	String user="postgres";
	String password="Hh_2010";
	conn =DriverManager.getConnection(url, user, password);
	
/*  	stmt_2 =conn.createStatement();
 */	stmt_3 =conn.createStatement();
	stmt_cate =conn.createStatement();	

	rs_cate = stmt_cate.executeQuery("SELECT id, name FROM categories"); 
%>
<%
if(request.getParameter("offset_c")==null && request.getParameter("offset_p")==null && request.getParameter("offset_s")==null) {
%>	
<form action="sales_analytics.jsp" method="POST">
		<input type="hidden" name="startcount" value="startcount"/>
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
		<strong>Age:</strong>
		<select name="age">
			<option value=-1></option>
			<% if(request.getParameter("age")!=null && Integer.parseInt(request.getParameter("age"))==-1){
				%>
				<option selected value=-1>All Ages</option> 
				<%} else {
					%>
				<option value=-1>All Ages</option> 
					<% 
				}
			String[] ages = {"12-18", "19-45", "46-65", "66-"};
				for(int i=0; i<4; i++){
					if(request.getParameter("age")!=null && Integer.parseInt(request.getParameter("age"))==i+1){
						%>
						<option selected value=<%=i+1%>><%=ages[i]%></option> 
						<%} else {
							%>
						<option value=<%=i+1%>><%=ages[i]%></option>
							<% 
						}
				}
			%>
		</select>

		<br>
		<input type="submit" value="Run Query">
</form>

<%
}	
	if(rowtype!=null && state!=null && cateid!=-2 && age!=-2)
	{
		%>
			<%-- <%=rowtype %><br>
			<%=state %><br>
			<%=cateid %><br>
			<%=age %><br> --%>
	
		<%
		int offset_c = 0;
		int offset_p = 0;
		int offset_s = 0;
		if(request.getParameter("startcount")==null){
			if(request.getParameter("offset_c")!=null){
			offset_c=Integer.parseInt(request.getParameter("offset_c"));
			}
			if(request.getParameter("offset_s")!=null){
				offset_s=Integer.parseInt(request.getParameter("offset_s"));
				}
			if(request.getParameter("offset_p")!=null){
			offset_p=Integer.parseInt(request.getParameter("offset_p"));
			}
		}
			
		int min = 0;
		int max = 0;
		switch (age) {
        case 1:  min = 11;
        		 max = 19;
                 break;
        case 2:  min = 18;
		 		 max = 46;
		 		 break;
        case 3:  min = 45;
		 		 max = 66;
                 break;
        case 4:  min = 65;
		 		 max = 1000;
                 break;
    	}
		
		ResultSet rs_num_p = null;
		String SQL_count = "SELECT count(*) FROM (select id from products ";
		if(cateid!=-1){
			SQL_count += "WHERE cid = ?";
		}
		SQL_count += "limit 10 offset " + offset_p +") p";
		
		
		PreparedStatement pstmt_num_p = conn.prepareStatement(SQL_count);
		if(cateid!=-1){
			pstmt_num_p.setInt(1, cateid);
		}
		rs_num_p= pstmt_num_p.executeQuery();
		rs_num_p.next();
		//products number
		num_p = rs_num_p.getInt("count");  	
	
		String SQL_1=null, SQL_2=null, SQL_3=null;
		
		//Products Query(the fist row)
		SQL_1 = "select p.id, p.name, sum(q1.quantity*q1.price) as amount "+
		"from products p left join ";
		if(age==-1) {
			if (state.equals("All")){
				SQL_1 += "sales q1 ";
			} else {
				SQL_1 += "(select * from sales q1, users uu " +
						"where q1.uid = uu.id and uu.state = '" +
						state +
						"') AS q1 ";
			}
			SQL_1 += "on q1.pid=p.id ";
		} else {
			SQL_1 += "(select * from sales s, users u where s.uid = u.id and u.age > "
					+ min + " and u.age < " + max;
			if(!state.equals("All")) {
				SQL_1 += " and u.state = '" + state + "'";
			}
			SQL_1 += ") AS q1 on q1.pid=p.id ";
		}
		if(cateid!=-1){
			SQL_1 += "where p.cid = ? ";
		}
		SQL_1 += "group by p.name,p.id "+
		 "order by  p.name asc " +
		 "limit 10 offset " + offset_p;
		pstmt=conn.prepareStatement(SQL_1);
		if(cateid!=-1){
			pstmt.setInt(1, cateid);
		}
		rs=pstmt.executeQuery();
		
	//Customers or States query
	if(rowtype.equals("States")) {
		SQL_2 = "select  u.state, sum(s.quantity*p.price) as amount from users u, sales s,  products p "+
				  "where s.uid=u.id and s.pid=p.id ";
		if(age!=-1){
			SQL_2 += "and u.age > " + min + " and u.age < " + max + " ";
		}
		if(cateid!=-1){
			SQL_2 += " and p.cid = ?";
		}
		SQL_2 += " group by u.state "+ 
				  "order by u.state asc "/* +
				  "limit 20;" */;
		pstmt2=conn.prepareStatement(SQL_2);
		if(cateid!=-1){
			pstmt2.setInt(1, cateid);
		}
		
		rs_2=pstmt2.executeQuery();//state not id, many users in one state
		while(rs_2.next()) {
			states_sales.put(rs_2.getString(1), (Integer)(rs_2.getInt(2)));
		}
	} else if (rowtype.equals("Customers")){
		SQL_2 = "select uu.id, uu.name, amount from users uu left join " +
		"(select  u.id, sum(s.quantity*p.price) as amount " +
		"from users u, sales s,  products p " +
		"where s.uid=u.id and s.pid=p.id ";
		if(age!=-1){
			SQL_2 += "and u.age > " + min + " and u.age < " + max + " ";
		}
		if(cateid!=-1){
			SQL_2 += " and p.cid = " + cateid;
		}
		SQL_2 += " group by u.id) q1 on uu.id = q1.id ";
		if(!state.equals("All")) {
			SQL_2 += " where uu.state = '" + state + "' ";
		}
		if(age!=-1){
			if(state.equals("All")){SQL_2 += "where ";}
			else {SQL_2 += "and ";}
			SQL_2 += "uu.age > " + min + " and uu.age < " + max + " ";
		}
		SQL_2 += "order by uu.name asc";
		
		//state not id, many users in one state

		String SQL_temp = "Create Temporary Table temp_c AS (";
		SQL_temp += SQL_2 + ")";
		stmt_temp = conn.createStatement();
		stmt_temp.execute(SQL_temp); 
		
		String SQL_cu = "select * from temp_c limit 20 offset " + offset_c; 
		pstmt2=conn.prepareStatement(SQL_cu);
		rs_2=pstmt2.executeQuery();
		
	}
		
		
		
		
		
		int i=0,j=0;
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
				<td><strong><%=rs.getString(2)%><br>[<%=rs.getInt(3)%>]</strong></td>
				<%}
				
				String SQL_checkq = "select * from products ";
				if(cateid!=-1){
					SQL_checkq += "where cid = ? ";
				}
				SQL_checkq += "limit 1 offset " + (offset_p+10); 
				pstmt_checkq=conn.prepareStatement(SQL_checkq);
				if(cateid!=-1){
					pstmt_checkq.setInt(1, cateid);
				}
				rs_checkq=pstmt_checkq.executeQuery();
					if(rs_checkq.next()){
				%>
					<form action="sales_analytics.jsp" method="POST">
					<input type="hidden" name="rowtype" value=<%=rowtype%>>
					<input type="hidden" name="state" value=<%=state%>>
					<input type="hidden" name="cateid" value="<%=cateid%>"/>
					<input type="hidden" name="age" value="<%=age%>"/>
					<input type="hidden" name="offset_p" value="<%=offset_p + 10%>"/>
					<%if(offset_c!=0) {%>
					<input type="hidden" name="offset_c" value="<%=offset_c%>"/>
					<%} %>
					<%if(offset_s!=0) {%>
					<input type="hidden" name="offset_s" value="<%=offset_s%>"/>
					<%} %>
					<td><input type="submit" value="Next 10 Products"></td>
					</form>
				<% 	
					}
				%>
				
				
			</tr>
			<%
				if(rowtype.equals("States")){
					if(!state.equals("All")){
					%>
						<tr>
						<td><strong><%=state%>[<%=states_sales.get(state) %>]</strong></td>
						<%
						SQL_3="select pp.id, pp.name, t1.amount from " +
								"(select * from products pp ";
						if(cateid!=-1){
							SQL_3 += "where cid = " + cateid + " ";
						} 
						SQL_3 += "order by name offset " + offset_p + " limit 10) pp " +
								"left join (select p.id, SUM(s.price*s.quantity) as amount " +
								"from sales s, products p, users u " +
								"where s.pid=p.id and s.uid=u.id and u.state = ? ";
						if(age!=-1){
							SQL_3 += "and u.age > " + min + " and u.age < " + max + " ";
						}
						SQL_3 += "group by p.id) AS t1 on t1.id=pp.id "; 
						SQL_3 += "order by pp.name";
						pstmt_cell = conn.prepareStatement(SQL_3);
							pstmt_cell.setString(1, state);
						
						rs_cell = pstmt_cell.executeQuery();
							while(rs_cell.next()) {
								Integer cell_amount = rs_cell.getInt(3);
								if(cell_amount!=0){
									%><td><font color='#0000ff'><%=cell_amount%></font></td><% 
								} else {
									%><td><font color='#ff0000'>0</font></td><% 
								}
							}
						%>
					</tr>
					<% 
					} else {
						 
						for(i=offset_s;i<offset_s+20;i++) {
							if(i==50) break;
						%>
						<tr>
							<td><strong><%=statesarray[i]%>[<%=states_sales.get(statesarray[i]) %>]</strong></td>
							<%
							
							SQL_3="select pp.id, pp.name, t1.amount from " +
									"(select * from products pp ";
							if(cateid!=-1){
								SQL_3 += "where cid = " + cateid + " ";
							} 
							SQL_3 += "order by name offset " + offset_p + " limit 10) pp " +
									"left join (select p.id, SUM(s.price*s.quantity) as amount " +
									"from sales s, products p, users u " +
									"where s.pid=p.id and s.uid=u.id and u.state = ? ";
							if(age!=-1){
								SQL_3 += "and u.age > " + min + " and u.age < " + max + " ";
							}
							SQL_3 += "group by p.id) AS t1 on t1.id=pp.id "; 
							SQL_3 += "order by pp.name";
							pstmt_cell = conn.prepareStatement(SQL_3);
 							pstmt_cell.setString(1, statesarray[i]);
 							/* if(cateid!=-1){
								pstmt_cell.setInt(1, cateid);
							} */
		
							rs_cell = pstmt_cell.executeQuery();
								while(rs_cell.next()) {
									Integer cell_amount = rs_cell.getInt(3);
									if(cell_amount!=0){
										%><td><font color='#0000ff'><%=cell_amount%></font></td><% 
									} else {
										%><td><font color='#ff0000'>0</font></td><% 
									}
								}
							%>
						</tr>
						<%
						}
						if(offset_s < 21){				
						%>
						<form action="sales_analytics.jsp" method="POST">
						<input type="hidden" name="rowtype" value=<%=rowtype%>>
						<input type="hidden" name="state" value=<%=state%>>
						<input type="hidden" name="cateid" value="<%=cateid%>"/>
						<input type="hidden" name="age" value="<%=age%>"/>
						<input type="hidden" name="offset_s" value="<%=offset_s + 20%>"/>
						<%if(offset_p!=0) {%>
						<input type="hidden" name="offset_p" value="<%=offset_p%>"/>
						<%} %>
						<tr><td><input type="submit" value="Next 20 States"></td></tr>
						</form>
						<%
						}
					}
					
					%>
					
				</table>
			
		<!-- 		session.setAttribute("TOP_10_Products",p_list);
		 -->	<% 
					
				} else if (rowtype.equals("Customers")){
					SQL_3 = "select t1.uid, pp.uname uname, pp.id pid, pp.name pname, t1.amount from " +
							"(select pc.id, pc.name, pc.cid, uc.id uid, uc.name uname " +
							"from (select * from products pc ";
					if(cateid!=-1){
						SQL_3 += "where cid = ? ";
					}
					SQL_3 += "order by name offset " + offset_p + " limit 10) pc," + "temp_c uc ";	
					SQL_3 +=") AS pp left join " +
							"(select u.name, s.uid, p.id, SUM(s.price*s.quantity) as amount " +
							"from sales s, products p, temp_c u where s.pid=p.id and s.uid=u.id " +
							"group by p.id, s.uid, u.name order by uid) AS t1 " +
							"on t1.id=pp.id and t1.uid=pp.uid "; 
					SQL_3 += "and pp.id in (select id from products ";
					SQL_3 += "order by name) order by uname, pname";
					
					pstmt_cell = conn.prepareStatement(SQL_3);
					if(cateid!=-1){
						pstmt_cell.setInt(1, cateid);
					}
					rs_cell = pstmt_cell.executeQuery();
					for(j=0;j<(offset_c*num_p);j++){
						rs_cell.next();
					}
					/* for(j=0;j<(offset_c*num_p);j++){
						rs_cell.next();
					} */
					while(rs_2.next()){
				%>
					<tr>
							<td><strong><%=rs_2.getString(2)%>[<%=rs_2.getInt(3)%>]</strong></td>
						
				<%	
						for(i=0;i<num_p;i++){
							
							rs_cell.next();
							Integer cell_amount = rs_cell.getInt(5);
							if(cell_amount!=0){
								%><td><font color='#0000ff'><%=cell_amount%></font></td><% 
							} else {
								%><td><font color='#ff0000'>0</font></td><% 
							}
						}
				%>
					</tr>
					
				<%
					}		
					
					String SQL_check = "select * from temp_c limit 1 offset " + (offset_c+20); 
					pstmt_check=conn.prepareStatement(SQL_check);
					rs_check=pstmt_check.executeQuery();
					if(rs_check.next()){
				%>
					<form action="sales_analytics.jsp" method="POST">
					
					<input type="hidden" name="rowtype" value=<%=rowtype%>>
					<input type="hidden" name="state" value=<%=state%>>
					<input type="hidden" name="cateid" value="<%=cateid%>"/>
					<input type="hidden" name="age" value="<%=age%>"/>
					<input type="hidden" name="offset_c" value="<%=offset_c + 20%>"/>
					<%if(offset_p!=0) {%>
					<input type="hidden" name="offset_p" value="<%=offset_p%>"/>
					<%} %>
					<tr><td><input type="submit" value="Next 20 Customers"></td></tr>
					</form>
				<% 	
					}
				}
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