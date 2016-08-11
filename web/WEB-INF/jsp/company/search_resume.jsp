<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>搜索简历</title>
    <link href="http://g.alicdn.com/sj/dpl/1.5.1/css/sui.min.css" rel="stylesheet">
    <%@include file="../common/head.jsp" %>
    <script src="/resources/scripts/vue.js"></script>
    <script src="/resources/js/filters/filters.js"></script>
    <script src="/resources/layer/layer.js"></script>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="container" id="container">
    <div class="row">
        <div class="col-md-12" id="stBar">
            搜索到
            <span style="color: red">{{totalItem}}</span>
            份简历
        </div>
    </div>
    <div class="row selectType" id="gradeDiv">
        <div class="col-md-1">
            年级:
        </div>
        <div class="col-md-11">
            <ul class="sui-tag">
                <li v-bind:class="{'tag-selected':!param.grade}" v-on:click="param.grade=0,load();">不限</li>
                <li v-bind:class="{'tag-selected':param.grade == 2010}" v-on:click="param.grade=2010,load();">2010</li>
                <li v-bind:class="{'tag-selected':param.grade == 2011}" v-on:click="param.grade=2011,load();">2011</li>
                <li v-bind:class="{'tag-selected':param.grade == 2012}" v-on:click="param.grade=2012,load();">2012</li>
                <li v-bind:class="{'tag-selected':param.grade == 2013}" v-on:click="param.grade=2013,load();">2013</li>
                <li v-bind:class="{'tag-selected':param.grade == 2014}" v-on:click="param.grade=2014,load();">2014</li>
                <li v-bind:class="{'tag-selected':param.grade == 2015}" v-on:click="param.grade=2015,load();">2015</li>
            </ul>
        </div>
    </div>
    <div class="row selectType" id="timeDiv">
        <div class="col-md-1">
            空余时间:
        </div>
        <div class="col-md-11">
            <ul class="sui-tag">
                <li v-bind:class="{'tag-selected':!param.time}" v-on:click="param.time=0">不限</li>
                <li v-bind:class="{'tag-selected':(param.time&64)==64}" v-on:click="changeTime(64)">周一</li>
                <li v-bind:class="{'tag-selected':(param.time&32)==32}" v-on:click="changeTime(32)">周二</li>
                <li v-bind:class="{'tag-selected':(param.time&16)==16}" v-on:click="changeTime(16)">周三</li>
                <li v-bind:class="{'tag-selected':(param.time&8)==8}" v-on:click="changeTime(8)">周四</li>
                <li v-bind:class="{'tag-selected':(param.time&4)==4}" v-on:click="changeTime(4)">周五</li>
                <li v-bind:class="{'tag-selected':(param.time&2)==2}" v-on:click="changeTime(2)">周六</li>
                <li v-bind:class="{'tag-selected':(param.time&1)==1}" v-on:click="changeTime(1)">周日</li>
            </ul>
        </div>
    </div>
    <div class="row selectType" id="salaryDiv">
        <div class="col-md-1">
            期望月薪:
        </div>
        <div class="col-md-11">
            <ul class="sui-tag">
                <li v-bind:class="{'tag-selected':!param.salary}" v-on:click="param.salary='',load();">不限</li>
                <li v-bind:class="{'tag-selected':param.salary=='500以下'}" v-on:click="param.salary='500以下',load();">500以下</li>
                <li v-bind:class="{'tag-selected':param.salary=='500-1000'}" v-on:click="param.salary='500-1000',load();">
                    500-1000
                </li>
                <li v-bind:class="{'tag-selected':param.salary=='1000-2000'}" v-on:click="param.salary='1000-2000',load();">
                    1000-2000
                </li>
                <li v-bind:class="{'tag-selected':param.salary=='2000-3000'}" v-on:click="param.salary='2000-3000',load();">
                    2000-3000
                </li>
                <li v-bind:class="{'tag-selected':param.salary=='3000-4000'}" v-on:click="param.salary='3000-4000',load();">
                    3000-4000
                </li>
                <li v-bind:class="{'tag-selected':param.salary=='4000以上'}" v-on:click="param.salary='4000以上',load();">4000以上
                </li>
            </ul>
        </div>
    </div>
    <div class="row selectType" id="schoolDiv">
        <div class="col-md-1">
            院系:
        </div>
        <div class="col-md-11">
            <ul class="sui-tag">
                <li v-bind:class="{'tag-selected':!param.school}" v-on:click="param.school=0,load();">不限</li>
                <li v-bind:class="{'tag-selected':item.id == param.school}" v-for="item in schools"
                    v-on:click="param.school=item.id,load();">
                    {{item.school}}
                </li>
            </ul>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="resumeTable">
                <thead>
                <tr>
                    <td>姓名</td>
                    <td>性别</td>
                    <td>年级</td>
                    <td>专业</td>
                    <td>期望月薪</td>
                    <td>操作</td>
                </tr>
                </thead>
                <tbody>
                <tr v-for="item in list">
                    <td>{{item.name}}</td>
                    <td>{{item.sex}}</td>
                    <td>{{item.grade}}</td>
                    <td>{{item.major.major}}</td>
                    <td>{{item.salary}}</td>
                    <td><a href="javascript:void(0)" v-on:click="openDlg(item.id)">查看简历</a></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <nav style="margin: 0 auto;text-align: center" v-if="totalPage > 1">
        <ul class="pagination pagination-lg">
            <li>
                <a href="javascript:void(0)" aria-label="Previous" v-on:click="load(-1)">&laquo;</a>
            </li>
            <li ng-repeat="p in pageArray" v-bind:class="{active:isCurrentPage(p)}">
                <a href="javascript:void(0)" v-on:click="loadData(p)">{{p}}</a>
            </li>
            <li>
                <a href="javascript:void(0)" aria-label="Next" v-on:click="load(1)">&raquo;</a>
            </li>
        </ul>
    </nav>

    <%--简历预览界面--%>
    <div class="preview container" id="preview">
        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-2 control-label">姓名</label>
                <div class="col-sm-10">
                    <p class="form-control-static">{{currentResume.name}}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">性别</label>
                <div class="col-sm-10">
                    <p class="form-control-static">{{currentResume.sex}}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">生日</label>
                <div class="col-sm-10">
                    <p class="form-control-static">{{currentResume.birthday | timestampFilter 'YYYY-MM-DD'}}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">年级</label>
                <div class="col-sm-10">
                    <p class="form-control-static">{{currentResume.grade}}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">专业</label>
                <div class="col-sm-10">
                    <p class="form-control-static">
                        {{currentResume.major.school.school}}
                        {{currentResume.major.major}}
                    </p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">籍贯</label>
                <div class="col-sm-10">
                    <p class="form-control-static">
                        {{currentResume.province}}
                        {{currentResume.city}}
                    </p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">期望薪资</label>
                <div class="col-sm-10">
                    <p class="form-control-static">{{currentResume.salary}}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">期望工作</label>
                <div class="col-sm-10">
                    <p class="form-control-static">
                    <span v-for="item in currentResume.positions">
                        {{item.name}}
                    </span>
                    </p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">空余时间</label>
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
                        <tr id="week">
                            <td>上午</td>
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
                <label class="col-sm-2 control-label">手机号</label>
                <div class="col-sm-10">
                    <p class="form-control-static">{{currentResume.phone}}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">邮箱</label>
                <div class="col-sm-10">
                    <p class="form-control-static">{{currentResume.email}}</p>
                </div>
            </div>
        </form>
    </div>
