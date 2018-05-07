<%--
    Document   : retrieveProducts
    Created on : Apr 9, 2018, 9:41:13 PM
    Author     : hanihussein
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
      if (session.getAttribute("id") == null){
            response.sendRedirect("../moustafa/signin.jsp");
    }
%>
<%
    String id = request.getParameter("userid");
    String driver = "com.mysql.jdbc.Driver";
    String connectionUrl = "jdbc:mysql://localhost:3306/";
    String database = "Ecommerce";
    String userid = "root";
    String password = "";
    try {
        Class.forName(driver);
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    ResultSet resultSet1 = null;
%>

<!DOCTYPE html>
<html>
  <jsp:include page="../includes/header.html"/>
  <jsp:include page="../includes/sidebar.html"/>
  <style>
  .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th{
    padding: 9px;
  }
  </style>


  <!-- Content Wrapper. Contains page content -->

  <div class="content-wrapper">
    <div class="container" style="width:998px;">

              <h1>Products</h1>
              <form action="addProduct.jsp">
         <button class="btn btn-success" style="margin-bottom:30px;" type="submit"><i class="fa fa-plus"></i> New Product</button>
     </form>

              <table class="table table-hover table-striped table-responsive container">
                  <tr>
                      <td><strong>name</strong></td>
                      <td class="text-center"><strong>description</strong></td>
                      <td><strong>price</strong></td>
                      <td><strong>discount</strong></td>
                      <td><strong>weight</strong></td>
                      <td><strong>height</strong></td>
                      <td><strong>width</strong></td>
                      <td><strong>category</strong></td>
                      <td><strong>control</strong></di>
                      <td></td>

                  </tr>
                  <%
                      try {
                          connection = DriverManager.getConnection(connectionUrl + database, userid, password);
                          statement = connection.createStatement();
                          String sql = "select * from Ecommerce.products_t "
                                  + "JOIN Ecommerce.category_t  ON category_t_category_id =  category_id ";
                          resultSet = statement.executeQuery(sql);
                          while (resultSet.next()) {
                  %>
                  <tr>
                      <td><%=resultSet.getString("product_name")%></td>
                      <td><%=resultSet.getString("product_description")%></td>
                      <td><%=resultSet.getFloat("product_price")%></td>
                      <td><%=resultSet.getFloat("product_discount")%></td>
                      <td><%=resultSet.getFloat("product_weight")%></td>
                      <td><%=resultSet.getFloat("product_height")%></td>
                      <td><%=resultSet.getFloat("product_width")%></td>
                      <td><%=resultSet.getString("category_name")%></td>

                      <td>
                          <form method="post" action="editProduct.jsp">
                              <button name="edit_id" class="btn btn-info" type="submit" value="<%=resultSet.getString("product_id")%>">Edit</button>
                          </form>
                      </td>
                      <td>
                          <form method="post" action="deleteProduct.jsp">
                              <button class="btn btn-danger" onclick="return confirm('Are you sure you want to Delete this?')" name="delete_id" type="submit" value="<%=resultSet.getString("product_id")%>">Delete</button>
                          </form>
                      </td>



                  </tr>
                  <%
                          }
                          connection.close();
                      } catch (Exception e) {
                          e.printStackTrace();
                          out.print("" + e);
                      }
                  %>
              </table>


    </div>

  </div>
  <jsp:include page="../includes/footer.html"/>
