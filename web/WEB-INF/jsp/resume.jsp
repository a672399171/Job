<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>个人简历</title>
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
    <style type="text/css">
        #typeDiv li:hover {
            cursor: pointer;
            background: grey;
        }

        #typeDiv ul {
            list-style-type: none;
            padding: 0;
        }

        #leftDiv, #rightDiv {
            width: 200px;
            height: 100%;
            float: left;
            border: 1px black solid;
            overflow: auto;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="container">
    <div class="row">
        <div class="col-md-3 col-md-offset-1">
            <div class="list-group">
                <a class="list-group-item" href="${root}/user/info.do">
                    <i class="fa fa-user fa-fw"></i>&nbsp; 我的资料
                </a>
                <a class="list-group-item active" href="${root}/user/resume.do">
                    <i class="fa fa-files-o fa-fw"></i>&nbsp; 我的简历
                </a>
                <a class="list-group-item" href="#">
                    <i class="fa fa-comments fa-fw"></i>&nbsp; 求职进展
                </a>
                <a class="list-group-item" href="${root}/user/poor.do">
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
            <h4>我的简历</h4>
            <hr>
            <form class="form-horizontal" action="${root}/user/saveOrUpdateResume.do" method="post">
                <div class="form-group">
                    <label class="col-sm-2 control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;名:</label>

                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="name" placeholder="姓名" value="${resume.name}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">性&nbsp;&nbsp;&nbsp;&nbsp;别:</label>

                    <div class="col-sm-8">
                        <c:choose>
                            <c:when test="${resume == null || resume.sex == null}">
                                <c:choose>
                                    <c:when test="${sessionScope.user.sex == '男'}">
                                        <label class="radio-inline">
                                            <input type="radio" name="sex" value="男" checked> 男
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="sex" value="女"> 女
                                        </label>
                                    </c:when>
                                    <c:otherwise>
                                        <label class="radio-inline">
                                            <input type="radio" name="sex" value="男"> 男
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="sex" value="女" checked> 女
                                        </label>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${resume.sex == '男'}">
                                        <label class="radio-inline">
                                            <input type="radio" name="sex" value="男" checked> 男
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="sex" value="女"> 女
                                        </label>
                                    </c:when>
                                    <c:otherwise>
                                        <label class="radio-inline">
                                            <input type="radio" name="sex" value="男"> 男
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="sex" value="女" checked> 女
                                        </label>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label for="birthday" class="col-sm-2 control-label">出生日期:</label>

                    <div class="col-sm-8">
                        <input type="date" class="form-control" name="birthday" id="birthday" placeholder="出生日期"
                               value="<fmt:formatDate value='${resume.birthday}' pattern='yyyy-MM-dd'></fmt:formatDate>"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">籍贯:</label>

                    <div class="col-sm-4">
                        <select class="form-control" id="province" name="province">
                            <option value="">选择省份</option>
                        </select>
                    </div>
                    <div class=col-sm-4>
                        <select class="form-control" id="city" name="city">
                            <option value="">选择城市</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="email" class="col-sm-2 control-label">Email:</label>

                    <div class="col-sm-8">
                        <input type="email" class="form-control" id="email" name="email" placeholder="电子邮箱"
                               value="${resume.email}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="phone" class="col-sm-2 control-label">手机号码:</label>

                    <div class="col-sm-8">
                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="手机号"
                               value="${resume.phone}">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">年级:</label>

                    <div class="col-sm-4">
                        <select class="form-control" name="grade" id="grade"></select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">专业:</label>

                    <div class="col-sm-4">
                        <select class="form-control" id="school"></select>
                    </div>
                    <div class="col-sm-4">
                        <select class="form-control" name="major_id" id="major"></select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">空余时间:</label>

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
                <div class="form-group">
                    <label class="col-sm-2 control-label">自我介绍:</label>

                    <div class="col-sm-8">
                        <textarea class="form-control" rows="6" name="introduce"
                                  placeholder="说出你的亮点，说不好人家就看上你了哦!">${resume.introduce}</textarea>
                    </div>
                </div>
                <h4>求职意向</h4>
                <hr>
                <div class="form-group">
                    <label class="col-sm-2 control-label">简历标题:</label>

                    <div class="col-sm-8">
                        <input type="text" class="form-control" name="title" placeholder="如：求职销售经理，2年经验"
                               value="${resume.title}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">职位类型:</label>

                    <div class="col-sm-10" id="typeDiv" style="height: 200px">
                        <div id="leftDiv">
                            <ul>

                            </ul>
                        </div>
                        <div id="rightDiv">
                            <ul>

                            </ul>
                        </div>
                    </div>
                    <span style="color: red">最多可选三个</span>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">期望月薪:</label>

                    <div class="col-sm-4">
                        <select class="form-control" name="salary" id="salary">
                            <option value="500元以下">500元以下</option>
                            <option value="500-1000">500-1000</option>
                            <option value="1000-2000">1000-2000</option>
                            <option value="2000-3000">2000-3000</option>
                            <option value="3000-4000">3000-4000</option>
                            <option value="4000元以上">4000元以上</option>
                        </select>
                    </div>
                    元/月
                </div>
                <input type="hidden" name="spare_time" id="spare_time"/>
                <input type="hidden" name="job_type" id="job_type"/>

                <%--<div class="col-sm-6" style="text-align: center">
                    <button type="button" class="btn btn-info" style="width: 150px" onclick="getJobTypes()">预览</button>
                </div>--%>
                <div class="col-sm-6" style="text-align: center">
                    <button type="submit" class="btn btn-primary" style="width: 150px" onclick="return setData()">
                        <i class="fa fa-floppy-o"></i> 保存
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="application/javascript">
    var url = "${root}/json/city.json";
    var schoolData = undefined;
    var typeData = undefined;
    var mytypes = undefined;

    $(function () {

        mytypes = "${requestScope.resume.job_type}".split("#");

        $.getJSON(url, function (data) {
            data.forEach(function (e) {
                var provinceSelect = $("#province");
                provinceSelect.append("<option value='" + e.province + "'>" + e.province + "</option>")
            });
            // 设置select选中某值
            $("#province option[value='" + "${resume.province}" + "']").attr("selected", "selected");
            $("#province").change();
        });

        initData();

        loadSchoolData();

        loadTypeData();
    });

    //加载职位类型数据
    function loadTypeData() {
        $.getJSON("${root}/user/admin/tree_data.do", function (data) {
            typeData = data;
            data.forEach(function (e) {
                $("#leftDiv ul").append("<li>" + e.label + "</li>");
                $("#leftDiv ul li").click(function () {
                    var s = $(this).text();
                    for (var i = 0; i < typeData.length; i++) {
                        if (typeData[i].label == s) {
                            $("#rightDiv ul").html("");
                            for (var j = 0; j < typeData[i].children.length; j++) {
                                var m = typeData[i].children[j];
                                var li = $("<li></li>");
                                var checkBox = $("<input type='checkbox' data='" + m.id + "' onclick='check(this)' />");
                                li.append(checkBox);
                                li.append(m.label);
                                $("#rightDiv ul").append(li);
                                for (var k = 0; k < mytypes.length; k++) {
                                    if (m.id == mytypes[k]) {
                                        checkBox.attr("checked", true);
                                        break;
                                    }
                                }
                            }
                            break;
                        }
                    }
                });
            });
        });
    }

    //chexkbox选择后触发
    function check(e) {
        for (var i = 0; i < mytypes.length; i++) {
            if (mytypes[i] == $(e).attr("data")) {
                mytypes.splice(i, 1);
                return;
            }
        }
        if ($(e).is(":checked")) {
            if (mytypes.length >= 3) {
                alert("不能超过三个！");
                $(e).attr("checked", false);
            } else {
                mytypes.push($(e).attr("data"));
            }
        }
    }

    //加载学院数据
    function loadSchoolData() {
        $.getJSON("${root}/job/school_data.do", function (data) {
            schoolData = data;
            data.forEach(function (e) {
                if (e.id == ${requestScope.resume.major.school.id}) {
                    $("#school").append("<option value='" + e.id + "' selected>" + e.school + "</option>");

                    $("#major").html("");
                    for (var j = 0; j < e.majors.length; j++) {
                        var m = e.majors[j];
                        $("#major").append("<option value='" + m.id + "'>" + m.major + "</option>");
                    }
                } else {
                    $("#school").append("<option value='" + e.id + "'>" + e.school + "</option>");
                }
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
        });
    }

    //初始化选中数据
    function initData() {
        var year = new Date().getFullYear();
        for (var i = year - 8; i <= year; i++) {
            $("#grade").append("<option value='" + i + "'>" + i + "</option>");
        }

        $("#grade option[value='" + "${resume.grade}" + "']").attr("selected", "selected");
        $("#salary option[value='" + "${resume.salary}" + "']").attr("selected", "selected");

        var typeArray = "${resume.job_type}".split("#");

        var types = $("#typeDiv :checkbox");

        //格式化
        var spareStr = parseInt(${requestScope.resume.spare_time}).toString(2);
        var timeLength = spareStr.length;
        if (spareStr.length < 7) {
            for (var i = 0; i < 7 - timeLength; i++) {
                spareStr = "0" + spareStr;
            }
        } else {
            spareStr = spareStr.substr(spareStr.length - 7);
        }
        //console.log(spareStr);
        var week = $("#week td :checkbox");

        for (var i = 0; i < spareStr.length; i++) {
            var c = spareStr.charAt(i);
            week.eq(i).attr("checked", c == '1');
        }

        for (var i = 0; i < types.length; i++) {
            if ($.inArray(types.eq(i).val(), typeArray) != -1) {
                types.eq(i).attr("checked", true);
            } else {
                types.eq(i).attr("checked", false);
            }
        }
    }

    $("#province").change(function () {
        var citySelect = $("#city");
        citySelect.html("");
        citySelect.append("<option value=''>选择城市</option>");
        $.getJSON(url, function (data) {
            data.forEach(function (e) {
                if (e.province == $("#province").val()) {
                    e.citys.forEach(function (city) {
                        citySelect.append("<option value='" + city + "'>" + city + "</option>")
                    });
                    // 设置select选中某值
                    $("#city option[value='" + "${resume.city}" + "']").attr("selected", "selected");
                    return;
                }
            });
        });
    });

    function setData() {
        $("#spare_time").val(getSpareTime());
        $("#job_type").val(mytypes.join("#"));
        return true;
    }

    function getSpareTime() {
        var str = "";
        var am = $("#week td :checkbox");
        for (var i = 0; i < am.length; i++) {
            if (am.eq(i).is(":checked")) {
                str += "1";
            } else {
                str += "0";
            }
        }
        var number = 0;
        for (var i = 1; i < str.length; i++) {
            number += str.charAt(i) * Math.pow(2, 7 - i);
        }
        console.log(str);
        return number;
    }
</script>
</body>
</html>

