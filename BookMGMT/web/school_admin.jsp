<%--
  Created by IntelliJ IDEA.
  User: Tiger
  Date: 2022/11/6
  Time: 17:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="dao.*" %>
<%@ page import="proto.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>学校管理</title>
    <link rel="icon" href="images/favicon.ico">
    <style>
        @import "css/button.css";
        @import "css/table.css";
        @import "css/navigate.css";
        @import "css/barcon.css";
        @import "css/header.css";
    </style>
    <script src="js/jquery-2.2.3.min.js"></script>
    <script src="js/page.js"></script>
    <script type="text/javascript">
        let currentPosition, timer;

        function GoTop(){
            timer=setInterval("runToTop()",1);
        }
        function runToTop(){
            currentPosition=document.documentElement.scrollTop || document.body.scrollTop;
            currentPosition-=15;
            if(currentPosition>0) {
                window.scrollTo(0,currentPosition);
            }
            else {
                window.scrollTo(0,0);
                clearInterval(timer);
            }
        }
    </script>
    <%
        int admin = Integer.parseInt(request.getParameter("admin"));
    %>
</head>
<body onload="get_info();">

    <div class="header" style="color: dodgerblue">
        <img src="./images/YZY协会logo 透明.png" alt="援之缘支教协会会标">
        <h1 style="text-align: center; font-family: 华文新魏; font-size: 50px">援之缘支教协会图书管理系统</h1>
        <p style="text-align: center; font-family: 华文行楷; font-size: 30px">——知雨书舍</p>
    </div>

    <form action="${pageContext.request.contextPath}/returnServlet" method="post">
        <input type="hidden" name="admin" value="<%=admin%>">
        <button type="submit" class="button_return"><span>返回</span></button>
    </form>

    <button class="button_top" onclick="GoTop()">↑</button>

    <div class="back">
        <%
            adminDao ad = new adminDao();
            List<admin> adminList = null;
            schoolDao sd = new schoolDao();
            List<school> schoolList = null;
            try {
                adminList = ad.SearchList();
                schoolList = sd.SearchList();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            assert adminList != null;
            assert schoolList != null;
            if(schoolList.size()!=0){
        %>
        <table style="min-width: 70%">
            <caption>学校管理</caption>
            <thead>
            <tr id="list">
                <th>id</th>
                <th>学校名字</th>
                <th>合作日期</th>
                <th>管理员</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="listbody">
            <%
                for (school s : schoolList) {
                    int id = s.get_admin();
                    String name = null;
                    try {
                        name=ad.Search(id).get_name();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
            %>
            <tr>
                <form method="post">
                    <input type="hidden" name="admin" value="<%=admin%>">
                    <input type="hidden" name="id" value="<%=s.get_id()%>">
                    <td><%=s.get_id()%></td>
                    <td><label>
                        <input type="text" name="name" required value=<%=s.get_name()%>>
                    </label></td>
                    <td><%=s.get_date()%></td>
                    <td><label>
                        <select name="adminId">
                            <option selected="selected" disabled selected hidden><%=name%></option>
                            <%for(admin a: adminList){%>
                            <option class="option" value=<%=a.get_id()%>><%=a.get_name()%></option>
                            <%} %>
                        </select>
                    </label></td>
                    <td>
                        <button type="submit" class="button1" onclick="this.form.action='${pageContext.request.contextPath}/school_updateServlet'">提交</button>
                        <button type="button" class="button1" onclick="delete_(this.form)">删除</button>
                    </td>
                </form>
            </tr>
            <%} %>
            </tbody>
        </table><br/>
        <table class="search">
            <tbody>
            <tr>
                <td>
                    <div class="barcon">
                        <ul>
                            <li>
                                <span id="total_tr"></span>
                                <input id="paging" type="text" value="" readonly>
                                <span id="total_page"></span>
                            </li>
                            <li><a href="##" id="firstPage">&lt;&lt;</a></li>
                            <li><a href="##" id="prePage">&lt;</a></li>
                            <li><a href="##" id="nextPage">&gt;</a></li>
                            <li><a href="##" id="lastPage">&gt;&gt;</a></li>
                            <li>
                                <span>前往</span>
                                <input id="input_page" type="text" value="" readonly autocomplete="off"/>
                                <span>页</span>
                            </li>
                        </ul>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
        <%} %>

        <form action="${pageContext.request.contextPath}/school_addServlet" method="post">
        <table style="width: 70%" id="test">
            <caption>新增学校</caption>
            <thead>
            <tr>
                <th>序号</th>
                <th>学校名字</th>
                <th>管理员id</th>
            </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}">
                <tr>
                    <input type="hidden" name="admin" value="<%=admin%>">
                    <td>${index + 1}</td>
                    <td><label>
                        <input type="text" name="name1" required>
                    </label></td>
                    <td><label>
                        <select name="adminId1">
                            <option disabled selected hidden>选择</option>
                            <%for(admin a: adminList){%>
                            <option value=<%=a.get_id()%>><%=a.get_name()%></option>
                            <%} %>
                        </select>
                    </label></td>
                </tr>
                </c:forEach>
            </tbody>
        </table><br/>
        <table class="search">
            <tbody>
            <tr>
                <td>
                    <input type="button" class="button1" style="width: 70px" value="增加栏位" onclick="add()">
                    <input type="button" class="button1" style="width: 70px" value="减少栏位" onclick="sub()">
                    <input type="submit" class="button1" onclick="ScrollPosition()" value="提交">
                </td>
            </tr>
            </tbody>
        </table>
        </form>

        <br/><br/><br/>
    </div>
    <script type="text/javascript">
        function delete_(f){
            let res = confirm("删除学校将会删除其所有图书及捐赠人信息，且无法撤销\n删除请点确定");
            f.action="${pageContext.request.contextPath}/school_deleteServlet";
            if(res){
                f.submit();
            }
        }
    </script>
    <script type="text/javascript">
        let index = 1;

        function add() {
            let addstep = index + 1;
            $("#test tr:last").after("<tr id='"+ addstep + "'>" +
                "<td>"+ addstep +"</td>" +
                "<td>" +
                "<input type='text' name='name" + addstep + "' required>" +
                "</td>" +
                "<td>"+
                "<select name='adminId" + addstep + "'>"+
                "<option disabled selected hidden>选择</option>"+
                "<%for(admin a: adminList){%>"+
                "<option value=<%=a.get_id()%>><%=a.get_name()%></option>"+
                "<%} %>"+
                "</select>"+
                "</td>"+
                "</tr>");
            index += 1;
        }
        function sub(){
            document.getElementById(index).remove();
            index -= 1;
        }
    </script>

    <div class="footer">
        <p>Copyright &copy 华中科技大学计算机科学与技术学院软件工程小组“三个老板” 版权所有</p>
        <p>联系我们：1472756570@qq.com</p>
    </div>

</body>
</html>


