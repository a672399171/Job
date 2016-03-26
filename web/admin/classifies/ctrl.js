/**
 * Created by Administrator on 2016/3/24.
 */

'use strict';

app.controller('ListController', function ($scope, $resource, $stateParams, $modal, $state) {
    //查询
    $scope.query = function (page, filter) {
        var $com = $resource($scope.app.host + "/job/admin/classifies/list/:page", {page: '@page'});
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
        $state.go('app.users.list', {search: $scope.search_context});
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
                    var $com = $resource($scope.app.host + "/user/admin/users/delete", null, {
                        'delete': {method: 'POST'}
                    });
                    $com.delete({'ids': ids}, function (data) {
                        if (data.msg) {
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

app.controller('DetailController', function ($rootScope, $scope, $resource, $stateParams, $state, $modal) {
    $scope.edit_mode = !!$stateParams.id;
    if ($scope.edit_mode) {
        var $com = $resource($scope.app.host + "/user/admin/users/detail/:id", {id: '@id'});
        var resp = $com.get({id: $stateParams.id}, function (data) {
            $scope.data = resp;
        });
    }
    else {
        $scope.data = {};
    }
    $scope.submit = function () {
        if ($scope.edit_mode) {
            var $com = $resource($scope.app.host + "/user/admin/users/update/:id", {id: '@id'}, {
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
            var $com = $resource($scope.app.host + "/user/admin/users/create");
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
            var $com = $resource($scope.app.host + "/user/admin/users/delete", null, {
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

app.controller('AbnTestController', function ($scope, $http) {
    var tree, treedata_avm;
    $scope.my_tree_handler = function (branch) {
        var _ref;
        $scope.output = "id: " + branch.id + " 名称: " + branch.label;
        if ((_ref = branch.data) != null ? _ref.description : void 0) {
            return $scope.output += '(' + branch.data.description + ')';
        }
    };

    $http.get($scope.app.host + "/user/admin/tree_data.do")
        .success(function (data) {
            treedata_avm = data;
            for (var i = 0; i < data.length; i++) {
                if (data[i].children) {
                    for (var j = 0; j < data[i].children.length; j++) {
                        data[i].children[j].onSelect = function (branch) {
                            console.log(branch);
                            $scope.currentNode = branch;
                            //return $scope.currentNode = branch;
                        }
                    }
                }
                data[i].onSelect = function (branch) {
                    $scope.currentNode = branch;
                    //return $scope.currentNode = branch;
                }
            }
        });
    treedata_avm = [];

    $scope.my_data = treedata_avm;
    $scope.try_changing_the_tree_data = function () {
        return $scope.my_data = treedata_avm;
    };

    //保存修改
    $scope.save_modify = function () {
        if(!$scope.currentNode) {
            return;
        }

        $http.post($scope.app.host + "/job/admin/saveOrUpdateType.do", $scope.currentNode)
            .success(function (data) {
                //console.log(data);
                if(data.success == true) {
                    $scope.currentNode.isNew = false;
                    alert("保存成功");
                    window.location.reload();
                } else {
                    alert("保存失败");
                }
            });
    };

    //删除
    $scope.delete_node = function () {
        if(!$scope.currentNode) {
            return;
        }

        $http.post($scope.app.host + "/job/admin/deleteType.do", $scope.currentNode)
            .success(function (data) {
                //console.log(data);
                if(data.success == true) {
                    alert("删除成功");
                    window.location.reload();
                } else {
                    alert("删除失败");
                }
            });
    };

    $scope.my_tree = tree = {};
    return $scope.try_adding_a_branch = function () {
        var b;
        b = tree.get_selected_branch();
        if (b.type == "classify") {
            return tree.add_branch(b, {
                label: 'New Branch',
                type: "position",
                isNew: true,
                c_id: b.id,
                onSelect: function (branch) {
                    $scope.currentNode = branch;
                }
            });
        }
    };
});
