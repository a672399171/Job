<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<style type="text/css">
    #hrefUl {
        list-style-type: none;
    }

    #hrefUl li {
        float: left;
        font-size: 20px;
        margin-top: 20px;
        margin-left: 20px;
    }
</style>
<div id="header" class="container">
    <div class="row">
        <div class="col-md-2 col-md-offset-1">
            <a href="${root}/">
                <img src="${root}/images/logo.gif"/>
            </a>
        </div>
        <div class="col-md-6">
            <ul id="hrefUl">
                <li id="job_manage"><a href="${root}/job/job_manage.do">职位管理</a></li>
                <li id="resume_manage"><a href="${root}/job/resume_manage.do">简历管理</a></li>
                <li id="resume_search"><a href="${root}/job/search_resume.do">搜索简历</a></li>
                <li id="account_setting"><a href="${root}/job/account_setting.do">账号设置</a></li>
            </ul>
        </div>
        <div class="col-md-3" id="login">
            <c:choose>
                <c:when test="${sessionScope.company != null}">
                    欢迎你，
                    <span style="color: #1a9c39">${sessionScope.company.username}</span>
                    <a href="javascript:void(0)" onclick="quit()">退出</a>
                </c:when>
            </c:choose>
        </div>
    </div>
</div>

<script type="application/javascript">

    //退出
    function quit() {
        $.post("${root}/user/quit.do", function (data) {
            window.location = "${root}" + "/";
        });
    }
</script>
