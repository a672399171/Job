<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>职位管理</title>
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
    <style type="text/css">
        #container {
            background: white;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="container" id="container">
    <div class="row">
        <div class="col-md-8">
            <a href="${root}/job/toPost.do">发布新职位</a>
        </div>
    </div>
    <div class="row">
        <c:choose>
            <c:when test="${fn:length(requestScope.jobs) <= 0}">
                暂无职位，请先发布职位。
            </c:when>
            <c:otherwise>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <td>名称</td>
                        <td>类型</td>
                        <td>发布时间</td>
                        <td>状态</td>
                        <td>操作</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="job" items="${requestScope.jobs}">
                        <tr>
                            <td><a href="${root}/job/job_detail.do?id=${job.id}">${job.name}</a></td>
                            <td>${job.type.name}</td>
                            <td><fmt:formatDate value="${job.post_time}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                            <td>
                                <c:choose>
                                    <c:when test="${job.status == 0}">
                                        停止中
                                    </c:when>
                                    <c:otherwise>
                                        运行中
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><a href="#">运行</a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script type="application/javascript">

</script>
</body>
</html>

