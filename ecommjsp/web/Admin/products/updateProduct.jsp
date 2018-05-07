<%--
    Document   : deleteProduct
    Created on : Apr 9, 2018, 11:17:57 PM
    Author     : hanihussein
--%>
<%@  page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>

<!DOCTYPE html>
<html>
  <jsp:include page="../includes/header.html"/>
  <jsp:include page="../includes/sidebar.html"/>


  <!-- Content Wrapper. Contains page content -->

  <div class="content-wrapper">
    <div class="container" style="width:949px;">

      <%
          int product_id = Integer.parseInt(request.getParameter("update_id"));

          String product_name = request.getParameter("product_name");
          String product_describe = request.getParameter("product_describe");
          float product_price = Float.parseFloat(request.getParameter("product_price"));
          float product_discount = Float.parseFloat(request.getParameter("product_discount"));
          float product_weight = Float.parseFloat(request.getParameter("product_weight"));
          float product_height = Float.parseFloat(request.getParameter("product_height"));
          float product_width = Float.parseFloat(request.getParameter("product_width"));
          int category_id = Integer.parseInt(request.getParameter("category_id"));

          try {
              Class.forName("com.mysql.jdbc.Driver");
              Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ecommerce", "root", "");
              Statement st = conn.createStatement();

              int i = st.executeUpdate("update Ecommerce.products_t set "
                      + "product_name='" + product_name + "'"
                      + " ,product_description='" + product_describe + "'"
                      + " ,product_price='" + product_price + "'"
                      + " ,product_discount='" + product_discount + "'"
                      + " ,product_weight='" + product_weight + "'"
                      + " ,product_height='" + product_height + "'"
                      + " ,product_width='" + product_width + "'"
                      + " ,product_width='" + category_id + "'"
                      + "where product_id= '" + product_id + "'");

              out.println("Data is successfully updated!");
          } catch (Exception e) {
              out.print("" + e);
              System.out.print(e);
              e.printStackTrace();
          }

      %>

    </div>

  </div>
  <jsp:include page="../includes/footer.html"/>
