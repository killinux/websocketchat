<%@ page language="java" import="java.sql.*,java.util.*,net.sf.json.JSONArray,com.hao.object.User" contentType="text/html; charset=utf-8" %>
<%
//mysql -uroot --default-character-set=utf8 -hkillinux.com -p
/*
create table users(id int primary key auto_increment ,username varchar(30) UNIQUE   ,nickname varchar(30) UNIQUE   ,img_url varchar(50),other varchar(60),passwd varchar(30)) ENGINE=MyISAM AUTO_INCREMENT=1826 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
insert into users(id,username,nickname,img_url,other,passwd) values('1','haoba','�ð�','00.jpg','�Ҿ��ÿ��԰��ɣ��´��л�����...','123');
insert into users(id,username,nickname,img_url,other,passwd) values('2','mashengxi','����ϣ','0.jpg','�Ҿ��ÿ��԰��ɣ��´��л�����...','123');
insert into users(id,username,nickname,img_url,other,passwd) values('3','jjfz','�ƾ�����','00.jpg','�Ҿ��ÿ��ԣ��´��л�����...','123');
insert into users(id,username,nickname,img_url,other,passwd) values('4','cjk','�Ծ���','00.jpg','���ԡ�����','123');
insert into users(id,username,nickname,img_url,other,passwd) values('5','hahaha','������','00.jpg','�Ҿ��ÿ��԰������´��л�����...','123');
insert into users(id,username,nickname,img_url,other,passwd) values('6','yoyoyo','ӴӴӴ','00.jpg','�Ҿ��ÿ��԰����´��л�����...','123');
insert into users(id,username,nickname,img_url,other,passwd) values('7','yyy','ӴӴӴ','00.jpg','�Ҿ��ÿ��԰����´��л�����...','123');
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