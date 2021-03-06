<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>企业登录</title>
    <%@include file="../common/head.jsp"%>
    <link rel="stylesheet" type="text/css" href="/resources/css/style_login.css"/>
    <script src="/resources/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
</head>
<body>
<div class="panel panel-default" id="login_panel">
    <div class="panel-body">
        <h3 align="center">企业登录</h3>
        <form id="loginForm">
            <div class="form-group">
                <input type="text" class="form-control" name="username" id="username" placeholder="用户名"
                       value="${username}">
            </div>
            <div class="form-group">
                <input type="password" class="form-control" name="password" id="password" placeholder="密码"
                       value="${password}">
            </div>
            <div class="checkbox">
                <%--<label>
                    <input type="checkbox" id="on"
                    <c:if test="${requestScope.flag}">
                           checked
                    </c:if>
                    >7天内自动登录
                </label>--%>
                <a href="/companyFindPassword" id="wangji">忘记密码</a>
            </div>

            <button type="submit" class="btn btn-default">登&nbsp;录</button>
            <div id="msg"></div>
            <a href="/companyReg" id="zhuce">没有账号？立即注册</a>
        </form>
    </div>
</div>

<script type="application/javascript">
    $(function () {
        $('#loginForm').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                username: {
                    message: '用户名不能为空',
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空'
                        }
                    }
                },
                password: {
                    message: '密码不能为空',
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        }
                    }
                }
            }
        }).on('success.form.bv', function (e) {
            e.preventDefault();

            // Use Ajax to submit form data
            $.post("/company/login", {
                username: $("#username").val(),
                password: $("#password").val()
                /*on: $("#on").is(":checked")*/
            }, function (data) {
                if (data.success) {
                    window.location = "/company/jobManage";
                } else {
                    $("#msg").text(data.error);
                }
            }, 'json');
        });
    });
</script>
</body>
</html>
