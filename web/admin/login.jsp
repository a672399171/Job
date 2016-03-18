<%@ page import="com.zzu.model.Common" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>后台登录</title>
    <script type="text/javascript"
            src="${root}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${root}/js/jquery.fullPage.min.js"></script>
    <link rel="stylesheet" href="${root}/bootstrap-3.3.4-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${root}/bootstrapvalidator/css/bootstrapValidator.min.css">
    <link rel="stylesheet" href="${root}/font-awesome-4.3.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${root}/css/common.css"/>
    <script src="${root}/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
    <script src="${root}/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <style type="text/css">
        #loginBtn {
            width: 100%;

        }

        .well {
            width: 400px;
            margin: 0 auto;
            margin-top: 20%;
        }

        body {
            background: url("${root}/images/login_bg.jpg") no-repeat;
        }

        #error {
            color: red;
        }
    </style>
</head>
<body>
<div class="well well-lg">
    <h2 align="center">后台登录</h2>
    <form action="${root}/user/admin/login.do" method="post">
        <div class="form-group">
            <input type="text" class="form-control" name="username" placeholder="用户名">
        </div>
        <div class="form-group">
            <input type="password" class="form-control" name="password" placeholder="密码">
        </div>
        <button type="submit" class="btn btn-default" id="loginBtn">登录</button>
        <span id="error">${sessionScope.error}</span>
    </form>
</div>

<%
    if(session.getAttribute(Common.ERROR) != null) {
        session.removeAttribute(Common.ERROR);
    }
%>

<script type="application/javascript">

</script>
</body>
</html>
