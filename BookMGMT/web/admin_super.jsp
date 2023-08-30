<%@ page import="dao.*" %>
<%@ page import="proto.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Superb
  Date: 2022/10/17
  Time: 14:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>个人信息</title>
    <link rel="icon" href="images/favicon.ico">
    <style>
        @import "css/button.css";
        @import "css/table.css";
        @import "css/header.css";
    </style>
</head>
<body>
<%
    String mess = (String) request.getAttribute("message");
    if(mess!=null){
%>
    <script type = text/javascript>
        alert("<%=mess%>");
    </script>
<%}%>

    <%int admin = Integer.parseInt(request.getParameter("admin"));%>
    <div class="header" style="color: dodgerblue">
        <img src="./images/YZY协会logo 透明.png" alt="援之缘支教协会会标">
        <h1 style="text-align: center; font-family: 华文新魏; font-size: 50px">援之缘支教协会图书管理系统</h1>
        <p style="text-align: center; font-family: 华文行楷; font-size: 30px">——知雨书舍</p>
    </div>
    <form action="${pageContext.request.contextPath}/returnServlet" method="post">
        <input type="hidden" name="admin" value="<%=admin%>">
        <button type="submit" class="button_return" style="vertical-align:middle"><span>返回</span></button>
    </form>

    <div class="back">
        <table>
            <caption>管理员名单</caption>
            <thead>
            <tr>
                <th>id</th>
                <th>邮箱</th>
                <th>名字</th>
                <th>是否为总管理员</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <%
                adminDao ad = new adminDao();
                List<admin> adminList = null;
                registerDao rd = new registerDao();
                List<register> registerList = null;
                try {
                    adminList = ad.SearchList();
                    registerList = rd.SearchList();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                assert adminList != null;
                for (admin a : adminList) {
            %>
            <form method="post">
                <input type="hidden" name="admin" value="<%=admin%>">
                <tr>
                    <input type="hidden" name="id" id="id" value="<%=a.get_id()%>">
                    <td><%=a.get_id()%></td>
                    <td><%=a.get_mail()%></td>
                    <td><%=a.get_name()%></td>
                    <td>
                        <%if(a.get_status()==1){%>
                        <input type="checkbox" style="height:15px" name="status" checked>
                        <%} else{%>
                        <input type="checkbox" style="height:15px" name="status">
                        <%} %>
                    </td>
                    <td>
                        <button type="submit" class="button1" onclick="this.form.action = '${pageContext.request.contextPath}/admin_updateServlet'" >提交</button>
                        <button type="button" class="button1" onclick="delete_(this.form)">删除</button>
                    </td>
                </tr>
            </form>
            <%} %>
            </tbody>
        </table>

        <script type="text/javascript">
            function delete_(f){
                let res = confirm("是否确认删除该管理员？");
                f.action="${pageContext.request.contextPath}/admin_deleteServlet";
                if(res){
                    f.submit();
                }
            }
        </script>

    <%
        assert registerList != null;
        if(registerList.size()!=0){
    %>
        <table>
            <caption>注册申请</caption>
            <thead>
            <tr>
                <th>邮箱</th>
                <th>名字</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (register r : registerList) {
            %>
            <form method="post">
                <input type="hidden" name="admin" value="<%=admin%>">
                <tr>
                    <input type="hidden" name="mail" readonly value=<%=r.get_mail()%>>
                    <td><%=r.get_mail()%></td>
                    <td><%=r.get_name()%></td>
                    <td>
                        <button type="submit" class="button1" onclick="this.form.action = '${pageContext.request.contextPath}/checkServlet?'">通过</button>
                        <button type="submit" class="button1" onclick="refuse(this.form)">拒绝</button>
                    </td>
                </tr>
            </form>
            <%} %>
            </tbody>
        </table>
    <%} %>
        <script type="text/javascript">
            function refuse(f){
                let res = confirm("是否确认拒绝这条注册申请？");
                f.action="${pageContext.request.contextPath}/refuseServlet";
                if(res){
                    f.submit();
                }
            }
        </script>
        <br/><br/><br/>
    </div>

    <div class="footer">
        <p>Copyright &copy 华中科技大学计算机科学与技术学院软件工程小组“三个老板” 版权所有</p>
        <p>联系我们：1472756570@qq.com</p>
    </div>

</body>
</html>
