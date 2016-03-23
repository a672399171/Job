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
    <style type="text/css">
        .well {
            width: 80%;
            margin: 0 auto;
            height: 400px
        }

        #top1 {
            margin: 0 auto;
            width: 50%
        }

        #top1 img {
            margin-right: 30px;
            display: inline-block;
        }

        #top1 div {
            display: inline-block;
        }

        #top2 {
            margin: 0 auto;
            width: 50%;
            text-align: center;
        }

        .usernameStyle {
            font-size: 26px;
            color: #2aabd2;
        }

        .successStyle {
            font-size: 26px;
            color: orange;
        }

        hr {
            height: 1px;
            border: none;
            border-top: 1px solid grey;
            width: 80%;
            margin-top: 20px;
            margin-bottom: 50px;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div id="body">
    <div class="well">
        <div id="top1">
            <img src="${root}/images/icon-succeed.png">

            <div>
                <span class="usernameStyle">672399171${sessionScope.user.username}</span>
                <span class="successStyle">恭喜你注册成功！</span>
            </div>
        </div>
        <hr>
        <div id="top2">
            <a type="button" class="btn btn-primary" href="${root}/user/info.do">
                <i class="fa fa-pencil-square-o"></i>&nbsp;完善个人资料
            </a>
            <a type="button" class="btn btn-info" href="${root}/">
                <i class="fa fa-home"></i>&nbsp;返回主页查看
            </a>
        </div>
    </div>
</div>
</body>
</html>

