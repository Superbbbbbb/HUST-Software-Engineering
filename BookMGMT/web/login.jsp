<%--
  Created by IntelliJ IDEA.
  User: Superb
  Date: 2022/10/14
  Time: 20:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>

<html>
<head>
    <title>登录</title>
    <link rel="icon" href="images/favicon.ico">
    <style>
        @import "css/login.css";
        @import "css/button.css";
        .box input[type="button"]{
            border: none;
            outline: none;
            color: #fff;
            background: dodgerblue;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 10px;
        }
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

<div>
    <form action="${pageContext.request.contextPath}/returnServlet" method="post">
        <button type="submit" class="button_return" style="vertical-align:middle"><span>返回</span></button>
    </form>
</div>

<div class="box">
    <p><strong>登录</strong></p>
    <form action="${pageContext.request.contextPath}/loginServlet" method="post">
        <div class="inputBox">
            <label for="mail"></label><input type="text" id="mail" name="mail" required>
            <label>邮箱</label>
        </div>
        <div class="inputBox">
            <input type="password" name="pwd" required>
            <label>密码</label>
        </div>
        <div align="center">
            <input type="submit" value="登录">
            <input type="button" onclick="forget(this.form)"  value="忘记密码">
        </div>
    </form>

    <script type="text/javascript">
        function forget(f){
            let mail = document.getElementById("mail").value;
            if(mail==="") {
                alert("请输入邮箱地址");
            }
            else{
                alert("密码将会发送到您的注册邮箱");
                f.action = "${pageContext.request.contextPath}/emailServlet";
                f.submit();
            }
        }
    </script>

</div>
</body>
</html>
