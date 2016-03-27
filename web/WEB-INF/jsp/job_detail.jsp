<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
    <title>${job.name}</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <script type="text/javascript"
            src="${root}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${root}/js/jquery.fullPage.min.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
    <link rel="stylesheet" href="${root}/bootstrap-3.3.4-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${root}/bootstrapvalidator/css/bootstrapValidator.min.css">
    <link rel="stylesheet" href="${root}/font-awesome-4.3.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${root}/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="${root}/css/style_job_detail.css"/>
    <script src="${root}/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
    <script src="${root}/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <script src="${root}/js/dateformat.js"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div id="leftDiv">
    <div class="baseInfo">
        <h2>${job.name}
            <c:choose>
                <c:when test="${requestScope.collection == null}">
                    <i class="fa fa-star" id="collect"></i>
                </c:when>
                <c:otherwise>
                    <i class="fa fa-star" id="collect" style="color: red"></i>
                </c:otherwise>
            </c:choose>
        </h2>

        <div class="require">
            <span class="font4">${job.low_salary}-${job.high_salary}</span>
            <fmt:formatDate pattern="yyyy-MM-dd hh:MM:ss" value="${requestScope.job.post_time}"></fmt:formatDate>
            <span class="font5">${job.type.name}</span>
            <c:choose>
                <c:when test="${requestScope.apply == null}">
                    <button class="btn btn-danger" id="apply">申请职位</button>
                </c:when>
                <c:otherwise>
                    <button class="btn btn-danger" id="apply" disabled>申请中</button>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="tag">${job.tag}</div>
    </div>
    <div class="jobIntroduce">
        <h4>职位介绍</h4>

        <p>
            技能要求：${job.skill}
        </p>

        <p>
            招聘人数：${job.person_count}
        </p>

        <p>
            职位描述：${job.description}
        </p>

        <p>
            工作时间：
        <table id="table" class="weekTable">
            <tr>
                <td>星期一</td>
                <td>星期二</td>
                <td>星期三</td>
                <td>星期四</td>
                <td>星期五</td>
                <td>星期六</td>
                <td>星期日</td>
            </tr>
            <tr id="week">
                <td><input type="checkbox"/></td>
                <td><input type="checkbox"/></td>
                <td><input type="checkbox"/></td>
                <td><input type="checkbox"/></td>
                <td><input type="checkbox"/></td>
                <td><input type="checkbox"/></td>
                <td><input type="checkbox"/></td>
            </tr>
        </table>
        </p>
    </div>
    <div class="companyIntroduce">
        <h4>公司介绍</h4>

        <p>${job.post_company.company_name}</p>

        <p>公司地址：${job.post_company.address}</p>

        <p>公司简介：${job.post_company.introduce}</p>

        <p>公司规模：${job.post_company.scope}</p>

        <p>联系人：${job.post_company.name}</p>

        <p>手机号：${job.post_company.phone}</p>

        <p>邮箱：${job.post_company.email}</p>

        <div id="container"></div>
    </div>
    <div class="allJobs">
        <h4>该公司所有职位</h4>
        <c:forEach var="item" items="${requestScope.jobs}">
            <div class="job_item" style="display: block">
                <table>
                    <tr>
                        <td width="30%"><a href="#" class="link">${item.name}</a></td>
                        <td width="30%" class="font3">
                            <fmt:formatDate value="${item.post_time}" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
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
    <div class="otherJobs">
        <h4>职位推荐</h4>
    </div>
</div>
<div id="rightDiv">
    <div class="companyLogo">
        <img src="${root}/images/${job.post_company.logo}">
    </div>
    <div class="comment">
        <h4>评论列表</h4>

        <div id="content">

        </div>
        <c:if test="${count != 0}">
            <nav style="margin: 0 auto" id="page">
                <ul class="pagination pagination-sm">
                    <li>
                        <a href="javascript:void(0)" aria-label="Previous" id="pre">&laquo;</a>
                    </li>
                    <li class="active" id="first"><a href="javascript:void(0)" onclick="loadComments(1)">1</a></li>
                    <li>
                        <a href="javascript:void(0)" aria-label="Next" id="next">&raquo;</a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>

