<%@ page language="java"  contentType="text/html; charset=GBK" %>
<%
String registpage=request.getParameter("r");
request.getSession().removeAttribute("user_id"); 
if(registpage==null){
response.sendRedirect("login.jsp");
}else{
response.sendRedirect("register.jsp");
}


%>