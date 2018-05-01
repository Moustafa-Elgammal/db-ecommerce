<%-- 
    Document   : logout
    Created on : May 1, 2018, 4:58:48 AM
    Author     : maxxi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  session.setAttribute("id", null);
  response.sendRedirect("signin.jsp");
%>