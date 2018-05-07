/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
 package dbShipmentUtility;

 import java.io.IOException;
 import java.util.ArrayList;
 import javax.servlet.jsp.JspWriter;
 import javax.servlet.http.*;
 import java.sql.*;
 import java.util.Date;



/**
 *
 * @author foush
 */
public class ShoppingCart {

  ArrayList<Item> itemlist = new ArrayList<Item>();  // list of Items in the cart
   java.text.DecimalFormat currency = new java.text.DecimalFormat("$ #,###,##0.00");

   public ShoppingCart()
       {

       }

   public void empty()
     {
       itemlist.clear();
     }
     //
     // add an item to the cart
     // if its there already, just update
     //

     public void add(Item anitem)
    {

     for(int i = 0; i < itemlist.size(); i++)
     {
     Item item = itemlist.get(i);
      if(anitem.id == item.id) // already in the cart?
      {
       item.quantity += anitem.quantity; // yes, just update the quantity
       item.weight+=anitem.weight;//yes ,just  update  the weight
       return;
      }
     }
     itemlist.add(anitem); // no, add it as a new item
    }
    //
    // remove an item with a given id from the shopping cart
    //
        public void remove(int id,JspWriter out)throws IOException
        {

         for(int i = 0; i < itemlist.size(); i++)
         {
          Item item = itemlist.get(i);
          if(id == item.id) // item in the cart?
          {
           itemlist.remove(i); // remove it
           //{test the function}out.println("<div class='btn btn-success'>"+"hello from remove"+"</div>");

           break;
          }
         }

        }

        public float totalPrice(JspWriter out,float firstKiloCost,float secondKiloCost,int shipping) throws IOException
          {

           float total = 0.0f;
           float shippingTotal=0.0f;
           // double totalWithoutShipping=0;

           for(int i = 0; i < itemlist.size(); i++)
           {
            Item item = (Item)itemlist.get(i);

             // totalWithoutShipping += item.price*item.quantity;
            shippingTotal+=costCalculation(firstKiloCost,secondKiloCost,item.weight);
            total += item.price*item.quantity+shippingTotal;
           }

           if(shipping==0){ //total shipping only
             return shippingTotal;

           }else { //totalPrice=shipping+product_price
              return total;
           }


          }



    //
   // Display the current contents of the cart as an html table
   //
   public void display(JspWriter out,float firstKiloCost,float secondKiloCost) throws IOException
     {
      //
      // start the table and output the header row
      //
    out.println("<div class='container mb-4'>");
    out.println("<div class='row'>");
        out.println("<div class='col-12'>");
        out.println("<div class='table-responsive'>");
        out.println("<table class='table table-striped'>");

      out.println("<thead>");
      out.println("<tr>");
      out.println("<th scope='col'> </th>");
      out.println("<th scope='col'>Name</th>");
      out.println("<th scope='col'>Quantity</th>");
      out.println("<th scope='col' class='text-left'>Price</th>");
      out.println("<th>Sub-Total</th>");
      out.println("<th>weight</th>");

      out.println("</tr>");
      out.println("</thead>");
      out.println("<tbody>");



      double total = 0;
      float shippingTotal=0;
      double totalWithoutShipping=0;
      //
      // output one item at a time from the cart, one item to a row table
      //
      for(int i = 0; i < itemlist.size(); i++)
      {
       Item item = (Item)itemlist.get(i);
       out.println(
                  "<td>"+"<img src='https://dummyimage.com/50x50/55595c/fff'/>"+"</td>"+
                  "<td>"+item.name+"</td>"+
                  "<td align=left>"+ item.quantity+"</td>"+
                  "<td align=left>"+ currency.format(item.price)+"</td>"+
                  "<td align=left>"+ currency.format(item.price*item.quantity)+"</td>"+
                  "<td align=left>"+item.weight+"</td>"+
                  "<td class='text-left'><A class='btn btn-sm btn-danger' href='?id="+item.id+"'><i class='fa fa-trash'></i></A></TD></tr>");
                  totalWithoutShipping += item.price*item.quantity;
       shippingTotal+=costCalculation(firstKiloCost,secondKiloCost,item.weight);
       total += item.price*item.quantity+shippingTotal;
      }
      //
      // add summary information (total, tax, grand total)
      //

       //out.println("<a href='checkOut.jsp'><input type='Button' value='Register'/></A><br/>");
out.println("<tr>");
out.println("<td></td>");
out.println("<td></td>");
out.println("<td></td>");
out.println("<td></td>");
out.println("<td>Sub-Total</td>");
out.println("<td class='text-left'>"+totalWithoutShipping+"</td>");
out.println("</tr>");

out.println("<tr>");
out.println("<td></td>");
out.println("<td></td>");
out.println("<td></td>");
out.println("<td></td>");
out.println("<td>Shipping</td>");
out.println("<td class='text-left'>"+shippingTotal+"</td>");
out.println("</tr>");

out.println("<tr>");
out.println("<td></td>");
out.println("<td></td>");
out.println("<td></td>");
out.println("<td></td>");
out.println("<td>"+"<strong>"+"Total"+"</strong>"+"</td>");
out.println("<td class='text-left'>"+"<strong>"+total+"</strong>"+"</td>");
out.println("</tr>");



out.println("</table>");
  out.println("</tbody>");





     }

