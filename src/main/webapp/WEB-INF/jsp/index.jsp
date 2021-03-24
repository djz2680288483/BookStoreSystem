<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.wyh.pojo.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
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

                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav">
                            <li><a href="${pageContext.request.contextPath}/book/specilBook">特价优惠 <span class="sr-only">(current)</span></a>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                                   aria-haspopup="true" aria-expanded="false">图书类别 <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <c:forEach var="bookType" items="${bookTypeList}">
                                        <li>
                                            <a href="${pageContext.request.contextPath}/book/queryBookByType?bookType=${bookType.typeName}">${bookType.typeName}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </ul>

                        <form class="navbar-form navbar-left" action="${pageContext.request.contextPath}/book/queryBook"
                              method="post">
                            <div class="form-group">
                                <input type="hidden" name="lpIsinput" id="lpIsinput" value="true">
                                <input type="hidden" name="hpIsinput" id="hpIsinput" value="true">
                                <input type="hidden" name="bNIsinput" id="bNIsinput" value="true">
                                <input type="text" name="lp" id="lp" class="form-control" placeholder="￥">
                                <input type="text" name="hp" id="hp" class="form-control" placeholder="￥">
                                <input type="text" name="bookName" id="bookName" class="form-control"
                                       placeholder="Search">
                            </div>
                            <button type="submit" class="btn btn-default" onclick="isInput()">搜索</button>
                        </form>
                        <script>
                            function isInput() {
                                if ($("#lp").val() === "") {
                                    document.getElementById("lpIsinput").value = false;
                                }
                                if ($("#hp").val() === "") {
                                    document.getElementById("hpIsinput").value = false;
                                }
                                if ($("#bookName").val() === "") {
                                    document.getElementById("bNIsinput").value = false;
                                }
                            }
                        </script>


                        <ul class="nav navbar-nav navbar-right form-inline">
                            <% User userSession = (User) session.getAttribute("userSession");
                                if (userSession == null) {%>
                            <li><a href="${pageContext.request.contextPath}/user/toLogin">登录</a></li>
                            <%
                            } else {
                                if (userSession.getUsername().equals("admin")) {
                            %>
                            <li>
                                <button type="button" class="btn btn-primary navbar-btn"><a
                                        href="${pageContext.request.contextPath}/order/allOrder" style="color: white">管理界面</a>
                                </button>
                            </li>
                            <li>
                                <button type="button" class="btn btn-warning navbar-btn"><a
                                        href="${pageContext.request.contextPath}/order/toUserOrder"
                                        style="color: white">我的订单</a></button>
                            </li>
                            <li>
                                <button type="button" class="btn btn-success navbar-btn"><a
                                        href="${pageContext.request.contextPath}/user/toMypage"
                                        style="color: white">${sessionScope.userName}</a></button>
                            </li>
                            <li><a href="${pageContext.request.contextPath}/user/userLogout">注销</a></li>

                            <%} else {%>
                            <li>
                                <button type="button" class="btn btn-info navbar-btn"><a
                                        href="${pageContext.request.contextPath}/book/recommendBook?hobbies=${sessionScope.userSession.hobbies}"
                                        style="color: white">智能推荐</a></button>
                            </li>
                            <li>
                                <button type="button" class="btn btn-warning navbar-btn"><a
                                        href="${pageContext.request.contextPath}/order/toUserOrder"
                                        style="color: white">我的订单</a></button>
                            </li>
                            <li>
                                <button type="button" class="btn btn-success navbar-btn"><a
                                        href="${pageContext.request.contextPath}/user/toMypage"
                                        style="color: white">${sessionScope.userName}</a></button>
                            </li>
                            <li><a href="${pageContext.request.contextPath}/user/userLogout">注销</a></li>
                            <%
                                    }
                                }
                            %>
                        </ul>
                    </div><!-- /.navbar-collapse -->
                </div><!-- /.container-fluid -->
            </nav>
        </div>
    </div>
</div>

<c:forEach var="book" items="${bookList}">

    <div class="col-md-4 column" >
        <div class="thumbnail">
            <a href="${pageContext.request.contextPath}/book/queryBookById?id=${book.id}"><img
                    src="D://bookPicture//${book.bookPic}"  alt="bookPic"></a>
            <div class="caption" style="text-align: center">
                <p><a href="${pageContext.request.contextPath}/book/queryBookById?id=${book.id}" style="color: black">${book.bookName}</a></p>
                <c:if test="${book.bookDiscount<10}"><p><span style="color: #e60000;font-weight: bold;font-size: large">￥${book.bookPrice*book.bookDiscount/10}</span>
                    <span style="color: #999999;text-decoration: line-through">￥${book.bookPrice}</span></p></c:if>
                <c:if test="${book.bookDiscount>=10}"><p><span
                        style="color:#e60000; font-size: large;font-weight: bold">￥${book.bookPrice}</span></p></c:if>
            </div>
        </div>
    </div>

</c:forEach>

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


<script src="${pageContext.request.contextPath}/webjars/jquery/3.2.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/webjars/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>
