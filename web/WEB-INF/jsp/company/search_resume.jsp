<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html ng-app="resumeSearch" lang="zh-CN">
<head>
    <title>搜索简历</title>
    <%@include file="../common/head.jsp"%>
    <script src="/js/angular-1.4.8/angular.min.js"></script>
    <script src="/layer/layer.js"></script>
</head>
<body ng-controller="ResumeListController">
<jsp:include page="header.jsp"/>
<div class="container" id="container">
    <div class="row">
        <div class="col-md-12" id="stBar">
            搜索到
            <span style="color: red">{{total}}</span>
            份简历
        </div>
    </div>
    <div class="row selectType" id="gradeDiv">
        <div class="col-md-1">
            年级:
        </div>
        <div class="col-md-11">
            <ul>
                <li ng-class="{on:params.grade==0}" ng-click="changeGrade(0)">不限</li>
                <li ng-class="{on:params.grade==2010}" ng-click="changeGrade(2010)">2010</li>
                <li ng-class="{on:params.grade==2011}" ng-click="changeGrade(2011)">2011</li>
                <li ng-class="{on:params.grade==2012}" ng-click="changeGrade(2012)">2012</li>
                <li ng-class="{on:params.grade==2013}" ng-click="changeGrade(2013)">2013</li>
                <li ng-class="{on:params.grade==2014}" ng-click="changeGrade(2014)">2014</li>
                <li ng-class="{on:params.grade==2015}" ng-click="changeGrade(2015)">2015</li>
            </ul>
        </div>
    </div>
    <div class="row selectType" id="timeDiv">
        <div class="col-md-1">
            空余时间:
        </div>
        <div class="col-md-11">
            <ul>
                <li ng-class="{on:timeArray[0]}" ng-click="changeTime(0)">不限</li>
                <li ng-class="{on:timeArray[1]}" ng-click="changeTime(1)">周一</li>
                <li ng-class="{on:timeArray[2]}" ng-click="changeTime(2)">周二</li>
                <li ng-class="{on:timeArray[3]}" ng-click="changeTime(3)">周三</li>
                <li ng-class="{on:timeArray[4]}" ng-click="changeTime(4)">周四</li>
                <li ng-class="{on:timeArray[5]}" ng-click="changeTime(5)">周五</li>
                <li ng-class="{on:timeArray[6]}" ng-click="changeTime(6)">周六</li>
                <li ng-class="{on:timeArray[7]}" ng-click="changeTime(7)">周日</li>
            </ul>
        </div>
    </div>
    <div class="row selectType" id="salaryDiv">
        <div class="col-md-1">
            期望月薪:
        </div>
        <div class="col-md-11">
            <ul>
                <li ng-class="{on:params.salary==null}" ng-click="changeSalary(null)">不限</li>
                <li ng-class="{on:params.salary=='500以下'}" ng-click="changeSalary('500以下')">500以下</li>
                <li ng-class="{on:params.salary=='500-1000'}" ng-click="changeSalary('500-1000')">500-1000</li>
                <li ng-class="{on:params.salary=='1000-2000'}" ng-click="changeSalary('1000-2000')">1000-2000
                </li>
                <li ng-class="{on:params.salary=='2000-3000'}" ng-click="changeSalary('2000-3000')">2000-3000
                </li>
                <li ng-class="{on:params.salary=='3000-4000'}" ng-click="changeSalary('3000-4000')">3000-4000
                </li>
                <li ng-class="{on:params.salary=='4000以上'}" ng-click="changeSalary('4000以上')">4000以上
                </li>
            </ul>
        </div>
    </div>
    <div class="row selectType" id="schoolDiv">
        <div class="col-md-1">
            院系:
        </div>
        <div class="col-md-11">
            <ul>
                <li ng-class="{on:params.school==0}" ng-click="changeSchool(0)">不限</li>
                <li ng-class="{on:item.id == params.school}" ng-repeat="item in schools"
                    ng-click="changeSchool(item.id)">
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
                <tr ng-repeat="item in resumes">
                    <td>{{item.name}}</td>
                    <td>{{item.sex}}</td>
                    <td>{{item.grade}}</td>
                    <td>{{item.major.major}}</td>
                    <td>{{item.salary}}</td>
                    <td><a href="javascript:void(0)" ng-click="openDlg(item.id)">查看简历</a></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <nav style="margin: 0 auto;text-align: center" ng-if="resumes.length > 0">
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
</div>

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
                <p class="form-control-static">{{currentResume.birthday.time | date:'yyyy-MM-dd'}}</p>
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
                    <span ng-repeat="item in currentResume.positions">
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