     public int checkOut(JspWriter out,String customer_id,String paymentMethod)//url is the DB ,that i want to connect to
         {
             int result = 0; // tally the classes added
             Timestamp now = new Timestamp(new Date().getTime());
             int lastInsertedID=0;
             int paymentID=0;

             try{
               // out.println("ok");

               // JDBC driver name and database URL
                 String JDBC_DRIVER = "com.mysql.jdbc.Driver";
                 String DB_URL = "jdbc:mysql://localhost/Ecommerce";
                //  Database credentials
                 final String USER = "root";
                 final String PASS = "";
             // open a connection
               Connection conn = null;
               Class.forName("com.mysql.jdbc.Driver");  // load the driver
               conn = DriverManager.getConnection(DB_URL,USER,PASS);
               // out.println("ok2");

// ***********************************************Creat order***************************
String sql="INSERT INTO orders_t (order_date) VALUES (?);"+
"";
     //
     // add entry to enroll table for each item
     //
             PreparedStatement prep = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
             // out.println("ok3");


             prep.setTimestamp(1, now);
             result+=prep.executeUpdate();
             ResultSet rs = prep.getGeneratedKeys();
             if (rs.next()){
                 lastInsertedID=rs.getInt(1);
             }


             // out.println("ok4");
             // out.println(""+result);
             // out.println(""+lastInsertedID);

             // *********************assign  the order to it's customer********************

             String sql2="INSERT INTO custmers_t_has_orders_t (custmers_t_custmer_id,orders_t_idorder_id) VALUES (?,?)";
             PreparedStatement prep2 = conn.prepareStatement(sql2);

             prep2.setString(1,customer_id);
             prep2.setInt(2,lastInsertedID);

             prep2.executeUpdate();

             // ************************Insert the order line***************************


             String sql3="INSERT INTO order_lines_t (orders_t_idorder_id,products_t_product_id) VALUES (?,?)";
             PreparedStatement prep3 = conn.prepareStatement(sql3);
             // prep3.setInt(1,lastInsertedID);
             // prep3.executeUpdate();
             prep3.setInt(1,lastInsertedID);



             for(int i = 0; i < itemlist.size(); i++)
             {
                Item item = itemlist.get(i);
                // prep3.setInt(1,lastInsertedID);
                prep3.setInt(2, item.id);
                result += prep3.executeUpdate();
             }
             itemlist.clear(); //empty the cart

             // ************************Insert paymentMethod***************************

//payment_mehtod_id => Make if auto increment later  ...now just test it
             String sql4="INSERT INTO payment_mehtod_t (payment_mehtod_name) VALUES (?)";
             PreparedStatement prep4 = conn.prepareStatement(sql4,Statement.RETURN_GENERATED_KEYS);

             prep4.setString(1, paymentMethod);
             prep4.executeUpdate();
             ResultSet rs2 = prep.getGeneratedKeys();
             if (rs2.next()){
                 paymentID=rs2.getInt(1);
             }


             // ************************Insert receipt***************************

//total price here ..hardcoded till i get some sleep and fix it

             String sql5="INSERT INTO receipt_t (orders_t_idorder_id,receipt_totalprice,payment_mehtod_t_payment_mehtod_id) VALUES (?,?,?)";
             PreparedStatement prep5 = conn.prepareStatement(sql5);

             prep5.setInt(1,lastInsertedID);
             prep5.setString(2,"50");
             prep5.setInt(3,paymentID);


             prep5.executeUpdate();




             prep.close();
             conn.close();
             }
             catch(Exception ex)
             {
               // unable to close the prepared statement
             }
             // return result;
             return lastInsertedID;
         }



