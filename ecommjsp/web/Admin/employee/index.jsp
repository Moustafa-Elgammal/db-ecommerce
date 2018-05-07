
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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


  <!-- Content Wrapper. Contains page content -->

  <div class="content-wrapper">
    <div class="container" style="width:1051px;">

      <h1>Employees</h1>
              <table  class="table table-hover table-striped table-responsive container">

                  <tr class="thead-dark">
                      <td>employee name</td>
                      <td>employee phone</td>
                      <td>employee salary</td>
                      <td>employee branch</td>
                      <td>skill</td>
                      <td>control</td>
                      <td></td>

                  </tr>

                  <%
                      try {
                          connection = DriverManager.getConnection(connectionUrl + database, userid, password);
                          statement = connection.createStatement();
                          String sql = "select * from Ecommerce.employees_t e,"
                                  + "Ecommerce.skills_t_has_employees_t se, Ecommerce.skills_t s,"
                                  + "Ecommerce.branches_t b "
                                  + "where e.employee_id = se.employees_t_employee_id and se.skills_t_skill_id = s.skill_id "
                                  + "and e.branches_t_branch_id = b.branch_id";

                          resultSet = statement.executeQuery(sql);
                          while (resultSet.next()) {
                  %>
                  <tr>
                      <td><%=resultSet.getString("employee_name")%></td>
                      <td><%=resultSet.getString("employee_phone")%></td>
                      <td><%=resultSet.getFloat("employee_salary")%></td>
                      <td><%=resultSet.getString("branch_address")%></td>
                      <td><%=resultSet.getString("skills_name")%></td>

                      <td>
                          <form method="post" action="editEmployee.jsp">
                              <button  class="btn btn-info" name="edit_id" type="submit" value="<%=resultSet.getString("employee_id")%>">Edit</button>
                          </form>
                        </td>
                        <td>

                          <form method="post" action="deleteEmployee.jsp">
                              <button  class="btn btn-danger" onclick="return confirm('Are you sure you want to Delete this?')" name="delete_id" type="submit" value="<%=resultSet.getString("employee_id")%>">Delete</button>
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
              <br><br><br><br>
               <form action="addEmployees.jsp">

          <button type="submit" class="btn btn-success"><i class="fa fa-plus"></i> New employee</button>
      </form>






    </div>

  </div>
  <jsp:include page="../includes/footer.html"/>
