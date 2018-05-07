<%--
    Document   : index
    Created on : Apr 9, 2018, 8:37:31 PM
    Author     : hanihussein
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*"%>

<!DOCTYPE html>
<html>
  <jsp:include page="../includes/header.html"/>
  <jsp:include page="../includes/sidebar.html"/>
  <%
        if (session.getAttribute("id") == null){
              response.sendRedirect("../moustafa/signin.jsp");
      }
  %>

  <!-- Content Wrapper. Contains page content -->

  <div class="content-wrapper">
    <div class="container" style="width:949px;">
      <h1>Add new Product</h1>

        <%
            Statement st = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ecommerce", "root", "");
                st = conn.createStatement();
                rs = st.executeQuery("select category_id, category_name from Ecommerce.category_t");

            } catch (Exception e) {
                out.print("" + e);
                System.out.print(e);
                e.printStackTrace();
            }
        %>

        <form method="post" action="insertProduct.jsp">
            Product name:
            <input class="form-control" type="text" name="product_name">
            <br>


            Product describe:
            <input class="form-control" type="text" name="product_describe">
            <br>


            Product price:
            <input class="form-control" type="text" name="product_price">
            <br>


            Product discount:
            <input class="form-control" type="text" name="product_discount">
            <br>


            Product weight:
            <input class="form-control" type="text" name="product_weight">
            <br>


            Product height:
            <input class="form-control" type="text" name="product_height">
            <br>


            Product width:
            <input class="form-control" type="text" name="product_width">
            <br>


            Category:
            <select name="category_id" class="form-control" style="width:20%;">
                <%while (rs.next()) {%>
                <option value="<%=rs.getString(1)%>"><%=    rs.getString(2)%></option>
                <%}%>
            </select>
            <br>
              <button type="submit" class="btn btn-success" style="margin-bottom:70px;"><i class="fa fa-plus"></i> Add new Product</button>
        </form>




    </div>

  </div>
  <jsp:include page="../includes/footer.html"/>
