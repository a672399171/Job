<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>注册成功</title>
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
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div id="body">
    <div class="well" style="width: 80%;margin: 0 auto;height: 400px">
        <div style="margin: 0 auto;width: 50%">
            <img src="${root}/images/icon-succeed.png" style="float: left;margin-right: 30px">
            <div>
                <span style="font-size: 26px;color: #2aabd2">${sessionScope.user.username}</span>
                <span style="font-size: 26px;color: red">注册成功！</span>
            </div>
            <a type="button" class="btn btn-primary">
                <i class="fa fa-pencil-square-o"></i>&nbsp;填写简历
            </a>
            <a type="button" class="btn btn-info">
                <i class="fa fa-search"></i>&nbsp;查看兼职信息
            </a>
        </div>
    </div>
</div>

<script type="application/javascript">

</script>
</body>
</html>

