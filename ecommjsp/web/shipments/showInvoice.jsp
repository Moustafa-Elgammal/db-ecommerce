<%--
    Document   : showInvoice
    Created on :may 1, 2018, 6:55:24 AM
    Author     : foush
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="dbShipmentUtility.*"%>
<%@page errorPage = "errorPage.jsp" %>
<jsp:useBean id="item" class="dbShipmentUtility.Item" scope = "request" />
<jsp:useBean id="shipping" class="dbShipmentUtility.ShoppingCart" scope ="request" />

<jsp:useBean id="cart" class="dbShipmentUtility.ShoppingCart" scope ="session" />
<jsp:setProperty name="item" property="*" />

<!DOCTYPE html>
<html>
  <head>
      <title>showInvoice Page</title>
      <style>
        body{
          background: #f8f9fa!important;

        }
      </style>
  </head>
    <body>
<%

//   String AddressSource= "";
//   String AddressDest= "";
//   String sourceZone=null;
//   String destZone="";
//   String email="";
//   String customer="";
//   String paymentMethod="";
//
//   float firstKiloCost=0;
//   float secondKiloCost=0;
//   double shippingCost=0;
//   int result =0;
//
//   if(request.getParameter("address-line1") != null)
//              AddressSource = request.getParameter("address-line1");
//   if(request.getParameter("address-line2") != null)
//             AddressDest = request.getParameter("address-line2");
//   if(request.getParameter("email") != null)
//             email = request.getParameter("email");
//   if(request.getParameter("paymentMethod") != null)
//             paymentMethod = request.getParameter("paymentMethod");
//
// //from the city , i got the source zone and the destZone
//                  sourceZone=shipping.WhichZone(AddressSource);
//                  destZone=shipping.WhichZone(AddressDest);
// out.println("<div class='btn btn-success'>"+sourceZone+"</div>");
// out.println("<div class='btn btn-success'>"+destZone+"</div>");
//
//                  firstKiloCost=shipping.KiloCost(sourceZone,destZone,"1");
//                  secondKiloCost=shipping.KiloCost(sourceZone,destZone,"0");
//                  out.println("<div class='btn btn-success'>"+firstKiloCost+"</div>");
//                  out.println("<div class='btn btn-success'>"+secondKiloCost+"</div>");
//                  out.println("<div class='btn btn-success'>"+paymentMethod+"</div>");


%>

<%
//
// //
// // database work
// //
// try{
//   // JDBC driver name and database URL
//    String JDBC_DRIVER = "com.mysql.jdbc.Driver";
//    String DB_URL = "jdbc:mysql://localhost/Ecommerce";
//   //  Database credentials
//    final String USER = "root";
//    final String PASS = "";
//  // open a connection
//   Connection conn = null;
//   Class.forName("com.mysql.jdbc.Driver");  // load the driver
//   System.out.println("Connecting to database...");
//   conn = DriverManager.getConnection(DB_URL,USER,PASS);
// // create the sql command
// System.out.println("Creating statement...");


  // PreparedStatement prep = conn.prepareStatement("Select * from custmers_t WHERE custmer_email=?");
  //   prep.setString(1, email);
  // ResultSet rs = prep.executeQuery();
  // // process results one row at a timne
  // while(rs.next())
  // {
  //   customer=rs.getString(1);
  //   out.println("<div class='btn btn-success'>"+rs.getString(1)+"</div>");
  //   }
  //
  //
  //        prep.close();
  //        conn.close();
  //       }
  //       catch(Exception ex)
  //       {
  //         out.println("Sorry, the system is unavailable<br/>");
  //         out.println(ex.toString()+"<br/>");
  //       }

%>









<jsp:include page="includes/header.jsp"/>
<%
session.setMaxInactiveInterval(1800); // make session expire after 30 minutes

// if (customer != null && paymentMethod != null) {
//   synchronized(session)  // lock the session
//   {
//     cart.checkOut(out,customer,paymentMethod);
//
//   }
//
// }



%>
<jsp:include page="includes/invoice.html"/>













</body>
