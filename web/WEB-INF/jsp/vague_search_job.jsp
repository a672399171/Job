<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html ng-app="searchJobResult">
<head>
    <title>搜索结果</title>
    <link rel="stylesheet" href="${root}/font-awesome-4.3.0/css/font-awesome.min.css">
    <script type="text/javascript"
            src="${root}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${root}/js/jquery.fullPage.min.js"></script>
    <link rel="stylesheet" href="${root}/bootstrap-3.3.4-dist/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${root}/css/common.css"/>
    <script src="${root}/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
    <script src="${root}/js/angular-1.4.8/angular.min.js"></script>
    <style type="text/css">
        .row {
            clear: both;
        }

        #middle {
            background: white;
            min-width: 800px;
            width: 80%;
            margin-left: 150px;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .job_item {
            width: 100%;
            height: 100px;
            border-bottom: 1px solid #cccccc;
            background: white;
            padding: 10px;
            cursor: pointer;
        }

        .job_item:hover {
            background: #F8F8F8;
        }

        .job_item table tr {
            height: 40px;
            line-height: 40px;
        }

        .link {
            color: dodgerblue;
            font-size: 18px;
        }

        nav {
            text-align: center;
        }

        #emptyDiv {
            width: 100%;
            margin: 0 auto;
            text-align: center;
            font-size: 25px;
            color: orangered;
        }

    </style>
</head>
<body ng-controller="JobListController">
<div class="big">
    <jsp:include page="/WEB-INF/jsp/header.jsp"/>

    <div class="container">
        <div class="row selectType" id="positionDiv">
            <div class="col-md-1">
                类别:
            </div>
            <div class="col-md-11">
                <ul>
                    <li ng-class="{on:params.c_id==0}" ng-click="changeCid(0)">不限</li>
                    <li ng-class="{on:item.id == params.c_id}" ng-repeat="item in classifies"
                        ng-click="changeCid(item.id)">
                        {{item.name}}
                    </li>
                </ul>
            </div>
        </div>
        <div class="row selectType" id="timeDiv">
            <div class="col-md-1">
                工作时间:
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
                月薪:
            </div>
            <div class="col-md-11">
                <ul>
                    <li ng-class="{on:params.low==0 && params.high=='max'}" ng-click="changeSalary(0,'max')">不限</li>
                    <li ng-class="{on:params.low==0 && params.high==500}" ng-click="changeSalary(0,500)">500以下</li>
                    <li ng-class="{on:params.low==500 && params.high==1000}" ng-click="changeSalary(500,1000)">
                        500-1000
                    </li>
                    <li ng-class="{on:params.low==1000 && params.high==2000}" ng-click="changeSalary(1000,2000)">
                        1000-2000
                    </li>
                    <li ng-class="{on:params.low==2000 && params.high==3000}" ng-click="changeSalary(2000,3000)">
                        2000-3000
                    </li>
                    <li ng-class="{on:params.low==3000 && params.high==4000}" ng-click="changeSalary(3000,4000)">
                        3000-4000
                    </li>
                    <li ng-class="{on:params.low==4000 && params.high=='max'}" ng-click="changeSalary(4000,'max')">
                        4000以上
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div id="middle">
        <div class="job_item" style="display: block" ng-repeat="item in jobs" ng-click="toUrl(item)">
            <table>
                <tr>
                    <td width="30%"><a href="#" class="link">{{item.name}}</a></td>
                    <td width="30%" class="font3">{{item.post_time.time | date:'yyyy-MM-dd hh:mm'}}</td>
                    <td width="30%" class="font5">{{item.post_company.company_name}}</td>
                </tr>
                <tr>
                    <td class="font5">{{item.type.name}}</td>
                    <td class="font4">{{item.low_salary}}-{{item.high_salary}}</td>
                    <td class="font3">{{item.post_company.scope}}</td>
                </tr>
            </table>
        </div>
    </div>

    <div ng-if="jobs.length <= 0" id="emptyDiv">
        对不起，暂无记录！
    </div>

    <nav style="margin: 0 auto;text-align: center" ng-if="jobs.length > 0">
        <ul class="pagination pagination-lg">
            <li>
                <a href="javascript:void(0)" aria-label="Previous" ng-click="load(-1)">&laquo;</a>
            </li>
            <li ng-repeat="p in pageArray" ng-class="{active:isCurrentPage(p)}">
                <a href="javascript:void(0)" ng-click="changePage(p)">{{p}}</a>
            </li>
            <li>
                <a href="javascript:void(0)" aria-label="Next" ng-click="load(1)">&raquo;</a>
            </li>
        </ul>
    </nav>
</div>

<jsp:include page="/WEB-INF/jsp/footer.jsp"/>

<script type="application/javascript">
    var app = angular.module("searchJobResult", []);
    app.host = "${root}";

    app.controller("JobListController", function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.minPage = 1;
        $scope.maxPage = 1;
        $scope.timeArray = [true, false, false, false, false, false, false, false];

        $scope.params = {
            keyword: "${keyword}",
            c_id: 0,
            page: 1,
            time: 127,
            low: 0,
            high: "max"
        };

        $scope.isCurrentPage = function (p) {
            return p == $scope.currentPage;
        };

        $scope.loadData = function () {
            $http.get(app.host + '/job/vagueSearchJobs.do', {
                params: $scope.params
            }).success(function (data) {
                $scope.jobs = data.rows;
                $scope.pageArray = [];

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

        //加载类型信息
        $scope.loadClassifies = function () {
            $http.get(app.host + '/job/classifyList.do', {
                params: $scope.params
            }).success(function (data) {
                $scope.classifies = data;
            });
        };

        //改变参数中的p_id
        $scope.changeCid = function (c_id) {
            $scope.params.c_id = c_id;
            $scope.loadData();
        };

        //改变参数中的salary
        $scope.changeSalary = function (low, high) {
            $scope.params.low = low;
            $scope.params.high = high;
            $scope.loadData();
        };

        //改变参数中的page
        $scope.changePage = function (page) {
            $scope.params.page = page;
            $scope.loadData();
        };

        //转到url
        $scope.toUrl = function (item) {
            window.location = "${root}/job/detail.do?id=" + item.id;
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

        //初始化加载类型信息
        $scope.loadClassifies();

        //初始加载职位列表
        $scope.loadData();
    });
</script>
</body>
</html>