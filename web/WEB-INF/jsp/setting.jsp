<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>账号设置</title>
    <script type="text/javascript"
            src="${root}/js/jquery-1.11.2.js"></script>
    <script src="${root}/layer/layer.js"></script>
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
            <div class="list-group">
                <a class="list-group-item" href="${root}/user/info.do">
                    <i class="fa fa-user fa-fw"></i>&nbsp; 我的资料
                </a>
                <a class="list-group-item" href="${root}/user/resume.do">
                    <i class="fa fa-files-o fa-fw"></i>&nbsp; 我的简历
                </a>
                <a class="list-group-item" href="#">
                    <i class="fa fa-comments fa-fw"></i>&nbsp; 求职进展
                </a>
                <a class="list-group-item" href="${root}/user/poor.do">
                    <i class="fa fa-user-secret fa-fw"></i>&nbsp; 贫困生认证
                </a>
                <a class="list-group-item" href="${root}/user/collection.do">
                    <i class="fa fa-star fa-fw"></i>&nbsp; 我的收藏
                </a>
                <a class="list-group-item" href="${root}/user/secret.do">
                    <i class="fa fa-lock fa-fw"></i>&nbsp; 隐私设置
                </a>
                <a class="list-group-item active" href="${root}/user/setting.do">
                    <i class="fa fa-cog fa-fw"></i>&nbsp; 账号设置
                </a>
            </div>
        </div>
        <div class="col-md-8">
            <h4>账号设置</h4>
            <hr>
            <button class="btn btn-default" onclick="openChangePasswordDlg()">修改密码</button>
            <table class="table" style="font-size: 14px;margin-top: 20px">
                <tr>
                    <th width="100">名称</th>
                    <th width="300">说明</th>
                    <th width="*">操作</th>
                </tr>
                <tr style="height: 50px">
                    <c:choose>
                        <c:when test="${empty sessionScope.user.email}">
                            <td style="color: red"><i class="fa fa-exclamation-triangle"></i> 邮箱未认证</td>
                            <td>认证邮箱是找回密码等操作时验证您身份的途径之一。</td>
                            <td><a href="javascript:void(0)" onclick="openEmailDlg()">认证</a></td>
                        </c:when>
                        <c:otherwise>
                            <td style="color: green"><i class="fa fa-check-circle"></i> 邮箱已认证</td>
                            <td>认证邮箱是找回密码等操作时验证您身份的途径之一。</td>
                            <td><a href="javascript:void(0)" onclick="openEmailDlg()">更换</a></td>
                        </c:otherwise>
                    </c:choose>
                </tr>
                <tr style="height: 50px">
                    <c:choose>
                        <c:when test="${empty sessionScope.user.phone}">
                            <td style="color: red"><i class="fa fa-exclamation-triangle"></i> 手机未认证</td>
                            <td>认证手机是找回密码等操作时验证您身份的途径之一。</td>
                            <td><a href="javascript:void(0)">认证</a></td>
                        </c:when>
                        <c:otherwise>
                            <td style="color: green"><i class="fa fa-check-circle"></i> 手机已认证</td>
                            <td>认证手机是找回密码等操作时验证您身份的途径之一。</td>
                            <td><a href="javascript:void(0)" data-toggle="modal"
                                   data-target="#modal2">更换</a></td>
                        </c:otherwise>
                    </c:choose>
                </tr>
            </table>
        </div>
    </div>
</div>

<div id="changePassword" class="hideDiv1">
    <table style="margin: 0 auto">
        <tr style="height: 30px;line-height: 30px;margin-top: 10px">
            <td>
                <input type="password" placeholder="输入当前密码" id="originPwd"/>
            </td>
        </tr>
        <tr style="height: 30px;line-height: 30px;margin-top: 10px">
            <td>
                <input type="password" placeholder="输入新密码" id="newPwd"/>
            </td>
        </tr>
        <tr style="text-align: center;height: 30px;line-height: 30px;margin-top: 10px">
            <td>
                <input type="button" class="btn btn-default" value="确认" onclick="changePassword()"/>
                <input type="button" class="btn btn-default" value="取消" onclick="layer.closeAll();"/>
            </td>
        </tr>
    </table>
</div>

<div id="emailDiv" class="hideDiv1">
    <table style="margin: 0 auto">
        <tr style="height: 30px;line-height: 30px;margin-top: 10px">
            <td>
                <input type="email" placeholder="输入要绑定的邮箱" id="email"/>
            </td>
        </tr>
        <tr style="text-align: center;height: 30px;line-height: 30px;margin-top: 10px">
            <td>
                <input type="button" class="btn btn-default" value="确认" onclick="bindEmail()"/>
                <input type="button" class="btn btn-default" value="取消" onclick="layer.closeAll();"/>
            </td>
        </tr>
    </table>
</div>

<script type="application/javascript">
    function sendMsg() {

    }

    //修改密码对话框
    function openChangePasswordDlg() {
        layer.open({
            type: 1,
            title: "修改密码",
            area: ['300px', '200px'],
            content: $('#changePassword')
        });
    }

    //更换邮箱对话框
    function openEmailDlg() {
        layer.open({
            type: 1,
            title: "邮箱验证",
            area: ['300px', '200px'],
            content: $('#emailDiv')
        });
    }

    //发送email
    function bindEmail() {
        $.post("${root}/user/bindEmail.do",
                {
                    email: $("#email").val()
                }, function (data) {
                    layer.closeAll();
                }, "json");
        layer.msg('发送中', {icon: 16});
    }

    //修改密码
    function changePassword() {
        $.post("${root}/user/changePassword.do", {
            originPwd: $("#originPwd").val(),
            newPwd: $("#newPwd").val()
        }, function (data) {
            if (data.msg == "unlogin") {
                window.location = "${root}/user/toLogin.do"
            } else if (data.msg == "pwderror") {
                alert("密码错误");
            } else {
                alert("修改成功");
                layer.closeAll();
            }
        }, "JSON");
    }
</script>
</body>
</html>

