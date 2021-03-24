<%@ page import="com.wyh.pojo.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: KAMISAMA
  Date: 2021/3/12
  Time: 13:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>书籍详情</title>
    <link href="${pageContext.request.contextPath}/webjars/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">

            <nav class="navbar navbar-default">
                <div class="container-fluid">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                                data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="/">首页</a>
                    </div>

                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
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

<div class="row">
    <div class="col-md-12">
        <div class="thumbnail">
            <img src="D://bookPicture//${book.bookPic}" alt="bookPic"/>
            <div class="caption">
                <h2 style="font-weight: bolder">${book.bookName}</h2>
                <p>&nbsp;</p>
                <h4 style="font-weight: bold">作者:${book.bookAuthor}</h4>
                <h4 style="font-weight: bold">类型:${book.bookType}</h4>
                <span style="font-weight: bold;font-size: x-large">内容简介</span>
                <p style="font-size: large">
                    ${book.detail}
                </p>
                <p><span style="color: #e60000;font-weight: bold;font-size: xx-large">￥${book.bookPrice*book.bookDiscount/10}</span> <span
                        style="color: #999999;font-size: large;text-decoration: line-through">￥${book.bookPrice}</span></p>
                <c:if test="${sessionScope.userSession==null}"><p><a href="#" class="btn btn-lg btn-danger" role="button" onclick="getBuy()">加入购物车</a></p></c:if>

                <c:if test="${sessionScope.userSession!=null}"><form action="${pageContext.request.contextPath}/order/addOrder">
                        <input type="hidden" name="username" value="${sessionScope.userSession.username}">
                        <input type="hidden" name="address" value="${sessionScope.userSession.address}">
                        <input type="hidden" name="phone" value="${sessionScope.userSession.phone}">
                        <input type="hidden" name="bookName" value="${book.bookName}">
                        <input type="hidden" name="id" value="${book.id}">
                        <p><button type="submit" class="btn btn-danger btn-lg" onclick="getBuy2()">加入购物车</button></p>
                    </form></c:if>



                <%
                if(userSession==null) {%>
                <div class="alert alert-danger" style="font-weight: bold" role="alert" id="addOrder" hidden="true">请先登录</div>
                <%}else{%>
                <div class="alert alert-success" style="font-weight: bold" role="alert" id="addOrder" hidden="true">已添加至我的订单</div>
                <%}%>

            </div>
        </div>
    </div>
</div>
<script>
    function getBuy() {
        var orderText = document.getElementById("addOrder");
        orderText.hidden = false;
    }
    function getBuy2(){
        alert("已添加至我的订单")
    }
</script>

</body>
</html>
