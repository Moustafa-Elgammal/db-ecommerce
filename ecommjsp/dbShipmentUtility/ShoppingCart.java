/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
 package dbShipmentUtility;

 import java.io.IOException;
 import java.util.ArrayList;
 import javax.servlet.jsp.JspWriter;
 import java.sql.*;
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

     public int checkOut(String url, String studentid)//url is the DB ,that i want to connect to
         {
             int result = 0; // tally the classes added
             try{
             // open a connection
               Connection con = null;
               Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");  // load the driver
               con = DriverManager.getConnection(url);
     //
     // add entry to enroll table for each item
     //
             PreparedStatement prep = con.prepareStatement("Insert into enroll (StudentID, CRN) values (?,?)");

             for(int i = 0; i < itemlist.size(); i++)
             {
                Item item = itemlist.get(i);
                prep.setString(1, studentid);
                prep.setInt(2, item.id);
                result += prep.executeUpdate();
             }
             itemlist.clear(); //empty the cart
             prep.close();
             con.close();
             }
             catch(Exception ex)
             {
               // unable to close the prepared statement
             }
             return result;
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
