<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>验证结果</title>
    <%@include file="common/head.jsp"%>
</head>
<body>
<%@include file="/WEB-INF/jsp/common/header.jsp"%>
<div class="big">
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <span style="font-size: 30px;color: orangered;">${result}</span>
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"></jsp:include>
</body>
</html>

