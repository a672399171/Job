<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<div class="row" id="header">
    <div class="col-md-2 col-md-offset-1">
        <a href="${root}/">
            <img src="${root}/images/logo.gif"/>
        </a>
    </div>
    <div class="col-md-6">
        <div id="inputDiv">
            <input type="text" placeholder="输入公司或职位" id="input" value="${requestScope.keyword}"
                   onkeydown="entersearch()"/>
            <input type="button" value="搜 索" id="searchBtn" onclick="searchJobs()"/>
        </div>
    </div>
    <div class="col-md-3" id="login">
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

                    <div class="list-group" id="list">
                        <a class="list-group-item" href="${root}/user/info.do">
                            <i class="fa fa-user fa-fw"></i>&nbsp; 我的资料
                        </a>
                        <a class="list-group-item" href="${root}/user/resume.do">
                            <i class="fa fa-files-o fa-fw"></i>&nbsp; 我的简历
                        </a>
                        <a class="list-group-item" href="${root}/user/apply.do">
                            <i class="fa fa-comments fa-fw"></i>&nbsp; 求职进展
                        </a>
                        <a class="list-group-item" href="${root}/user/poor.do">
                            <i class="fa fa-user-secret fa-fw"></i>&nbsp; 贫困生认证
                        </a>
                        <a class="list-group-item" href="${root}/user/collection.do">
                            <i class="fa fa-star fa-fw"></i>&nbsp; 我的收藏
                        </a>
                        <a class="list-group-item" href="${root}/user/secret.do">
                            <i class="fa fa-lock fa-fw"></i>&nbsp; 隐私设置
                        </a>
                        <a class="list-group-item" href="${root}/user/setting.do">
                            <i class="fa fa-cog fa-fw"></i>&nbsp; 账号设置
                        </a>
                    </div>
                </div>
                | <a href="javascript:void(0)" onclick="quit()">退出</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script type="application/javascript">
    $(function () {
        $("#login_href").attr("href", "${root}/user/toLogin.do?from=" + window.location.href);
    });

    //退出
    function quit() {
        $.post("${root}/user/quit.do", function (data) {
            window.location = "${root}";
        });
    }

    //鼠标滑过
    $("#person_href").mouseover(function () {
        $("#list").slideDown(500);
    });

    //鼠标离开
    $("#div1").mouseleave(function () {
        $("#list").slideUp(500);
    });

    //搜索工作
    function searchJobs() {
        var val = $("#input").val();
        if (jQuery.trim(val) != "") {
            var url = "${root}/job/vague_search_job.do?keyword=" + val;
            window.location = url;
        }
    }

    //回车键搜索
    function entersearch() {
        var event = window.event || arguments.callee.caller.arguments[0];
        if (event.keyCode == 13) {
            searchJobs();
        }
    }
</script>