         public void checkoutdisplay(JspWriter out,float firstKiloCost,float secondKiloCost) throws IOException
           {

    double total = 0;
    float shippingTotal=0;
    double totalWithoutShipping=0;

      out.println("<div class='container'>");
      out.println("<div class='row'>");
    out.println(" <div class='col-md-4 order-md-2 mb-4'>")  ;
    out.println("<h4 class='d-flex justify-content-between align-items-center mb-3'>");
    out.println(" <span class='text-muted'>Your cart</span>");
    out.println("<span class='badge badge-secondary badge-pill'>"+itemlist.size()+"</span>");
    out.println("</h4>")   ;
    out.println("<ul class='list-group mb-3'>");
// Here ..iterate throw the items in the itemlist

for(int i = 0; i < itemlist.size(); i++)
{
 Item item = (Item)itemlist.get(i);

 out.println("<li class='list-group-item d-flex justify-content-between lh-condensed'>");
   out.println("<div>");
    out.println("<h6 class='my-0'>"+item.name+"</h6>");
     out.println("<small class='text-muted'>"+"<pan>"+item.quantity+"</span>"+"</small>");
     out.println("</div>");
out.println("<span class='text-muted'>"+item.price+"</span>");
 out.println("</li>");

            totalWithoutShipping += item.price*item.quantity;
 shippingTotal+=costCalculation(firstKiloCost,secondKiloCost,item.weight);
 total += item.price*item.quantity+shippingTotal;
}




                 out.println("<li class='list-group-item d-flex justify-content-between'>");
                out.println("<span>"+"Total price"+"</span>");
                   out.println("<strong>"+total+"</strong>");
                 out.println("</li>");


      out.println("</ul>");
      out.println("</div>")  ;



           }


// receipt item display
public void lineItemsDisplay(JspWriter out,float firstKiloCost,float secondKiloCost) throws IOException
  {


          double total = 0;
          float shippingTotal=0;
          double totalWithoutShipping=0;


        // Here ..iterate throw the items in the itemlist

         out.println("<div class='items'>");

        for(int i = 0; i < itemlist.size(); i++)
        {
        Item item = (Item)itemlist.get(i);
        out.println("<div class='row item'>");
          out.println("<div class='col-sm-4 desc'>");
            out.println(item.name);
          out.println("</div>");
          out.println("<div class='col-sm-3 qty'>");
            out.println(item.quantity);
          out.println("</div>");
          out.println("<div class='col-sm-5 amount text-right'>");
            out.println(item.quantity*item.price);
          out.println("</div>");
        out.println("</div>");
        totalWithoutShipping += item.price*item.quantity;

        }




        out.println("</div>");


        // <%-- thanks the user for chooseing our company --%>

        out.println("<div class='total text-right'>");
          out.println("<p class='extra-notes'>");
            out.println("<strong>Thanks</strong>");
            out.println("We are pleased to serve you guies .We hope you come here again soon");

          out.println("</p>");
          out.println("<div class='field'>");
            out.println("Subtotal");
             out.println("<span>"+ totalWithoutShipping+ "</span>");
          out.println("</div>");
          out.println("<div class='field'>");
            out.println("Shipping"+ "<span>"+""+totalPrice(out,firstKiloCost,secondKiloCost,1)+"</span>");
          out.println("</div>");
          out.println("<div class='field'>");
            out.println("Discount"+ "<span>"+"0%"+"</span>");
          out.println("</div>");
          out.println("<div class='field grand-total'>");
            out.println("Total"+"<span>"+""+totalPrice(out,firstKiloCost,secondKiloCost,0)+"</span>");
          out.println("</div>");
        out.println("</div>");










  }













/**
ShippingAlgorithm

*/









         public String WhichZone(String city){//url is the DB ,that i want to connect to

           String result = "";
           try{
             // JDBC driver name and database URL
              String JDBC_DRIVER = "com.mysql.jdbc.Driver";
              String DB_URL = "jdbc:mysql://localhost/Ecommerce";
             //  Database credentials
              final String USER = "root";
              final String PASS = "";

           // open a connection
             Connection con = null;
             Class.forName("com.mysql.jdbc.Driver");  // load the driver
             con = DriverManager.getConnection(DB_URL,USER,PASS);
           //
           // get the city's zone
           //
           PreparedStatement prep = con.prepareStatement("Select * from cities_t WHERE city_name=?");

              prep.setString(1, city);
         ResultSet rs = prep.executeQuery();
         while(rs.next()){
            result=rs.getString(3);
         }
           prep.close();
           con.close();
           }
           catch(Exception ex)
           {
             // unable to close the prepared statement
           }

         return result;

         }



