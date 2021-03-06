/**
 * Created by Administrator on 2016/3/24.
 */

'use strict';

app.controller('PoorListController', function ($scope, $resource, $stateParams, $modal, $state) {
    //查询
    $scope.query = function (page, filter) {
        var $com = $resource("/user/admin/poors/list/:page", {page: '@page'});
        if (!page) {
            page = 1;
        } else {
            page = parseInt(page);
        }
        $com.get({page: page}, function (data) {
            //扩展分页数据，显示页签，最终效果为  < 1 2 3 4 5 >
            data.page_index = page;
            data.pages = [];    //页签表
            var N = 5;          //每次显示5个页签
            var s = Math.floor(page / N) * N;
            if (s == page)s -= N;
            s += 1;
            var e = Math.min(data.page_count, s + N - 1)
            for (var i = s; i <= e; i++)
                data.pages.push(i)
            $scope.data = data;
            $scope.search_context = filter;
        });
    };
    //搜索跳转
    $scope.search = function () {
        $state.go('app.poors.list', {search: $scope.search_context});
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
                    templateUrl: 'poors/confirm.html',
                    controller: 'ConfirmController',
                    size: 'sm'
                });
                modalInstance.result.then(function () {
                    var $com = $resource("/user/admin/poors/delete", null, {
                        'delete': {method: 'POST'}
                    });
                    $com.delete({'ids': ids}, function (data) {
                        if (data.msg) {
                            alert(data.msg);
                        }
                        $state.go('app.poors.list');
                    });
                });
            }
        }
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

app.controller('PoorDetailController', function ($rootScope, $scope, $resource, $stateParams, $state, $modal, $http) {
    $scope.edit_mode = !!$stateParams.id;
    $scope.schools = [];
    $scope.majors = [];

    //获取院系信息
    $http.get("/job/school_data.do")
        .success(function (d) {
            $scope.schools = d;
        });

    if ($scope.edit_mode) {
        var $com = $resource("/user/admin/poors/detail/:id", {id: '@id'});
        var resp = $com.get({id: $stateParams.id}, function (data) {
            $scope.data = resp;
        });
    }
    else {
        $scope.data = {};
    }
    $scope.submit = function () {
        $scope.data.major_id = $scope.data.major.id;

        delete $scope.data.major;

        //发送请求
        $http.post("/user/admin/poors/saveOrUpdatePoor.do", $scope.data)
            .then(function (response) {
                $state.go('app.poors.list');
            });
    };
    $scope.delete = function (id) {
        //弹出删除确认
        var modalInstance = $modal.open({
            templateUrl: 'poors/confirm.html',
            controller: 'ConfirmController',
            size: 'sm'
        });
        modalInstance.result.then(function () {
            var $com = $resource("/user/admin/poors/delete", null, {
                'delete': {method: 'POST'}
            });
            var ids = [];
            ids.push(id);
            $com.delete({'ids': ids}, function (data) {
                alert(data.msg);
                $state.go('app.poors.list');
            });
        });
    };
    //发送认证信息
    $scope.auth = function (u_id, status) {
        $http.post("/user/admin/auth.do", {
            u_id: u_id,
            status: status
        }).then(function (response) {
            $state.go('app.poors.list');
        });
    };
    //显示院系div
    $scope.showSchoolDiv = function () {
        $("#schoolDiv").show();
        $(".mask").show();

        $(".mask").click(function () {
            $("#schoolDiv").hide();
            $(".mask").hide();
        });
    };
    //改变右侧院系内容
    $scope.changeMajor = function (id) {
        if ($scope.schools) {
            for (var i = 0; i < $scope.schools.length; i++) {
                if ($scope.schools[i].id == id) {
                    $scope.majors = $scope.schools[i].majors;
                    break;
                }
            }
        }
    };
    //点击右侧项目时设置数据
    $scope.setMajor = function (item) {
        $scope.data.major = item;

        $("#schoolDiv").hide();
        $(".mask").hide();
    };
});
