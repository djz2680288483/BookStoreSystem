<%@ page import="com.wyh.pojo.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: KAMISAMA
  Date: 2021/3/13
  Time: 17:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户管理</title>
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
                        <a class="navbar-brand" href="${pageContext.request.contextPath}/order/allOrder">订单管理</a>
                        <a class="navbar-brand" href="${pageContext.request.contextPath}/user/allUser">用户管理</a>
                        <a class="navbar-brand" href="${pageContext.request.contextPath}/bookType/allType">类别管理</a>
                        <a class="navbar-brand" href="${pageContext.request.contextPath}/book/allBook">书籍管理</a>
                        <a class="navbar-brand" href="${pageContext.request.contextPath}/book/toAddBook">添加书籍</a>
                        <a class="navbar-brand" href="/">用户界面</a>
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

<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="page-header">
                <h1 style="font-weight: bold">
                    <small>订单管理</small>
                </h1>
            </div>
        </div>
    </div>



    <div class="row clearfix">
        <div class="col-md-12 column">
            <table class="table table-hover table-striped">
                <thead>
                <tr>
                    <th>订单日期</th>
                    <th>商品名</th>
                    <th>用户名</th>
                    <th>收货地址</th>
                    <th>收货号码</th>
                    <th>支付状态</th>
                    <th>发货状态</th>
                    <th>操作|状态</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="order" items="${orderList}">
                    <tr>
                        <td>${order.orderDate}</td>
                        <td>${order.bookName}</td>
                        <td>${order.username}</td>
                        <td>${order.receverAddr}</td>
                        <td>${order.receverTel}</td>
                        <c:if test="${order.isPay==0}">
                            <td>未支付</td>
                        </c:if>
                        <c:if test="${order.isPay==1}">
                            <td>已付款</td>
                        </c:if>
                        <c:if test="${order.isDelivery==0}">
                            <td>未发货</td>
                        </c:if>
                        <c:if test="${order.isDelivery==1}">
                            <td>已发货</td>
                        </c:if>
                        <td>
                            <c:choose>
                                <c:when test="${order.isPay==0}"><span style="color:#999999;font-weight: bold">待用户付款</span></c:when>
                                <c:when test="${order.isPay==1&&order.isDelivery==0}">
                                    <form action="${pageContext.request.contextPath}/order/Delivery" method="post">
                                        <input type="hidden" name="id" value="${order.id}">
                                        <button type="submit" class="btn button btn-warning">点击发货</button>
                                    </form>
                                </c:when>
                                <c:when test="${order.isDelivery==1&&order.completion==0}"><span style="color:#999999;font-weight: bold">待用户收货</span></c:when>
                                <c:when test="${order.completion==1}">
                                    <button class="btn btn-success">订单完成</button>
                                    <form action="${pageContext.request.contextPath}/order/deleteOrder" method="post">
                                        <input type="hidden" name="id" value="${order.id}">
                                        <button type="submit" class="btn button btn-warning">删除订单</button>
                                    </form>
                                </c:when>
                            </c:choose>
                        </td>


                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>


<%--分页--%>
<div class="col-md-12 column" style="text-align: center">
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <li>
                <a href="?currentPage=1" aria-label="Previous">
                    <span aria-hidden="true">首页</span>
                </a>
            </li>
            <c:if test="${pageInfo.hasPreviousPage}">
                <li><a href="?currentPage=${pageInfo.pageNum-1}"><span>&laquo;</span></a></li>
            </c:if>
            <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                <c:if test="${page_Num==pageInfo.pageNum}">
                    <li class="active"><a href="#">${page_Num}</a></li>
                </c:if>
                <c:if test="${page_Num!=pageInfo.pageNum}">
                    <li><a href="?currentPage=${page_Num}">${page_Num}</a></li>
                </c:if>
            </c:forEach>
            <c:if test="${pageInfo.hasNextPage}">
                <li><a href="?currentPage=${pageInfo.pageNum+1}"><span>&raquo;</span></a></li>
            </c:if>
            <li><a href="?currentPage=${pageInfo.pages}">末页</a></li>
        </ul>
    </nav>
</div>



</body>
</html>
