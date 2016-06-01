<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>简历投递成功</title>
    <%@include file="common/head.jsp"%>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
    <script src="${root}/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <script src="${root}/js/ajaxfileupload.js"></script>
</head>
<body>
<div class="big container">
    <%@include file="header.jsp"%>
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <img src="${root}/images/icon-succeed.png">
                <span class="font6">简历投递成功！</span>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>

