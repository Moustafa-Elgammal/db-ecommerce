
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <div class="container"  style="width:949px;">

      <h1>Edit Employee</h1>

            <%
                String Selected = "";
                int sklID=0;
                int brnchID=0;
                int employee_id = Integer.parseInt(request.getParameter("edit_id"));

                Statement st1 = null;
                Statement st2 = null;

                Connection conn = null;
                ResultSet skls = null;
                ResultSet emps = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ecommerce", "root", "");
                    st1 = conn.createStatement();
                    emps = st1.executeQuery("select * from Ecommerce.employees_t e, Ecommerce.skills_t_has_employees_t se, Ecommerce.skills_t s "
                            + "where e.employee_id= '" + employee_id + "' and e.employee_id = se.employees_t_employee_id and se.skills_t_skill_id = s.skill_id");

                    while (emps.next()) {
            %>

            <form method="post" action="updateemployee.jsp">

            <div class="form-group">
              <label for="employee_name">  Name:</label>
              <input type="text" class="form-control" name="employee_name" value="<%=emps.getString("employee_name")%>">

            </div>


                            <div class="form-group">
                              <label for="employee_phone">  Phone:</label>
                              <input type="text" name="employee_describe" class="form-control"value="<%=emps.getString("employee_phone")%>">
                              </div>
                              <br>

                                                <div class="form-group">
                                                  <label for="employee_salary">  Salary:</label>
                                                <input type="text" class="form-control" name="employee_salary" value="<%=emps.getString("employee_salary")%>">
                                                </div>





                <%

                   sklID = emps.getInt("skill_id");
                   brnchID =  emps.getInt("branches_t_branch_id");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.print("" + e);
                    }

                %>


                <%
                Statement st = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    st = conn.createStatement();
                    rs = st.executeQuery("select skill_id, skills_name from Ecommerce.skills_t");

                } catch (Exception e) {
                    out.print("" + e);
                    System.out.print(e);
                    e.printStackTrace();
                }
            %>


                skill:
                <select name= "skill_id"  class="form-control" style="width:20%;">
                    <%
                        String Selec = "";
                        while (rs.next()) {

                            if (sklID ==  rs.getInt(1)){
                                   Selec = "selected";
                                }else{
                                    Selec = "";
                                }


                    %>

                    <option value="<%=rs.getString(1)%>" <%=Selec %> ><%= rs.getString(2) %></option>
                    <%}%>

                </select>

                <br>
                <br><%
                Statement stt = null;
                ResultSet rb = null;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    stt = conn.createStatement();
                    rb = st.executeQuery("select branch_id, branch_address from Ecommerce.branches_t");

                } catch (Exception e) {
                    out.print("" + e);
                    System.out.print(e);
                    e.printStackTrace();
                }
            %>


                Branch:
                <select name= branches_t_branch_id"  class="form-control" style="width:20%;">
                    <%
                        String Selectt = "";
                        while (rb.next()) {

                            if (brnchID ==  rb.getInt(1)){
                                   Selectt = "selected";
                                }else{
                                    Selectt = "";
                                }


                    %>

                    <option value="<%=rb.getString(1)%>" <%=Selectt %> ><%= rb.getString(2) %></option>
                    <%}%>

                </select>

                <br>
                <br>
                 <button name="update_id" type="submit" class="btn btn-success" value="<%=employee_id%>"><i classes="fa fa-edit"></i>Update</button>
            </form>



    </div>

  </div>
  <jsp:include page="../includes/footer.html"/>
