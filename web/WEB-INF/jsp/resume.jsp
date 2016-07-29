<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>个人简历</title>
    <%@include file="common/head.jsp" %>
    <script src="/resources/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <script src="/resources/bootstrapvalidator/js/language/zh_CN.js"></script>
    <script src="/resources/js/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
    <script src="/resources/js/bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN.min.js"></script>
    <script src="/resources/scripts/vue.js"></script>
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
<div class="big container">
    <%@include file="/WEB-INF/jsp/header.jsp" %>
    <div class="row">
        <div class="col-xs-3 col-xs-offset-1">
            <div class="list-group">
                <a class="list-group-item " href="/user/info">
                    <i class="fa fa-user fa-fw"></i>&nbsp; 我的资料
                </a>
                <a class="list-group-item active" href="/user/resume">
                    <i class="fa fa-files-o fa-fw"></i>&nbsp; 我的简历
                </a>
                <a class="list-group-item" href="/user/apply">
                    <i class="fa fa-comments fa-fw"></i>&nbsp; 求职进展
                </a>
                <a class="list-group-item" href="/user/poor">
                    <i class="fa fa-user-secret fa-fw"></i>&nbsp; 贫困生认证
                </a>
                <a class="list-group-item" href="/user/collection">
                    <i class="fa fa-star fa-fw"></i>&nbsp; 我的收藏
                </a>
                <a class="list-group-item" href="/user/secret">
                    <i class="fa fa-lock fa-fw"></i>&nbsp; 隐私设置
                </a>
                <a class="list-group-item" href="/user/setting">
                    <i class="fa fa-cog fa-fw"></i>&nbsp; 账号设置
                </a>
            </div>
        </div>
        <div class="col-xs-6" id="resumeData">
            <h4>我的简历</h4>
            <hr>
            <form class="form-horizontal" action="/user/saveOrUpdateResume.do" id="form" method="post">
                <div class="form-group">
                    <label class="col-xs-2 control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;名:</label>

                    <div class="col-xs-8">
                        <input type="text" class="form-control" name="name" placeholder="姓名" v-model="resume.name">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">性&nbsp;&nbsp;&nbsp;&nbsp;别:</label>

                    <div class="col-xs-8">
                        <label class="radio-inline">
                            <input type="radio" name="sex" value="男" v-model="resume.sex"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="sex" value="女" v-model="resume.sex"> 女
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="birthday" class="col-xs-2 control-label">出生日期:</label>

                    <div class="col-xs-8">
                        <input type="text" class="form-control" id="birthday" name="birthday" placeholder="出生日期"
                               readonly v-model="resume.birthday" data-toggle="datepicker">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">籍贯:</label>

                    <div class="col-xs-4">
                        <select class="form-control" id="province" name="province" v-model="resume.province"></select>
                    </div>
                    <div class=col-xs-4>
                        <select class="form-control" id="city" name="city" v-model="resume.city"></select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="email" class="col-xs-2 control-label">Email:</label>

                    <div class="col-xs-8">
                        <input type="email" class="form-control" id="email" name="email" placeholder="电子邮箱"
                               v-model="resume.email">
                    </div>
                </div>
                <div class="form-group">
                    <label for="phone" class="col-xs-2 control-label">手机号码:</label>

                    <div class="col-xs-8">
                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="手机号"
                               v-model="resume.phone">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">年级:</label>

                    <div class="col-xs-4">
                        <select class="form-control" name="grade" id="grade" v-model="resume.grade"></select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">专业:</label>

                    <div class="col-xs-4">
                        <select class="form-control" id="school" v-model="resume.major.school.school"></select>
                    </div>
                    <div class="col-xs-4">
                        <select class="form-control" name="major_id" id="major" v-model="resume.major.major"></select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">空余时间:</label>

                    <div class="col-xs-10">
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
                                <td><input type="checkbox" value="1" v-model="times"/></td>
                                <td><input type="checkbox" value="2" v-model="times"/></td>
                                <td><input type="checkbox" value="3" v-model="times"/></td>
                                <td><input type="checkbox" value="4" v-model="times"/></td>
                                <td><input type="checkbox" value="5" v-model="times"/></td>
                                <td><input type="checkbox" value="6" v-model="times"/></td>
                                <td><input type="checkbox" value="7" v-model="times"/></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">自我介绍:</label>

                    <div class="col-xs-8">
                        <textarea class="form-control" rows="6" name="introduce" v-model="resume.introduce"
                                  placeholder="说出你的亮点，说不好人家就看上你了哦!"></textarea>
                    </div>
                </div>
                <h4>求职意向</h4>
                <hr>
                <div class="form-group">
                    <label class="col-xs-2 control-label">简历标题:</label>

                    <div class="col-xs-8">
                        <input type="text" class="form-control" name="title" placeholder="如：求职销售经理，2年经验"
                               v-model="resume.title"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">职位类型:</label>

                    <div class="col-xs-10" id="typeDiv" style="height: 200px">
                        <div style="color: #2a6496" id="mySelect"></div>
                        <div id="leftDiv">
                            <ul></ul>
                        </div>
                        <div id="rightDiv">
                            <ul></ul>
                        </div>
                    </div>
                    <span style="color: red">最多可选三个</span>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">期望月薪:</label>

                    <div class="col-xs-4">
                        <select class="form-control" name="salary" id="salary" v-model="resume.salary">
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

                <div class="col-xs-6" style="text-align: center">
                    <button type="submit" class="btn btn-primary" onclick="return setData()" style="width: 150px">
                        <i class="fa fa-floppy-o"></i> 保存
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>

