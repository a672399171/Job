<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>找回密码</title>
    <%@include file="../common/head.jsp"%>
    <style type="text/css">
        #panel {
            width: 35%;
            min-width: 420px;
            height: 300px;
            margin: 0 auto;
            margin-top: 15%;
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
<div class="big">
    <div class="panel panel-default" id="panel">
        <div class="page-header">
            <h3 align="center">找回密码</h3>
        </div>
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

            <div class="row" style="margin-top: 10px">
                <div class="col-md-8 col-md-offset-2">
                    <input type="text" class="form-control" id="user" placeholder="输入用户名">
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

<script type="application/javascript">

    $(function () {
        if ('${sessionScope.auth}' != "") {
            showChangPwd();
        }
    });

    $("#n").click(sendEmail);

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

        $.post("/user/resetPassword", {
            password: pwd1,
            type:"company"
        }, function (data) {
            if (data.msg) {
                alert(data.msg);
            } else {
                window.location = "/";
            }
        });
    });

    //发送邮件
    function sendEmail() {
        $.post("/user/verifyEmail", {
            email: $("#email").val(),
            username: $("#user").val(),
            type:"company"
        }, function (data) {
            console.log(data);
            if (data.msg) {
                $("#m").text(data.msg);
            } else {
                alert("发送成功,请及时登录邮箱验证！");
            }
        });
    }
</script>
</body>
</html>
