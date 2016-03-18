<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>我的收藏</title>
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
<div class="container">
    <div class="row">
        <div class="col-md-3 col-md-offset-1">
            <ul class="list-group">
                <li class="list-group-item">
                    <a href="${root}/user/info.do"><i class="fa fa-user"></i> 我的资料</a>
                </li>
                <li class="list-group-item">
                    <a href="${root}/user/resume.do"><i class="fa fa-files-o"></i> 我的简历</a>
                </li>
                <li class="list-group-item">
                    <a href="#"><i class="fa fa-comments"></i> 求职进展</a>
                </li>
                <li class="list-group-item">
                    <a href="${root}/user/poor.do"><i class="fa fa-user-secret"></i> 贫困生认证</a>
                </li>
                <li class="list-group-item" style="color: red;background: grey">
                    <a href="${root}/user/collection.do"><i class="fa fa-star"></i> 我的收藏</a>
                </li>
                <li class="list-group-item">
                    <a href="${root}/user/secret.do"><i class="fa fa-lock"></i> 隐私设置</a>
                </li>
                <li class="list-group-item">
                    <a href="${root}/user/setting.do"><i class="fa fa-cog"></i> 账号设置</a>
                </li>
            </ul>
        </div>
        <div class="col-md-8">
            <h4>我的收藏</h4>
            <hr>
            <div class="list_item container">
                <div class="row">
                    <a href="#" class="font1 col-sm-4">理财顾问<span class="font2">(2000-3000元/月)</span></a>
                    <a href="#" class="font1 col-sm-4">深圳腾讯科技有限公司</a>
                </div>
                <div class="row" style="margin-top: 10px;margin-bottom: 10px">
                    <div class="col-sm-4">张小姐:14789632501</div>
                    <div class="col-sm-4">14:25收藏</div>
                </div>
                <div class="row" style="margin-top: 10px;margin-bottom: 10px">
                    <a href="#" class="col-sm-1 col-sm-offset-5">取消收藏</a>
                    <a href="#" class="col-sm-1">申请职位</a>
                </div>
            </div>
            <hr style="margin-top: -4px">
            <div class="list_item container">
                <div class="row">
                    <a href="#" class="font1 col-sm-4">理财顾问<span class="font2">(2000-3000元/月)</span></a>
                    <a href="#" class="font1 col-sm-4">深圳腾讯科技有限公司</a>
                </div>
                <div class="row" style="margin-top: 10px;margin-bottom: 10px">
                    <div class="col-sm-4">张小姐:14789632501</div>
                    <div class="col-sm-4">14:25收藏</div>
                </div>
                <div class="row" style="margin-top: 10px;margin-bottom: 10px">
                    <a href="#" class="col-sm-1 col-sm-offset-5">取消收藏</a>
                    <a href="#" class="col-sm-1">申请职位</a>
                </div>
            </div>
            <hr style="margin-top: -4px">
            <div class="list_item container">
                <div class="row">
                    <a href="#" class="font1 col-sm-4">理财顾问<span class="font2">(2000-3000元/月)</span></a>
                    <a href="#" class="font1 col-sm-4">深圳腾讯科技有限公司</a>
                </div>
                <div class="row" style="margin-top: 10px;margin-bottom: 10px">
                    <div class="col-sm-4">张小姐:14789632501</div>
                    <div class="col-sm-4">14:25收藏</div>
                </div>
                <div class="row" style="margin-top: 10px;margin-bottom: 10px">
                    <a href="#" class="col-sm-1 col-sm-offset-5">取消收藏</a>
                    <a href="#" class="col-sm-1">申请职位</a>
                </div>
            </div>
            <hr style="margin-top: -4px">
        </div>
    </div>
</div>

<script type="application/javascript">

</script>
</body>
</html>
