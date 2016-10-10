<%@ page language="java"  contentType="text/html; charset=utf-8" %>
<%
String registpage=request.getParameter("r");
request.getSession().removeAttribute("user_id"); 
if(registpage==null){
response.sendRedirect("login.jsp");
}else{
response.sendRedirect("register.jsp");
}


%>