<%@ page language="java" import="java.sql.*,java.util.*,net.sf.json.JSONArray,com.hao.object.User" contentType="text/html; charset=utf-8" %>
<%
System.out.println("dologin.jsp");
String RL = "jdbc:mysql://killinux.com:3306/haochat?useUnicode=true&characterEncoding=utf-8&user=root&password=haoning";
String u=request.getParameter("u");
String p=request.getParameter("p");
String sqlStr = "select * from users where username='"+u+"' and passwd='"+p+"'";
try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(RL);
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery(sqlStr);
//	List users=new ArrayList();
	User user = null;
	while (rs.next()) {
		user = new User();
		user.setId(rs.getInt("id"));
		//user.setUsername(rs.getString("username"));
	//	user.setNickname(rs.getString("nickname"));
		user.setImg_url(rs.getString("img_url"));
		user.setOther(rs.getString("other"));
		request.getSession().setAttribute("user_id",rs.getInt("id")); 
		request.getSession().setAttribute("username",rs.getString("username"));
		request.getSession().setAttribute("nickname",rs.getString("nickname"));
		System.out.println("nickname:"+rs.getString("nickname"));
		out.println(rs.getInt("id"));  
	//	users.add(user);
	}
	if(user==null){
		out.println("error");
	}
//	JSONArray jsonArray = JSONArray.fromObject( users );  
   // out.println( jsonArray );  
	rs.close();
	st.close();
	con.close();
} catch (Exception err) {
	out.println("err");
	err.printStackTrace();
}
%>