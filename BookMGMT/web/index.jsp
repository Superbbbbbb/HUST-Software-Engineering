<%@ page import="java.util.List" %>
<%@ page import="dao.*" %>
<%@ page import="proto.*" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Superb
  Date: 2022/10/14
  Time: 20:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>援之缘支教协会图书管理系统</title>
    <link rel="icon" href="images/favicon.ico">
    <meta name="keywords" content="支教,图书,捐助,华科,援之缘">
    <meta name="description" content="华中科技大学援之缘支教协会图书管理系统">
    <meta name="author" content="软件工程作业小组：胡沁心，张宁静，苏宜静">
    <link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">

    <style>
        @import "css/navigate.css";
        @import "css/header.css";
        @import "css/button.css";
        body{
            font-family: Arial;
            background: white;
        }
        .box{
            width: 1024px;
            height: 576px;
            position: relative;
            margin: auto;
        }
        .box-img{
            position: absolute;
            top: 0;
            left: 0;
            opacity: 0;
            transition: all 1.5s;
        }
        .box-img:nth-child(1){
            opacity: 1;
        }
        .box-left{
            position: absolute;
            width: 35px;
            height: 70px;
            color: pink;
            top: 250px;
            left: 0;
            border-radius: 0 5px 5px 0;
            text-align: center;
            line-height: 70px;
            font-size: 24px;
        }
        .box-left:hover{
            background-color: #999999;
            color: #fff;
        }
        .box-right{
            position: absolute;
            width: 35px;
            height: 70px;
            color: pink;
            top: 250px;
            right: 0;
            border-radius: 5px 0 0 5px;
            text-align: center;
            line-height: 70px;
            font-size: 24px;
        }
        .box-right:hover{
            background-color: #999999;
            color: #fff;
        }
        .box-select>ul{
            padding: 0;
            margin: 0;
            list-style: none;
        }
        .box-select li{
            width: 14px;
            height: 14px;
            border-radius: 100%;
            background-color: blanchedalmond;
            float: left;
            margin-left: 10px;
        }
        .box-select li:hover{
            background-color: #ffffff;
        }
        .box-select li:nth-child(1){
            background-color: #ffffff;
        }
        .box-select{
            position: absolute;
            bottom: 20px;
            right: 100px;
        }
        .box h2{
            color: dodgerblue;
            text-align: center;
            font-family: 幼圆;
            font-size: 30px;
            letter-spacing: 10px;
            line-height: 10px;
        }
        .box p{
            letter-spacing: 2px;
            line-height: 30px;
        }
        .box-row:after{
            content: "";
            display: table;
            clear: both;
        }
        .box-column{
            float: left;
            width: 50%;
            padding: 30px;
            text-align: justify;
            text-indent: 32px;
        }
        @media screen and (max-width: 600px) {
            .box-column {
                width: 100%;
            }
        }

        .ml {
            position: relative;
            font-weight: 200;
            font-size: 4em;
        }
        .ml .text-wrapper {
            position: relative;
            display: inline-block;
            padding-top: 0.2em;
            padding-right: 0.05em;
            padding-bottom: 0.1em;
            overflow: hidden;
        }
        .ml .letter {
            transform-origin: 50% 100%;
            display: inline-block;
            line-height: 1em;
        }

        .ml1 {
            position: relative;
            font-weight: 200;
            font-size: 4em;
        }
        .ml1 .text-wrapper {
            position: relative;
            display: inline-block;
            padding-top: 0.2em;
            padding-right: 0.05em;
            padding-bottom: 0.1em;
            overflow: hidden;
        }
        .ml1 .letter {
            transform-origin: 50% 100%;
            display: inline-block;
            line-height: 1em;
        }

        .ml2 {
            position: relative;
            font-weight: 200;
            font-size: 4em;
        }
        .ml2 .text-wrapper {
            position: relative;
            display: inline-block;
            padding-top: 0.2em;
            padding-right: 0.05em;
            padding-bottom: 0.1em;
            overflow: hidden;
        }
        .ml2 .letter {
            transform-origin: 50% 100%;
            display: inline-block;
            line-height: 1em;
        }
        #nav3{
            display:none;
            position:absolute;
            z-index:1;
            background-color: floralwhite;
            width:240px;
            text-align: left;
            padding: 10px;
            border: 2px dashed dodgerblue;
        }
        .button_{
            background-color:dodgerblue;
            border-radius:8px;
            border: none;
            font-size: 15px;
            padding: 2px 5px;
            color: white;
            cursor: pointer;
        }
        .msg{
            font-size: 10px;
            text-align: right;
            line-height: 10px;
        }
    </style>
    <script type="text/javascript">
        let currentPosition, timer;

        function GoTop(){
            timer=setInterval("runToTop()",1);
        }
        function runToTop() {
            currentPosition = document.documentElement.scrollTop || document.body.scrollTop;
            currentPosition -= 15;
            if (currentPosition > 0) {
                window.scrollTo(0, currentPosition);
            } else {
                window.scrollTo(0, 0);
                clearInterval(timer);
            }
        }
        function GoDown(){
            timer=setInterval("runToDown(0)",1);
        }
        function runToDown(s){
            currentPosition=document.documentElement.scrollTop || document.body.scrollTop;
            currentPosition+=5;
            if(s===0){
                if(currentPosition<document.body.scrollHeight-document.getElementById("foot").offsetHeight-document.getElementById("box3").offsetHeight-50) {
                    window.scrollTo(0,currentPosition);
                }
                else {
                    window.scrollTo(0,document.body.scrollHeight-document.getElementById("foot").offsetHeight-document.getElementById("box3").offsetHeight-50);
                    clearInterval(timer);
                }
            }
            else{
                if(currentPosition<s) {
                    window.scrollTo(0,currentPosition);
                }
                else {
                    window.scrollTo(0,s);
                }
            }
        }
    </script>
