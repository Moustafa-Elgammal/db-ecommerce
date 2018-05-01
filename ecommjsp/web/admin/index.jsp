<%-- 
    Document   : index
    Created on : May 1, 2018, 4:56:44 AM
    Author     : maxxi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
      if (session.getAttribute("id") == null){
            response.sendRedirect("signin.jsp");
    }  
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <a href="logout.jsp">Sign out</a>
        <h1>Hello World!</h1>
    </body>
</html>
