<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>个人简历</title>
    <%@include file="common/head.jsp" %>
    <link href="http://g.alicdn.com/sj/dpl/1.5.1/css/sui.min.css" rel="stylesheet">
    <script type="text/javascript" src="http://g.alicdn.com/sj/dpl/1.5.1/js/sui.min.js"></script>
    <script src="/resources/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <script src="/resources/bootstrapvalidator/js/language/zh_CN.js"></script>
    <script src="/resources/scripts/vue.js"></script>
    <script src="/resources/js/filters/filters.js"></script>
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
    <%@include file="/WEB-INF/jsp/common/header.jsp" %>
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
            <form class="form-horizontal" id="form" method="post">
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
                               readonly v-model="resume.birthday | timestampFilter 'YYYY-MM-DD'">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">籍贯:</label>

                    <div class="col-xs-4">
                        <select class="form-control" id="province" name="province" v-model="resume.province"
                                v-on:change="changeCities()">
                            <option v-for="item in citys" v-bind:value="item.province">
                                {{ item.province }}
                            </option>
                        </select>
                    </div>
                    <div class=col-xs-4>
                        <select class="form-control" id="city" name="city" v-model="resume.city">
                            <option v-for="item in currentCities" v-bind:value="item">
                                {{ item }}
                            </option>
                        </select>
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
                        <select class="form-control" name="grade" id="grade" v-model="resume.grade">
                            <option v-for="item in grades" v-bind:value="item">
                                {{ item }}
                            </option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">专业:</label>

                    <div class="col-xs-4">
                        <select class="form-control" id="school" v-model="resume.major.school.id"
                                v-on:change="changeMajors()">
                            <option v-bind:value="item.id" v-for="item in schools">{{item.school}}</option>
                        </select>
                    </div>
                    <div class="col-xs-4">
                        <select class="form-control" name="major_id" id="major" v-model="resume.major.id">
                            <option v-bind:value="item.id" v-for="item in currentMajors">{{item.major}}</option>
                        </select>
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
                        <div style="color: #2a6496" id="mySelect">{{ resume.types }}</div>
                        <div id="leftDiv">
                            <ul>
                                <li v-for="item in typeData" v-on:click="changePositions(item)">{{ item.name }}</li>
                            </ul>
                        </div>
                        <div id="rightDiv">
                            <ul>
                                <li v-for="item in currentPositions">
                                    <label>
                                        <input type="checkbox" value="{{item.id}}" v-model="resume.types"/>
                                        {{ item.name }}
                                    </label>
                                </li>
                            </ul>
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

                <div class="col-xs-6" style="text-align: center">
                    <button type="submit" class="btn btn-primary" onclick="return submitHandler()" style="width: 150px">
                        <i class="fa fa-floppy-o"></i> 保存
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/jsp/common/footer.jsp"/>

<script type="application/javascript">
    var typeData = undefined;
    var positions = [];
    var vm = undefined;
    var vueData = {};

    $(function () {
        $('#birthday').datepicker({size: "small"});
        initData();
        initVue();
    });

    function initVue() {
        $.get('/user/resume/${sessionScope.user.id}', function (data) {
            vueData.times = [];
            var spare_time = data.data.resume.spare_time;
            var times = spare_time.toString(2).split('');
            for (var i = 0; i < times.length; i++) {
                if (times[i] === '1') {
                    vueData.times.push(i + 1 + 7 - times.length + "");
                }
            }

            vueData.resume = data.data.resume;
            vueData.resume.types = vueData.resume.job_type.split('#');
            vueData.currentCities = [];
            vueData.currentMajors = [];
            vueData.currentPositions = [];

            changeCurrentCities();
            changeCurrentMajors();
            if (data.success) {
                vm = new Vue({
                    el: '#resumeData',
                    data: vueData,
                    methods: {
                        changeCities: changeCurrentCities,
                        changeMajors: changeCurrentMajors,
                        changePositions: changeCurrentPositions
                    }
                });
            }
        }, 'JSON');
    }

    // 改变城市列表
    function changeCurrentCities() {
        for (var i = 0; i < vueData.citys.length; i++) {
            if (vueData.citys[i].province === vueData.resume.province) {
                vueData.currentCities = vueData.citys[i].citys;
                break;
            }
        }
    }

    // 改变专业列表
    function changeCurrentMajors() {
        for (var i = 0; i < vueData.schools.length; i++) {
            if (vueData.schools[i].id === vueData.resume.major.school.id) {
                vueData.currentMajors = vueData.schools[i].majors;
                break;
            }
        }
    }

    // 改变子类型
    function changeCurrentPositions(item) {
        for (var i = 0; i < vueData.typeData.length; i++) {
            if (vueData.typeData[i].id === item.id) {
                vueData.currentPositions = vueData.typeData[i].positions;
                vm.$set('currentPositions', vueData.typeData[i].positions);
                break;
            }
        }
    }

    //加载省市信息
    function loadProvinceData() {
        $.getJSON("/resources/json/city.json", function (data) {
            vueData.citys = data;
        });
    }

    //加载职位类型数据
    function loadTypeData() {
        $.getJSON("/job/typeData", function (data) {
            vueData.typeData = data;
        });
    }

    //加载学院数据
    function loadSchoolData() {
        $.getJSON("/job/schoolData", function (data) {
            vueData.schools = data;
        });
    }

    //初始化选中数据
    function initData() {
        var grades = [];
        var year = new Date().getFullYear();
        for (var i = year - 8; i <= year; i++) {
            grades.push(i);
        }
        vueData.grades = grades;

        loadProvinceData();
        loadSchoolData();
        loadTypeData();
    }

    function submitHandler() {
        vueData.resume.job_type = vueData.resume.types.join('#');

        vueData.resume.spare_time = 0;
        for (var i = 0; i < vueData.times.length; i++) {
            vueData.resume.spare_time += Math.pow(2, 7 - parseInt(vueData.times[i]));
        }

        $.post('/user/resume', {
            "id": vueData.resume.id,
            "u_id": vueData.resume.u_id,
            "name": vueData.resume.name,
            "sex": vueData.resume.sex,
            "birthday": moment(new Date(vueData.resume.birthday)).format('YYYY-MM-DD'),
            "phone": vueData.resume.phone,
            "major.id": vueData.resume.major.id,
            "major.major": vueData.resume.major.major,
            "major.school.id": vueData.resume.major.school.id,
            "major.school.school": vueData.resume.major.school.school,
            "city": vueData.resume.city,
            "province": vueData.resume.province,
            "introduce": vueData.resume.introduce,
            "salary": vueData.resume.salary,
            "title": vueData.resume.title,
            "email": vueData.resume.email,
            "job_type": vueData.resume.job_type,
            "spare_time": vueData.resume.spare_time,
            "grade":vueData.resume.grade
        }, function (data) {
            if (data.success) {
                window.location.reload();
            } else {
                alert(data.error);
            }
        }, 'JSON');
        return false;
    }

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

