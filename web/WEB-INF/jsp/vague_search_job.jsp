<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>搜索结果</title>
    <link rel="stylesheet" type="text/css"
          href="${root}/jquery-easyui-1.4.4/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css"
          href="${root}/jquery-easyui-1.4.4/themes/icon.css"/>
    <link rel="stylesheet" href="${root}/font-awesome-4.3.0/css/font-awesome.min.css">
    <script type="text/javascript"
            src="${root}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${root}/js/jquery.fullPage.min.js"></script>
    <script type="text/javascript"
            src="${root}/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${root}/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="${root}/bootstrap-3.3.4-dist/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${root}/css/common.css"/>
    <script src="${root}/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
    <style type="text/css">
        .row {
            clear: both;
        }

        #middle {
            background: white;
            min-width: 800px;
            width: 80%;
            margin-left: 150px;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .job_item {
            width: 100%;
            height: 100px;
            border-bottom: 1px solid #cccccc;
            background: white;
            padding: 10px;
            cursor: pointer;
        }

        .job_item:hover {
            background: #F8F8F8;
        }

        .job_item table tr {
            height: 40px;
            line-height: 40px;
        }

        .link {
            color: dodgerblue;
            font-size: 18px;
        }

        nav {
            text-align: center;
        }

    </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/header.jsp"/>

<div class="container">
    <div class="row selectType" id="positionDiv">
        <div class="col-md-1">
            类别:
        </div>
        <div class="col-md-11">
            <ul>
                <li id="0"
                    <c:if test="${c_id == '0'}">class="on" </c:if>
                >不限
                </li>
                <c:forEach items="${requestScope.classifies}" var="item">
                    <li
                            <c:if test="${item.id == c_id}">
                                class="on"
                            </c:if>
                            id="${item.id}">${item.name}</li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="row selectType" id="timeDiv">
        <div class="col-md-1">
            工作时间:
        </div>
        <div class="col-md-11">
            <ul>
                <li class="on" id="first">不限</li>
                <li>周一</li>
                <li>周二</li>
                <li>周三</li>
                <li>周四</li>
                <li>周五</li>
                <li>周六</li>
                <li>周日</li>
            </ul>
        </div>
    </div>
    <div class="row selectType" id="salaryDiv">
        <div class="col-md-1">
            月薪:
        </div>
        <div class="col-md-11">
            <ul>
                <li class="on" low="0" high="max">不限</li>
                <li low="0" high="500">500以下</li>
                <li low="500" high="1000">500-1000</li>
                <li low="1000" high="2000">1000-2000</li>
                <li low="2000" high="3000">2000-3000</li>
                <li low="3000" high="4000">3000-4000</li>
                <li low="4000" high="max">4000以上</li>
            </ul>
        </div>
    </div>
</div>

<div id="middle">
    <c:forEach var="item" items="${requestScope.jobs}">
        <div class="job_item">
            <table>
                <tr>
                    <td width="300"><a href="#" class="link">${item.name}</a></td>
                    <td width="200" class="font3">
                        <fmt:formatDate value="${item.post_time}" pattern="yyyy-MM-dd"></fmt:formatDate>
                    </td>
                    <td width="300" class="font5">${item.post_company.company_name}</td>
                </tr>
                <tr>
                    <td class="font5">应届生</td>
                    <td class="font4">${item.low_salary}-${item.high_salary}</td>
                    <td class="font3">民营/私企 | 101－300人</td>
                </tr>
            </table>
        </div>
    </c:forEach>
</div>
<c:choose>
    <c:when test="${count == 0}">
        暂无记录！
    </c:when>
    <c:otherwise>
        <nav>
            <ul class="pagination pagination-lg">
                <li id="pre"><a href="#" aria-label="Previous">«</a></li>
                <li id="next"><a href="#" aria-label="Next">»</a></li>
            </ul>
        </nav>
    </c:otherwise>
</c:choose>

<jsp:include page="/WEB-INF/jsp/footer.jsp"/>

<script type="application/javascript">
    //页码
    var currentPage = ${page};
    //条数
    var count = ${count};
    //页数
    var totalPage = ${count}/10;
    totalPage = Math.floor(totalPage) + 1;
    //时间
    var time = parseInt(${time}).toString(2);
    var timeLength = time.length;
    if(time.length<7) {
        for(var i=0;i<7-timeLength;i++) {
            time = "0" + time;
        }
    } else {
        time = time.substr(time.length-7);
    }

    $(function () {
        //初始化工资选中状态
        $("#salaryDiv li").removeClass("on");
        for (var i = 0; i < $("#salaryDiv li").length; i++) {
            if ($("#salaryDiv li").eq(i).attr("low") == "${low}"
                    && $("#salaryDiv li").eq(i).attr("high") == "${high}") {
                $("#salaryDiv li").eq(i).addClass("on");
            }
        }

        //初始化时间选中状态
        $("#timeDiv li").removeClass("on");
        if (time == '1111111') {
            $("#first").addClass("on");
        } else {
            for (var i = 0; i < time.length; i++) {
                if (time.charAt(i) == '1') {
                    $("#timeDiv li").eq(i + 1).addClass("on");
                }
            }
        }

        if (currentPage >= 3 && totalPage >= 5) {
                for(var i = currentPage+3;i>currentPage-3;i--) {
                    if(i == currentPage) {
                        $("#pre").after("<li class='active'><a href='#'>" + i + "</a></li>");
                    } else {
                        $("#pre").after("<li><a href='#'>" + i + "</a></li>");
                    }
                }
        } else {
            for(var i = totalPage;i>0;i--) {
                if(i == currentPage) {
                    $("#pre").after("<li class='active'><a href='#'>" + i + "</a></li>");
                } else {
                    $("#pre").after("<li><a href='#'>" + i + "</a></li>");
                }
            }
        }
    });

    $("#timeDiv li").click(function (e) {
        if ($(e.target)[0].id == "first") {
            $("#timeDiv li").removeClass("on");
            $(this).addClass("on");
        } else {
            if ($("#first").hasClass("on")) {
                $("#first").removeClass("on");
            }
            if ($(this).attr("flag") == undefined) {
                $(this).attr("flag", false);
            }
            if ($(this).attr("flag") == "false") {
                $(this).addClass("on");
                $(this).attr("flag", true);
            } else {
                $(this).removeClass("on");
                $(this).attr("flag", false);
            }
        }
        loadData();
    });
    $("#salaryDiv li").click(function () {
        $("#salaryDiv li").removeClass("on");
        $(this).addClass("on");
        loadData();
    });

    $("#positionDiv li").click(function () {
        $("#positionDiv li").removeClass("on");
        $(this).addClass("on");
        loadData();
    });

    //加载数据，刷新页面
    function loadData() {
        var url = "${root}/job/vague_search_job.do?keyword=${keyword}";
        var c_id = $("#positionDiv .on").eq(0).attr("id");

        var low = $("#salaryDiv .on").attr("low");
        var high = $("#salaryDiv .on").attr("high");

        url += "&c_id=" + c_id + "&time=" + getWorkTime() + "&low=" + low + "&high=" + high;
        window.location = url;
    }

    //获取工作时间
    function getWorkTime() {
        var temp = 0;
        if ($("#first").hasClass("on")) {
            temp = 127;
        } else {
            for (var i = 1; i < $("#timeDiv li").length; i++) {
                if ($("#timeDiv li").eq(i).hasClass("on")) {
                    temp += Math.pow(2,7-i);
                }
            }
        }
        return temp;
    }
</script>
</body>
</html>

