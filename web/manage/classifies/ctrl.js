'use strict';

app.controller('ConfirmController', ['$scope', '$modalInstance', function ($scope, $modalInstance) {
    $scope.ok = function () {
        $modalInstance.close();
    };
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
}]);

app.controller('AbnTestController', function ($scope, $http, $modal) {
    var tree, treedata_avm;
    $scope.my_tree_handler = function (branch) {
        var _ref;
        $scope.output = "id: " + branch.id + " 名称: " + branch.label;
        if ((_ref = branch.data) != null ? _ref.description : void 0) {
            return $scope.output += '(' + branch.data.description + ')';
        }
    };

    $http.get("/user/admin/tree_data.do")
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
            $scope.my_data = treedata_avm;
        });
    treedata_avm = [];

    $scope.my_data = treedata_avm;

    $scope.try_changing_the_tree_data = function () {
        return $scope.my_data = treedata_avm;
    };

    //保存修改
    $scope.save_modify = function () {
        if (!$scope.currentNode) {
            return;
        }

        $http.post("/job/admin/saveOrUpdateType.do", $scope.currentNode)
            .success(function (data) {
                //console.log(data);
                if (data.success == true) {
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
        if (!$scope.currentNode) {
            return;
        }

        //弹出删除确认
        var modalInstance = $modal.open({
            templateUrl: 'classifies/confirm.html',
            controller: 'ConfirmController',
            size: 'sm'
        });
        modalInstance.result.then(function () {
            $http.post("/job/admin/deleteType.do", $scope.currentNode)
                .success(function (data) {
                    //console.log(data);
                    if (data.success == true) {
                        alert("删除成功");
                        window.location.reload();
                    } else {
                        alert("删除失败");
                    }
                });
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
