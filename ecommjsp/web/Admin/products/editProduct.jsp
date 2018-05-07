<%--
    Document   : deleteProduct
    Created on : Apr 9, 2018, 11:17:57 PM
    Author     : hanihussein
--%>
<%@  page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>

<%
      if (session.getAttribute("id") == null){
            response.sendRedirect("../moustafa/signin.jsp");
    }
%>
<!DOCTYPE html>
<html>
  <jsp:include page="../includes/header.html"/>
  <jsp:include page="../includes/sidebar.html"/>


  <!-- Content Wrapper. Contains page content -->

  <div class="content-wrapper">
    <div class="container" style="width:949px;">

      <h1>Edit Product</h1>

              <%
                  String Selected = "";
                  int categID=0;
                  int product_id = Integer.parseInt(request.getParameter("edit_id"));

                  Statement st1 = null;
                  Statement st2 = null;

                  Connection conn = null;
                  ResultSet categRS = null;
                  ResultSet prodRs = null;

                  try {
                      Class.forName("com.mysql.jdbc.Driver");
                      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ecommerce", "root", "");
                      st1 = conn.createStatement();
                      prodRs = st1.executeQuery("select * from Ecommerce.products_t where product_id= '" + product_id + "'");

                      while (prodRs.next()) {
              %>

              <form method="post" action="updateProduct.jsp">

                  Product name:
                  <input class="form-control" type="text" name="product_name" value="<%=prodRs.getString("product_name")%>">
                  <br>
                  <br>

                  Product describe:
                  <input class="form-control" type="text" name="product_describe" value="<%=prodRs.getString("product_description")%>">
                  <br>
                  <br>

                  Product price:
                  <input class="form-control" type="text" name="product_price" value="<%=prodRs.getString("product_price")%>">
                  <br>
                  <br>

                  Product discount:
                  <input class="form-control" type="text" name="product_discount" value="<%=prodRs.getString("product_discount")%>">
                  <br>
                  <br>

                  Product weight:
                  <input class="form-control" type="text" name="product_weight" value="<%=prodRs.getString("product_weight")%>">
                  <br>
                  <br>

                  Product height:
                  <input class="form-control" type="text" name="product_height" value="<%=prodRs.getString("product_height")%>">
                  <br>
                  <br>

                  Product width:
                  <input class="form-control" type="text" name="product_width" value="<%=prodRs.getString("product_width")%>">
                  <br>
                  <br>

                  <%
                      categID = prodRs.getInt("category_t_category_id");
                          }
                      } catch (Exception e) {
                          e.printStackTrace();
                          out.print("" + e);
                      }
                  %>

                  <%
                      try {
                          st2 = conn.createStatement();
                          categRS = st2.executeQuery("select category_id, category_name from Ecommerce.category_t");
                  %>
                  Category:
                  <select name="category_id"  class="form-control" style="width:20%;">
                      <%
                          String Selec = "";
                          while (categRS.next()) {
                                  if(categID ==  categRS.getInt(1)){
                                     Selec = "selected";
                                  }else{
                                      Selec = "";
                                  }

                      %>

                      <option value="<%=categRS.getString(1)%>" <%=Selec %> ><%= categRS.getString(2) %></option>
                      <%}%>
                      <%

                          } catch (Exception e) {
                              e.printStackTrace();
                              out.print("" + e);
                          }
                      %>
                  </select>

                  <br>

                   <button name="update_id" class="btn btn-success" type="submit" value="<%=product_id%>">Update</button>
              </form>

    </div>

  </div>
  <jsp:include page="../includes/footer.html"/>
