<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>注册成功</title>
    <%@include file="common/head.jsp"%>
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
<div class="big container">
    <%@include file="/WEB-INF/jsp/common/header.jsp"%>
    <div id="body">
        <div class="well">
            <div id="top1">
                <img src="/resources/images/icon-succeed.png">

                <div>
                    <span class="usernameStyle">${sessionScope.user.username}</span>
                    <span class="successStyle">恭喜你注册成功！</span>
                </div>
            </div>
            <hr>
            <div id="top2">
                <a type="button" class="btn btn-primary" href="/user/info">
                    <i class="fa fa-pencil-square-o"></i>&nbsp;完善个人资料
                </a>
                <a type="button" class="btn btn-info" href="/">
                    <i class="fa fa-home"></i>&nbsp;返回主页查看
                </a>
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