<script type="application/javascript">

    //记录收藏按钮的状态
    var flag = true;
    //页数
    var totalPage =
    ${count}/
    10;
    totalPage = Math.floor(totalPage) + 1;
    //当前页
    var currentPage = 1;

    function initMap() {
        var map = new BMap.Map("container");          // 创建地图实例
        var point = new BMap.Point(${job.post_company.x}, ${job.post_company.y});  // 创建点坐标
        map.centerAndZoom(point, 15);               // 初始化地图，设置中心点坐标和地图级别
        var opts = {type: BMAP_NAVIGATION_CONTROL_LARGE};
        map.addControl(new BMap.NavigationControl(opts));
        var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
        map.addControl(top_left_control);
        map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
        map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
        var marker = new BMap.Marker(point);        // 创建标注
        map.addOverlay(marker);                     // 将标注添加到地图中
    }

    $(function () {
        flag = ${requestScope.collection != null};
        initMap();
        var spareStr = parseInt(${requestScope.job.work_time}).toString(2);
        var timeLength = spareStr.length;
        if (spareStr.length < 7) {
            for (var i = 0; i < 7 - timeLength; i++) {
                spareStr = "0" + spareStr;
            }
        } else {
            spareStr = spareStr.substr(spareStr.length - 7);
        }

        var week = $("#week td :checkbox");

        for (var i = 0; i < spareStr.length; i++) {
            var c = spareStr.charAt(i);
            week.eq(i).attr("checked", c == '1');
        }
        $(":checkbox").attr("disabled", "disabled");

        loadComments(1);

        for (var i = totalPage; i > 1; i--) {
            $("#first").after("<li><a href='javascript:void(0)'>" + i + "</a></li>");
        }

        setPages();

        $(".pagination li a").click(function () {
            var p = $(this).text();
            if (jQuery.isNumeric(p)) {
                loadComments(p);
                currentPage = p;
                setPages();
            }
        });
    });

    $("#pre").click(function () {
        if (currentPage > 1) {
            currentPage -= 1;
            loadComments(currentPage);
            setPages();
        }
    });

    $("#next").click(function () {
        if (currentPage < totalPage) {
            currentPage += 1;
            loadComments(currentPage);
            setPages();
        }
    });

    //设置上下页码
    function setPages() {
        var lis = $("#page li");
        lis.removeClass("active");
        for (var i = 0; i < lis.length; i++) {
            if (lis.eq(i).text() == currentPage) {
                lis.eq(i).addClass("active");
            }
        }
    }

    $("#collect").click(function () {
        if (${sessionScope.user == null}) {
            window.location = "${root}/user/toLogin.do?from=" + window.location.href;
        } else {
            flag = !flag;
            if (flag) {
                $("#collect").css("color", "red");
            } else {
                $("#collect").css("color", "#888");
            }
            $.post("${root}/job/updateCollection.do", {
                collection: flag,
                j_id:${job.id}
            }, function (data) {
                if (data.msg) {
                    window.location = "${root}/user/toLogin.do?from=" + window.location.href;
                }
            }, "JSON");
        }
    });

    $("#apply").click(function () {
        if (${sessionScope.user == null}) {
            window.location = "${root}/user/toLogin.do?from=" + window.location.href;
        } else {
            $.post("${root}/job/applyJob.do", {
                j_id:${job.id}
            }, function (data) {
                if (data.msg) {
                    window.location = "${root}/user/toLogin.do?from=" + window.location.href;
                } else {
                    window.location = "${root}/job/applySuccess.do";
                }
            }, "JSON");
        }
    });

    //ajax加载评论
    function loadComments(page) {
        $.post("${root}/job/getComments.do", {
            id:${requestScope.job.id},
            page: page
        }, function (data) {
            $("#content").html("");
            for (var i = 0; i < data.length; i++) {
                var date = new Date(data[i].c_time.time);
                var time = date.Format("yyyy-MM-dd hh:mm:ss");
                var str = "<div>" +
                        "<img src='${root}/images/" + data[i].user.photo_src + "' class='headPhoto'>" +
                        "<span>" + time + "</span>" +
                        "</div>" +
                        "<div class='contentDiv'>" +
                        "<p>" + data[i].content + "</p>" +
                        "</div>";
                $("#content").append(str);
            }
        }, "JSON");
    }
</script>
</body>
</html>

