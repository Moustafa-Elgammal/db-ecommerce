<%--
    Document   : contact
    Created on : Mar 28, 2018, 4:28:19 AM
    Author     : foush
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Contact Page</title>
    </head>
    <body>
        <h1>Hello From contact</h1>
    </body>
</html>
<%out.println("<a class='btn btn-success btn-block add' href='index.jsp?id="+rs.getString(1)+"&name="+name+"&quantity=1&price="+price+
             "'>Add to cart</a>");%>
