<%--
    Document   : receipt
    Created on : Apr 24, 2018, 4:48:24 AM
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
      <title>Checkout Page</title>
      <style>
        body{
          background: #f8f9fa!important;
        }
      </style>
  </head>
    <body>
      <jsp:include page="includes/header.jsp"/>
<%

  String AddressSource= "";
  String AddressDest= "";
  String sourceZone=null;
  String destZone="";
  String email="";
  String customer="";
  String customer_name="";
  String customer_address="";
  String customer_phone="";
  String customer_postalcode="";

  String paymentMethod="";

  float firstKiloCost=0;
  float secondKiloCost=0;
  double shippingCost=0;
  int result =0;
  int lastInsertedID=0;

  if(request.getParameter("address-line1") != null)
             AddressSource = request.getParameter("address-line1");
  if(request.getParameter("address-line2") != null)
            AddressDest = request.getParameter("address-line2");
  if(request.getParameter("email") != null)
            email = request.getParameter("email");
  if(request.getParameter("paymentMethod") != null)
            paymentMethod = request.getParameter("paymentMethod");

//from the city , i got the source zone and the destZone
                 sourceZone=shipping.WhichZone(AddressSource);
                 destZone=shipping.WhichZone(AddressDest);
out.println("<div class='btn btn-success'>"+sourceZone+"</div>");
out.println("<div class='btn btn-success'>"+destZone+"</div>");

                 firstKiloCost=shipping.KiloCost(sourceZone,destZone,"1");
                 secondKiloCost=shipping.KiloCost(sourceZone,destZone,"0");
                 out.println("<div class='btn btn-success'>"+firstKiloCost+"</div>");
                 out.println("<div class='btn btn-success'>"+secondKiloCost+"</div>");
                 out.println("<div class='btn btn-success'>"+paymentMethod+"</div>");


%>

<%
session.setMaxInactiveInterval(1800); // make session expire after 30 minutes

if (customer != null && paymentMethod != null) {
  synchronized(session)  // lock the session
  {
    lastInsertedID=cart.checkOut(out,customer,paymentMethod);

  }

}

%>

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
  PreparedStatement prep = conn.prepareStatement("Select * from custmers_t WHERE custmer_email=?");
    prep.setString(1, email);
  ResultSet rs = prep.executeQuery();
  // process results one row at a timne
  while(rs.next())
  {
   customer_name=rs.getString(2);
    customer_address=rs.getString(6);
    customer_phone=rs.getString(3);
    customer_postalcode=rs.getString(7);

    customer=rs.getString(1);

    out.println("<div class='btn btn-success'>"+rs.getString(1)+"</div>");

%>














<div class="receipt-content">
<div class="container bootstrap snippet">
<div class="row">
<div class="col-md-12">
<div class="invoice-wrapper" id="content">
<div class="intro">
Hi <strong><%=rs.getString(2)%></strong>,
<br>
This is the receipt for a payment of <strong><%=cart.totalPrice(out,firstKiloCost,secondKiloCost,1)%></strong> (USD) for your works
</div>

<div class="payment-info">
<div class="row">
<div class="col-sm-6">
<span>Payment No.</span>

<strong><%=lastInsertedID%></strong>
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



<%-- insert the receipt time and data --%>

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
  PreparedStatement prep2 = conn.prepareStatement("Select * from orders_t WHERE idorder_id=?");
  prep2.setInt(1,lastInsertedID);
  ResultSet rs2 = prep2.executeQuery();
  // process results one row at a timne
  while(rs2.next())
  {


%>


<div class="col-sm-6 text-right">
<span>Payment Date</span>
<strong><%=rs2.getString(2)%></strong>
</div>

<%
}
         prep2.close();
         conn.close();
        }
        catch(Exception ex)
        {
          out.println("Sorry, the system is unavailable<br/>");
          out.println(ex.toString()+"<br/>");
        }

%>


</div>
</div>

<%-- get the customer details --%>



<div class="payment-details">
<div class="row">
<div class="col-sm-6">
<span>Client</span>
<strong><%=customer_name%></strong>
<p><span>Address:</span>
<%=customer_address%><br>
<span>Phone:</span><%=customer_phone%><br>
<span>Postal address:</span><%=customer_postalcode%> <br>
<br>
<a href="#">
<%=email%>
</a>
</p>
</div>



<div class="col-sm-6 text-right">
<span>Payment To</span>
<strong>
our awesome company
</strong>
<p>
344 9th Avenue <br>
Zagaging <br>
99383 <br>
Egypt <br>
<a href="#">
OTG@gmail.com
</a>
</p>
</div>
</div>
</div>

<%-- shipping info  --%>


<div class="payment-details ">
  <h4 class="text-center" style="color: #A9B0BB;">Shipping info</h4>
<div class="row">
<div class="col-sm-6">
<span>source</span>
<strong><%=AddressSource%></strong>

</p>
</div>



<div class="col-sm-6 text-right">
<span>Description</span>
<strong><%=AddressDest%></strong>

</div>
</div>
</div>

<h5 class="text-success">Total shipping Price</h5><span><%=cart.totalPrice(out,firstKiloCost,secondKiloCost,0)%></span>




<div class="line-items">
						<div class="headers clearfix">
							<div class="row">
								<div class="col-sm-4">Description</div>
								<div class="col-sm-3">Quantity</div>
								<div class="col-sm-5 text-right">Amount</div>
							</div>
						</div>

						<%-- <div class="items">
							<div class="row item">
								<div class="col-sm-4 desc">
									Html theme
								</div>
								<div class="col-sm-3 qty">
									3
								</div>
								<div class="col-sm-5 amount text-right">
									$60.00
								</div>
							</div>


						</div> --%>
            <%cart.lineItemsDisplay(out,firstKiloCost,secondKiloCost);%>


            <%-- print the receipt --%>
            <div id="editor"></div>


						<div class="print" id="cmd">
							<button onclick="javascript:demoFromHTML();">
								<i class="fa fa-print"></i>
								Print this receipt
							</button>
						</div>
					</div>
				</div>

				<div class="footer">
					Copyright © 2018. company name
				</div>
			</div>
		</div>
	</div>
</div>
<script>
function demoFromHTML() {
var pdf = new jsPDF('p', 'pt', 'letter');
// source can be HTML-formatted string, or a reference
// to an actual DOM element from which the text will be scraped.
source = $('#content')[0];

// we support special element handlers. Register them with jQuery-style
// ID selector for either ID or node name. ("#iAmID", "div", "span" etc.)
// There is no support for any other type of selectors
// (class, of compound) at this time.
specialElementHandlers = {
    // element with id of "bypass" - jQuery style selector
    '#editor': function (element, renderer) {
        // true = "handled elsewhere, bypass text extraction"
        return true
    }
};
margins = {
    top: 80,
    bottom: 60,
    left: 40,
    width: 522
};
// all coords and widths are in jsPDF instance's declared units
// 'inches' in this case
pdf.fromHTML(
source, // HTML string or DOM elem ref.
margins.left, // x coord
margins.top, { // y coord
    'width': margins.width, // max width of content on PDF
    'elementHandlers': specialElementHandlers
},

function (dispose) {
    // dispose: object with X, Y of the last line add to the PDF
    //          this allow the insertion of new lines after html
    pdf.save('Test.pdf');
}, margins);
}
</script>






</body>
