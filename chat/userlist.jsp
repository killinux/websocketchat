<%@ page language="java" import="java.sql.*,java.util.*,net.sf.json.JSONArray,com.hao.object.User" contentType="text/html; charset=utf-8" %>
<%
//mysql -uroot --default-character-set=utf8 -hkillinux.com -p
/*
create table users(id int primary key auto_increment ,username varchar(30) UNIQUE   ,nickname varchar(30) UNIQUE   ,img_url varchar(50),other varchar(60),passwd varchar(30)) ENGINE=MyISAM AUTO_INCREMENT=1826 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
insert into users(id,username,nickname,img_url,other,passwd) values('1','haoba','好吧','00.jpg','我觉得可以啊吧！下次有机会我...','123');
insert into users(id,username,nickname,img_url,other,passwd) values('2','mashengxi','麻生希','0.jpg','我觉得可以啊吧！下次有机会我...','123');
insert into users(id,username,nickname,img_url,other,passwd) values('3','jjfz','酒井法子','00.jpg','我觉得可以！下次有机会我...','123');
insert into users(id,username,nickname,img_url,other,passwd) values('4','cjk','苍井空','00.jpg','测试。。。','123');
insert into users(id,username,nickname,img_url,other,passwd) values('5','hahaha','哈哈哈','00.jpg','我觉得可以啊哈！下次有机会我...','123');
insert into users(id,username,nickname,img_url,other,passwd) values('6','yoyoyo','哟哟哟','00.jpg','我觉得可以啊！下次有机会我...','123');
insert into users(id,username,nickname,img_url,other,passwd) values('7','yyy','哟哟哟','00.jpg','我觉得可以啊！下次有机会我...','123');
*/
String RL = "jdbc:mysql://killinux.com:3306/haochat?useUnicode=true&characterEncoding=utf-8&user=root&password=haoning";
String uid=request.getParameter("uid");
String sqlStr = "select * from users where id in (select fid from friend where uid='"+uid+"');";
try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(RL);
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery(sqlStr);
	List users=new ArrayList();

	while (rs.next()) {
		User user = new User();
		user.setId(rs.getInt("id"));
		user.setUsername(rs.getString("username"));
		user.setNickname(rs.getString("nickname"));
		user.setImg_url(rs.getString("img_url"));
		user.setOther(rs.getString("other"));
		users.add(user);
	}
	JSONArray jsonArray = JSONArray.fromObject( users );  
    out.println( jsonArray );  
	rs.close();
	st.close();
	con.close();
} catch (Exception err) {
	err.printStackTrace();
}
%>