<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<div class="container">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a href="/" class="navbar-brand" style="padding: 0;">
            <img src="/resources/images/logo.png" height="50"/>
        </a>
    </div>
    <div class="navbar-collapse collapse">
        <ul class="nav navbar-nav">
            <li id="job_manage" class="active"><a href="/company/jobManage">职位管理</a></li>
            <li id="resume_manage"><a href="/company/resumeManage">简历管理</a></li>
            <li id="resume_search"><a href="/company/searchResume">搜索简历</a></li>
            <li id="account_setting"><a href="/company/accountSetting">账号设置</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <c:choose>
                <c:when test="${sessionScope.company != null}">
                    <div style="margin: 15px 50px 0 20px">
                        <span>欢迎你，</span>
                        <span style="color: #1a9c39">${sessionScope.company.username}</span>
                        <a href="javascript:void(0)" onclick="quit()">退出</a>
                    </div>
                </c:when>
            </c:choose>
        </ul>
    </div>
</div>
<script type="application/javascript">

    //退出
    function quit() {
        $.post("/company/quit", function (data) {
            window.location = "/";
        });
    }
</script>
