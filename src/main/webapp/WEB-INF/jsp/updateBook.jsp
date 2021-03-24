<%@ page import="com.wyh.pojo.User" %><%--
  Created by IntelliJ IDEA.
  User: KAMISAMA
  Date: 2021/3/11
  Time: 21:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>更改书籍</title>
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
                <h1 style="text-align: center">
                    <small>更改书籍</small>
                </h1>
            </div>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/book/updateBook" enctype="multipart/form-data" method="post">
        <input type="hidden" name="originalPic" value="${book.bookPic}">
        <input type="hidden" name="id" value="${book.id}">

        <div class="form-group">
            <label>书籍名称</label>
            <input type="text" name="bookName" class="form-control" value="${book.bookName}" required>
        </div>
        <div class="form-group">
            <label>书籍作者</label>
            <input type="text" name="bookAuthor" class="form-control" value="${book.bookAuthor}" required>
        </div>
        <div class="form-group">
            <label>书籍类型</label>
            <input type="text" name="bookType" class="form-control" value="${book.bookType}" required>
        </div>
        <div class="form-group">
            <label>书籍描述</label>
            <textarea class="form-control"  name="detail" rows="3"  required>${book.detail}</textarea>
        </div>
        <div class="form-group">
            <label>书籍价格</label>
            <input type="text" name="bookPrice" class="form-control" value="${book.bookPrice}" required>
        </div>
        <div class="form-group">
            <label>书籍折扣</label>
            <input type="text" name="bookDiscount" class="form-control" value="${book.bookDiscount}" required>
        </div>
        <div class="form-group">
            <label>书籍图片</label>
            <input type="file" name="file" class="form-control"  required>
        </div>

        <div class="form-group">
            <input type="submit" class="form-control" value="修改">
        </div>
    </form>


</div>

</body>
</html>
