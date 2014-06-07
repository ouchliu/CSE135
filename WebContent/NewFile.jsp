<%
if(cateid==-1) {
	pstmt_p = conn.prepareStatement("SELECT * FROM products");
	rs_p = pstmt_p.executeQuery(); 
	
	Statement stmt_num_p = conn.createStatement(); 
	rs_num_p= stmt_num_p.executeQuery("SELECT count(*) FROM products");
} else {
	pstmt_p = conn.prepareStatement("SELECT * FROM products WHERE cid = ?");
	pstmt_p.setInt(1, cateid);
	rs_p = pstmt_p.executeQuery(); 
	
	PreparedStatement pstmt_num_p = conn.prepareStatement("SELECT count(*) FROM products WHERE cid = ?"); 
	pstmt_num_p.setInt(1, cateid);
	rs_num_p= pstmt_num_p.executeQuery();
}
rs_num_p.next();
num_p = rs_num_p.getInt("count"); 
%>