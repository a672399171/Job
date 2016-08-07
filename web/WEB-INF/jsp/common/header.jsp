<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="row" id="header">
    <div class="col-xs-2 col-xs-offset-1">
        <a href="/">
            <img src="/resources/images/logo.png"/>
        </a>
    </div>
    <div class="col-xs-6">
        <div class="input-group inputDiv">
            <input type="text" class="form-control" placeholder="输入公司或职位" id="input"
                   value="${param.keyword}" onkeydown="enterSearch()">
            <span class="input-group-btn">
                <button class="btn btn-default" type="button" id="searchBtn" onclick="searchJobs()">搜 索</button>
            </span>
        </div>
    </div>
    <div class="col-xs-3" id="login">
        <c:choose>
            <c:when test="${sessionScope.user == null}">
                <a href="/login?from=${pageContext.request.requestURL}" id="login_href">登录</a> |
                <a href="/reg">注册</a> |
                <a href="/companyLogin">企业登录</a>
            </c:when>
            <c:otherwise>
                <div id="div1">
                    <a href="/user/info" id="person_href">
                        <img src="/resources/images/${sessionScope.user.photo_src}" id="photo"/>
                            ${sessionScope.user.username}
                    </a>

                    <div class="list-group" id="list">
                        <a class="list-group-item" href="/user/info">
                            <i class="fa fa-user fa-fw"></i>&nbsp; 我的资料
                        </a>
                        <a class="list-group-item" href="/user/resume">
                            <i class="fa fa-files-o fa-fw"></i>&nbsp; 我的简历
                        </a>
                        <a class="list-group-item" href="user/apply">
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
                | <a href="javascript:void(0)" onclick="quit()">退出</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script type="application/javascript">
    $(function () {
        $("#login_href").attr("href", "/login?from=" + window.location.href);
    });

    //退出
    function quit() {
        $.post("/user/quit", function (data) {
            window.location = "/";
        },'JSON');
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
            var url = "/job/vagueList?keyword=" + val;
            window.location = url;
        }
    }

    //回车键搜索
    function enterSearch() {
        var event = window.event || arguments.callee.caller.arguments[0];
        if (event.keyCode == 13) {
            searchJobs();
        }
    }
</script>