</div>

<script type="application/javascript">
    var vm = undefined;
    var vueData = {
        param: {
            grade: '${param.grade}',
            time: '${param.time}',
            salary: '${param.salary}',
            school: '${param.school}'
        },
        currentResume: undefined
    };

    $(function () {
        $("#hrefUl li a").removeClass("activeTitle");
        $("#resume_search a").addClass("activeTitle");

        loadSchools();

        $.post('/company/searchResume', vueData.param, function (data) {
            if (data.success) {
                vueData.list = data.list;
                vueData.totalPage = data.totalPage;
                vueData.pageSize = data.pageSize;
                vueData.totalItem = data.totalItem;
                vueData.page = data.page;

                vm = new Vue({
                    el: '#container',
                    data: vueData,
                    methods: {
                        changeTime: function (time) {
                            vueData.param.time %= 127;
                            vueData.param.time |= time;

                            vm.$set('param.time', vueData.param.time);

                            load();
                        },
                        openDlg: function (id) {
                            $.get("/user/resume/" + id, function (data) {
                                if (data.success) {
                                    vm.$set('currentResume', data.data.resume);

                                    //预处理空余时间表格
                                    var spareStr = parseInt(data.data.resume.spare_time).toString(2);
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

                                    layer.open({
                                        type: 1,
                                        title: "简历预览",
                                        closeBtn: 0,
                                        shadeClose: true,
                                        area: ['800px', '600px'],
                                        content: $("#preview")
                                    });
                                }
                            }, 'JSON');
                        },
                        load: function () {
                            $.post('/company/searchResume', vueData.param, function (data) {
                                if (data.success) {
                                    vueData.list = data.list;
                                    vueData.totalPage = data.totalPage;
                                    vueData.pageSize = data.pageSize;
                                    vueData.totalItem = data.totalItem;
                                    vueData.page = data.page;
                                }
                            }, 'JSON');
                        }
                    }
                });
            }
        }, 'JSON');
    });

    //加载院系信息
    function loadSchools() {
        $.get('/job/schoolData', function (data) {
            vueData.schools = data;
        }, 'JSON');
    }

</script>
</body>
</html>

