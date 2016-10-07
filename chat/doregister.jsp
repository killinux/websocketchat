<%@ page language="java" import="java.sql.*,java.util.*,net.sf.json.JSONArray,com.hao.object.User" contentType="text/html; charset=GBK" %>
<%
String RL = "jdbc:mysql://killinux.com:3306/haochat?useUnicode=true&characterEncoding=utf-8&user=root&password=haoning";
String username=request.getParameter("u");
String p=request.getParameter("p");
String nickname=request.getParameter("n");
String sqlStr = "insert into users(username,nickname,img_url,passwd,other,onlinekey) values('"+username+"','"+nickname+"','00.jpg','"+p+"','我觉得可以啊！下次有机会我...',1)";
try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(RL);
			//Statement st = con.createStatement();
			PreparedStatement st = conn.prepareStatement(sqlStr, Statement.RETURN_GENERATED_KEYS);  
			int result = st.executeUpdate();
			
			ResultSet rs = st.getGeneratedKeys();  
			 if (rs.next()) {  
		        Long id = rs.getLong(1);   
		        String friend_sql = "insert into friend values('"+id+"',1)";
		        PreparedStatement friend_st = conn.prepareStatement(friend_sql); 
		        int friend_result = friend_st.executeUpdate();
		        out.println(id);   
		        request.getSession().setAttribute("user_id",id); 
		        request.getSession().setAttribute("username",username);
		        request.getSession().setAttribute("nickname",nickname);
		        
			}else{
				out.println("error");
			}
			
			rs.close();
			st.close();
			conn.close();
		} catch (Exception err) {
			out.println("err");
			err.printStackTrace();
		}
%>