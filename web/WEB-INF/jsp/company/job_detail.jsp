<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>职位信息</title>
    <%@include file="../common/head.jsp"%>
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
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-2 control-label">职位名称</label>

                    <div class="col-sm-10">
                        <p class="form-control-static">${requestScope.job.name}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">职位类型</label>

                    <div class="col-sm-10" id="typeDiv">
                        <p class="form-control-static">${requestScope.job.type.name}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">月薪范围</label>

                    <div class="col-sm-10">
                        <p class="form-control-static">${requestScope.job.low_salary}-${requestScope.job.high_salary}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">职位描述</label>

                    <div class="col-sm-10">
                        <p class="form-control-static">${requestScope.job.description}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">招聘人数</label>

                    <div class="col-sm-10">
                        <p class="form-control-static">${requestScope.job.person_count}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">技能要求</label>

                    <div class="col-sm-10">
                        <p class="form-control-static">${requestScope.job.skill}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">职位标签</label>

                    <div class="col-sm-10">
                        <p class="form-control-static">${requestScope.job.tag}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">工作时间</label>

                    <div class="col-sm-10">
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
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="../common/footer.jsp"%>
<script type="application/javascript">
    $(function() {
        $("#hrefUl li a").removeClass("activeTitle");
        $("#job_manage a").addClass("activeTitle");

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
    });
</script>
</body>
</html>

