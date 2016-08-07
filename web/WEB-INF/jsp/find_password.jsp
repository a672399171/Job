<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>找回密码</title>
    <%@include file="common/head.jsp" %>
    <script src="/resources/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <style type="text/css">
        #panel {
            width: 35%;
            min-width: 420px;
            height: 400px;
            margin: 0 auto;
            margin-top: 15%;
            padding: 50px;
        }

        .row {
            margin-bottom: 15px;
        }

        #pic {
            cursor: pointer;
            margin-top: 5px;
        }

        #hide div {
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="big container">
    <div class="panel panel-default" id="panel">
        <div class="panel-body">
            <div class="row" id="hide" style="display: none">
                <h4 align="center">重置密码</h4>
                <div class="col-md-12">
                    <input type="password" class="form-control" id="pwd" placeholder="输入新密码">
                </div>
                <div class="col-md-12">
                    <input type="password" class="form-control" id="pwd2" placeholder="确认密码">
                </div>
                <div class="col-md-12">
                    <button class="btn btn-danger" style="width: 100%" id="okBtn">确定</button>
                </div>
            </div>

            <ul class="nav nav-tabs nav-justified" id="tab">
                <li role="presentation" class="active">
                    <a href="#jw" aria-controls="jw">通过教务密码找回</a>
                </li>
                <li role="presentation">
                    <a href="#e" aria-controls="e">通过邮箱找回</a>
                </li>
            </ul>

            <div class="tab-content" id="tabContent">
                <div role="tabpanel" class="tab-pane active" id="jw">
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-8 col-md-offset-2">
                            <input type="text" class="form-control" id="username" placeholder="输入用户名">
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-8 col-md-offset-2">
                            <input type="text" class="form-control" id="school_num" placeholder="输入注册时填写的学号">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2">
                            <input type="password" class="form-control" id="jwpwd" placeholder="输入教务系统密码">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 col-md-offset-2">
                            <input type="text" class="form-control" id="code" placeholder="验证码">
                        </div>
                        <div class="col-md-4">
                            <img src="/user/captchaCode" id="pic" onclick="refresh()"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2">
                            <button type="button" class="btn btn-primary" id="next" style="width: 100%">下一步</button>
                        </div>
                    </div>
                    <span id="msg" style="color: red;margin-left: 100px"></span>
                </div>
                <div role="tabpanel" class="tab-pane" id="e">
                    <div class="row" style="margin-top: 10px">
                        <div class="col-md-8 col-md-offset-2">
                            <input type="text" class="form-control" id="user" placeholder="输入用户名">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2">
                            <input type="email" class="form-control" id="email" placeholder="输入绑定的邮箱">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8 col-md-offset-2">
                            <button type="button" class="btn btn-primary" id="n" style="width: 100%">下一步</button>
                        </div>
                    </div>
                    <span id="m" style="color: red;margin-left: 100px"></span>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="application/javascript">

    $(function () {
        if ('${sessionScope.auth}' != "") {
            showChangPwd();
        }
    });

    //刷新验证码
    function refresh() {
        $("#pic").attr("src", '/user/captchaCode' + "?d" + new Date());
    }

    $("#next").click(verifySchoolNum);
    $("#n").click(sendEmail);

    //验证学号和验证码
    function verifySchoolNum() {
        $.post("/user/verify", {
            username: $("#username").val(),
            school_num: $("#school_num").val(),
            jwpwd: $("#jwpwd").val(),
            code: $("#code").val()
        }, function (data) {
            console.log(data);
            if (data.msg) {
                $("#msg").text(data.msg);
            } else {
                showChangPwd();
            }
        });
    }

    //显示重置密码
    function showChangPwd() {
        $("#tab").hide();
        $("#tabContent").hide();
        $("#hide").show();
    }

    $("#okBtn").click(function () {
        var pwd1 = $("#pwd").val();
        var pwd2 = $("#pwd2").val();

        if (pwd1.length > 0 && pwd2.length > 0) {
            if (pwd1 != pwd2) {
                alert("密码不一致!");
                return;
            }
        } else {
            alert("密码不能为空!");
            return;
        }

        $.post("/user/resetPassword.do", {
            password: pwd1,
            type: "user"
        }, function (data) {
            if (data.msg) {
                alert(data.msg);
            } else {
                window.location = "/";
            }
        });
    });

    //发送邮件
    // TODO 发送邮件后隐藏页面显示区域,邮箱格式错误时要提示
    function sendEmail() {
        $.post("/user/findPassword", {
            email: $("#email").val(),
            username: $("#user").val(),
            type: "user"
        }, function (data) {
            if(data.success) {
                alert("发送成功,请及时登录邮箱 " + $("#email").val() + " 验证！");
            } else {
                $("#m").text(data.error);
            }
        });
    }

    $('#tab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show')
    })
</script>
</body>
</html>
