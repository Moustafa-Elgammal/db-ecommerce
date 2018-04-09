<%--
    Document   : cart
    Created on : Mar 28, 2018, 4:18:46 AM
    Author     : foush
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dbShipmentUtility.*"%>
<%@page errorPage = "errorPage.jsp" %>
<jsp:useBean id="item" class="dbShipmentUtility.Item" scope = "request" />
<jsp:useBean id="cart" class="dbShipmentUtility.ShoppingCart" scope ="session" />
<jsp:setProperty name="item" property="*" />
<!DOCTYPE html>
<html>
  <head>
      <title>Cart Page</title>
  </head>
    <body>
      <jsp:include page="includes/header.jsp"/>

      <section class="jumbotron text-center">
          <div class="container">
              <h1 class="jumbotron-heading">Your Cart</h1>
              <p class="lead text-muted mb-0">You Can View your Cart containts Here</p>
          </div>
      </section>


                      <%

                                session.setMaxInactiveInterval(1800); // make session expire after 30 minutes
                                //
                                // Remove the item
                                String idstr = request.getParameter("id");
                                  if (idstr == null) {
                                    idstr="0";
                                  }
                                try
                                {

                                 int id = Integer.parseInt(idstr);
                                  synchronized(session)  // lock the session
                                  {
                                   cart.remove(id,out);
                                  }
                                }
                                catch(Exception ex)
                                {
                                  out.println("Error: "+ ex.toString()+ "<br/>");
                                }
                                cart.display(out,0,0);

                      %>





                    </tbody>
                </table>
            </div>
        </div>
        <div class="col mb-2">
            <div class="row">
                <div class="col-sm-12  col-md-6">
                    <a href="index.jsp" class="btn btn-block btn-light">Continue Shopping</a>
                </div>
                <div class="col-sm-12 col-md-6 text-right">
                    <a href="checkout.jsp"class="btn btn-lg btn-block btn-success text-uppercase">Checkout</a>
                </div>
            </div>
        </div>
    </div>
</div>




<%
 //
 // set the session's inactive interval
 //
  session.setMaxInactiveInterval(1800); // 30 minutes
  //shoppingCart_ItemCount+=2;
   //session.setAttribute("count",shoppingCart_ItemCount);
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
  <jsp:include page="includes/footer.html"/>

    </body>
</html>
