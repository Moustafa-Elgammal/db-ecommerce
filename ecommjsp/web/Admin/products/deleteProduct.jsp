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
    int product_id = Integer.parseInt(request.getParameter("delete_id"));



    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ecommerce", "root", "");
        Statement st = conn.createStatement();


        int i = st.executeUpdate("delete from Ecommerce.products_t where product_id= '"+product_id+"'");


        out.println("Data is successfully Deleted!");
    } catch (Exception e) {
        out.print(""+e);
        System.out.print(e);
        e.printStackTrace();
    }
%>





    </div>

  </div>
  <jsp:include page="../includes/footer.html"/>
