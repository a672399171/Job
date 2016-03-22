<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>搜索简历</title>
    <script type="text/javascript"
            src="${root}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${root}/js/jquery.fullPage.min.js"></script>
    <link rel="stylesheet" href="${root}/bootstrap-3.3.4-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${root}/bootstrapvalidator/css/bootstrapValidator.min.css">
    <link rel="stylesheet" href="${root}/font-awesome-4.3.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${root}/css/common.css"/>
    <script src="${root}/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
    <script src="${root}/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <script src="${root}/js/ajaxfileupload.js"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="container" id="container">
    <div class="row">
        <div class="col-md-12" id="stBar">
            搜索到0份简历
        </div>
    </div>
    <div class="row selectType" id="gradeDiv">
        <div class="col-md-1">
            年级:
        </div>
        <div class="col-md-11">
            <ul>
                <li class="on">不限</li>
                <li>2010</li>
                <li>2011</li>
                <li>2012</li>
                <li>2013</li>
                <li>2014</li>
                <li>2015</li>
            </ul>
        </div>
    </div>
    <div class="row selectType" id="timeDiv">
        <div class="col-md-1">
            空余时间:
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
            期望月薪:
        </div>
        <div class="col-md-11">
            <ul>
                <li class="on">不限</li>
                <li>500以下</li>
                <li>500-1000</li>
                <li>1000-2000</li>
                <li>2000-3000</li>
                <li>3000-4000</li>
                <li>4000以上</li>
            </ul>
        </div>
    </div>
    <div class="row selectType" id="schoolDiv">
        <div class="col-md-1">
            院系:
        </div>
        <div class="col-md-11">
            <ul>
                <li class="on">不限</li>
                <c:forEach items="${requestScope.schools}" var="item">
                    <li id="${item.id}">${item.school}</li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="resumeTable">
                <thead>
                <tr>
                    <td>期望职位</td>
                    <td>姓名</td>
                    <td>性别</td>
                    <td>年级</td>
                    <td>专业</td>
                    <td>期望月薪</td>
                    <td>操作</td>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>

<script type="application/javascript">
    $(function () {
        initData(0, "00000000000000", "", 0);
    });

    $("#gradeDiv li").click(function () {
        $("#gradeDiv li").removeClass("on");
        $(this).addClass("on");
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
    });
    $("#salaryDiv li").click(function () {
        $("#salaryDiv li").removeClass("on");
        $(this).addClass("on");
    });
    $("#schoolDiv li").click(function () {
        $("#schoolDiv li").removeClass("on");
        $(this).addClass("on");
    });

    function initData(grade, spare_time, salary, school) {
        $.post("${root}/job/searchResume.do",
                {
                    grade: grade,
                    spare_time: spare_time,
                    salary: salary,
                    school: school
                }, function (data) {
                    $("#resumeTable tbody").html("");
                    for (var i = 0; i < data.resumes.length; i++) {
                        var resume = data.resumes[i];
                        var tr = $("<tr>" +
                                "<td>" + resume.job_type + "</td>" +
                                "<td>" + resume.name + "</td>" +
                                "<td>" + resume.sex + "</td>" +
                                "<td>" + resume.grade + "</td>" +
                                "<td>" + resume.major.major + "</td>" +
                                "<td>" + resume.salary + "</td>" +
                                "<td><a href='${root}/job/resume_detail.do?id=" + resume.id + "'>详情</a></td>" +
                                "</tr>"
                        );
                        $("#resumeTable tbody").append(tr);
                    }
                }, "JSON");
    }

    $(".selectType li").click(function () {
        initData(getGrade(), getSpareTime(), getSalary(), getSchool());
    });

    function getSpareTime() {
        var time = "";
        if ($("#first").hasClass("on")) {
            time = "0000000";
        } else {
            for (var i = 1; i < $("#timeDiv li").length; i++) {
                if ($("#timeDiv li").eq(i).hasClass("on")) {
                    time += "1";
                } else {
                    time += "0";
                }
            }
        }
        return time;
    }

    function getGrade() {
        var grade = 0;
        for (var i = 0; i < $("#gradeDiv li").length; i++) {
            if ($("#gradeDiv li").eq(i).hasClass("on")) {
                if (i != 0) {
                    grade = $("#gradeDiv li").eq(i).text();
                }
                break;
            }
        }
        return grade;
    }

    function getSalary() {
        var salary = "";
        for (var i = 0; i < $("#salaryDiv li").length; i++) {
            if ($("#salaryDiv li").eq(i).hasClass("on")) {
                if (i != 0) {
                    salary = $("#salaryDiv li").eq(i).text();
                    break;
                }
            }
        }
        return salary;
    }

    function getSchool() {
        var school = 0;

        for (var i = 0; i < $("#schoolDiv li").length; i++) {
            if ($("#schoolDiv li").eq(i).hasClass("on")) {
                if (i != 0) {
                    school = parseInt($("#schoolDiv li").eq(i).attr("id"));
                    break;
                }
            }
        }

        console.log(school);

        return school;
    }
</script>
</body>
</html>

