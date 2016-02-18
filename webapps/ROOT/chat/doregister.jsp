<%@ page language="java" import="java.sql.*,java.util.*,net.sf.json.JSONArray,com.hao.object.User" contentType="text/html; charset=GBK" %>
<%
String RL = "jdbc:mysql://192.168.137.11:3306/haochat?useUnicode=true&characterEncoding=utf-8&user=root&password=haoning";
String u=request.getParameter("u");
String p=request.getParameter("p");
String name=request.getParameter("n");
String sqlStr = "insert into users(username,nickname,img_url,passwd,other) values('"+name+"','"+u+"','00.jpg','"+p+"','我觉得可以啊！下次有机会我...')";
try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(RL);
			//Statement st = con.createStatement();
			PreparedStatement st = conn.prepareStatement(sqlStr, Statement.RETURN_GENERATED_KEYS);  
			int result = st.executeUpdate();

			ResultSet rs = st.getGeneratedKeys();  
			 if (rs.next()) {  
		        Long id = rs.getLong(1);   
		        out.println(id);   
		        request.getSession().setAttribute("user_id",id); 
		        request.getSession().setAttribute("username",u);
		        request.getSession().setAttribute("nickname",name);
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