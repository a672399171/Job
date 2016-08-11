/**
 * Created by Administrator on 2016/3/24.
 */

'use strict';

app.controller('UserListController', function ($scope, $resource, $stateParams, $modal, $state) {
    //查询
    $scope.query = function (page, filter) {
        var $com = $resource("/user/admin/users/list/:page?filter=:filter", {page: '@page'});
        if (!page) {
            page = 1;
        } else {
            page = parseInt(page);
        }
        $com.get({page: page,filter:filter}, function (data) {
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
        });
    };
    //搜索跳转
    $scope.search = function () {
        $scope.query(1,$scope.search_context);
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
                    templateUrl: 'users/confirm.html',
                    controller: 'ConfirmController',
                    size: 'sm'
                });
                modalInstance.result.then(function () {
                    var $com = $resource("/user/admin/users/delete",null, {
                        'delete': {method: 'POST'}
                    });
                    $com.delete({'ids': ids}, function (data) {
                        if(data.msg) {
                            alert(data.msg);
                        }
                        $state.go('app.users.list');
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

app.controller('UserDetailController', function ($rootScope, $scope, $resource, $stateParams, $state, $modal) {
    $scope.edit_mode = !!$stateParams.id;
    if ($scope.edit_mode) {
        var $com = $resource("/user/admin/users/detail/:id", {id: '@id'});
        var resp = $com.get({id: $stateParams.id}, function (data) {
            $scope.data = resp;
        });
    }
    else {
        $scope.data = {};
    }
    $scope.submit = function () {
        if ($scope.edit_mode) {
            var $com = $resource("/user/admin/users/update/:id", {id: '@id'}, {
                'update': {method: 'POST'}
            });
            $com.update({id: $stateParams.id}, $scope.data, function (data) {
                if (data.success) {
                    alert(data.msg);
                    $state.go('app.users.list');
                } else {
                    alert(data.msg);
                }
            });
        } else {
            var $com = $resource("/user/admin/users/create");
            $com.save($scope.data, function (data) {
                if (data.success) {
                    alert(data.msg);
                    $state.go('app.users.list');
                } else {
                    alert(data.msg);
                }
            });
        }
    };
    $scope.delete = function (id) {
        //弹出删除确认
        var modalInstance = $modal.open({
            templateUrl: 'users/confirm.html',
            controller: 'ConfirmController',
            size: 'sm'
        });
        modalInstance.result.then(function () {
            var $com = $resource("/user/admin/users/delete",null, {
                'delete': {method: 'POST'}
            });
            var ids = [];
            ids.push(id);
            $com.delete({'ids': ids}, function (data) {
                alert(data.msg);
                $state.go('app.users.list');
            });
        });
    }
});
