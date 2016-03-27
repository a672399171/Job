<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>职位信息</title>
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
            </form>
        </div>
    </div>
</div>

<script type="application/javascript">
    $(function() {
        var spareStr = "${requestScope.job.work_time}";

        var am = $("#am td :checkbox");
        var pm = $("#pm td :checkbox");

        for (var i = 0; i < spareStr.length; i++) {
            var c = spareStr.charAt(i);
            if (i < 7) {
                am.eq(i).attr("checked", c == '1');
            } else {
                pm.eq(i - 7).attr("checked", c == '1');
            }
        }
        $(":checkbox").attr("disabled","disabled");
    });
</script>
</body>
</html>