         public float KiloCost(String sourceZone,String destZone,String firstOrAdditional){
           //return the fist/additional kilo of shipping of all companies    1 --> first    0 ---> Additional

           float BestPrice =0;
           float NextPrice=0;
           try{
             // JDBC driver name and database URL
              String JDBC_DRIVER = "com.mysql.jdbc.Driver";
              String DB_URL = "jdbc:mysql://localhost/Ecommerce";
             //  Database credentials
              final String USER = "root";
              final String PASS = "";

           // open a connection
             Connection con = null;
             Class.forName("com.mysql.jdbc.Driver");  // load the driver
             con = DriverManager.getConnection(DB_URL,USER,PASS);
           //
           // get the city's zone
           //
           PreparedStatement prep = con.prepareStatement("Select * from shipping_rates_t WHERE zone_source=? AND zones_destination=? AND isFirst=?");

              prep.setString(1, sourceZone);
              prep.setString(2, destZone);
              prep.setString(3, firstOrAdditional);
           ResultSet rs = prep.executeQuery();
         if (rs.next()) {
         BestPrice=Float.parseFloat(rs.getString(5));
         }
           while(rs.next()){


             //Here i have all the records of all shipping companies' 1'st kilo price
             NextPrice=Float.parseFloat(rs.getString(5));
             if(NextPrice < BestPrice){BestPrice=NextPrice;}
              //result=rs.getString(3);
           }
           prep.close();
           con.close();
           }
           catch(Exception ex)
           {
             // unable to close the prepared statement
           }

         //return the smallest price :)
         //return BestPrice;
         return BestPrice;
         }



public float costCalculation(float firstKiloCost,float secondKiloCost,float weight){
  float total = 0;
  float itemShippingPrice=0;
  float cost=0;
  float extraWeight=0;

       if(weight<=1){
          total+=firstKiloCost;
       }else{
            extraWeight=weight-1;
            itemShippingPrice=firstKiloCost+extraWeight*secondKiloCost;
            total+=itemShippingPrice;
        }


  return total;
}

//pagination
public static ArrayList<Item> getRecords(int start,int total){
       ArrayList<Item> list=new ArrayList<Item>();
       try{
         // JDBC driver name and database URL
          String JDBC_DRIVER = "com.mysql.jdbc.Driver";
          String DB_URL = "jdbc:mysql://localhost/Ecommerce";
         //  Database credentials
          final String USER = "root";
          final String PASS = "";

       // open a connection
         Connection con = null;
         Class.forName("com.mysql.jdbc.Driver");  // load the driver
         con = DriverManager.getConnection(DB_URL,USER,PASS);

           PreparedStatement ps=con.prepareStatement("select * from product limit "+(start-1)+","+total);
           ResultSet rs=ps.executeQuery();
           while(rs.next()){
               Item e=new Item();

               e.setId(rs.getInt(1));
               e.setName(rs.getString(2));
              // e.setQuantity(rs.getString(3));
              // e.setPrice(rs.getString(4));
              // e.setWeight(rs.getString(5));
               list.add(e);
           }
           con.close();
       }catch(Exception e){System.out.println(e);}
       return list;
   }


/** pagination******/
/*
//get number of rows in the table

   public float num() throws Exception {
     try{
       // JDBC driver name and database URL
        String JDBC_DRIVER = "com.mysql.jdbc.Driver";
        String DB_URL = "jdbc:mysql://localhost/Ecommerce";
       //  Database credentials
        final String USER = "root";
        final String PASS = "";

     // open a connection
       Connection con = null;
       Class.forName("com.mysql.jdbc.Driver");  // load the driver
       con = DriverManager.getConnection(DB_URL,USER,PASS);
       PreparedStatement prep = con.prepareStatement("select count(*) from products_t");

       ResultSet rs = prep.executeQuery();


       while (rs.next()) {
       return rs.getInt(1);
         }
         con.close();
     }catch(Exception e){System.out.println(e);}
     return 0;
}
*/
}
