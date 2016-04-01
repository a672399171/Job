app.controller("CommentController", function ($scope, $http) {
    $scope.params = {
        page: 1,
        id: app.job_id
    };

    $scope.load = function (page,callback) {
        $scope.params.page = page;

        $http.get(app.host + '/job/getComments.do', {
            params: $scope.params
        }).success(function (data) {
            if(callback) {
                callback(data);
            }
        });
    };

    //初始化加载第一页评论
    $scope.load(1);
});

app.controller("CompanyJobController", function ($scope, $http) {
    $scope.params = {
        page: 1,
        id:app.company_id
    };

    $scope.load = function (page,callback) {
        $scope.params.page = page;

        $http.get(app.host + '/job/getJobsByCompany.do', {
            params: $scope.params
        }).success(function (data) {
            if(callback) {
                callback(data);
            }
        });
    };

    $scope.toUrl = function (id) {
        window.location = app.host + "/job/detail.do?id=" + id;
    };

    $scope.load(1);
});