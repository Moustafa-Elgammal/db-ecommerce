<%--
    Document   : findProduct
    Created on : Mar 29, 2018, 9:42:11 AM
    Author     : foush
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Find product page</title>
    </head>
    <body>
        <h1>product match</h1>
        <%
          String productName="";

          if(request.getParameter("productName") != null){
              productName = request.getParameter("productName");
              productName=productName.toLowerCase();
}




               //
   // database work
   //
        try{
          // JDBC driver name and database URL
           String JDBC_DRIVER = "com.mysql.jdbc.Driver";
           String DB_URL = "jdbc:mysql://localhost/Ecommerce";

          //  Database credentials
           final String USER = "root";
           final String PASS = "";
         // open a connection
          Connection conn = null;
          Class.forName("com.mysql.jdbc.Driver");  // load the driver
          System.out.println("Connecting to database...");
          conn = DriverManager.getConnection(DB_URL,USER,PASS);
      // create the sql command
      System.out.println("Creating statement...");

          PreparedStatement prep = conn.prepareStatement("Select * from products_t WHERE product_name=?");
          prep.setString(1,productName);

          ResultSet rs = prep.executeQuery();
   %>
   <table border ="1">
       <tr>
        <td>Name </td>
        <td>Description</td>
        <td>Price</td>
        <td>Weight</td>
        </tr>
    <%
         // process results one row at a timne
         while(rs.next())
         {
         out.println("<tr>");
         out.println("<td>"+rs.getString(2)+"</td>");
         out.println("<td>"+rs.getString(3)+"</td>");
         out.println("<td>"+rs.getString(4)+"</td>");
         out.println("<td>"+rs.getString(5)+"</td>");
         out.println("<td>"+rs.getString(6)+"</td>");
         out.println("<td>"+rs.getString(7)+"</td>");
         out.println("<td>"+rs.getString(8)+"</td>");
         out.println("<td><a href='deleteCourse.jsp?CRN="+rs.getString(1)+"'><input type='button' value='delete'/></A></td>");
         String name =rs.getString(2);
         name = java.net.URLEncoder.encode(name, "UTF-8");  // fix name into a url ok
         out.println("<td><a href='addItemToCart.jsp?id="+rs.getString(1)+"&name="+name+"&quantity=1&price=9.95"+
                      "'><input type='button' value='add'/></A></td>");

          out.println("</tr>");
         }

   %>
   </table>
   <%
        prep.close();
        conn.close();
       }
       catch(Exception ex)
       {
         out.println("Sorry, the system is unavailable<br/>");
         out.println(ex.toString()+"<br/>");
       }

       %>
    </body>
</html>
