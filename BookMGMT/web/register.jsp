<%--
  Created by IntelliJ IDEA.
  User: Superb
  Date: 2022/10/15
  Time: 22:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册</title>
    <link rel="icon" href="images/favicon.ico">
    <style>
        @import "css/register.css";
        @import "css/button.css";
        .msg{
            font-size: 10px;
            text-align: right;
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

<div id="loginDiv">
    <form action="${pageContext.request.contextPath}/registerServlet" method="post">
        <p id="register"><strong>注册</strong></p>
        <p><label for="name">用户姓名:</label><input type="text" id="name" name="name"></p>
        <p id="message3" class="msg">请勿超过10个中文字符或20个英文字符</p>
        <p><label for="mail">邮箱地址:</label><input type="text" id="mail" name="mail" onblur="mail_check(this.value)"></p>
        <p id="message" class="msg">请输入正确的邮箱地址</p>
        <p><label for="pwd">用户密码:</label><input type="password" id="pwd" name="pwd" onblur="pwd_check(this.value)"></p>
        <p id="message1" class="msg">请输入6~16位密码</p>
        <p><label for="pwd_">确认密码:</label><input type="password" id="pwd_" name="pwd_" onblur="check_pwd(this.value)"></p>
        <p id="message2" class="msg">请再次填写密码</p>
<br/>
        <p style="text-align: center;">
            <input type="button" class="button" onclick="check(this.form)" value="提交  ">

<%--            <input type="submit" class="button" value="提交  ">--%>
        </p>
    </form>

    <script>
        function mail_check(v) {
            let m_reg=  /^([a-zA-Z0-9]+[_|.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
            let message = document.getElementById('message');
            if (v === "") {
                message.innerHTML = "请输入正确的邮箱地址";
            } else if (!m_reg.test(v)) {
                    message.innerHTML = message.innerHTML = '邮箱地址无效';
            } else {
                message.innerHTML = message.innerHTML = "ok";
            }
        }
        function pwd_check(v) {
            let p_reg = /^[\w]{6,16}$/;
            let message = document.getElementById('message1');
            if (v === "") {
                message.innerHTML = "请输入6~16位密码";
            } else if (!p_reg.test(v)) {
                message.innerHTML = message.innerHTML = '不是6到16位或有除下划线外的特殊字符';
            } else {
                message.innerHTML = message.innerHTML = "ok";
            }
        }
        function check_pwd(v) {
            let pwd = document.getElementById("pwd").value;
            let message = document.getElementById('message2');
            if(pwd===""){
                message.innerHTML = '请再次填写密码';
            }
            else if (pwd !== v) {
                message.innerHTML = '密码不相同';
            } else {
                message.innerHTML = 'ok';
            }
        }
        function check(f){
            let m_reg=  /^([a-zA-Z0-9]+[_|.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
            let p_reg = /^[\w]{6,16}$/;
            let pwd = document.getElementById("pwd").value;
            let pwd_ = document.getElementById("pwd_").value;
            let name = document.getElementById("name").value;
            let mail = document.getElementById("mail").value;
            if(!p_reg.test(pwd)){
                alert("密码不是6到16位或有除下划线外的特殊字符");
            }
            else if(!m_reg.test(mail)){
                alert('请输入有效的邮箱地址！');
            }
            else if(pwd===""||pwd_===""||name===""||mail===""){
                alert(pwd+'\n'+pwd_+'\n'+name+'\n'+mail+'\n'+"请填写完整信息！");
            }
            else if(pwd===pwd_){
                f.submit();
            }
            else {
                alert("密码不相同");
            }
        }
    </script>
</div>

</body>


