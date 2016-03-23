<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>注册</title>
    <script type="text/javascript"
            src="${root}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${root}/js/jquery.fullPage.min.js"></script>
    <link rel="stylesheet" href="${root}/bootstrap-3.3.4-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${root}/bootstrapvalidator/css/bootstrapValidator.min.css">
    <link rel="stylesheet" type="text/css" href="${root}/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="${root}/css/style_reg.css"/>
    <script src="${root}/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
    <script src="${root}/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div id="body">
    <div class="well" id="well">
        <h2 align="center">用户注册</h2>
        <form id="regForm">
            <div class="form-group">
                <input type="text" class="form-control" id="username" name="username" placeholder="用户名">
            </div>
            <div class="form-group">
                <input type="password" class="form-control" id="password" name="password" placeholder="密码">
            </div>
            <div class="form-group">
                <input type="password" class="form-control" id="password2" name="password2" placeholder="确认密码">
            </div>
            <div class="form-group">
                <input type="text" class="form-control" id="school_num" name="school_num" placeholder="学号">
            </div>
            <div class="form-group">
                <input type="password" class="form-control" id="jwpwd" name="jwpwd" placeholder="教务系统密码">
            </div>
            <div class="form-group" id="varifyDiv">
                <input type="text" class="form-control" id="varify" name="varify" placeholder="验证码">
            </div>
            <img src="${root}/user/varify.do" width="100" height="31" id="verify_img">
            <a href="javascript:void(0)" onclick="refresh()" style="color: #1f637b">看不清？换一个</a>
            <div class="checkbox" id="checkDiv">
                <label>
                    <input type="checkbox" checked>我接受服务条款
                </label>
            </div>
            <button type="submit" class="btn btn-danger" id="zhuce">立即注册</button>
            <span style="color: red" id="msg"></span>
        </form>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
<script type="application/javascript">
    $(function () {
        $('#regForm').bootstrapValidator({
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
                        },
                        stringLength: {
                            min: 6,
                            max: 30,
                            message: '用户名为6-30位之间'
                        }
                    }
                },
                password: {
                    message: '密码不能为空',
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        stringLength: {
                            min: 6,
                            max: 30,
                            message: '密码为6-30位之间'
                        }
                    }
                },
                password2: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        identical: {
                            field: 'password',
                            message: '两次输入密码不一致'
                        }
                    }
                },
                school_num: {
                    message: '学号不能为空',
                    validators: {
                        notEmpty: {
                            message: '学号不能为空'
                        },
                        regexp: {
                            regexp: /^[0-9_\.]{11}$/,
                            message: '学号格式不正确'
                        }
                    }
                },
                jwpwd: {
                    message: '教务密码不能为空',
                    validators: {
                        notEmpty: {
                            message: '教务密码不能为空'
                        }
                    }
                },
                varify: {
                    message: '验证码不能为空',
                    validators: {
                        notEmpty: {
                            message: '验证码不能为空'
                        }
                    }
                }
            }
        }).on('success.form.bv', function(e) {
            // Prevent form submission
            e.preventDefault();

            // Get the form instance
            var $form = $(e.target);

            // Get the BootstrapValidator instance
            var bv = $form.data('bootstrapValidator');

            // Use Ajax to submit form data
            $.post("${root}/user/reg.do", {
                username:$("#username").val(),
                password:$("#password").val(),
                school_num:$("#school_num").val(),
                jwpwd:$("#jwpwd").val(),
                varify:$("#varify").val()
            }, function(data) {
                if(data.msg != undefined) {
                    $("#msg").text(data.msg);
                } else {
                    window.location = "${root}/user/reg_success.do";
                }
            }, 'json');
        });
    });

    function refresh() {
        $("#verify_img").attr("src","${root}/user/varify.do?t=" + new Date().getTime());
    }
</script>
</body>
</html>

