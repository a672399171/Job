app.controller("CommentController", function ($scope, $http) {
    $scope.currentPage = 1;
    $scope.minPage = 1;
    $scope.maxPage = 1;

    $scope.params = {
        page: 1,
        id: app.job_id
    };

    $scope.isCurrentPage = function (p) {
        return p == $scope.currentPage;
    };

    $scope.loadData = function (page) {
        $scope.params.page = page;

        $http.get(app.host + '/job/getComments.do', {
            params: $scope.params
        }).success(function (data) {
            $scope.comments = data.rows;
            $scope.pageArray = [];

            $scope.maxPage = Math.ceil(data.total / 5);

            if ($scope.maxPage <= 5) {
                for (var i = 0; i < $scope.maxPage; i++) {
                    $scope.pageArray.push(i + 1);
                }
            } else {
                if ($scope.currentPage > 3) {
                    var end = $scope.maxPage > $scope.currentPage + 2 ? $scope.currentPage + 2 : $scope.maxPage;
                    for (var i = $scope.currentPage - 2; i <= end; i++) {
                        $scope.pageArray.push(i);
                    }
                } else {
                    for (var i = 0; i < 5; i++) {
                        $scope.pageArray.push(i + 1);
                    }
                }
            }

            $scope.currentPage = page;
        });
    };

    $scope.load = function (temp) {
        if ((temp < 0 && $scope.currentPage <= $scope.minPage) ||
            ($scope.currentPage >= $scope.maxPage && temp > 0)) {
            return;
        } else {
            $scope.loadData($scope.currentPage + temp);
        }
    };

    //初始化加载第一页评论
    $scope.loadData(1);
});

app.controller("CompanyJobController", function ($scope, $http) {
    $scope.currentPage = 1;
    $scope.minPage = 1;
    $scope.maxPage = 1;

    $scope.params = {
        page: 1,
        id:app.company_id
    };

    $scope.isCurrentPage = function (p) {
        return p == $scope.currentPage;
    };

    $scope.loadData = function (page) {
        $scope.params.page = page;

        $http.get(app.host + '/job/getJobsByCompany.do', {
            params: $scope.params
        }).success(function (data) {
            $scope.jobs = data.rows;
            $scope.pageArray = [];

            $scope.maxPage = Math.ceil(data.total / 5);

            if ($scope.maxPage <= 5) {
                for (var i = 0; i < $scope.maxPage; i++) {
                    $scope.pageArray.push(i + 1);
                }
            } else {
                if ($scope.currentPage > 3) {
                    var end = $scope.maxPage > $scope.currentPage + 2 ? $scope.currentPage + 2 : $scope.maxPage;
                    for (var i = $scope.currentPage - 2; i <= end; i++) {
                        $scope.pageArray.push(i);
                    }
                } else {
                    for (var i = 0; i < 5; i++) {
                        $scope.pageArray.push(i + 1);
                    }
                }
            }

            $scope.currentPage = page;
        });
    };

    $scope.load = function (temp) {
        if ((temp < 0 && $scope.currentPage <= $scope.minPage) ||
            ($scope.currentPage >= $scope.maxPage && temp > 0)) {
            return;
        } else {
            $scope.loadData($scope.currentPage + temp);
        }
    };

    $scope.toUrl = function (id) {
        window.location = app.host + "/job/detail.do?id=" + id;
    };

    $scope.loadData(1);
});