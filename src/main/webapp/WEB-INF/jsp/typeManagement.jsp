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
    <title>类别管理</title>
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
                    <small>类别管理</small>
                </h1>
            </div>
        </div>
    </div>



    <div class="row clearfix">
        <div class="col-md-12 column">
            <table class="table table-hover table-striped">
                <thead>
                <tr>
                    <th>类别Id</th>
                    <th>书籍类别</th>
                    <th>书籍数量</th>
                    <th>操作</th>
                </tr>
                </thead>


                <tbody>
                <c:forEach var="type" items="${typeList}">
                    <tr>
                        <td>${type.typeId}</td>
                        <td>${type.typeName}</td>
                        <td>${type.numbers}</td>
                        <c:if test="${type.numbers!=0}">
                            <td>
                                <a href="${pageContext.request.contextPath}/bookType/deleteType?id=${type.id}" class="btn btn-danger disabled" role="button">删除类别</a>
                            </td>
                        </c:if>
                        <c:if test="${type.numbers==0}">
                            <td>
                                <a href="${pageContext.request.contextPath}/bookType/deleteType?id=${type.id}" class="btn btn-danger  " role="button">删除类别</a>
                            </td>
                        </c:if>
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
