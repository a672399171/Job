<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html ng-app="resumeApp" lang="zh-CN">
<head>
    <title>简历管理</title>
    <%@include file="../common/head.jsp" %>
    <script src="/resources/js/moment-with-locales.js"></script>
    <script src="/resources/scripts/vue.js"></script>
    <script src="/resources/js/filters/filters.js"></script>
    <script src="/resources/layer/layer.js"></script>
    <style type="text/css">
        #container {
            background: white;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="container" id="container">
    <div class="row">
        <table class="table table-hover">
            <thead>
            <tr>
                <td>姓名</td>
                <td>年级</td>
                <td>申请职位</td>
                <td>状态</td>
                <td colspan="2">操作</td>
            </tr>
            </thead>
            <tbody>
            <tr v-for="item in list" v-if="totalItem > 0">
                <td>{{item.resume.name}}</td>
                <td>{{item.resume.grade}}</td>
                <td>
                    <a href="/company/job/{{item.job.id}}">{{item.job.name}}</a>
                </td>
                <td>
                    <span class="label label-default" v-if="item.state==0">未处理</span>
                    <span class="label label-danger" v-if="item.state==1">已回绝</span>
                    <span class="label label-success" v-if="item.state==2">已接收</span>
                </td>
                <td>
                    <span v-if="item.state==0">
                        <a href="javascript:void(0)" v-on:click="updateApply(item,1)">回绝</a>
                        <a href="javascript:void(0)" v-on:click="updateApply(item,2)">接收</a>
                    </span>
                    <a href="javascript:void(0)" v-on:click="openDlg(item.resume.id)">查看简历</a>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <nav style="margin: 0 auto;text-align: center" v-if="totalPage > 1">
        <ul class="pagination pagination-lg">
            <li>
                <a href="javascript:void(0)" aria-label="Previous" ng-click="load(-1)">&laquo;</a>
            </li>
            <li ng-repeat="p in pageArray" ng-class="{active:isCurrentPage(p)}">
                <a href="javascript:void(0)" ng-click="loadData(p)">{{p}}</a>
            </li>
            <li>
                <a href="javascript:void(0)" aria-label="Next" ng-click="load(1)">&raquo;</a>
            </li>
        </ul>
    </nav>

    <%--简历预览界面--%>
    <div class="preview container" id="preview" >
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
    var vueData = {currentResume: undefined};
    $("#hrefUl li a").removeClass("activeTitle");
    $("#resume_manage a").addClass("activeTitle");

    layer.msg('加载中', {icon: 16});
    $.get('/company/applies', function (data) {
        layer.closeAll();
        vueData = data;

        vm = new Vue({
            el: '#container',
            data: vueData,
            methods: {
                openDlg: function (r_id) {
                    $.get("/user/resume/" + r_id, function (data) {
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
                }
            }
        })
    }, 'JSON');

    /*var app = angular.module("resumeApp", []);
     app.controller("ResumeController", function ($scope, $http) {
     $scope.currentPage = 1;
     $scope.minPage = 1;
     $scope.maxPage = 1;
     $scope.currentResume = {};

     $scope.params = {
     page: 1,
     id: ${sessionScope.company.id}
     };

     $scope.isCurrentPage = function (p) {
     return p == $scope.currentPage;
     };

     //打开预览对话框
     $scope.openDlg = function (r_id) {
     $http.get("/job/admin/resumes/detail/" + r_id)
     .success(function (data) {
     $scope.currentResume = data;

     //预处理空余时间表格
     var spareStr = parseInt(data.spare_time).toString(2);
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
     area: ['800px','600px'],
     skin: 'yourclass',
     content: $("#preview")
     });
     });
     };

     //更新投递信息
     $scope.updateApply = function (item, state) {
     $http.get("/job/updateApply.do", {
     params: {
     j_id: item.job.id,
     r_id: item.resume.id,
     state: state
     }
     }).success(function (data) {
     if (!data.error) {
     $scope.loadData(1);
     } else {
     window.location = "/user/toCompanyLogin.do";
     }
     });
     };

     $scope.loadData = function (page) {
     if (page) {
     $scope.params.page = page;
     }

     $http.get('/job/resumeOfCompany.do', {
     params: $scope.params
     }).success(function (data) {
     $scope.applies = data.rows;
     $scope.pageArray = [];

     $scope.maxPage = Math.ceil(data.total / 10);

     if ($scope.maxPage <= 5) {
     for (var i = 0; i < $scope.maxPage; i++) {
     $scope.pageArray.push(i + 1);
     }
     } else {
     if ($scope.currentPage > 3) {
     var end = $scope.maxPage > $scope.currentPage + 2 ? $scope.currentPage + 2 : $scope.maxPage;
     for (var i = $scope.currentPage - 2; i <= end; i++) {
     $scope.pageArray.push(i);
     }
     } else {
     for (var i = 0; i < 5; i++) {
     $scope.pageArray.push(i + 1);
     }
     }
     }

     $scope.currentPage = page;
     });
     };

     $scope.load = function (temp) {
     if ((temp < 0 && $scope.currentPage <= $scope.minPage) ||
     ($scope.currentPage >= $scope.maxPage && temp > 0)) {
     return;
     } else {
     $scope.loadData($scope.currentPage + temp);
     }
     };

     //初始化数据
     $scope.loadData();
     });*/
</script>
</body>
</html>