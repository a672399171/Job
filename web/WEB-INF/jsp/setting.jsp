<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>账号设置</title>
    <%@include file="common/head.jsp" %>
    <script src="${root}/layer/layer.js"></script>
    <style type="text/css">
        .hideDialog {
            display: none;
        }

        .hideDialog table {
            margin: 0 auto;
        }

        .hideDialog tr {
            margin-bottom: 10px;
        }

        .hideDialog input {
            height: 25px;
            line-height: 25px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="big container">
    <%@include file="/WEB-INF/jsp/header.jsp" %>
    <div class="row">
        <div class="col-xs-3 col-xs-offset-1">
            <div class="list-group">
                <a class="list-group-item" href="${root}/user/info.do">
                    <i class="fa fa-user fa-fw"></i>&nbsp; 我的资料
                </a>
                <a class="list-group-item" href="${root}/user/resume.do">
                    <i class="fa fa-files-o fa-fw"></i>&nbsp; 我的简历
                </a>
                <a class="list-group-item" href="${root}/user/apply.do">
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
        <div class="col-xs-8">
            <h4>账号设置</h4>
            <hr>
            <button class="btn btn-default" onclick="openChangePasswordDlg()">修改密码</button>
            <table class="table" style="font-size: 14px;margin-top: 20px">
                <tr>
                    <th width="180">名称</th>
                    <th width="400">说明</th>
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
            </table>
        </div>
    </div>

    <div id="changePassword" class="hideDialog">
        <table>
            <tr>
                <td>
                    <input type="password" placeholder="输入当前密码" id="originPwd"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="password" placeholder="输入新密码" id="newPwd"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="password" placeholder="确认新密码" id="newPwd2"/>
                </td>
            </tr>
            <tr style="text-align: center;height: 60px">
                <td>
                    <button type="button" class="btn btn-default" onclick="changePassword()">确认</button>
                    <button type="button" class="btn btn-default" onclick="layer.closeAll();">取消</button>
                </td>
            </tr>
        </table>
    </div>

    <div id="emailDiv" class="hideDialog">
        <table>
            <tr>
                <td>
                    <input type="email" placeholder="输入要绑定的邮箱" id="email"/>
                </td>
            </tr>
            <tr style="text-align: center;height: 60px">
                <td>
                    <button type="button" class="btn btn-default" onclick="bindEmail()">确认</button>
                    <button type="button" class="btn btn-default" onclick="layer.closeAll();">取消</button>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>

<script type="application/javascript">
    //修改密码对话框
    function openChangePasswordDlg() {
        layer.open({
            type: 1,
            title: "修改密码",
            area: ['300px', '250px'],
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
        if ($("#originPwd").val().trim() == "" || $("#newPwd").val().trim() == "" ||
                $("#newPwd2").val().trim() == "") {
            alert("密码不能为空");
        } else if ($("#newPwd").val() != $("#newPwd2").val()) {
            alert("两次密码输入不一致");
        } else {
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
    }
</script>
</body>
</html>

