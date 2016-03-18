<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>账号设置</title>
    <script type="text/javascript"
            src="${root}/js/jquery-1.11.2.js"></script>
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
                <li class="list-group-item">
                    <a href="${root}/user/secret.do"><i class="fa fa-lock"></i> 隐私设置</a>
                </li>
                <li class="list-group-item" style="color: red;background: grey">
                    <a href="${root}/user/setting.do"><i class="fa fa-cog"></i> 账号设置</a>
                </li>
            </ul>
        </div>
        <div class="col-md-8">
            <h4>账号设置</h4>
            <hr>
            <table class="table" style="font-size: 14px">
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
                            <td><a href="javascript:void(0)" data-toggle="modal"
                                   data-target="#modal1">认证</a></td>
                        </c:when>
                        <c:otherwise>
                            <td style="color: green"><i class="fa fa-check-circle"></i> 邮箱已认证</td>
                            <td>认证邮箱是找回密码等操作时验证您身份的途径之一。</td>
                            <td><a href="javascript:void(0)">更换</a></td>
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
        <div class="modal bs-example-modal-sm" id="modal1" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
            <div class="modal-dialog modal-sm">
                <div class="modal-content" style="width: 500px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">修改设置</h4>
                    </div>
                    <div class="modal-body container">
                        <span>验证邮箱，绑定成功后可用该邮箱直接登录</span>

                        <div class="row">
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="email" placeholder="输入常用邮箱">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" onclick="sendEmail()">确定</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal bs-example-modal-sm" id="modal2" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
            <div class="modal-dialog modal-sm">
                <div class="modal-content" style="width: 500px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">修改设置</h4>
                    </div>
                    <div class="modal-body container">
                        <span>验证手机号，修改成功后可用该手机号直接登录</span>

                        <div class="row">
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="phone" placeholder="输入常用常用手机号">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-2">
                                <input type="text" class="form-control" id="varify" placeholder="输入短信验证码">
                            </div>
                            <button type="button" class="btn btn-default" onclick="sendMsg()">获取验证码</button>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary">确定</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="application/javascript">
    function sendMsg() {

    }

    function sendEmail() {
        $.post("${root}/user/bindEmail.do",
        {
            url:"${root}/user/",
            email:$("#email").val()
        }, function(data){
            alert("发送成功！");
        },"json");
    }
</script>
</body>
</html>

