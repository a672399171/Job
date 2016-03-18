<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>贫困生认证</title>
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
                <li class="list-group-item" style="color: red;background: grey">
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
        <div class="col-lg-6">
            <h4>贫困生认证</h4>
            <hr>
            <c:choose>
                <c:when test="${poor != null  && poor.status == 2}">
                    <span>贫困生已认证完成！</span>
                </c:when>
                <c:when test="${poor != null && poor.status == 1}">
                    贫困审核中，请耐心等待...
                </c:when>
                <c:otherwise>
                    <form class="form-horizontal" action="${root}/user/poor_confirm.do" enctype="multipart/form-data" method="post">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">学号:</label>
                            <div class="col-sm-8">
                                <p class="form-control-static">${sessionScope.user.school_num}</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;名:</label>

                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="name" placeholder="姓名" value="${resume.name}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email" class="col-sm-2 control-label">Email:</label>

                            <div class="col-sm-8">
                                <input type="email" class="form-control" id="email" name="email" placeholder="电子邮箱"
                                       value="${resume.email}">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="school" class="col-sm-2 control-label">院系:</label>

                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="school" id="school" placeholder="院系"
                                       value=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="file" class="col-sm-2 control-label">证明照片:</label>
                            <div class="col-sm-8">
                                <input type="file" id="file" name="file">
                            </div>
                        </div>
                        <div class="col-sm-6" style="text-align: center">
                            <button type="submit" class="btn btn-primary" style="width: 150px" onclick="return setData()">
                                <i class="fa fa-floppy-o"></i> 确定
                            </button>
                        </div>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script type="application/javascript">

</script>
</body>
</html>

