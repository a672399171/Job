<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>隐私设置</title>
    <script type="text/javascript"
            src="${root}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${root}/js/jquery.fullPage.min.js"></script>
    <link rel="stylesheet" href="${root}/bootstrap-3.3.4-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${root}/bootstrapvalidator/css/bootstrapValidator.min.css">
    <link rel="stylesheet" href="${root}/font-awesome-4.3.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${root}/bootstrap-switch/css/bootstrap3/bootstrap-switch.min.css">
    <link rel="stylesheet" type="text/css" href="${root}/css/common.css"/>
    <script src="${root}/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
    <script src="${root}/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <script src="${root}/bootstrap-switch/js/bootstrap-switch.min.js"></script>
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
                <li class="list-group-item">
                    <a href="${root}/user/collection.do"><i class="fa fa-star"></i> 我的收藏</a>
                </li>
                <li class="list-group-item" style="color: red;background: grey">
                    <a href="${root}/user/secret.do"><i class="fa fa-lock"></i> 隐私设置</a>
                </li>
                <li class="list-group-item">
                    <a href="${root}/user/setting.do"><i class="fa fa-cog"></i> 账号设置</a>
                </li>
            </ul>
        </div>
        <div class="col-md-8">
            <h4>隐私设置</h4>
            <hr>
            <div class="alert alert-success" role="alert" style="font-size: 20px">
                允许企业有好机会时主动联系我
                <div class="switch" style="height: 30px;display: inline-block">
                    <input type="checkbox" name="my-checkbox" id="secret">
                </div>
            </div>

        </div>
    </div>
</div>

<script type="application/javascript">

    $(function () {
        if (${sessionScope.user.push}) {
            $("#secret").attr("checked", "checked");
        }
        $("#secret").bootstrapSwitch();
    });

    $("#secret").on('switchChange.bootstrapSwitch', function (event, state) {
        $.post("${root}/user/updateSecret.do",
                {
                    secret: state
                }, function (data) {

                }, "json");
    });
</script>
</body>
</html>

