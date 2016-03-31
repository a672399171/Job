app.controller('PictureController', ['$scope', '$http', 'Upload', function ($scope, $http, Upload) {
    $http.get($scope.app.host + "/json/pic.json")
        .then(function (response) {
            $scope.array = response.data;
            for (var i = 0; i < $scope.array.length; i++) {
                $scope.array[i].local = "";
                $scope.array[i].id = i;
            }
        });

    //上传
    $scope.upload = function (file, item) {
        Upload.upload({
            url: $scope.app.host + '/user/uploadPicture.do',
            data: {file: file}
        }).then(function (resp) {
            item.local = resp.config.data.file.name;
            item.src = $scope.app.host + "/images/index/" + resp.data.src;
        }, function (resp) {
            console.log('Error status: ' + resp.status);
        }, function (evt) {
            var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
            item.local = 'progress: ' + progressPercentage + '%';
        });
    };

    //删除
    $scope.delete = function(item) {
        for(var i=0;i<$scope.array.length;i++) {
            console.log($scope.array[i].id + "  " + item.id);
            if($scope.array[i].id == item.id) {
                $scope.array.splice(i,1);
                break;
            }
        }
    };

    //保存
    $scope.save = function () {
        $http.post($scope.app.host + "/user/updatePictureJson.do", {
            data:JSON.stringify($scope.array)
        })
            .then(function (response) {
                alert("保存成功");
            });
    }
}]);