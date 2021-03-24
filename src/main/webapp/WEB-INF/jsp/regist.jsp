<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: KAMISAMA
  Date: 2021/3/10
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <script src="webjars/jquery/3.2.1/jquery.min.js"></script>
    <link href="${pageContext.request.contextPath}/webjars/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container" style="font-size: large">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="page-header">
                <h1 style="text-align: center">
                    <small>注册</small>
                </h1>
            </div>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/user/addUser" method="post">
        <div class="form-group">
            <label>用户名:</label><span id="userInfo"></span>
            <input type="text" name="username" class="form-control" id="username" onblur="checkName()" required><span
                style="color: #e60000;font-weight: bold">${message1}</span>
        </div>
        <div class="form-group">
            <label>密码:</label>
            <input type="password" name="password" id="password" class="form-control" required><span
                style="color: #e60000;font-weight: bold">${message2}</span>
        </div>
        <div class="form-group">
            <label>确认密码:</label><span id="pwdInfo"></span>
            <input type="password" name="password2" id="password2" class="form-control" onblur="checkPwd()" required>
        </div>
        <label>性别：</label>
        <div class="radio">
            <label>
                <input type="radio" name="sex" id="optionsRadios1" value="男" checked>男
            </label>
            <label>
                <input type="radio" name="sex" id="optionsRadios2" value="女">女
            </label>
        </div>
        <label>爱好:</label>
        <c:forEach var="bookType" items="${bookTypeList}">
        <div class="checkbox-inline">
           <lable>
            <input type="checkbox" name="hobbies"  value="${bookType.typeName}" onclick="checkHobby()">
            ${bookType.typeName}
            </lable>
        </div>
        </c:forEach><span id="hobbyInfo"></span>



        <div class="form-group">
            <label>电话号码：</label></label><span id="phoneInfo"></span>
            <input type="text" name="phone" id="phone" class="form-control" onblur="checkPhone()" required>
        </div>
        <div class="form-group">
            <label>邮箱：</label></label><span id="emailInfo"></span>
            <input type="text" id="email" name="email" class="form-control" onblur="checkEmail()" required>
        </div>
        <div class="form-group">
            <label>地址：</label></label><span id="addressInfo"></span>
            <input type="text" name="address" class="form-control" required>
        </div>


        <div class="form-group" style="text-align: center">
            <input type="submit" class="btn btn-primary btn-lg" value="&nbsp;&nbsp;&nbsp;注册&nbsp;&nbsp;&nbsp;">
        </div>
    </form>
</div>

<script>
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
                $("#pwdInfo").css("color","red");
                $("#pwdInfo").html("两次密码不相同");
            }else{
                $("#pwdInfo").css("color","green");
                $("#pwdInfo").html("√");
            }
        }
    }
    function checkName(){
        $.post({
            url:"${pageContext.request.contextPath}/Ajax/checkName",
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

    function checkHobby(){
        var hobby=document.getElementsByName("hobbies");
        var checkNum=0;
        for(var i=0;i<hobby.length;i++){
            if(hobby[i].checked){
                checkNum++;
            }
        }
        if(checkNum!==3){
            $("#hobbyInfo").css("color","red");
            $("#hobbyInfo").html("请选择3项");
        }
        if(checkNum===3){
            $("#hobbyInfo").css("color","green");
            $("#hobbyInfo").html("√");
        }

    }


</script>





</body>
</html>
