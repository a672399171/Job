<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>主页</title>
    <link rel="stylesheet" href="${root}/font-awesome-4.3.0/css/font-awesome.min.css">
    <script type="text/javascript" src="${root}/js/jquery-1.11.2.js"></script>
    <link rel="stylesheet" href="${root}/bootstrap-3.3.4-dist/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${root}/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="${root}/css/style_index.css"/>
    <script src="${root}/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
    <script src="${root}/js/dateformat.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/header.jsp"/>

<div id="list1">
    <div id="type_title">选择类目</div>
    <ul>
        <c:forEach var="item" items="${requestScope.array}">
            <li>
                <a href="javascript:void(0)">${item.name}</a>
                <span></span>
                <div class='hideDiv'>
                    <p class='alink'>
                        <c:forEach items="${item.positions}" var="position">
                            <a href='${root}/job/job_list.do?c_id=${item.id}&p_id=${position.id}&page=1&time=127&low=0&high=max'>${position.name}</a>
                        </c:forEach>
                    </p>
                </div>
            </li>
        </c:forEach>
    </ul>
</div>

<div id="carousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
        <li data-target="#carousel-example-generic" data-slide-to="1"></li>
        <li data-target="#carousel-example-generic" data-slide-to="2"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
        <div class="item active">
            <img src="${root}/images/1.jpg" alt="">

            <div class="carousel-caption">

            </div>
        </div>
        <div class="item">
            <img src="${root}/images/1.jpg" alt="">

            <div class="carousel-caption">

            </div>
        </div>
    </div>

    <!-- Controls -->
    <a class="left carousel-control" href="#carousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#carousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

<div id="middle">
    <h2>最新招聘</h2>
    <hr>
    <div class="job_item">
        <table>
            <tr>
                <td width="30%"><a href="#" class="link">金融销售</a></td>
                <td width="30%" class="font3">今天</td>
                <td width="30%" class="font5">国晟鸿业(厦门)资产管理有限公司</td>
            </tr>
            <tr>
                <td class="font5">应届生</td>
                <td class="font4">3000-6000</td>
                <td class="font3">101－300人</td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/WEB-INF/jsp/footer.jsp"/>

<script type="application/javascript">
    $(function () {
        $("#login_href").attr("href", "${root}/user/toLogin.do?from=" + window.location.href);
        //getClassifies();
        getRecentJobs();

        $("#list1 ul li").mouseover(function () {
            $(this).children(".hideDiv").show();
            $(this).children("span").css("display", "inline-block");
        });
        $("#list1 ul li").mouseleave(function () {
            $(this).children(".hideDiv").hide();
            $(this).children("span").hide();
        });
    });

    function getClassifies() {
        $.getJSON("${root}/job/classifies.do", function (data) {
            var classifies = data.classifies;
            var positions = data.positions;
            for (var i = 0; i < classifies.length; i++) {
                var classify = classifies[i];
                var li = $("<li>" + classify.name + "<span></span>" + "</li>");
                var hideDiv = $("<div class='hideDiv'></div>");
                var p = $("<p class='alink'></p>");
                for (var j = 0; j < positions.length; j++) {
                    var position = positions[j];
                    if (position.c_id == classify.id) {
                        p.append("<a href='#'>" + position.name + "</a>");
                    }
                }
                hideDiv.append(p);
                li.append(hideDiv);
                $("#list1 ul").append(li);
            }
            $("#list1 ul li").mouseover(function () {
                $(this).children(".hideDiv").show();
                $(this).children("span").css("display", "inline-block");
            });
            $("#list1 ul li").mouseleave(function () {
                $(this).children(".hideDiv").hide();
                $(this).children("span").hide();
            });
        });
    }

    function getRecentJobs() {
        $.getJSON("${root}/job/getRecentJobs.do", function (data) {
            var jobs = data.jobs;
            for (var i = 0; i < jobs.length; i++) {
                var job = jobs[i];
                var item = $(".job_item").eq(0).clone();
                //工作名称
                item.find(".link").eq(0).text(job.name);
                //发布时间
                item.find(".font3").eq(0).text(new Date(job.post_time.time).Format("yyyy-MM-dd hh:mm"));
                //公司名
                item.find(".font5").eq(0).text(job.post_company.company_name);
                //职位类型
                item.find(".font5").eq(1).text(job.type.name);
                //工资
                item.find(".font4").eq(0).text(job.low_salary + "-" + job.high_salary);
                //公司规模
                item.find(".font3").eq(1).text(job.post_company.scope);
                item.show();
                item.click(function () {
                    window.location = "${root}/job/detail.do?id=" + job.id;
                });
                $("#middle").append(item);
            }
        });
    }

    function quit() {
        $.post("${root}/user/quit.do", function (data) {
            window.location = "${root}";
        });
    }

    $(".job_item").click(function () {
        window.location = $(this).attr("url");
    });
</script>
</body>
</html>

