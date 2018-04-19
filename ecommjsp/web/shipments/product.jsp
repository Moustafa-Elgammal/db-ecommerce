<%--
    Document   : product
    Created on : Mar 28, 2018, 1:27:46 AM
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
      <title>product Page</title>
      
    </head>
    <body>
      <%
      String productName="";
      String Quantity="";

      if(request.getParameter("productName") != null){
          productName = request.getParameter("productName");
          productName=productName.toLowerCase();
      }
      if(request.getParameter("quantity") != null){
          Quantity = request.getParameter("quantity");
      }

      %>
      <jsp:include page="includes/header.jsp"/>
      <section class="jumbotron text-center">
          <div class="container">
              <h1 class="jumbotron-heading">Product Details</h1>
              <p class="lead text-muted mb-0">Detailed info about this product  And you can search for specific product in the search by name</p>
          </div>
        </section>
      <div class="container">
          <div class="row">
              <div class="col">
                  <nav aria-label="breadcrumb">
                      <ol class="breadcrumb">
                          <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                          <li class="breadcrumb-item active" aria-current="page"><%out.println(""+productName);%></li>
                      </ol>
                  </nav>
              </div>
          </div>
      </div>

      <div class="container">
          <div class="row">
              <!-- Image -->
              <div class="col-12 col-lg-6">
                  <div class="card bg-light mb-3">
                      <div class="card-body">
                          <a href="" data-toggle="modal" data-target="#productModal">
                              <img class="img-fluid" src="../Design/shipments/images/largepic.png" />
                              <p class="text-center">Zoom</p>
                          </a>
                      </div>
                  </div>
              </div>
<%
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
  // process results one row at a timne
  while(rs.next())
  {
%>
              <!-- Add to cart -->
              <div class="col-12 col-lg-6 add_to_cart_block">
                  <div class="card bg-light mb-3">
                      <div class="card-body">
                          <%out.println("<p class='price'>"+rs.getString(4)+"$"+"</p>");%>

                          <p class="price_discounted">149.90 $</p>


                          <form method="get" action="?">

                              <div class="form-group">
                                  <label>Quantity :</label>
                                  <div class="input-group mb-3">
                                      <div class="input-group-prepend">
                                          <button type="button" class="quantity-left-minus btn btn-danger btn-number"  data-type="minus" data-field="">
                                              <i class="fa fa-minus"></i>
                                          </button>
                                      </div>
                                      <input type="text" class="form-control"  id="quantity" name="quantity" min="1" max="100" value="1">
                                      <input type="hidden" name="id" value="<%out.print(rs.getString(1));%>">
                                      <input type="hidden" name="price" value="<%out.print(rs.getString(4));%>">
                                      <input type="hidden" name="name" value="<%out.print(rs.getString(2));%>">
                                      <input type="hidden" name="weight" value="<%out.print(rs.getString(6));%>">
                                      <input type="hidden" name="productName" value="<%out.print(rs.getString(2));%>">




                                      <div class="input-group-append">
                                          <button type="button" class="quantity-right-plus btn btn-success btn-number" data-type="plus" data-field="">
                                              <i class="fa fa-plus"></i>
                                          </button>
                                      </div>
                                  </div>
                              </div>

                                     <button class="btn btn-success btn-lg btn-block text-uppercase" onclick='location.href="cart.jsp?quantity="+<%out.print(request.getParameter("quantity"));%>+"&id="+<%out.print(request.getParameter("id"));%>+"price="+<%out.print(request.getParameter("price"));%>+"&name="+<%out.print(request.getParameter("name"));%>+"&weight="+<%out.print(request.getParameter("weight"));%>"' type="submit">
                                          Add to cart</button>


                          </form>
                          <div class="product_rassurance">
                              <ul class="list-inline">
                                  <li class="list-inline-item"><i class="fa fa-truck fa-2x"></i><br/>Fast delivery</li>
                                  <li class="list-inline-item"><i class="fa fa-credit-card fa-2x"></i><br/>Secure payment</li>
                                  <li class="list-inline-item"><i class="fa fa-phone fa-2x"></i><br/>+33 1 22 54 65 60</li>
                              </ul>
                          </div>
                          <div class="reviews_product p-3 mb-2 ">
                              3 reviews
                              <i class="fa fa-star"></i>
                              <i class="fa fa-star"></i>
                              <i class="fa fa-star"></i>
                              <i class="fa fa-star"></i>
                              <i class="fa fa-star"></i>
                              (4/5)
                              <a class="pull-right" href="#reviews">View all reviews</a>
                          </div>
                          <div class="datasheet p-3 mb-2 bg-info text-white">
                          </div>
                      </div>
                  </div>
              </div>
          </div>

          <div class="row">
              <!-- Description -->
              <div class="col-12">
                  <div class="card border-light mb-3">
                      <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-align-justify"></i> Description</div>
                      <div class="card-body">
                      <!-- Small Description -->

                                <%out.println("<p class='card-text'>"+rs.getString(3)+"</p>");%>

                          <!-- Large Description -->
                          <%out.println("<p class='card-text'>"+rs.getString(10)+"</p>");%>



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
%>

              <!-- Reviews -->

          </div>
      </div>



      <%
       //
       // set the session's inactive interval
       //
        session.setMaxInactiveInterval(1800); // 30 minutes
        //shoppingCart_ItemCount+=2;
        // session.setAttribute("count",shoppingCart_ItemCount);
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
  <h1 class="text-center "> Reviews</h1>
  <div class="container">
  <div id="disqus_thread"></div>
</div>

      <jsp:include page="includes/footer.html"/>

      <script>

  $(document).ready(function(){
      var quantity = 1;

      $('.quantity-right-plus').click(function(e){
          e.preventDefault();
          var quantity = parseInt($('#quantity').val());
          $('#quantity').val(quantity + 1);
      });

      $('.quantity-left-minus').click(function(e){
          e.preventDefault();
          var quantity = parseInt($('#quantity').val());
          if(quantity > 1){
              $('#quantity').val(quantity - 1);
          }
      });

  });

      </script>



      <script>



      /**
      *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
      *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables*/

      var disqus_config = function () {
      this.page.url = "http://localhost:8080/build/shipments/product.js"  // Replace PAGE_URL with your page's canonical URL variable
      this.page.identifier = <%out.print(request.getParameter("productName"));%> // Replace PAGE_IDENTIFIER with your page's unique identifier variable
      };

      (function() { // DON'T EDIT BELOW THIS LINE
      var d = document, s = d.createElement('script');
      s.src = 'https://foushecommerce.disqus.com/embed.js';
      s.setAttribute('data-timestamp', +new Date());
      (d.head || d.body).appendChild(s);
      })();
      </script>
      <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>







      </script>









<script id="dsq-count-scr" src="//foushecommerce.disqus.com/count.js" async></script>
    </body>
</html>
