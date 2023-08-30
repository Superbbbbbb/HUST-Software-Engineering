<%@ page import="java.util.List" %>
<%@ page import="dao.*" %>
<%@ page import="proto.*" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Superb
  Date: 2022/10/17
  Time: 14:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <link rel="icon" href="images/favicon.ico">
    <style>
        @import "css/navigate.css";
        @import "css/barcon.css";
        @import "css/header.css";
        @import "css/button.css";
        @import "css/table.css";
    </style>
    <script src="js/jquery-2.2.3.min.js"></script>
    <script src="js/page.js"></script>
    <script type="text/javascript">
        function ScrollPosition() {
            let pos = document.getElementsByName("position");
            pos.forEach(p=>p.value = document.body.scrollTop);
        }

        let currentPosition, timer;

        function GoTop() {
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
        int school = Integer.parseInt(request.getParameter("school"));
        int admin = Integer.parseInt(request.getParameter("admin"));
        String n = request.getParameter("n");
        if(n==null) n="";
        String p = request.getParameter("position");
        int position = p==null?0:Integer.parseInt((p.split("\\."))[0]);
        schoolDao sd = new schoolDao();
        String school_name = null;
        try {
            school_name = sd.Search(school);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
    <title>图书管理·<%=school_name%></title>
</head>
<body onload="get_info();window.scrollTo(0,<%=position%>);">

<div class="header" style="color: dodgerblue">
    <img src="./images/YZY协会logo 透明.png" alt="援之缘支教协会会标">
    <h1 style="text-align: center; font-family: 华文新魏; font-size: 50px">援之缘支教协会图书管理系统</h1>
    <p style="text-align: center; font-family: 华文行楷; font-size: 30px">——知雨书舍·<%=school_name%></p>
</div>

<form action="${pageContext.request.contextPath}/returnServlet" method="post">
    <input type="hidden" name="admin" value="<%=admin%>">
    <button type="submit" class="button_return" style="vertical-align:middle"><span>返回</span></button>
</form>

<button class="button_top" onclick="GoTop()">↑</button>

<div class="back">
    <%
        bookDao bd = new bookDao();
        List<book> bookList = null;
        typeDao td = new typeDao();
        List<type> typeList = null;
        try {
            typeList = td.SearchList();
            bookList = bd.SearchName(n,school);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
    <table class="search">
        <caption>书单</caption>
        <tbody>
        <tr>
            <td>
                <form action="${pageContext.request.contextPath}/searchServlet" method="post">
                    <input type="hidden" name="school" value=<%=school%>>
                    <input type="hidden" name="admin" value=<%=admin%>>
                    查询书名:<input type="text" id="name" style="text-align: left;" name="n" value=<%=n%>>
                    <input type="submit" class="button1" value="查询">
                    <input type="button" class="button1" onclick="quit(this.form)" value="取消">
                </form>
            </td>
        </tr>
        </tbody>
    </table><br/>
    <table>
        <thead>
        <tr id="list">
            <th>id</th>
            <th>书名</th>
            <th>类型</th>
            <th>入库日期</th>
            <th>捐赠人</th>
            <th>出借</th>
            <th>借阅人</th>
            <th>出借日期</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="listbody">
        <%
            assert bookList != null;
            for (book b : bookList) {
                if(b==null) break;
                String tn = null;
                try {
                    tn = td.Search(b.get_type()).get_name();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
        %>
        <form method="post">
            <input type="hidden" name="school" value=<%=school%>>
            <input type="hidden" name="admin" value=<%=admin%>>
            <input type="hidden" name="id" value=<%=b.get_id()%>>
            <tr>
                <input type="hidden" name="type" value=<%=b.get_type()%>>
                <td><%=b.get_id()%></td>
                <td><input type="text" name="name" required value=<%=b.get_name()%>></td>
                <td>
                    <select name="type">
                        <option disabled selected hidden><%=tn%></option>
                        <%
                            assert typeList != null;
                            for(type t: typeList){
                        %>
                        <option value=<%=t.get_id()%>><%=t.get_name()%></option>
                        <%} %>
                    </select>
                </td>
                <td><%=b.get_date()%></td>
                <td><label>
                    <input type="text" style="width: 80px" name="donator" required value=<%=b.get_donator()%>>
                </label></td>
                <td>
                    <%if(b.get_status()==1){%>
                    <label>
                        <input type="checkbox" name="status" checked>
                    </label>
                    <%} else{ %>
                    <label>
                        <input type="checkbox" name="status">
                    </label>
                    <%} %>
                </td>
                <td><label>
                    <input type="text" style="width: 80px" name="borrow_name" value=<%=b.get_borrow_name()%>>
                </label></td>
                <td><%=b.get_lend_date()%></td>
                <td>
                    <input type="submit" class="button1" onclick="this.form.action = '${pageContext.request.contextPath}/book_updateServlet'" value="提交">
                    <input type="submit" class="button1" onclick="delete_(this.form)" value="删除">
                </td>
            </tr>
        </form>
        <%--            <iframe src="" width="0" height="0" name="frame" style="display:none"></iframe>--%>
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

    <script type="text/javascript">
        function quit(f) {
            document.getElementById("name").value="";
            f.submit();
        }
        function delete_(f){
            let res = confirm("是否确认删除该图书？");
            f.action="${pageContext.request.contextPath}/book_deleteServlet";
            if(res){
                f.submit();
            }
        }
    </script>

    <form action="${pageContext.request.contextPath}/book_addServlet" method="post">
        <table style="width: 70%" id="test">
            <caption>新增图书</caption>
            <thead>
            <tr>
                <th>序号</th>
                <th>书名</th>
                <th>类型</th>
                <th>捐赠人</th>
            </tr>
            </thead>
            <tbody>
            <input type="hidden" name="school" value=<%=school%>>
            <input type="hidden" name="admin" value=<%=admin%>>
            <c:forEach items="${list}">
                <tr>
                    <td>${index + 1}</td>
                    <td><label><input type="text" name="name1" required></label></td>
                    <td><label>
                        <select name="type1">
                            <option disabled selected hidden>选择</option>
                            <%
                                assert typeList != null;
                                for(type t: typeList){
                            %>
                            <option value=<%=t.get_id()%>><%=t.get_name()%></option>
                            <%} %>
                        </select>
                    </label></td>
                    <td><label><input type="text" style="width: 80px" name="donator1" required></label></td>
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
    </form><br/>

    <form action="${pageContext.request.contextPath}/type_addServlet" method="post">
        <table style="width: 70%" id="type">
            <caption>新增类型</caption>
            <thead>
            <tr>
                <th>序号</th>
                <th>名字</th>
            </tr>
            </thead>
            <tbody>
            <input type="hidden" name="school" value=<%=school%>>
            <input type="hidden" name="admin" value=<%=admin%>>
            <c:forEach items="${list}">
                <tr>
                    <input type="hidden" name="position">
                    <td>${index + 1}</td>
                    <td><input type="text" name="type1" required></td>
                </tr>
            </c:forEach>
            </tbody>
        </table><br/>
        <table class="search">
            <tbody>
            <tr>
                <td>
                    <input type="button" class="button1" style="width: 70px" value="增加栏位" onclick="add_t()">
                    <input type="button" class="button1" style="width: 70px" value="减少栏位" onclick="sub_t()">
                    <input type="submit" class="button1" onclick="ScrollPosition()" value="提交">
                </td>
            </tr>
            </tbody>
        </table>
    </form>

    <br/><br/><br/>

</div>

<script type="text/javascript">
    let index = 1;
    function add() {
        let addstep = index + 1;
        $("#test tr:last").after("<tr id='"+ addstep + "' required>" +
            "<td>"+ addstep +"</td>" +
            "<td>" +
            "<input type='text' name='name" + addstep + "' required>" +
            "</td>" +
            "<td>"+
            "<select name='type" + addstep + "'>"+
            "<option disabled selected hidden>选择</option>"+
            "<%
                    assert typeList != null;
                    for(type t: typeList){
                 %>"+
            "<option value=<%=t.get_id()%>><%=t.get_name()%></option>"+
            "<%} %>"+
            "</select>"+
            "</td>"+
            "<td>"+
            "<input type='text' style='width: 80px' name='donator"+ addstep + "' required>"+
            "</td>"+
            "</tr>");
        index += 1;
    }
    function sub(){
        document.getElementById(index).remove();
        index -= 1;
    }
    function add_t() {
        let addstep = index + 1;
        $("#type tr:last").after("<tr id='t"+ addstep + "'>" +
            "<td>"+ addstep +"</td>" +
            "<td>" +
            "<input type='text' name='type" + addstep + "' required>" +
            "</td>" +
            "</tr>");
        index += 1;
    }
    function sub_t(){
        document.getElementById("t" + index).remove();
        index -= 1;
    }
</script>

<div class="footer">
    <p>Copyright &copy 华中科技大学计算机科学与技术学院软件工程小组“三个老板” 版权所有</p>
    <p>联系我们：1472756570@qq.com</p>
</div>

</body>
</html>
