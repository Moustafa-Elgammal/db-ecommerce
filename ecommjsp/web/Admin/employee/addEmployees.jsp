
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
      <h1>Add new Employee</h1>

              <%
                  Statement st = null;
                  ResultSet rs = null;
                  try {
                      Class.forName("com.mysql.jdbc.Driver");
                      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ecommerce", "root", "");
                      st = conn.createStatement();
                      rs = st.executeQuery("select skill_id, skills_name from Ecommerce.skills_t");

                  } catch (Exception e) {
                      out.print("" + e);
                      System.out.print(e);
                      e.printStackTrace();
                  }
              %>



              <form method="post" action="insertEmployee.jsp">

                <div class="form-group">
                  <label for="employee_name">  Name:</label>
                  <input type="text" class="form-control"  name="employee_name" placeholder="Enter Name">


                  </div>




                <div class="form-group">
                  <label for="employee_phone">  Phone:</label>
                  <input type="text" class="form-control col-lg-6" name="employee_phone">
                  </div>
                  <br>


                  <div class="form-group">
                    <label for="employee_salary">  Salary:</label>
                  <input type="text" class="form-control" name="employee_salary">
                  </div>



                  Skill:
                  <select name="skill_id" class="form-control" style="width:20%;">
                      <%while (rs.next()) {%>
                      <option value="<%=rs.getString(1)%>"><%=    rs.getString(2)%></option>
                      <%}%>
                  </select>
                  <br>
                  <br>


                   <%
                  Statement stt = null;
                  ResultSet rb = null;
                  try {
                      Class.forName("com.mysql.jdbc.Driver");
                      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ecommerce", "root", "");
                      st = conn.createStatement();
                      rb = st.executeQuery("select branch_id, branch_address from Ecommerce.branches_t");

                  } catch (Exception e) {
                      out.print("" + e);
                      System.out.print(e);
                      e.printStackTrace();
                  }
              %>

                  Branch:
                  <select name="branches_t_branch_id" class="form-control" style="width:20%;">
                      <%while (rb.next()) {%>
                      <option value="<%=rb.getString(1)%>"><%=    rb.getString(2)%></option>
                      <%}%>
                  </select>
                  <br>
                  <br>

                  <br>

                    <button type="submit" class="btn btn-success" style="margin-bottom:70px;"><i class="fa fa-plus"></i> Add new employee</button>
              </form>






    </div>

  </div>
  <jsp:include page="../includes/footer.html"/>