<script type="application/javascript">
    $(function () {
        $("#hrefUl li a").removeClass("activeTitle");
        $("#resume_search a").addClass("activeTitle");
    });

    var app = angular.module("resumeSearch", []);
    app.host = "";

    app.controller("ResumeListController", function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.total = 0;
        $scope.minPage = 1;
        $scope.maxPage = 1;
        $scope.timeArray = [true, false, false, false, false, false, false, false];

        $scope.params = {
            grade: 0,
            school: 0,
            page: 1,
            time: 127,
            salary: null
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

        $scope.loadData = function () {
            $http.get(app.host + '/job/searchResume.do', {
                params: $scope.params
            }).success(function (data) {
                $scope.resumes = data.rows;
                $scope.pageArray = [];
                $scope.total = data.total;

                $scope.maxPage = Math.ceil(data.total / 11);

                if ($scope.maxPage <= 11) {
                    for (var i = 0; i < $scope.maxPage; i++) {
                        $scope.pageArray.push(i + 1);
                    }
                } else {
                    if ($scope.currentPage > 6) {
                        var end = $scope.maxPage > $scope.currentPage + 5 ? $scope.currentPage + 5 : $scope.maxPage;
                        for (var i = $scope.currentPage - 5; i <= end; i++) {
                            $scope.pageArray.push(i);
                        }
                    } else {
                        for (var i = 0; i < 11; i++) {
                            $scope.pageArray.push(i + 1);
                        }
                    }
                }

                $scope.currentPage = $scope.params.page;
            });
        };

        //加载院系信息
        $scope.loadSchools = function () {
            $http.get(app.host + '/job/school_data.do')
                    .success(function (data) {
                        $scope.schools = data;
                    });
        };

        //改变参数中的school
        $scope.changeSchool = function (school) {
            $scope.params.school = school;
            $scope.loadData();
        };

        //改变参数中的grade
        $scope.changeGrade = function (grade) {
            $scope.params.grade = grade;
            $scope.loadData();
        };

        //改变参数中的salary
        $scope.changeSalary = function (salary) {
            $scope.params.salary = salary;
            $scope.loadData();
        };

        //改变参数中的page
        $scope.changePage = function (page) {
            $scope.params.page = page;
            $scope.loadData();
        };

        //改变参数中的时间
        $scope.changeTime = function (p) {
            if (p == 0) {
                $scope.resetTime();
            } else {
                $scope.timeArray[0] = false;
                $scope.timeArray[p] = !$scope.timeArray[p];
                var flag = true;
                for (var i = 1; i < $scope.timeArray.length; i++) {
                    if (!$scope.timeArray[i]) {
                        flag = false;
                    }
                }
                if (flag) {
                    $scope.resetTime();
                }
            }

            var num = 0;
            if ($scope.timeArray[0]) {
                num = 127;
            } else {
                for (var i = 1; i < $scope.timeArray.length; i++) {
                    if ($scope.timeArray[i]) {
                        num += Math.pow(2, 7 - i);
                    }
                }
            }
            $scope.params.time = num;
            $scope.loadData();
        };

        $scope.resetTime = function () {
            for (var i = 0; i < $scope.timeArray.length; i++) {
                $scope.timeArray[i] = false;
            }
            $scope.timeArray[0] = true;
        };

        $scope.load = function (temp) {
            if ((temp < 0 && $scope.currentPage <= $scope.minPage) ||
                    ($scope.currentPage >= $scope.maxPage && temp > 0)) {
            } else {
                $scope.changePage($scope.params.page + temp);
            }
        };

        //初始化加载院系信息
        $scope.loadSchools();

        //初始加载职位列表
        $scope.loadData();
    });

</script>
</body>
</html>

