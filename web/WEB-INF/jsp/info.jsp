<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>个人资料</title>
    <%@include file="common/head.jsp" %>
    <script src="${root}/js/ajaxfileupload.js"></script>
</head>
<body>
<div class="big container">
    <%@include file="header.jsp" %>
    <div class="row">
        <div class="col-xs-3 col-xs-offset-1">
            <div class="list-group">
                <a class="list-group-item active" href="/user/info">
                    <i class="fa fa-user fa-fw"></i>&nbsp; 我的资料
                </a>
                <a class="list-group-item" href="/user/resume">
                    <i class="fa fa-files-o fa-fw"></i>&nbsp; 我的简历
                </a>
                <a class="list-group-item" href="/user/apply">
                    <i class="fa fa-comments fa-fw"></i>&nbsp; 求职进展
                </a>
                <a class="list-group-item" href="/user/poor">
                    <i class="fa fa-user-secret fa-fw"></i>&nbsp; 贫困生认证
                </a>
                <a class="list-group-item" href="/user/collection">
                    <i class="fa fa-star fa-fw"></i>&nbsp; 我的收藏
                </a>
                <a class="list-group-item" href="/user/secret">
                    <i class="fa fa-lock fa-fw"></i>&nbsp; 隐私设置
                </a>
                <a class="list-group-item" href="/user/setting">
                    <i class="fa fa-cog fa-fw"></i>&nbsp; 账号设置
                </a>
            </div>
        </div>
        <div class="col-xs-1">
            <img src="${root}/images/${sessionScope.user.photo_src}" width="100" height="100"
                 style="margin-top: 20px;border: 1px solid black" id="head_photo"/>
        </div>
        <div class="col-xs-5">
            <form class="form-horizontal" action="/user/modifyInfo" method="post"
                  enctype="multipart/form-data">
                <div class="form-group">
                    <label class="col-xs-3 control-label">用户名:</label>

                    <div class="col-xs-8">
                        <p class="form-control-static">${sessionScope.user.username}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="nickname" class="col-xs-3 control-label">昵称:</label>

                    <div class="col-xs-8">
                        <input type="text" class="form-control" id="nickname" name="nickname"
                               placeholder="昵称" value="${sessionScope.user.nickname}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-3 control-label">性别:</label>

                    <div class="col-xs-8">
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
                <div class="form-group">
                    <label for="file" class="col-xs-3 control-label">更换头像</label>

                    <div class="col-xs-8">
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
<jsp:include page="footer.jsp"/>

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
                        $("#head_photo").attr("src", "${root}/images/" + data.src);
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
            var file = fileSystem.GetFile(filePath);
            fileSize = file.Size;
        } else {
            fileSize = $("#file")[0].files[0].size;
        }

        return fileSize;
    }
</script>
</body>
</html>

