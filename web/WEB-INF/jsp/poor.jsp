<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>贫困生认证</title>
    <%@include file="common/head.jsp"%>
    <link href="http://g.alicdn.com/sj/dpl/1.5.1/css/sui.min.css" rel="stylesheet">
    <script type="text/javascript" src="http://g.alicdn.com/sj/dpl/1.5.1/js/sui.min.js"></script>
</head>
<body>
<div class="big">
    <jsp:include page="header.jsp"></jsp:include>
    <div class="container">
        <div class="row">
            <div class="col-md-3 col-md-offset-1">
                <div class="list-group">
                    <a class="list-group-item" href="${root}/user/info.do">
                        <i class="fa fa-user fa-fw"></i>&nbsp; 我的资料
                    </a>
                    <a class="list-group-item" href="${root}/user/resume.do">
                        <i class="fa fa-files-o fa-fw"></i>&nbsp; 我的简历
                    </a>
                    <a class="list-group-item" href="${root}/user/apply.do">
                        <i class="fa fa-comments fa-fw"></i>&nbsp; 求职进展
                    </a>
                    <a class="list-group-item active" href="${root}/user/poor.do">
                        <i class="fa fa-user-secret fa-fw"></i>&nbsp; 贫困生认证
                    </a>
                    <a class="list-group-item" href="${root}/user/collection.do">
                        <i class="fa fa-star fa-fw"></i>&nbsp; 我的收藏
                    </a>
                    <a class="list-group-item" href="${root}/user/secret.do">
                        <i class="fa fa-lock fa-fw"></i>&nbsp; 隐私设置
                    </a>
                    <a class="list-group-item" href="${root}/user/setting.do">
                        <i class="fa fa-cog fa-fw"></i>&nbsp; 账号设置
                    </a>
                </div>
            </div>
            <div class="col-lg-6">
                <h4>贫困生认证</h4>
                <hr>

                <div class="sui-steps steps-auto">
                    <c:if test="${poor == null || poor.status == 0}">
                        <div class="wrap">
                            <div class="current">
                                <label>
                                    <span class="round">1</span>
                                    <span>第一步 资料填写</span>
                                </label>
                                <i class="triangle-right-bg"></i><i class="triangle-right"></i>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${poor != null && poor.status != 0}">
                        <div class="wrap">
                            <div class="finished">
                                <label>
                                    <span class="round"><i class="sui-icon icon-pc-right"></i></span>
                                    <span>第一步 资料填写</span>
                                </label>
                                <i class="triangle-right-bg"></i><i class="triangle-right"></i>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${poor == null || poor.status == 0}">
                        <div class="wrap">
                            <div class="todo">
                                <label>
                                    <span class="round">2</span><span>第二步 贫困审核</span>
                                </label>
                            </div>
                        </div>
                        <div class="wrap">
                            <div class="todo">
                                <label>
                                    <span class="round">3</span><span>第三步 审核成功</span>
                                </label>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${poor != null && poor.status == 1}">
                        <div class="wrap">
                            <div class="current">
                                <label>
                                    <span class="round">2</span><span>第二步 贫困审核</span>
                                </label>
                                <i class="triangle-right-bg"></i><i class="triangle-right"></i>
                            </div>
                        </div>
                        <div class="wrap">
                            <div class="todo">
                                <label>
                                    <span class="round">3</span><span>第三步 审核成功</span>
                                </label>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${poor != null && poor.status == 2}">
                        <div class="wrap">
                            <div class="finished">
                                <label>
                                    <span class="round"><i
                                            class="sui-icon icon-pc-right"></i></span><span>第二步 贫困审核</span>
                                </label>
                                <i class="triangle-right-bg"></i><i class="triangle-right"></i>
                            </div>
                        </div>
                        <div class="wrap">
                            <div class="finished">
                                <label>
                                    <span class="round">3</span><span>第三步 审核成功</span>
                                </label>
                            </div>
                        </div>
                    </c:if>
                </div>
                <form class="form-horizontal" action="${root}/user/poor_confirm.do" enctype="multipart/form-data"
                      method="post">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">学号:</label>

                        <div class="col-sm-8">
                            <p class="form-control-static">${sessionScope.user.school_num}</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;名:</label>

                        <div class="col-sm-8">
                            <c:if test="${poor == null || poor.status == 0}">
                                <input type="text" class="form-control" name="name" placeholder="姓名"
                                       value="${poor.name}">
                            </c:if>
                            <c:if test="${poor != null && poor.status != 0}">
                                <p class="form-control-static">${poor.name}</p>
                            </c:if>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email:</label>

                        <div class="col-sm-8">
                            <c:if test="${poor == null || poor.status == 0}">
                                <input type="email" class="form-control" name="email" placeholder="电子邮箱"
                                       value="${poor.email}">
                            </c:if>
                            <c:if test="${poor != null && poor.status != 0}">
                                <p class="form-control-static">${poor.email}</p>
                            </c:if>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">专业:</label>

                        <c:if test="${poor == null || poor.status == 0}">
                            <div class="col-sm-4">
                                <select class="form-control" id="school"></select>
                            </div>
                            <div class="col-sm-4">
                                <select class="form-control" name="major" id="major"></select>
                            </div>
                        </c:if>

                        <c:if test="${poor != null && poor.status != 0}">
                            <div class="col-sm-8">
                                <p class="form-control-static">${poor.major.major}</p>
                            </div>
                        </c:if>
                    </div>
                    <div class="form-group">
                        <label for="file" class="col-sm-2 control-label">证明照片:</label>

                        <div class="col-sm-8">
                            <c:if test="${poor ==null || poor.status == 0}">
                                <input type="file" id="file" name="file">
                            </c:if>
                            <c:if test="${poor !=null &&poor.status != 0}">
                                <img src="${root}/images/${poor.src}" alt="暂无图片"/>
                            </c:if>
                        </div>
                    </div>
                    <c:if test="${poor == null || poor.status == 0}">
                        <div class="col-sm-6" style="text-align: center">
                            <button type="submit" class="btn btn-primary" style="width: 150px"
                                    onclick="return setData()">
                                <i class="fa fa-floppy-o"></i> 确定
                            </button>
                        </div>
                    </c:if>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>

<script type="application/javascript">
    $(function () {
        loadSchoolData();
    });

    //加载学院数据
    function loadSchoolData() {
        $.getJSON("${root}/job/school_data.do", function (data) {
            schoolData = data;
            data.forEach(function (e) {
                $("#school").append("<option value='" + e.id + "'>" + e.school + "</option>");

                $("#school").change(function () {
                    var s = $("#school").val();
                    for (var i = 0; i < schoolData.length; i++) {
                        if (schoolData[i].id == s) {
                            $("#major").html("");
                            for (var j = 0; j < schoolData[i].majors.length; j++) {
                                var m = schoolData[i].majors[j];
                                $("#major").append("<option value='" + m.id + "'>" + m.major + "</option>");
                            }
                            break;
                        }
                    }
                });
            });
            $("#school").change();
        });
    }
</script>
</body>
</html>

