<%--
    Document   : checkout
    Created on : Mar 31, 2018, 9:15:11 AM
    Author     : foush
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="dbShipmentUtility.*"%>
<%@page errorPage = "errorPage.jsp" %>
<jsp:useBean id="item" class="dbShipmentUtility.Item" scope = "request" />
<jsp:useBean id="shipping" class="dbShipmentUtility.ShoppingCart" scope ="request" />

<jsp:useBean id="cart" class="dbShipmentUtility.ShoppingCart" scope ="session" />
<jsp:setProperty name="item" property="*" />

<!DOCTYPE html>
<html>
  <head>
      <title>Checkout Page</title>
  </head>
    <body>
<%

  String AddressSource= "";
  String AddressDest= "";
  String sourceZone=null;
  String destZone="";
  float firstKiloCost=0;
  float secondKiloCost=0;
  double shippingCost=0;

  if(request.getParameter("address-line1") != null)
             AddressSource = request.getParameter("address-line1");
  if(request.getParameter("address-line2") != null)
            AddressDest = request.getParameter("address-line2");

//from the city , i got the source zone and the destZone
                 sourceZone=shipping.WhichZone(AddressSource);
                 destZone=shipping.WhichZone(AddressDest);
out.println("<div class='btn btn-success'>"+sourceZone+"</div>");
out.println("<div class='btn btn-success'>"+destZone+"</div>");

                 firstKiloCost=shipping.KiloCost(sourceZone,destZone,"1");
                 secondKiloCost=shipping.KiloCost(sourceZone,destZone,"0");
                 out.println("<div class='btn btn-success'>"+firstKiloCost+"</div>");
                 out.println("<div class='btn btn-success'>"+secondKiloCost+"</div>");


//calculate the shipping cost
//shippingCost=shipping.costCalculation(firstKiloCost,secondKiloCost,cart);









%>









      <jsp:include page="includes/header.jsp"/>
      <section class="jumbotron text-center">
          <div class="container">
              <h1 class="jumbotron-heading">Shipping information</h1>
              <p class="lead text-muted mb-0">please enter your Shipping information below the cart info .To get you the best shipping company</p>
          </div>
      </section>
      <div class="container test-center">
      <h1 class="text-center alert-success" >Cart info</h1>
    </div>
      <%
       //
       // set the session's inactive interval
       //
        session.setMaxInactiveInterval(1800); // 30 minutes

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
        cart.display(out,firstKiloCost,secondKiloCost);
       %>
       <jsp:include page="includes/postalAddressform.html"/>






     </div>
     </div>
     </div>
     </div>
 <jsp:include page="includes/footer.html"/>
    </body>
</html>
