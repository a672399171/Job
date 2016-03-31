/**
 * Created by Administrator on 2016/3/24.
 */

'use strict';

app.controller('JobListController', function ($scope, $resource, $stateParams, $modal, $state) {
    //查询
    $scope.query = function (page, filter, state) {
        var $com = $resource($scope.app.host + "/job/admin/jobs/list/:page?filter=:filter&state=:state", {page: '@page'});
        if (!page) {
            page = 1;
        } else {
            page = parseInt(page);
        }
        $com.get({page: page, filter: filter, state: state}, function (data) {
            //扩展分页数据，显示页签，最终效果为  < 1 2 3 4 5 >
            $scope.page_index = page;
            $scope.pages = [];    //页签表
            var N = 5;          //每次显示5个页签

            $scope.pages = [];
            $scope.maxPage = Math.ceil(data.total / 10);

            if ($scope.maxPage <= N) {
                for (var i = 0; i < $scope.maxPage; i++) {
                    $scope.pages.push(i + 1);
                }
            } else {
                if ($scope.page_index > Math.ceil(N / 2)) {
                    var end = $scope.maxPage > $scope.page_index + Math.floor(N / 2) ? $scope.page_index + Math.floor(N / 2) : $scope.maxPage;
                    for (var i = $scope.page_index - Math.floor(N / 2); i <= end; i++) {
                        $scope.pages.push(i);
                    }
                } else {
                    for (var i = 0; i < N; i++) {
                        $scope.pages.push(i + 1);
                    }
                }
            }

            $scope.data = data;
            $scope.search_context = filter;
            $scope.state = state;
        });
    };
    //搜索跳转
    $scope.search = function () {
        $scope.query(1, $scope.search_context, $scope.state);
    };

    //change
    $scope.change = function () {
        $scope.query(1, $scope.search_context, $scope.state);
    };
    //全选
    var selected = false;
    $scope.selectAll = function () {
        selected = !selected;
        angular.forEach($scope.data.rows, function (item) {
            item.selected = selected;
        });
    };
    //自定义操作处理，其中1为删除所选记录
    $scope.exec = function () {
        if ($scope.operate == "1") {
            var ids = [];
            angular.forEach($scope.data.rows, function (item) {
                if (item.selected) {
                    ids.push(item.id);
                }
            });
            if (ids.length > 0) {
                //弹出删除确认
                var modalInstance = $modal.open({
                    templateUrl: 'jobs/confirm.html',
                    controller: 'ConfirmController',
                    size: 'sm'
                });
                modalInstance.result.then(function () {
                    var $com = $resource($scope.app.host + "/job/admin/jobs/delete", null, {
                        'delete': {method: 'POST'}
                    });
                    $com.delete({'ids': ids}, function (data) {
                        if (data.msg) {
                            alert(data.msg);
                        }
                        $state.go('app.jobs.list');
                    });
                });
            }
        }
    };
    //格式化日期
    $scope.formatDate = function (object) {
        var date = new Date(object.time);
        return date;
    };

    //根据url参数（分页、搜索关键字）查询数据
    $scope.query($stateParams.page, $stateParams.search);
});

app.controller('ConfirmController', ['$scope', '$modalInstance', function ($scope, $modalInstance) {
    $scope.ok = function () {
        $modalInstance.close();
    };
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
}]);

//把数字转化成二进制日期字符数组
function numberToDateString(number) {
    var spareStr = parseInt(number).toString(2);
    var timeLength = spareStr.length;
    var array = [];
    if (spareStr.length < 7) {
        for (var i = 0; i < 7 - timeLength; i++) {
            spareStr = "0" + spareStr;
        }
    } else {
        spareStr = spareStr.substr(spareStr.length - 7);
    }
    array = spareStr.split("");
    return array;
}

//把二进制日期字符数组转化成数字
function dateStringToNumber(array) {
    var number = 0;
    for (var i = 1; i < array.length; i++) {
        number += array[i] * Math.pow(2, 7 - i);
    }
    return number;
}

