<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>个人资料</title>
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
    <script src="${root}/js/ajaxfileupload.js"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="container">
    <div class="row">
        <div class="col-md-3 col-md-offset-1">
            <ul class="list-group">
                <li class="list-group-item" style="color: red;background: grey">
                    <a href="${root}/user/info.do"><i class="fa fa-user"></i> 我的资料</a>
                </li>
                <li class="list-group-item">
                    <a href="${root}/user/resume.do"><i class="fa fa-files-o"></i> 我的简历</a>
                </li>
                <li class="list-group-item">
                    <a href="#"><i class="fa fa-comments"></i> 求职进展</a>
                </li>
                <li class="list-group-item" >
                    <a href="${root}/user/poor.do"><i class="fa fa-user-secret"></i> 贫困生认证</a>
                </li>
                <li class="list-group-item">
                    <a href="${root}/user/collection.do"><i class="fa fa-star"></i> 我的收藏</a>
                </li>
                <li class="list-group-item">
                    <a href="${root}/user/secret.do"><i class="fa fa-lock"></i> 隐私设置</a>
                </li>
                <li class="list-group-item">
                    <a href="${root}/user/setting.do"><i class="fa fa-cog"></i> 账号设置</a>
                </li>
            </ul>
        </div>
        <div class="col-lg-1">
            <img src="${root}/images/${sessionScope.user.photo_src}" width="100" height="100"
                 style="margin-top: 20px;border: 1px solid black" id="head_photo"/>
        </div>
        <div class="col-lg-5">
            <form class="form-horizontal" action="${root}/user/modify_info.do" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label class="col-sm-3 control-label">用户名:</label>

                    <div class="col-sm-8">
                        <p class="form-control-static">${sessionScope.user.username}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="nickname" class="col-sm-3 control-label">昵称:</label>

                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="nickname" name="nickname"
                               placeholder="昵称" value="${sessionScope.user.nickname}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3 control-label">性别:</label>

                    <div class="col-sm-8">
                        <c:choose>
                            <c:when test="${sessionScope.user.sex == '男'}">
                                <label class="radio-inline">
                                    <input type="radio" name="sex" value="男" checked> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="sex" value="女"> 女
                                </label>
                            </c:when>
                            <c:otherwise>
                                <label class="radio-inline">
                                    <input type="radio" name="sex" value="男"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="sex" value="女" checked> 女
                                </label>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <%--<div class="form-group">
                    <label for="phone" class="col-sm-3 control-label">手机号码:</label>
                    <div class="col-sm-8">
                        <input type="tel" class="form-control" id="phone" placeholder="手机号码">
                    </div>
                </div>
                <div class="form-group">
                    <label for="varify" class="col-sm-3 control-label">验证码:</label>
                    <div class="col-sm-5">
                        <input type="tel" class="form-control" id="varify" placeholder="验证码">
                    </div>
                    <div class="col-sm-3">
                        <button type="button" class="btn btn-default">获取验证码</button>
                    </div>
                </div>--%>
                <div class="form-group">
                    <label for="file" class="col-sm-3 control-label">更换头像</label>

                    <div class="col-sm-8">
                        <input type="file" id="file" name="file">
                    </div>
                </div>
                <input type="hidden" value="${sessionScope.user.photo_src}" name="photo_src" id="photo_src"/>
                <p class="help-block">格式仅支持.jpg,.png,.gif,大小不超过300KB</p>
                <button type="submit" class="btn btn-primary" style="width: 150px">
                    <i class="fa fa-floppy-o"></i> 完成修改
                </button>
            </form>
        </div>
    </div>
</div>

<script type="application/javascript">
    $("#file").change(function () {

        var filePath = $("#file").val();
        var fileType = filePath.substr(filePath.lastIndexOf(".") + 1);
        console.log(fileType);
        if ($.inArray(fileType, ['jpg', 'JPG', 'gif', 'GIF', 'png', 'PNG']) != -1) {
            var fileSize = getFileSize();
            console.log(fileSize);

            if (fileSize <= 300 * 1024) {
                $.ajaxFileUpload({
                    url: '${root}/user/upload_photo.do',
                    secureuri: false,
                    fileElementId: "file",
                    dataType: 'json',
                    success: function (data) {
                        $("#head_photo").attr("src","${root}/images/" + data.src);
                        $("#photo_src").val(data.src);
                    },
                    error: function (data, status, e) {
                        alert('上传失败！');
                    }
                });
            } else {
                alert("文件过大！");
            }
        } else {
            alert("文件格式不正确！");
        }
    });

    function getFileSize() {
        var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
        var fileSize = 0;
        if (isIE && !$("#file").files) {
            var filePath = $("#file").value;
            var fileSystem = new ActiveXObject("Scripting.FileSystemObject");

            if (!fileSystem.FileExists(filePath)) {
                alert("附件不存在，请重新输入！");
                var file = document.getElementById(id);
                file.outerHTML = file.outerHTML;
                return;
            }
            var file = fileSystem.GetFile (filePath);
            fileSize = file.Size;
        } else {
            fileSize = $("#file")[0].files[0].size;
        }

        return fileSize;
    }
</script>
</body>
</html>

