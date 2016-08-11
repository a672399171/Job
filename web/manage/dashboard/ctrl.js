app.controller('DashboardController', function ($scope, $state, $http) {
    //查询
    $scope.query = function () {
        $http.get("/admin/dashboard")
            .then(function(response) {
                $scope.poorCount = response.data.data.poorCount;
                $scope.companyCount = response.data.data.companyCount;
            });
    };

    $scope.query();
});