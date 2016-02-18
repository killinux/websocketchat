package com.hao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;

import com.hao.object.User;

public class Test {

	public static void main(String[] args) {
		String abc=null+"";
		System.out.println(abc);
		/*String RL = "jdbc:mysql://192.168.137.11:3306/haochat?useUnicode=true&characterEncoding=utf-8&user=root&password=haoning";
		String u="aa";//request.getParameter("u");
		String p="bb";//request.getParameter("p");
		String sqlStr = "insert into users(name,img_url,passwd,other) values('"+u+"','00.jpg','"+p+"','我觉得可以啊！下次有机会我...')";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(RL);
			//Statement st = con.createStatement();
			PreparedStatement st = conn.prepareStatement(sqlStr, Statement.RETURN_GENERATED_KEYS);  
			int result = st.executeUpdate();

			ResultSet rs = st.getGeneratedKeys();  
			 if (rs.next()) {  
		        Long id = rs.getLong(1);   
		        System.out.println("数据主键：" + id);   
		       // request.getSession().setAttribute("user_id",id); 
			}else{
				System.out.println("error");
			}
			
			rs.close();
			st.close();
			conn.close();
		} catch (Exception err) {
			err.printStackTrace();
		}*/

	}

}