<script type="application/javascript">
    var provinceData = undefined;
    var schoolData = undefined;
    var typeData = undefined;
    var mytypes = undefined;
    var positions = [];

    $(function () {
        /*if ("
        ${requestScope.resume.job_type}".trim() != "") {
         mytypes = "
        ${requestScope.resume.job_type}".split("#");
         $("#mySelect").text()
         } else {
         mytypes = [];
         }
        <c:forEach items="${requestScope.resume.positions}" var="item">
         positions.push("
        ${item.name}");
        </c:forEach>

         showMySelected();

         $('#birthday').datepicker({
         format: 'yyyy-mm-dd',
         autoclose: true,
         language: 'zh-CN'
         });

         loadSchoolData();
         loadTypeData();*/
        initData();
        loadProvinceData(initVue);
    });

    function initVue() {
        $.get('/user/resume/${sessionScope.user.id}', function (data) {
            var spare_time = data.data.resume.spare_time;
            var times = spare_time.toString(2).split('');
            if (times.length < 7) {
                times.splice(0, 7 - times.length, '0');
            }
            for (var i = 0; i < times.length; i++) {
                if (times[i] === '1') {
                    times.push(i + 7 - times.length);
                }
            }

            if (data.success) {
                new Vue({
                    el: '#resumeData',
                    data: {
                        resume: data.data.resume,
                        times: times
                    }
                });
            }
        }, 'JSON');
    }

    //显示当前已选的类型
    function showMySelected() {
        var str = positions.join("、");
        $("#mySelect").text(str);
    }

    //加载省市信息
    function loadProvinceData(callback) {
        $.getJSON("/resources/json/city.json", function (data) {
            provinceData = data;
            data.forEach(function (e) {
                var provinceSelect = $("#province");
                provinceSelect.append("<option value='" + e.province + "'>" + e.province + "</option>")
            });
            $("#province").change();
            callback();
        });
    }

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
                                var checkBox = $("<input type='checkbox' data='" + m.id + "' text='" + m.label + "' onclick='check(this)' />");
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
            }
            if (positions[i] == $(e).attr("text")) {
                positions.splice(i, 1);
            }
        }
        if ($(e).is(":checked")) {
            if (mytypes.length >= 3) {
                alert("不能超过三个！");
                $(e).attr("checked", false);
            } else {
                mytypes.push($(e).attr("data"));
                positions.push($(e).attr("text"))
            }
        }
        showMySelected();
    }

    //加载学院数据
    function loadSchoolData() {
        $.getJSON("/job/schoolData", function (data) {
            data.forEach(function (e) {
                if (e.id == "${requestScope.resume.major.school.id}") {
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
            $("#school").change();
        });
    }

    //初始化选中数据
    function initData() {
        var year = new Date().getFullYear();
        for (var i = year - 8; i <= year; i++) {
            $("#grade").append("<option value='" + i + "'>" + i + "</option>");
        }

        /*
         var typeArray = "
        ${resume.job_type}".split("#");

         var types = $("#typeDiv :checkbox");

         for (var i = 0; i < types.length; i++) {
         if ($.inArray(types.eq(i).val(), typeArray) != -1) {
         types.eq(i).attr("checked", true);
         } else {
         types.eq(i).attr("checked", false);
         }
         }*/
    }

    $("#province").change(function () {
        var citySelect = $("#city");
        citySelect.html("");
        provinceData.forEach(function (e) {
            if (e.province == $("#province").val()) {
                e.citys.forEach(function (city) {
                    citySelect.append("<option value='" + city + "'>" + city + "</option>")
                });
                return;
            }
        });
    });

    $('#form').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            name: {
                message: '姓名不能为空',
                validators: {
                    notEmpty: {
                        message: '姓名不能为空'
                    },
                    stringLength: {
                        min: 0,
                        max: 20,
                        message: '姓名为0-20位之间'
                    }
                }
            },
            title: {
                message: '简历标题不能为空',
                validators: {
                    notEmpty: {
                        message: '简历标题不能为空'
                    },
                    stringLength: {
                        min: 0,
                        max: 50,
                        message: '简历标题为0-50位之间'
                    }
                }
            },
            phone: {
                message: '手机号码不能为空',
                validators: {
                    notEmpty: {
                        message: '手机号码不能为空'
                    },
                    regexp: {
                        regexp: /^[0-9_\.]{11}$/,
                        message: '手机号码格式不正确'
                    }
                }
            }
        }
    });
</script>
</body>
</html>

