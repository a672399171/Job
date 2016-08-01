<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>隐私设置</title>
    <%@include file="common/head.jsp" %>
    <link rel="stylesheet" href="/resources/bootstrap-switch/css/bootstrap3/bootstrap-switch.min.css">
    <script src="/resources/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <script src="/resources/bootstrap-switch/js/bootstrap-switch.min.js"></script>
</head>
<body>
<div class="big container">
    <%@include file="/WEB-INF/jsp/common/header.jsp" %>
    <div class="row">
        <div class="col-xs-3 col-xs-offset-1">
            <div class="list-group">
                <a class="list-group-item " href="/user/info">
                    <i class="fa fa-user fa-fw"></i>&nbsp; 我的资料
                </a>
                <a class="list-group-item" href="/user/resume">
                    <i class="fa fa-files-o fa-fw"></i>&nbsp; 我的简历
                </a>
                <a class="list-group-item" href="/user/apply">
                    <i class="fa fa-comments fa-fw"></i>&nbsp; 求职进展
                </a>
                <a class="list-group-item" href="/user/poor">
                    <i class="fa fa-user-secret fa-fw"></i>&nbsp; 贫困生认证
                </a>
                <a class="list-group-item" href="/user/collection">
                    <i class="fa fa-star fa-fw"></i>&nbsp; 我的收藏
                </a>
                <a class="list-group-item active" href="/user/secret">
                    <i class="fa fa-lock fa-fw"></i>&nbsp; 隐私设置
                </a>
                <a class="list-group-item" href="/user/setting">
                    <i class="fa fa-cog fa-fw"></i>&nbsp; 账号设置
                </a>
            </div>
        </div>
        <div class="col-xs-8">
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
<jsp:include page="common/footer.jsp"/>
<script type="application/javascript">

    $(function () {
        if (${sessionScope.user.push}) {
            $("#secret").attr("checked", "checked");
        }
        $("#secret").bootstrapSwitch();
    });

    $("#secret").on('switchChange.bootstrapSwitch', function (event, state) {
        $.post("/user/updateSecret.do", {
            secret: state
        }, function (data) {

        }, "json");
    });
</script>
</body>
</html>

