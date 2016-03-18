<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<div id="header" class="container">
    <div class="row">
        <div class="col-md-2 col-md-offset-1">
            <img src="${root}/images/logo.gif"/>
        </div>
        <%--<div id="hrefs" class="col-md-5">
            <ul>
                <li><a href="${root}" class="font1">首页</a></li>
                <li><a href="#" class="font1">职位</a></li>
                <li><a href="#" class="font1">校园招聘</a></li>
            </ul>
        </div>--%>
        <div class="col-md-5">
            <div id="inputDiv">
                <input type="text" placeholder="输入公司或职位" id="input"/>
                <input type="button" value="搜 索" id="searchBtn"/>
            </div>
        </div>
        <div class="col-md-4" id="login">
            <c:choose>
                <c:when test="${sessionScope.user == null}">
                    <a href="${root}/user/toLogin.do?from=${pageContext.request.requestURL}" id="login_href">登录</a> |
                    <a href="${root}/user/toReg.do">注册</a> |
                    <a href="${root}/user/toCompanyLogin.do">企业登录</a>
                </c:when>
                <c:otherwise>
                    <div id="div1">
                        <a href="${root}/user/info.do" id="person_href">
                            <img src="${root}/images/${sessionScope.user.photo_src}" id="photo"/>
                                ${sessionScope.user.username}
                        </a>
                        <ul id="list">
                            <li><a href="${root}/user/info.do"><i class="fa fa-user"></i></i> 我的资料</a></li>
                            <li><a href="${root}/user/resume.do"><i class="fa fa-files-o"></i> 我的简历</a></li>
                            <li><a href="${root}/user/poor.do"><i class="fa fa-user-secret"></i> 贫困生认证</a></li>
                            <li><a href="${root}/user/collection.do"><i class="fa fa-star"></i> 我的收藏</a></li>
                            <li><a href="${root}/user/secret.do"><i class="fa fa-lock"></i> 隐私设置</a></li>
                            <li><a href="${root}/user/setting.do"><i class="fa fa-cog"></i> 账号设定</a></li>
                        </ul>
                    </div>
                    | <a href="javascript:void(0)" onclick="quit()">退出</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script type="application/javascript">
    $(function() {
        $("#login_href").attr("href","${root}/user/toLogin.do?from=" + window.location.href);
    });

    function quit() {
        $.post("${root}/user/quit.do",function(data) {
            window.location = "${root}";
        });
    }

    $("#person_href").mouseover(function() {
        $("#list").slideDown(500);
    });

    $("#div1").mouseleave(function() {
        $("#list").slideUp(500);
    });
</script>
