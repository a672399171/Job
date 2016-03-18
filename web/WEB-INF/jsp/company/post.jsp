<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>发布新职位</title>
    <script type="text/javascript"
            src="${root}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${root}/js/jquery.fullPage.min.js"></script>
    <link rel="stylesheet" href="${root}/bootstrap-3.3.4-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${root}/bootstrapvalidator/css/bootstrapValidator.min.css">
    <link rel="stylesheet" href="${root}/font-awesome-4.3.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${root}/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="${root}/css/post.css"/>
    <script src="${root}/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
    <script src="${root}/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <script src="${root}/js/ajaxfileupload.js"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div id="bigDiv"></div>
<div class="container" id="container">
    <div class="row">
        <div class="col-md-8">
            <form class="form-horizontal" method="post" action="${root}/job/post_job.do">
                <div class="form-group">
                    <label for="name" class="col-sm-2 control-label">职位名称</label>

                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="name" id="name" placeholder="职位名称">
                    </div>
                </div>
                <div class="form-group">
                    <label for="type" class="col-sm-2 control-label">职位类型</label>

                    <div class="col-sm-10" id="typeDiv">
                        <input type="text" class="form-control" id="type" placeholder="请选择职位类型">

                        <div id="hideJobDiv">
                            <div id="leftList">
                                <ul></ul>
                            </div>
                            <div id="rightList">
                                <ul></ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">月薪范围</label>

                    <div class="col-sm-3">
                        <input type="number" class="form-control" name="low_salary" placeholder="最低月薪">
                    </div>
                    <div class="col-sm-3">
                        <input type="number" class="form-control" name="high_salary" placeholder="最高月薪">
                    </div>
                </div>
                <div class="form-group">
                    <label for="type" class="col-sm-2 control-label">职位描述</label>

                    <div class="col-sm-10">
                        <textarea class="form-control" rows="3" name="description"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">招聘人数</label>

                    <div class="col-sm-10">
                        <input type="number" class="form-control" name="person_count" placeholder="招聘人数">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">技能要求</label>

                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="skill" placeholder="技能要求">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">职位标签</label>

                    <div class="col-sm-10">
                        <a href="javascript:void(0)" class="tag" id="t1">工资日结</a>
                        <a href="javascript:void(0)" class="tag" id="t2">长期兼职</a>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">工作时间</label>

                    <div class="col-sm-10">
                        <table id="table">
                            <tr>
                                <td></td>
                                <td>星期一</td>
                                <td>星期二</td>
                                <td>星期三</td>
                                <td>星期四</td>
                                <td>星期五</td>
                                <td>星期六</td>
                                <td>星期日</td>
                            </tr>
                            <tr id="am">
                                <td>上午</td>
                                <td><input type="checkbox"/></td>
                                <td><input type="checkbox"/></td>
                                <td><input type="checkbox"/></td>
                                <td><input type="checkbox"/></td>
                                <td><input type="checkbox"/></td>
                                <td><input type="checkbox"/></td>
                                <td><input type="checkbox"/></td>
                            </tr>
                            <tr id="pm">
                                <td>下午</td>
                                <td><input type="checkbox"/></td>
                                <td><input type="checkbox"/></td>
                                <td><input type="checkbox"/></td>
                                <td><input type="checkbox"/></td>
                                <td><input type="checkbox"/></td>
                                <td><input type="checkbox"/></td>
                                <td><input type="checkbox"/></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <input type="hidden" name="work_time" id="work_time"/>
                <input type="hidden" name="tag" id="tag"/>
                <input type="hidden" name="type" id="typeHidden"/>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-default" onclick="return setData()">保存职位</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="application/javascript">
    var objs = [];

    $("#typeDiv").click(function () {
        $("#hideJobDiv").show();
        $("#bigDiv").show();
    });
    $(function () {
        $("#bigDiv").width(window.screen.availWidth - 40);
        $("#bigDiv").height(window.screen.availHeight - 40);
        initData();
    });
    $("#rightList ul li").click(function () {
        $("#rightList ul li").css("background", "white");
        $(this).css("background", "grey");
    });

    function initData() {
        $.getJSON("${root}/job/classifies.do", function (data) {
            var classifies = data.classifies;
            var positions = data.positions;
            for (var i = 0; i < classifies.length; i++) {
                var classify = classifies[i];
                var li = $("<li>" + classify.name + "</li>");
                $("#leftList ul").append(li);
                var obj = {
                    classify: classify,
                    positions: []
                };

                for (var j = 0; j < positions.length; j++) {
                    var position = positions[j];
                    if (position.c_id == classify.id) {
                        obj.positions.push(position);
                    }
                }
                objs.push(obj);
            }
            $("#leftList ul li").click(function () {
                $("#leftList ul li").css("background", "white");
                $(this).css("background", "grey");

                $("#rightList ul").html("");
                for (var i = 0; i < objs.length; i++) {
                    var obj = objs[i];
                    if (obj.classify.name == $(this).text()) {
                        for (var j = 0; j < obj.positions.length; j++) {
                            $("#rightList ul").append("<li id='" + obj.positions[j].id + "'>" + obj.positions[j].name + "</li>");
                        }
                        break;
                    }
                }
                $("#rightList ul li").click(function () {
                    $("#rightList ul li").css("background", "white");
                    $(this).css("background", "grey");
                    $("#type").val($(this).text());
                    $("#typeHidden").val($(this).attr("id"));
                    $("#bigDiv").click();
                });
            });
        });
    }

    $("#bigDiv").click(function () {
        $("#hideJobDiv").hide();
        $("#bigDiv").hide();
    });

    $("#type").focus(function () {
        $("#type").blur();
    });

    var t1 = false;
    var t2 = false;

    $("#t1").click(function () {
        if (t1) {
            $(this).css("background", "#F8F8F8");
        } else {
            $(this).css("background", "#A2C2D1");
        }
        t1 = !t1;
    });
    $("#t2").click(function () {
        if (t2) {
            $(this).css("background", "#F8F8F8");
        } else {
            $(this).css("background", "#A2C2D1");
        }
        t2 = !t2;
    });

    function getSpareTime() {
        var str = "";
        var am = $("#am td :checkbox");
        var pm = $("#pm td :checkbox");
        for (var i = 0; i < am.length; i++) {
            if (am.eq(i).is(":checked")) {
                str += "1";
            } else {
                str += "0";
            }
        }
        for (var i = 0; i < pm.length; i++) {
            if (pm.eq(i).is(":checked")) {
                str += "1";
            } else {
                str += "0";
            }
        }
        console.log(str);
        return str;
    }

    function setData() {
        $("#work_time").val(getSpareTime());
        var str = "";
        if (t1) {
            str += $("#t1").text();
        }
        if (t2) {
            str += $("#t2").text();
        }
        $("#tag").val(str);
        return true;
    }
</script>
</body>
</html>

