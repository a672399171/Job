app.controller("CommentController", function ($scope, $http) {
    $scope.params = {
        page: 1,
        id: app.job_id
    };

    $scope.load = function (page, callback) {
        $scope.params.page = page;

        $http.get(app.host + '/job/getComments.do', {
            params: $scope.params
        }).success(function (data) {
            if (callback) {
                callback(data);
            } else {
                $scope.data = data.rows;
            }
        });
    };

    //发表评论
    $scope.postComment = function () {
        $http.get(app.host + '/user/postComment.do', {
            params: {
                j_id: app.job_id,
                content: $("#comment").val()
            }
        }).then(function (response) {
            $("#comment").val("");
            $scope.load(1);
        });
    };

    //初始化加载第一页评论
    $scope.load(1);
});

app.controller("CompanyJobController", function ($scope, $http) {
    $scope.params = {
        page: 1,
        id: app.company_id
    };

    $scope.load = function (page, callback) {
        $scope.params.page = page;

        $http.get(app.host + '/job/getJobsByCompany.do', {
            params: $scope.params
        }).success(function (data) {
            if (callback) {
                callback(data);
            }
        });
    };

    $scope.toUrl = function (id) {
        window.location = app.host + "/job/detail.do?id=" + id;
    };

    $scope.load(1);
});

app.controller("RecommendController", function ($scope, $http) {

    $scope.params = {
        u_id: app.u_id,
        j_id: app.job_id
    };

    $scope.load = function () {
        $http.get(app.host + '/job/getRecommendJobs.do', {
            params: $scope.params
        }).then(function (response) {
            console.log(response.data);
            $scope.data = response.data;
        });
    };

    $scope.toUrl = function (id) {
        window.location = app.host + "/job/detail.do?id=" + id;
    };

    $scope.load();
});