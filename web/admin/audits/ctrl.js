/**
 * Created by Administrator on 2016/3/24.
 */

'use strict';

app.controller('AuditListController', function ($scope, $resource, $stateParams, $modal, $state) {
    //查询
    $scope.query = function (page, filter) {
        var $com = $resource($scope.app.host + "/user/admin/companies/list/:page", {page: '@page', audit: true});
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

app.controller('AuditDetailController', function ($rootScope, $scope, $resource, $stateParams, $state, $http) {
    $scope.edit_mode = !!$stateParams.id;
    if ($scope.edit_mode) {
        var $com = $resource($scope.app.host + "/user/admin/companies/detail/:id", {id: '@id'});
        var resp = $com.get({id: $stateParams.id}, function (data) {
            $scope.data = resp;
        });
    }
    else {
        $scope.data = {};
    }
    //发送认证信息
    $scope.audit = function (id, audit) {
        $http.post($scope.app.host + "/user/admin/audit.do", {
            id: id,
            audit: audit
        }).then(function (response) {
            $state.go('app.audits.list');
        });
    };
});
