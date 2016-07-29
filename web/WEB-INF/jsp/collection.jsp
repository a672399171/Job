<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>我的收藏</title>
    <%@include file="common/head.jsp" %>
    <script src="${root}/js/moment-with-locales.js"></script>
    <style type="text/css">
        .list_item {
            padding: 5px;
            border-bottom: 1px #dddddd solid;
        }

        .list_item table:hover {
            cursor: pointer;
            background: white;
        }

        .list_item table {
            width: 100%;
        }

        .list_item tr {
            height: 30px;
            line-height: 20px;
        }

        .date {
            margin-right: 50px;
        }
    </style>
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
                <a class="list-group-item" href="/user/apply">
                    <i class="fa fa-comments fa-fw"></i>&nbsp; 求职进展
                </a>
                <a class="list-group-item" href="/user/poor">
                    <i class="fa fa-user-secret fa-fw"></i>&nbsp; 贫困生认证
                </a>
                <a class="list-group-item active" href="/user/collection">
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
        <div class="col-xs-8">
            <h4>我的收藏</h4>
            <hr>
            <c:forEach items="${requestScope.collections}" var="item">
                <div class="list_item">
                    <table url="${root}/job/detail.do?id=${item.job.id}">
                        <tr>
                            <td width="40%">
                                <span class="font4" style="font-size:15px;color: black">${item.job.name}</span>
                                <span class="font2"
                                      style="font-size: 15px">(${item.job.low_salary}-${item.job.high_salary})</span>
                            </td>
                            <td width="30%">
                                <span class="font3">${item.job.post_company.company_name}</span>
                            </td>
                            <td width="30%">
                                <span class="font3">${item.job.post_company.name}:${item.job.post_company.phone}</span>
                            </td>
                        </tr>
                    </table>
                    <div style="width: 100%;text-align: right;padding-right: 30px">
                        <span class="date">
                            <fmt:formatDate value="${item.collect_time}" pattern="yyyy-MM-dd HH:mm"/>
                        </span>
                        <a href="javascript:void(0)"
                           onclick="cancelCollection(${item.user.id},${item.job.id})">取消收藏</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>

<script type="application/javascript">
    $(formatDate);

    $(".list_item table").click(function () {
        window.location = $(this).attr("url");
    });

    //取消收藏
    function cancelCollection(u_id, j_id) {
        $.post("${root}/user/cancelCollection.do", {
            u_id: u_id,
            j_id: j_id
        }, function (data) {
            if (data.success) {
                window.location.reload();
            } else {
                window.location = "${root}/user/toLogin.do";
            }

        }, "JSON");
    }

    //格式化时间
    function formatDate() {
        moment.locale("zh_cn");

        var dates = $(".date");
        for (var i = 0; i < dates.length; i++) {
            var dText = dates.eq(i).text();
            dates.eq(i).text(moment(dText, "YYYY-MM-DD hh:mm").fromNow() + "收藏");
        }
    }
</script>
</body>
</html>

