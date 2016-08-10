<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>简历投递成功</title>
    <%@include file="common/head.jsp"%>
</head>
<body>
<div class="big container">
    <%@include file="common/header.jsp"%>
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <img src="/resources/images/icon-succeed.png">
                <span class="font6">简历投递成功！</span>
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

