<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: KAMISAMA
  Date: 2021/3/10
  Time: 13:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <link href="${pageContext.request.contextPath}/webjars/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
    <style>

    </style>
</head>
<body>
<div class="container-fluid" style="text-align: center;font-size: large">
    <div class="row-fluid">
        <div class="span12">
            <form class="form-horizontal" action="${pageContext.request.contextPath}/user/userLogin">
                <div class="control-group">

                    <div class="controls">
                        <label class="control-label" for="inputUsername">用户名:</label>
                        <input id="inputUsername" type="text" name="userName" required/>
                    </div>
                </div>
                <div class="control-group">

                    <div class="controls">
                        <label class="control-label" for="inputPassword" >密码:&nbsp;&nbsp;</label>
                        <input id="inputPassword" type="password" name="passWord" required/>
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <button type="submit" class="btn btn-default right-button btn-lg">登陆</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="btn btn-default btn-lg" href="${pageContext.request.contextPath}/user/toRegist" role="button">注册</a><br>
                        <c:choose>
                            <c:when test="${message==1}"><span style="color:red;font-weight: bold">用户名错误</span></c:when>
                            <c:when test="${message==2}"><span style="color:red;font-weight: bold">密码错误</span></c:when>
                        </c:choose>




                    </div>
                </div>
            </form>
        </div>
    </div>
</div>





</body>
</html>
