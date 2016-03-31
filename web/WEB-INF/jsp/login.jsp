<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<%
    String username = ""; //用户名
    String passward = ""; //密码
    Cookie[] cookies = request.getCookies();
    boolean flag = false;
    if (cookies != null) {
        for (int i = 0; i < cookies.length; i++) {
            if (cookies[i].getName().equals("cookie_user")) {
                username = cookies[i].getValue().split("-")[0];
                passward = cookies[i].getValue().split("-")[1];
                request.setAttribute("username", username); //存用户名
                request.setAttribute("password", passward); //存密码
                flag = true;
            }
        }
    }
%>
<html>
<head>
    <title>登录</title>
    <script type="text/javascript"
            src="${root}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${root}/js/jquery.fullPage.min.js"></script>
    <link rel="stylesheet" href="${root}/bootstrap-3.3.4-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${root}/bootstrapvalidator/css/bootstrapValidator.min.css">
    <link rel="stylesheet" type="text/css" href="${root}/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="${root}/css/style_login.css"/>
    <script src="${root}/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
    <script src="${root}/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
</head>
<body>
<div class="big">
    <div class="panel panel-default" id="login_panel">
        <div class="panel-body">
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
                    <label>
                        <input type="checkbox" id="on"
                            <%
                            if(flag) {
                                %>
                               checked
                            <%
                            }
                        %>
                        >记住我
                    </label>
                    <a href="#" id="wangji">忘记密码</a>
                </div>

                <button type="submit" class="btn btn-default">登&nbsp;录</button>
                <div id="msg"></div>
                <a href="${root}/user/toReg.do" id="zhuce">没有账号？立即注册</a>
            </form>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>

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
            // Prevent form submission
            e.preventDefault();

            // Get the form instance
            var $form = $(e.target);

            // Get the BootstrapValidator instance
            var bv = $form.data('bootstrapValidator');

            // Use Ajax to submit form data
            $.post("${root}/user/login.do", {
                username: $("#username").val(),
                password: $("#password").val(),
                on: $("#on").is(":checked")
            }, function (data) {
                console.log(data);
                if (data.msg == true) {
                    window.location = "${param.from}";
                } else {
                    $("#msg").text(data.msg);
                }
            }, 'json');
        });
    });
</script>
</body>
</html>
