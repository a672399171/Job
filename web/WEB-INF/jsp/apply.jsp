<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>求职进展</title>
    <%@include file="common/head.jsp" %>
    <link href="http://g.alicdn.com/sj/qnui/1.5.1/css/sui.min.css" rel="stylesheet">
    <script type="text/javascript" src="http://g.alicdn.com/sj/qnui/1.5.1/js/sui.min.js"></script>
</head>
<body>
<div class="big container">
    <%@include file="header.jsp" %>
    <div class="row">
        <div class="col-xs-3 col-xs-offset-1">
            <div class="list-group">
                <a class="list-group-item " href="/user/info">
                    <i class="fa fa-user fa-fw"></i>&nbsp; 我的资料
                </a>
                <a class="list-group-item" href="/user/resume">
                    <i class="fa fa-files-o fa-fw"></i>&nbsp; 我的简历
                </a>
                <a class="list-group-item active" href="/user/apply">
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
        <div class="col-xs-7">
            <h4 style="font-size: 16px">求职进展</h4>
            <hr>
            <c:choose>
                <c:when test="${fn:length(requestScope.applies) > 0}">
                    <c:forEach var="item" items="${requestScope.applies}">
                        <div class="well well-sm">
                            <div class="contentDiv">
                                <div class="col-xs-4">
                                    <a href="${root}/job/detail.do?id=${item.job.id}">${item.job.name}</a>
                                </div>
                                <div class="col-xs-4">
                                        ${item.job.post_company.company_name}
                                </div>
                                <div class="col-xs-4">
                                    <fmt:formatDate value="${item.apply_date}"
                                                    pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
                                </div>
                            </div>

                            <div class="sui-steps steps-auto" style="margin-top: 10px">
                                <div class="wrap">
                                    <div class="finished">
                                        <label>
                                            <span class="round"><i class="sui-icon icon-pc-right"></i></span>
                                            <span>第一步 投递简历</span>
                                        </label>
                                        <i class="triangle-right-bg"></i><i class="triangle-right"></i>
                                    </div>
                                </div>
                                <c:choose>
                                    <c:when test="${item.state == 2}">
                                        <div class="wrap">
                                            <div class="finished">
                                                <label>
                                                        <span class="round"><i
                                                                class="sui-icon icon-pc-right"></i></span>
                                                    <span>第二步 公司审核</span>
                                                </label>
                                                <i class="triangle-right-bg"></i><i class="triangle-right"></i>
                                            </div>
                                        </div>
                                        <div class="wrap">
                                            <div class="finished">
                                                <label>
                                                        <span class="round"><i
                                                                class="sui-icon icon-pc-right"></i></span>
                                                    <span>第三步 成功入职</span>
                                                </label>
                                                <i class="triangle-right-bg"></i><i class="triangle-right"></i>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${item.state == 1}">
                                        <div class="wrap">
                                            <div class="finished">
                                                <label>
                                                    <span class="round">2</span><span>第二步 公司审核</span>
                                                </label>
                                                <i class="triangle-right-bg"></i><i class="triangle-right"></i>
                                            </div>
                                        </div>
                                        <div class="wrap">
                                            <div class="todo">
                                                <label>
                                                    <span class="round">3</span><span>第三步 申请失败</span>
                                                </label>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="wrap">
                                            <div class="todo">
                                                <label>
                                                    <span class="round">2</span><span>第二步 公司审核</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="wrap">
                                            <div class="todo">
                                                <label>
                                                    <span class="round">3</span><span>第三步 成功入职</span>
                                                </label>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <span style="font-size: 15px;color: red">暂无进展,请先投递简历。</span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
<script type="application/javascript">

</script>
</body>
</html>