app.controller('JobDetailController', function ($rootScope, $scope, $resource, $stateParams, $state, $modal, $http) {
    $scope.edit_mode = !!$stateParams.id;

    $scope.types = [];

    //获取类型分组信息
    $http.get($scope.app.host + "/user/admin/tree_data.do")
        .success(function (d) {
            $scope.children = [];
            $scope.types = d;
        });

    if ($scope.edit_mode) {
        var $com = $resource($scope.app.host + "/job/admin/jobs/detail/:id", {id: '@id'});
        var resp = $com.get({id: $stateParams.id}, function (data) {
            $scope.data = resp;
            $scope.chars = numberToDateString(resp.work_time);
        });
    } else {
        $scope.companies = [];
        //获取所有的公司
        $http.get($scope.app.host + "/user/admin/companies/list/0")
            .success(function (d) {
                $scope.companies = d.rows;
            });
        //初始化字符数组
        $scope.chars = ['0', '0', '0', '0', '0', '0', '0'];
        $scope.data = {};
    }

    $scope.submit = function () {
        $scope.data.work_time = dateStringToNumber($scope.chars);

        $scope.data.company = $scope.data.post_company.id;
        $scope.data.position = $scope.data.type.id;

        delete $scope.data.post_company;
        delete $scope.data.type;
        delete $scope.data.post_time;

        if ($scope.edit_mode) {
            var $com = $resource($scope.app.host + "/job/admin/jobs/update/:id", {id: '@id'}, {
                'update': {method: 'POST'}
            });

            $com.update({id: $stateParams.id}, $scope.data, function (data) {
                if (data.success) {
                    $state.go('app.jobs.list');
                } else {
                    alert("未知错误");
                }
            });
        } else {
            var $com = $resource($scope.app.host + "/job/admin/jobs/create");
            $com.save($scope.data, function (data) {
                if (data.success) {
                    $state.go('app.jobs.list');
                } else {
                    alert("未知错误");
                }
            });
        }
    };
    $scope.delete = function (id) {
        //弹出删除确认
        var modalInstance = $modal.open({
            templateUrl: 'jobs/confirm.html',
            controller: 'ConfirmController',
            size: 'sm'
        });
        modalInstance.result.then(function () {
            var $com = $resource($scope.app.host + "/job/admin/jobs/delete", null, {
                'delete': {method: 'POST'}
            });
            var ids = [];
            ids.push(id);
            $com.delete({'ids': ids}, function (data) {
                alert(data.msg);
                $state.go('app.jobs.list');
            });
        });
    };
    //格式化日期
    $scope.formatDate = function (object) {
        var date = new Date();
        if (object) {
            date = new Date(object.time);
        }
        return date;
    };
    //改变右侧li内容
    $scope.changeRightItem = function (id) {
        if ($scope.types) {
            for (var i = 0; i < $scope.types.length; i++) {
                if ($scope.types[i].id == id) {
                    $scope.children = $scope.types[i].children;
                    break;
                }
            }
        }
    };
    //点击右侧项目时设置数据
    $scope.setData = function (item) {
        $scope.data.type = {
            id: item.id,
            c_id: item.c_id,
            name: item.label
        };

        $("#typeDiv").hide();
        $(".mask").hide();
    };
    //显示隐藏div
    $scope.showDiv = function () {
        $("#typeDiv").show();
        $(".mask").show();

        $(".mask").click(function () {
            $("#typeDiv").hide();
            $(".mask").hide();
        });
    };
    //显示公司div
    $scope.showCompanyDiv = function () {
        $("#companyDiv").show();
        $(".mask").show();

        $(".mask").click(function () {
            $("#companyDiv").hide();
            $(".mask").hide();
        });
    };
    //点击公司时设置数据
    $scope.setCompany = function (item) {
        $scope.data.post_company = {
            id: item.id,
            company_name: item.company_name
        };

        $("#companyDiv").hide();
        $(".mask").hide();
    };
});
