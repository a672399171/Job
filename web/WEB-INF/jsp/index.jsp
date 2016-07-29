<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>大学生兼职网</title>
    <%@include file="common/head.jsp"%>
    <link rel="stylesheet" type="text/css" href="/resources/css/style_index.css"/>
</head>
<body>
<div class="big container">
    <%@include file="/WEB-INF/jsp/header.jsp"%>

    <div class="row">
        <div id="list1" class="col-xs-2 col-xs-offset-1">
            <div id="type_title">选择类目</div>
            <ul>
                <c:forEach var="item" items="${requestScope.classifies}">
                    <li>
                        <a href="javascript:void(0)">${item.name}</a>
                        <span></span>

                        <div class='hideDiv'>
                            <p class='alink'>
                                <c:forEach items="${item.positions}" var="position">
                                    <a href='javascript:void(0)'
                                       onclick="toJobList(${item.id},${position.id},1,127,0,'max')">${position.name}</a>
                                </c:forEach>
                            </p>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <div id="carousel" class="carousel slide col-md-8" data-ride="carousel">
            <!-- Indicators -->
            <ol class="carousel-indicators"></ol>

            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox"></div>

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
        <script type="application/javascript">
            $("#carousel").height($("#list1").height());
            //加载图片轮播配置
            $.getJSON("${root}/json/pic.json", function (data) {
                for (var i = 0; i < data.length; i++) {
                    var li = $("<li data-target='#carousel' data-slide-to='" + i + "'></li>");
                    if (i == 0) {
                        li.addClass("active");
                    }
                    $("#carousel .carousel-indicators").append(li);

                    var div = $("<div class='item'></div>");
                    div.append("<a href='" + data[i].href + "' target='_blank'><img src='/resources/images/index/" + data[i].src + "' alt='图片不存在'></a>");

                    if (i == 0) {
                        div.addClass("active");
                    }

                    $("#carousel .carousel-inner").append(div);
                }
                $('#carousel').carousel();
                $(".carousel-inner").width($('#carousel').width() + "px");
                $(".carousel-inner").height($('#carousel').height() + "px");
                //console.log($('#carousel').outerWidth() + "  " + $('#carousel').height());
                var imgs = $(".carousel-inner .item a img");
                for (var i = 0; i < imgs.length; i++) {
                    imgs.eq(i).css("width", $('#carousel').width() + "px");
                    imgs.eq(i).css("height", $('#carousel').height() + "px");
                }
            });
        </script>
        <div id="middle" class="col-xs-10 col-xs-offset-1">
            <h2>最新招聘</h2>
            <hr>
            <c:forEach var="item" items="${requestScope.jobs}">
                <div class="job_item" style="display: block" url="/job/${item.id}">
                    <table>
                        <tr>
                            <td width="30%"><a href="#" class="link">${item.name}</a></td>
                            <td width="30%" class="font3 date">
                                <fmt:formatDate value="${item.post_time}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>
                            <td width="30%" class="font5">${item.post_company.company_name}</td>
                        </tr>
                        <tr>
                            <td class="font5">${item.type.name}</td>
                            <td class="font4">${item.low_salary}-${item.high_salary}</td>
                            <td class="font3">${item.post_company.scope}</td>
                        </tr>
                    </table>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/jsp/right.jsp"/>
<jsp:include page="/WEB-INF/jsp/footer.jsp"/>

<script type="application/javascript">

    $(function () {
        formatDate();

        $("#list1 ul li").mouseover(function () {
            $(this).children(".hideDiv").css("margin-left", $("#list1").width() - 7 + "px");
            $(this).children(".hideDiv").css("margin-top", -$(this).height() - 3 + "px");
            $(this).children(".hideDiv").show();
            $(this).children("span").css("display", "inline-block");
        });
        $("#list1 ul li").mouseleave(function () {
            $(this).children(".hideDiv").hide();
            $(this).children("span").hide();
        });
    });

    //格式化时间
    function formatDate() {
        moment.locale("zh_cn");

        var dates = $(".date");
        for (var i = 0; i < dates.length; i++) {
            var dText = dates.eq(i).text();
            dates.eq(i).text(moment(dText, "YYYY-MM-DD hh:mm").fromNow());
        }
    }

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

    function quit() {
        $.post("${root}/user/quit.do", function (data) {
            window.location = "${root}";
        });
    }

    //post方法
    function post(URL, PARAMS) {
        var temp = document.createElement("form");
        temp.action = URL;
        temp.method = "post";
        temp.style.display = "none";
        for (var x in PARAMS) {
            var opt = document.createElement("textarea");
            opt.name = x;
            opt.value = PARAMS[x];
            temp.appendChild(opt);
        }
        document.body.appendChild(temp);
        temp.submit();
        return temp;
    }

    //转到职位列表页面
    function toJobList(c_id, p_id, page, time, low, high) {
        var param = {
            c_id: c_id,
            p_id: p_id,
            page: page,
            time: time,
            low: low,
            high: high
        };
        post("/job/job_list.do", param);
    }

    $(".job_item").click(function () {
        window.location = $(this).attr("url");
    });
</script>
</body>
</html>

