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
        margin-left: 50px;
    }
</style>
<div id="header" class="container">
    <div class="row">
        <div class="col-md-2 col-md-offset-1">
            <img src="${root}/images/logo.gif"/>
        </div>
        <div class="col-md-6">
            <ul id="hrefUl">
                <li><a href="${root}/job/job_manage.do">职位管理</a></li>
                <li><a href="${root}/job/resume_manage.do">简历管理</a></li>
                <li><a href="${root}/job/search_resume.do">搜索简历</a></li>
                <li><a href="${root}/job/account_setting.do">账号设置</a></li>
            </ul>
        </div>
        <div class="col-md-3" id="login">

        </div>
    </div>
</div>

<script type="application/javascript">

</script>