</head>
<body onload="GoIn()">
<%
    String mess = (String) request.getAttribute("message");
    if(mess!=null){
%>
<script type = text/javascript>
    alert("<%=mess%>");
</script>
<%}%>
<div id="b" style="opacity:0">
    <button class="button_down" onclick="GoDown(0)"><strong>捐助途径</strong></button>
    <button class="button_top" onclick="GoTop()">↑</button>
</div>
<div id="x" style="opacity:0">

    <div class="header" style="color: dodgerblue">
        <img src="./images/YZY协会logo 透明.png" alt="援之缘支教协会会标">
        <h1 style="text-align: center; font-family: 华文新魏; font-size: 50px">援之缘支教协会图书管理系统</h1>
        <p style="text-align: center; font-family: 华文行楷; font-size: 30px">——知雨书舍</p>
    </div>
    <div class="navigate">
        <ul>
            <%
                Object a = request.getAttribute("admin");
                schoolDao sd = new schoolDao();
                adminDao ad = new adminDao();
                List<school> schoolList = null;
                try {
                    schoolList = sd.SearchList();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                if(a!=null){
                    int admin = (int) request.getAttribute("admin");
                    admin adm = null;
                    try {
                        adm = ad.Search(admin);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    if(adm==null){
            %>
            <li id="li2">
                <a href="login.jsp">登录</a>
            </li>
            <li id="li2">
                <a onclick="return inform()" href="register.jsp">注册</a>
            </li>
            <%} else{%>
            <li id="li2">
                <a onclick="return sign_out()" href="index.jsp">退出</a><br/>
            </li>
            <div class="nav1">
                <%
                    List<school> sList = null;
                    try {
                        sList = sd.SearchList(admin);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
                <a href="#"><i class="fa fa-book fa-fw"></i>图书管理</a>
                <div class="nav2">
                    <%
                        assert sList != null;
                        for (school s : sList) {
                    %>
                    <a href="book_admin.jsp?admin=<%=a%>&school=<%=s.get_id()%>"><%=s.get_name()%></a>
                    <%} %>
                </div>
            </div>

            <%if(adm.get_status()==1){%>
            <li>
                <a href="admin_super.jsp?admin=<%=a%>"><i class="fa fa-user fa-fw"></i>管理员</a>
            </li>
            <li>
                <a href="school_admin.jsp?admin=<%=a%>"><i class="fa fa-envelope-open fa-fw"></i>学校管理</a>
            </li>
            <%}%>
            <div class="nav1" id="nav1" style="float: right">
                <a href="#"><i class="fa fa-user-circle-o" aria-hidden="true"></i> 个人信息更改</a>
                <div id="nav3">
                    <form action="${pageContext.request.contextPath}/adminServlet" method="post" target="frame">
                        <input type="hidden" name="admin" value="<%=admin%>">
                        <lable>权限: </lable><%=(adm.get_status()==1?"总管理员":"管理员")%><br/>
                        <lable>名字: </lable><input type="text" id="name" name="name" value=<%=adm.get_name()%>>
                        <p id="message3" class="msg">请勿超过10个中文字符或20个英文字符</p>
                        <lable>邮箱: </lable><input type="text" id="mail" name="mail" onblur="mail_check(this.value)" value=<%=adm.get_mail()%>>
                        <p id="message" class="msg">ok</p>
                        <lable>密码: </lable><input type="text" id="pwd" name="pwd" onblur="pwd_check(this.value)" value=<%=adm.get_password()%>>
                        <p id="message1" class="msg">ok</p>
                        <div style="text-align: center">
                            <button type="button" class="button_" onclick="check(this.form)">更改</button>
                        </div>
                    </form>
                    <iframe name="frame" style="display:none"></iframe>
                </div>
            </div>
            <%} } else{%>
            <li id="li2">
                <a href="login.jsp">登录</a>
            </li>
            <li id="li2">
                <a onclick="return inform()" href="register.jsp">注册</a>
            </li>
            <%}%>
            <div class="nav1">
                <a href="#" id="nav"><i class="fa fa-bank fa-fw"></i>合作学校</a>
                <div class="nav2">
                    <%
                        assert schoolList != null;
                        for (school s : schoolList) {
                            if(a!=null){
                    %>
                    <a href="school.jsp?admin=<%=a%>&school=<%=s.get_id()%>"><%=s.get_name()%></a>
                    <%} else{%>
                    <a href="school.jsp?school=<%=s.get_id()%>"><%=s.get_name()%></a>
                    <%}}%>
                </div>
            </div>
        </ul>
    </div>
    <script type="text/javascript">
        function inform() {
            return confirm("管理员权限的注册审核仅对援之缘内部人员开放\n继续注册请点确定");
        }
        function sign_out(){
            return confirm("是否确认退出？");
        }
        function mail_check(v) {
            let m_reg=  /^([a-zA-Z0-9]+[_|.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
            let message = document.getElementById('message');
            if(!m_reg.test(v)){
                message.innerHTML = '邮箱地址无效';
            }
            else{
                message.innerHTML = "ok";
            }
        }
        function pwd_check(v) {
            let p_reg = /^[\w]{6,16}$/;
            let message = document.getElementById('message1');
            if(!p_reg.test(v)){
                message.innerHTML = '不是6到16位或有除下划线外的特殊字符';
            } else{
                message.innerHTML = "ok";
            }
        }
        function check(f){
            let p_reg = /^[\w]{6,16}$/;
            let m_reg=  /^([a-zA-Z0-9]+[_|.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
            let pwd = document.getElementById("pwd").value;
            let name = document.getElementById("name").value;
            let mail = document.getElementById("mail").value;
            if(pwd===""||name===""||mail===""){
                alert("请填写完整信息！");
            } else if(!m_reg.test(mail)){
                alert('请输入有效的邮箱！');
            }else if(!p_reg.test(pwd)){
                alert("密码不是6到16位或有除下划线外的特殊字符");
            } else{
                alert("更改成功");
                f.submit();
            }
        }
    </script>
    <div class="box">
        <div class="box-img"><img src="./images/1.jpg" alt="" width="1024" height="576"></div>
        <div class="box-img"><img src="./images/2.jpg" alt="" width="1024" height="576"></div>
        <div class="box-img"><img src="./images/3.jpg" alt="" width="1024" height="576"></div>
        <div class="box-img"><img src="./images/4.jpg" alt="" width="1024" height="576"></div>
        <div class="box-img"><img src="./images/5.jpg" alt="" width="1024" height="576"></div>
        <div class="box-img"><img src="./images/6.jpg" alt="" width="1024" height="576"></div>
        <div class="box-left" style="cursor: pointer">&lt;</div>
        <div class="box-right" style="cursor: pointer">&gt;</div>
        <div class="box-select">
            <ul>
                <li class="button"></li>
                <li class="button"></li>
                <li class="button"></li>
                <li class="button"></li>
                <li class="button"></li>
                <li class="button"></li>
            </ul>
        </div>
    </div>
</div>
<script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
    $('#nav').on('click',function(e){
        e.stopPropagation();
        if(document.getElementById("nav3").style.display==="block") {
            $("#nav3").css("display", "none");
            $("#nav1").css("background-color", "blanchedalmond");
        }
        else{
            $("#nav3").css("display", "block");
            $("#nav1").css("background-color", "aliceblue");
        }
    });
    $('#nav1').on('click',function(e){
        e.stopPropagation();
        $("#nav3").css("display", "block");
        $("#nav1").css("background-color", "aliceblue");
    });
    $(document).on('click',function(){
        $("#nav3").css("display","none");
        $("#nav1").css("background-color", "blanchedalmond");
    });
    function GoIn(){
        let now, last = 0;
        let i = 0, i1 = 0, i2 = 0, i3 = 0, b = 0;
        let s1 = document.getElementById('x').offsetHeight;
        let s2 = s1 + document.getElementById('box1').offsetHeight;
        let s3 = s2 + document.getElementById('box2').offsetHeight;
        let scroll = setInterval(function () {
            now = document.documentElement.scrollTop || document.body.scrollTop;
            let e = now - last;
            if (e > 0) {
                if (document.body.scrollTop > 300 && document.body.scrollTop < s1 + 10) runToDown(s1 + 10);
                else if (document.body.scrollTop > (s1 + 50) && document.body.scrollTop < s2 - 50) runToDown(s2 - 50);
                else if (document.body.scrollTop > (s2 + 50) && document.body.scrollTop < s3 - 50) runToDown(s3 - 50);
            }
            last = now;
        }, 1);
        let t = setInterval(function () {
            if (document.body.scrollTop < (s1 - 200)) {
                if (i < 1) i += 0.1;
                if (i1 > 0) i1 -= 0.01;
            } else if (document.body.scrollTop > (s1 - 200) && document.body.scrollTop < (s1 + 200)) {
                if (i1 < 1) i1 += 0.01;
                if (i2 > 0) i2 -= 0.01;
                if (i > 0) i -= 0.01;
            } else if (document.body.scrollTop > (s2 - 200) && document.body.scrollTop < (s2 + 200)) {
                if (i2 < 1) i2 += 0.01;
                if (i1 > 0) i1 -= 0.01;
                if (i3 > 0) i3 -= 0.01;
            } else if (document.body.scrollTop > (s2 + 200)) {
                if (i3 < 1) i3 += 0.01;
                if (i2 > 0) i2 -= 0.01;
            }
            if (b < 1) {
                b += 0.1;
                show_b(b);
            }
            show_x(i);
            show_box1(i1);
            show_box2(i2);
            show_box3(i3);
        }, 10);
    }
    function show_b(i){
        $("#b").css("opacity", i);
    }
    function show_x(i){
        $("#x").css("opacity", i);
    }
    function show_box1(i){
        $("#box1").css("opacity", i);
    }
    function show_box2(i){
        $("#box2").css("opacity", i);
    }
    function show_box3(i){
        $("#box3").css("opacity", i);
    }
</script>
<script type="text/javascript">
    $(function (){
        let index = 0;  //标记当前图片文件索引
        let f;
        timer();
        function show(){
            //显示图片
            $(".box-img").css("opacity", "0");  //显示下一张图片之前，前面的所有图片都进行隐藏
            $(".box-img").eq(index).css("opacity", "1");    //下一张图片进行显示
        }
        function colorUpdate (){
            //点击时改变底部按钮颜色
            $(".button").css("background-color", "blanchedalmond"); //在改变按钮颜色前先让所有按钮变为默认色，避免一次点击后按钮不能恢复到默认色
            $(".button").eq(index).css("background-color", "#ffffff");  //改变点击的按钮的颜色
        }
        function timer(){
            f = setInterval(function (){
                if (index != ($(".box-img").length-1))
                    index++;
                else
                    index = 0;
                show();
                colorUpdate();
            },2000) //每隔2秒显示下一张图片
        }
        $(".box-left").click(function (){
            clearInterval(f);
            if (!index)
                index = $(".box-img").length-1;
            else
                index--;
            show();
            colorUpdate();
            timer();
        })
        $(".box-right").click(function (){
            clearInterval(f);
            if (index != $(".box-img").length-1)
                index++;
            else
                index = 0;
            show();
            colorUpdate();
            timer();
        })
        $(".button").click(function (){
            clearInterval(f);
            index = $(this).index();
            show();
            colorUpdate();
            timer();
        })
    })
</script>
<div class="box" id="box1" style="opacity:0">
    <br/><br/><br/><br/>
    <h2 class="ml">
                <span class="text-wrapper">
                <span class="letters">我们是谁</span>
                </span>
    </h2>
    <br/>
    <%--            style="opacity:0"--%>
    <p style="color: #f1b0b7; text-align: center"><strong>————</strong></p>
    <br/>
    <div class="box-row">
        <div class="box-column">
            <img src="./images/7.jpg" alt="我们是谁" style="margin: 0; width: 452px; float: left">
        </div>
        <div class="box-column">
            <br/><br/><br/>
            <p>援之缘支教协会，成立于2006年初，致力于联系和团结有爱心并热衷于公益事业的校友及青年朋友们，身体力行，向全社会宣传爱心和奉献的精神。</p>
            <br/><br/>
            <p><strong>援</strong>——奉献社会，成就自我；<br/></p>
            <p><strong>之</strong>——搭筑平台，沟通合作；<br/></p>
            <p><strong>缘</strong>——以缘相聚，与爱共舞。<br/></p>
        </div>
    </div>
</div>
<div class="box" id="box2" style="opacity:0">
    <h2 class="ml1">
                <span class="text-wrapper">
                <span class="letters">我们在做什么</span>
                </span>
    </h2>
    <br/>
    <p style="color: #f1b0b7; text-align: center"><strong>————</strong></p>
    <br/>
    <div class="box-row">
        <div class="box-column">
            <br>
            <p>我们以暑期支教为核心，为百余名华中大学子组成的数支队伍提供志愿服务山区教育的平台，在山区支教的三周里，接近并陪伴孩子们的梦想。我们以支教训练营为门槛，为提升支教志愿者质量，进行长达一个学期的培训、考核与建设活动。</p><br>
            <p>这里有我所热爱的人，做着我所热爱的事，为了我们共同热爱的援之缘。援之缘人是公益活动的参与者，更是公益活动的组织者。援之缘人一届届地走出华中大，而援之缘一年年地，<strong>放飞希望，让爱蔓延</strong>。</p>
        </div>
        <div class="box-column">
            <img src="./images/8.jpg" alt="我们在做什么" style="margin: 0; width: 452px; float: right">
        </div>
    </div>
</div>
<div class="box" id="box3" style="opacity:0">
    <h2 class="ml2">
                <span class="text-wrapper">
                <span class="letters">捐助途径</span>
                </span>
    </h2>
    <br/>
    <p style="color: #f1b0b7; text-align: center"><strong>————</strong></p>
    <br/>
    <div class="box-row">
        <div class="box-column">
            <img src="./images/9.jpg" alt="捐助途径" style="margin: 0; width: 452px; float: left">
        </div>
        <div class="box-column">
            <br/>
            <p>援之缘支教协会以“安琪计划”与“知雨书舍”为拓展，建立山区奖助体系与图书室，在短期支教的年年传承中，做到物质与精神上的长期陪伴。</p><br/>
            <p>知雨书舍，是援之缘支教协会两大特色小组之一。协会建立山区图书室，并根据各个基地的环境建立特色主题书舍。</p><br/>
            <p>书籍捐赠：电话：17700713202（微信同号）</p>
            <p>&emsp;&emsp;&emsp;&emsp;&emsp;Q Q：2393732975</p>
            <p>公益合作：邮箱：1472756570@qq.com</p>
            <br/><br/>
        </div>
    </div>
</div>


<script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/2.0.2/anime.min.js"></script>
<script>
    // Wrap every letter in a span
    let textWrapper = document.querySelector('.ml .letters');
    textWrapper.innerHTML = textWrapper.textContent.replace(/\S/g, "<span class='letter'>$&</span>");

    anime.timeline({loop: true})
        .add({
            targets: '.ml .letter',
            scale: [0, 1],
            duration: 1500,
            elasticity: 600,
            delay: (el, i) => 45 * (i+1)
        }).add({
        targets: '.ml',
        opacity: 0,
        duration: 1000,
        easing: "easeOutExpo",
        delay: 1000
    });

    // Wrap every letter in a span
    let textWrapper1 = document.querySelector('.ml1 .letters');
    textWrapper1.innerHTML = textWrapper1.textContent.replace(/\S/g, "<span class='letter'>$&</span>");

    anime.timeline({loop: true})
        .add({
            targets: '.ml1 .letter',
            scale: [0, 1],
            duration: 1500,
            elasticity: 600,
            delay: (el, i) => 45 * (i+1)
        }).add({
        targets: '.ml1',
        opacity: 0,
        duration: 1000,
        easing: "easeOutExpo",
        delay: 1000
    });

    // Wrap every letter in a span
    let textWrapper2 = document.querySelector('.ml2 .letters');
    textWrapper2.innerHTML = textWrapper2.textContent.replace(/\S/g, "<span class='letter'>$&</span>");

    anime.timeline({loop: true})
        .add({
            targets: '.ml2 .letter',
            scale: [0, 1],
            duration: 1500,
            elasticity: 600,
            delay: (el, i) => 45 * (i+1)
        }).add({
        targets: '.ml2',
        opacity: 0,
        duration: 1000,
        easing: "easeOutExpo",
        delay: 1000
    });
</script>

<div class="footer" id="foot">
    <p>Copyright &copy 华中科技大学计算机科学与技术学院软件工程小组“三个老板” 版权所有</p>
    <p>联系我们：1472756570@qq.com</p>
</div>
</body>

</html>

