<%--
    Document   : shipmentCalcuForm
    Created on : Mar 24, 2018, 9:34:23 AM
    Author     : foush
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="dbShipmentUtility.*"%>
<%@page errorPage = "errorPage.jsp" %>
<jsp:useBean id="item" class="dbShipmentUtility.Item" scope = "request" />
<jsp:useBean id="cart" class="dbShipmentUtility.ShoppingCart" scope ="session" />
<jsp:setProperty name="item" property="*" />


<!DOCTYPE html>
<html>
  <head>
      <title>All products</title>
  </head>
  <body>
<%
String category= "";
category = request.getParameter("category");


%>
<jsp:include page="includes/header.jsp"/>

<section class="jumbotron text-center">
    <div class="container">
        <h1 class="jumbotron-heading">All PRODUCTS</h1>
        <p class="lead text-muted mb-0">browse all the product in the store And you can search for specific product in the search by name</p>
    </div>
</section>


<div class="container">
    <div class="row">
        <div class="col">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="?">Home</a></li>
                </ol>
            </nav>
        </div>
    </div>
</div>
<jsp:include page="includes/sidebar.html"/>


<div class="col">
            <div class="row">

<%
Integer shoppingCart_ItemCount = new Integer(0);
session.setAttribute("count", shoppingCart_ItemCount);
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
  PreparedStatement prep = conn.prepareStatement("Select * from products_t WHERE category_t_category_id=? ");
    prep.setString(1, category);
  ResultSet rs = prep.executeQuery();
  // process results one row at a timne
  while(rs.next())
  {
%>

                  <div class="col-12 col-md-6 col-lg-4">
                      <div class="card" style="margin-bottom: 20px;">
                          <img class="card-img-top" src="../Design/shipments/images/fff.png" alt="Card image cap">
                          <div class="card-body">
                          <%out.println("<h4 class='card-title'>"+"<a href='product.jsp' title='View Product'>"+rs.getString(2)+"</a>"+"</h4>");%>
                          <%out.println("<p>"+rs.getString(3)+"</p>");%>
                              <div class="row">
                                  <div class="col">
                                        <%out.println("<p class='btn btn-danger btn-block'>"+rs.getString(4)+"$"+"</p>");%>
                                  </div>
                                  <div class="col">
                                      <%
                                      String name =rs.getString(2);
                                      name = java.net.URLEncoder.encode(name, "UTF-8");  // fix name into a url ok
                                      String price=rs.getString(4);
                                       %>

                                       <%out.println("<a class='btn btn-success btn-block add' href='?id="+rs.getString(1)+"&name="+name+"&quantity=1"+"&weight="+rs.getString(6)+"&price="+price+
                                                    "'>Add to cart</a>");%>
                                  </div>
                              </div>
                          </div>
                      </div>

                  </div>



<%
}
     prep.close();
     conn.close();
    }
    catch(Exception ex)
    {
      out.println("Sorry, the system is unavailable<br/>");
      out.println(ex.toString()+"<br/>");
    }
%>

<%
 //
 // set the session's inactive interval
 //
  session.setMaxInactiveInterval(1800); // 30 minutes
  shoppingCart_ItemCount+=2;
   session.setAttribute("count",shoppingCart_ItemCount);
 //
 // now add the item to the cart
 //
 synchronized(session)  // lock the session
 {
    cart.add(item); // cart uses ArrayList which is not thread safe so we locked
    //cart.display(out); // tell the cart to send its contents to the browser
  }
 %>

















</div>
</div>
</div>
</div>
 <jsp:include page="includes/footer.html"/>












    </body>
</html>
