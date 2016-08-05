<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>企业注册</title>
    <%@include file="../common/head.jsp"%>
    <link rel="stylesheet" type="text/css" href="/css/style_reg.css"/>
    <script src="/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
    <script src="/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <script src="/layer/layer.js"></script>
</head>
<body>
<div class="big">
    <jsp:include page="header.jsp"/>
    <div id="body">
        <div class="well" id="well">
            <h2 align="center">企业注册</h2>

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
                    <input type="email" class="form-control" id="email" name="email" placeholder="邮箱">
                </div>
                <div class="form-group" id="varifyDiv">
                    <input type="text" class="form-control" id="varify" name="varify" placeholder="验证码">
                </div>
                <img src="/user/varify.do" width="100" height="31" id="verify_img">
                <a href="javascript:void(0)" onclick="refresh()" style="color: #1f637b">看不清？换一个</a>

                <div class="checkbox" id="checkDiv">
                    <label>
                        <input type="checkbox" checked id="tiaokuan">我接受
                        <a href="javascript:void(0)" onclick="openDlg()" style="color: red">《服务条款》</a>
                    </label>
                </div>
                <button type="submit" class="btn btn-danger" id="zhuce">立即注册</button>
                <span style="color: red" id="msg"></span>
            </form>
        </div>
    </div>

    <div style="display: none;width: 580px;height: 590px;word-wrap: break-word" id="dlg">
    <pre>
                               服务条款
        本网站提供的给兼职工作发布用户宣传、发布招聘信息，个人用户发布求职信息，
    查询招聘会信息，薪资行情，求职指南，培训信息等，在使用本网站时，即认为用户遵
    守此协。本网可能定期修改相关条款。因此，我们建议您定期查看这些条款。如果您通
    知本网站不接受任何改变，那么您对本网站的使用就将终止，否则，您的继续使用就构
    成您对所有改变的接受，并受这些改变的约束。

                            一、网站使用条款
    1.个人用户必须同意使用本网站仅用于合法的目的，已注册的个人用户可以发布个人求
      职信息，设置信息状态。在此种情况下，求职者个人资料仍然储存在本网站数据库中
      ，直至其本人将其个人资料从其中删除为止。
    2.兼职工作发布用户可通过网上在线注册并登录兼职工作信息。
    3.个人用户必须独自全部承担由于向本网站注册企业或其他用户发送个人资料所形成的
      一切风险。本网站对于任何企业与个人之间所发生的一切纠纷，概不负责。
    4.兼职工作发布用户须独自对登记在本网站上及其他链接页面上的内容的正确性负责。
      本网站有权修改兼职工作发布用户的招聘广告以符合本网站的规定，有权删除一切非
      法的、辱骂性的及不健康的资料。
    5.本网站有权在适当的时候调整服务收费或收取其他相关费用。对拒绝接受新的收费标
      准的企业，本网站有权暂停或中止相关用户的使用资格。
    6.本网站保留对用户资料进行修改的权力。
    7.兼职工作发布用户有权进入本网站资料库进行查询，但禁止利用此项权利进行查询人
      才以外的其他用途。
    8.未经个人用户的许可，本网站不会将其个人资料随意公开。
    9.用户注册之后，需要网站工作人员审核，48小时内公布审核结果。

                            二、明确禁止条款
    1.禁止在个人简历中公布不完整、虚假或不准确的资料，禁止在简历中公布不属于简历
      内容的资料。一经发现本网站将暂停或终止对该用户的服务。
    2.未经其许可不得随意公开本网站中的任何个人资料或兼职工作信息，不得向用户发送
      垃圾邮件。
    3.严禁采取任何方式侵犯本网站，包括：登录没有对其授权的服务器或帐号；进入没有
      对其开放的数据库；探测、测试或破坏本网站系统的安全性；干扰本网站对用户提供
      的服务；对本网站系统或网络安全造成破坏的所有个人或实体，将依法追究其法律责
      任。
    4.严禁利用本网站发送、散布或储存侵犯他人版权、商标权、商业秘密或其他知识产权
      以及侵犯他人隐私权、违反法律法规的资料；严禁利用本网站发送、散布或储存任何
      诽谤、辱骂、恐吓、伤害他人和庸俗淫秽的信息。一经发现本网站有权立即取消该用
      户的会员资格并禁止其再次登录本网站。
    5.用户和本网站双方都必须遵守中华人民共和国法律，服从中华人民共和国的司法管辖。
      使用本网站所产生的任何争议，均以中华人民共和国法律为标准解决。
    </pre>
    </div>
</div>
<script type="application/javascript">

    $(function () {
        //如果是验证失败进来的话
        if ("${requestScope.result}" != "") {
            alert("${requestScope.result}");
        }
    });

    //打开协议对话框
    function openDlg() {
        layer.open({
            type: 1,
            title: "服务条款",
            area: ['600px', '600px'],
            content: $('#dlg')
        });
    }

    $(function () {
        $("#login_href").attr("href", "/user/toCompanyLogin.do");

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
                varify: {
                    message: '验证码不能为空',
                    validators: {
                        notEmpty: {
                            message: '验证码不能为空'
                        }
                    },
                    remote:{
                        message:"验证码错误",
                        url:"/user/checkVarify.do",
                        data:{
                            varify:$("#varify").val()
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

            if (!$("#tiaokuan").is(":checked")) {
                alert("请同意服务条款！");
                return;
            }

            // Use Ajax to submit form data
            $.post("/user/companyReg.do", {
                username: $("#username").val(),
                password: $("#password").val(),
                email: $("#email").val(),
                varify: $("#varify").val()
            }, function (data) {
                if (data.msg != undefined) {
                    $("#msg").text(data.msg);
                } else {
                    alert("邮件发送成功，请登录邮箱完成注册!");
                }
            }, 'json');
        });
    });

    function refresh() {
        $("#verify_img").attr("src", "/user/varify.do?t=" + new Date().getTime());
    }
</script>
</body>
</html>

