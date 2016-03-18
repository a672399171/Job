<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>简历详情</title>
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
                    <label class="col-sm-2 control-label">姓名</label>

                    <div class="col-sm-10">
                        <p class="form-control-static">${requestScope.resume.name}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">性别</label>

                    <div class="col-sm-10" id="typeDiv">
                        <p class="form-control-static">${requestScope.resume.sex}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">出生日期</label>

                    <div class="col-sm-10">
                        <p class="form-control-static">
                            <fmt:formatDate value="${requestScope.resume.birthday}" pattern="yyyy-MM-dd"></fmt:formatDate>
                        </p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">手机号</label>

                    <div class="col-sm-10">
                        <p class="form-control-static">${requestScope.resume.phone}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">专业</label>

                    <div class="col-sm-10">
                        <p class="form-control-static">${requestScope.resume.major.school.school} ${requestScope.resume.major.major}专业</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">年级</label>

                    <div class="col-sm-10">
                        <p class="form-control-static">${requestScope.resume.grade}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">籍贯</label>

                    <div class="col-sm-10">
                        <p class="form-control-static">${requestScope.resume.province} ${requestScope.resume.city}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">邮箱</label>

                    <div class="col-sm-10">
                        <p class="form-control-static">${requestScope.resume.email}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">自我介绍</label>

                    <div class="col-sm-10">
                        <p class="form-control-static">${requestScope.resume.introduce}</p>
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
            </form>
        </div>
    </div>
</div>

<script type="application/javascript">
    $(function() {
        var spareStr = "${requestScope.resume.spare_time}";

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
