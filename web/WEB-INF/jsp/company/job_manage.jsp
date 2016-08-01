<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>职位管理</title>
    <%@include file="../common/head.jsp"%>
    <script src="${root}/js/ajaxfileupload.js"></script>
    <script src="${root}/js/moment-with-locales.js"></script>
    <style type="text/css">
        #container {
            background: white;
        }

        #postBtn {
            float: right;
            margin: 10px;
            margin-right: 50px;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="container" id="container">
    <div class="row">
        <div class="col-md-12">
            <a class="btn btn-success" href="${root}/job/toPost.do" id="postBtn">发布新职位</a>
        </div>
    </div>
    <div class="row">
        <c:choose>
            <c:when test="${fn:length(requestScope.jobs) <= 0}">
                <div style="color: red;font-size: 20px;margin: 0 auto;width: 30%">暂无职位，请先发布职位。</div>
            </c:when>
            <c:otherwise>
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <td>标题</td>
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
                            <td><span class="font3">${job.type.name}</span></td>
                            <td>
                                <span class="date">
                                    <fmt:formatDate value="${job.post_time}"
                                                    pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${job.status == 0}">
                                        <span class="label label-default">Stoped</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="label label-success">Running</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${job.status == 0}">
                                        <a href="javascript:void(0)" style="color: green"
                                           onclick="changeStatus(${job.id},1)">运行</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="javascript:void(0)" style="color: red"
                                           onclick="changeStatus(${job.id},0)">停止</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<%@include file="../common/footer.jsp"%>
<script type="application/javascript">
    //格式化时间
    function formatDate() {
        moment.locale("zh_cn");

        var dates = $(".date");
        for (var i = 0; i < dates.length; i++) {
            var dText = dates.eq(i).text();
            dates.eq(i).text(moment(dText, "YYYY-MM-DD hh:mm").fromNow());
        }
    }

    //改变职位运行状态
    function changeStatus(j_id, status) {
        $.post("${root}/job/changeJobStatus.do", {
            j_id: j_id,
            status: status
        }, function (data) {
            window.location.reload();
        }, "JSON");
    }

    $(function () {
        formatDate();

        $("#hrefUl li a").removeClass("activeTitle");
        $("#job_manage a").addClass("activeTitle");
    });
</script>
</body>
</html>

