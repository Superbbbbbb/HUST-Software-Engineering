<%@ page import="java.util.List" %>
<%@ page import="dao.*" %>
<%@ page import="proto.*" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Superb
  Date: 2022/10/14
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <link rel="icon" href="images/favicon.ico">
    <style>
        @import "css/table.css";
        @import "css/navigate.css";
        @import "css/button.css";
        @import "css/barcon.css";
        @import "css/header.css";
        .a{
            font-size:12px;
            opacity: 0;
            background-color: blanchedalmond;
        }
    </style>
    <script src="js/jquery-2.2.3.min.js"></script>
    <script src="js/page.js"></script>
    <%
        String a = request.getParameter("admin");
        int school = Integer.parseInt(request.getParameter("school"));
        schoolDao sd = new schoolDao();
        String school_name = null;
        typeDao td = new typeDao();
        List<type> typeList = null;
        try {
            school_name = sd.Search(school);
            typeList = td.SearchList(school);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        assert typeList != null;
    %>
    <title><%=school_name%></title>
</head>
<body onload="get_info();GoIn()">
<div id="body" style="opacity: 0">
    <div class="header" style="color: dodgerblue">
        <img src="./images/YZY协会logo 透明.png" alt="援之缘支教协会会标">
        <h1 style="text-align: center; font-family: 华文新魏; font-size: 50px">援之缘支教协会图书管理系统</h1>
        <p style="text-align: center; font-family: 华文行楷; font-size: 30px">——知雨书舍·<%=school_name%></p>
    </div>
    <form action="${pageContext.request.contextPath}/returnServlet" method="post">
        <%
            if(a!=null){
                int admin = Integer.parseInt(a);
        %>
        <input type="hidden" name="admin" value="<%=admin%>">
        <%} %>
        <button type="submit" class="button_return" style="vertical-align:middle"><span>返回</span></button>
    </form>

    <div class="back">
        <div class="left" id="n">
            <%if(a!=null){%>
                <a style="background-color: blanchedalmond" href="school.jsp?admin=<%=a%>&school=<%=school%>">捐赠者名单</a>
            <%} else{%>
                <a style="background-color: blanchedalmond" href="school.jsp?school=<%=school%>">捐赠者名单</a>
            <%}%>
            <a style="background-color: blanchedalmond" href="#">图书分类 »</a>
            <div>
                <%
                    int i=0;
                    for (type t : typeList) {
                        i++;
                        if(a!=null){%>
                <a id="t<%=i%>" class="a" style="padding:10px" href="book.jsp?admin=<%=a%>&school=<%=school%>&type=<%=t.get_id()%>"><td><div style="float:left"><%=t.get_name()%></div>类<div style="float:right"><%=t.get_num()%></div></td></a>
                <%} else{%>
                <a id="t<%=i%>" class="a" style="padding:10px" href="book.jsp?school=<%=school%>&type=<%=t.get_id()%>"><td><div style="float:left"><%=t.get_name()%></div>类<div style="float:right"><%=t.get_num()%></div></td></a>
                <%} } %>
            </div>
        </div>

        <div class="right">
            <table style="width: 50%">
                <caption>捐赠者名单</caption>
                <thead>
                <tr id="list">
                    <th class="table_2 th">名字</th>
                    <th class="table_2 th">捐赠数量</th>
                </tr>
                </thead>
                <tbody id="listbody">
                <%
                        donatorDao dd = new donatorDao();
                        List<donator> donatorList = null;
                        try {
                            donatorList = dd.Search(school);
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        assert donatorList != null;
                        for (donator d : donatorList) {
                %>
                <tr>
                    <td><%=d.get_name()%></td>
                    <td><%=d.get_num()%></td>
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
            </table><br/>
        </div>
    </div>
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript">
        function GoIn(){
            let b = 0,o = 0,i=1;
            timer = setInterval(function () {
                if(b<1) {
                    b += 0.1;
                    show_body(b);
                }
                else{
                    let x = document.getElementById('t' + i);
                    if(x===null){
                        clearInterval(timer);
                    }
                    if (o < 1) {
                        o += 0.04;
                        show_type(x, o);
                    }
                    else {
                        i=i+1;
                        o=0;
                    }
                }
            }, 10);
        }
        function show_body(i){
            $("#body").css("opacity", i);
        }
        function show_type(x,i){
            x.style.opacity = i;
        }
    </script>

    <div class="footer">
        <p>Copyright &copy 华中科技大学计算机科学与技术学院软件工程小组“三个老板” 版权所有</p>
        <p>联系我们：1472756570@qq.com</p>
    </div>
</div>
</body>
</html>

