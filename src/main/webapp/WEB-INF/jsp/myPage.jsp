<%@ page import="com.wyh.pojo.User" %><%--
  Created by IntelliJ IDEA.
  User: KAMISAMA
  Date: 2021/3/12
  Time: 21:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的主页</title>
    <link href="${pageContext.request.contextPath}/webjars/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
    <script src="webjars/jquery/3.2.1/jquery.min.js"></script>
    <style>
        span{
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">

            <nav class="navbar navbar-default">
                <div class="container-fluid">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="/">首页</a>
                    </div>

                    <div>
                        <ul class="nav navbar-nav navbar-right form-inline">
                            <% User userSession = (User) session.getAttribute("userSession");
                                if (userSession == null) {%>
                            <li><a href="${pageContext.request.contextPath}/user/toLogin">登录</a></li>
                            <%} else { if(userSession.getUsername().equals("admin")){%>
                            <li><button type="button" class="btn btn-primary navbar-btn"><a href="${pageContext.request.contextPath}/order/allOrder" style="color: white">管理界面</a></button></li>
                            <li><button type="button" class="btn btn-warning navbar-btn"><a href="${pageContext.request.contextPath}/order/toUserOrder" style="color: white">我的订单</a></button></li>
                            <li><button type="button" class="btn btn-success navbar-btn"><a href="${pageContext.request.contextPath}/user/toMypage" style="color: white">${sessionScope.userName}</a></button></li>
                            <li><a href="${pageContext.request.contextPath}/user/userLogout">注销</a></li>

                            <%}else{%>
                            <li><button type="button" class="btn btn-warning navbar-btn"><a href="${pageContext.request.contextPath}/order/toUserOrder" style="color: white">我的订单</a></button></li>
                            <li><button type="button" class="btn btn-success navbar-btn"><a href="${pageContext.request.contextPath}/user/toMypage" style="color: white">${sessionScope.userName}</a></button></li>
                            <li><a href="${pageContext.request.contextPath}/user/userLogout">注销</a></li>
                            <%}}%>
                        </ul>
                    </div><!-- /.navbar-collapse -->
                </div><!-- /.container-fluid -->
            </nav>
        </div>
    </div>
</div>

<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column" >
            <div class="page-header">
                <h1 style="text-align: center">
                    <small>修改资料</small>
                </h1>
            </div>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/#" method="post">
        <%--       前端传递隐藏域--%>
        <input type="hidden" name="Id" value="${sessionScope.userSession.id}">
        <input type="hidden" id="originalPwd" value="${sessionScope.userSession.password}">

        <div class="form-group">
            <label >用户名:</label><span id="userInfo"></span>
            <input type="text" name="username" id="username" class="form-control" value="${sessionScope.userSession.username}"  onblur="checkName()" required>
        </div>
        <div class="form-group">
            <label >原密码:</label><span id="originalPwdInfo"></span>
            <input type="password"  id="originalPwd2" class="form-control"  onblur="checkOriginalPwd()" required>
        </div>

        <div class="form-group">
             <label >新密码:</label>
             <input type="password" name="password" id="password" class="form-control" required>
        </div>

        <div class="form-group">
             <label >确认密码:</label><span id="passwordInfo"></span>
             <input type="password" name="password" id="password2" class="form-control" onblur="checkPwd()" required>
        </div>


        <label>性别：</label>
            <div class="radio" >
                <label>
                    <input type="radio" name="sex" id="optionsRadios1" value="男" checked>男
                </label>
                <label>
                    <input type="radio" name="sex" id="optionsRadios2" value="女">女
                </label>
            </div>

        <div class="form-group">
            <label >电话号码:</label><span id="phoneInfo"></span>
            <input type="text" name="phone" id="phone" class="form-control" value="${sessionScope.userSession.phone}" onblur="checkPhone()" required>
        </div>

        <div class="form-group">
             <label >邮箱地址:</label><span id="emailInfo"></span>
             <input type="text" name="phone" id="email" class="form-control" value="${sessionScope.userSession.email}" onblur="checkEmail()" required>
        </div>

        <div class="form-group">
            <label >地址:</label>
            <input type="text" name="address" class="form-control" value="${sessionScope.userSession.address}" required>
        </div>

        <div class="form-group">
            <input type="submit" class="form-control" value="修改">
        </div>
    </form>


</div>

<script>
    function checkName(){
        $.post({
            url:"${pageContext.request.contextPath}/Ajax/checkName_update",
            data:{"username":$("#username").val()},
            success:function (data){
                if(data.toString()==="用户名可用"){
                    $("#userInfo").css("color","green");
                }else {
                    $("#userInfo").css("color","red");
                }
                $("#userInfo").html(data);
            }
        })
    }

    function checkOriginalPwd(){
        var originalPwd = document.getElementById("originalPwd").value;
        var input_OPwd = document.getElementById("originalPwd2").value;
        console.log(originalPwd);
        if(input_OPwd!=null&&input_OPwd!=""){
            if(input_OPwd!==originalPwd){
                $("#originalPwdInfo").css("color","red");
                $("#originalPwdInfo").html("密码错误")
            }else{
                $("#originalPwdInfo").css("color","green");
                $("#originalPwdInfo").html("√")
            }
        }
    }

    function checkEmail(){
        var email=document.getElementById("email").value;
        if(!(/^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/.test(email))){
            $("#emailInfo").css("color","red");
            $("#emailInfo").html("邮箱格式有误，请重填")
        }else{
            $("#emailInfo").css("color","green");
            $("#emailInfo").html("√")
        }
    }
    function checkPhone(){
        var phone=document.getElementById("phone").value;
        if(!(/^1[34578]\d{9}$/.test(phone))){
            $("#phoneInfo").css("color","red");
            $("#phoneInfo").html("手机号有误，请重填")
        }else{
            $("#phoneInfo").css("color","green");
            $("#phoneInfo").html("√")
        }
    }
    function checkPwd(){
        var password=document.getElementById("password").value;
        var password2=document.getElementById("password2").value;
        if(password2 !== ""){
            if(password !== password2){
                $("#passwordInfo").css("color","red");
                $("#passwordInfo").html("两次密码不相同");
            }else{
                $("#passwordInfo").css("color","green");
                $("#passwordInfo").html("√");
            }
        }
    }
</script>



</body>
</html>
