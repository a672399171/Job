app.controller('LoadingController', function ($scope, $state, $http) {
    console.log("loading");

    $http.post("/admin/login")
        .then(function (response) {
            if (response.data.success) {
                $state.go('app.dashboard');
            } else {
                $state.go('auth.login');
            }
        });
});

app.controller('LoginController', function ($scope, $state, $http) {
    $scope.login = function () {
        $scope.authError = "";

        $http.post("/admin/login", {
                username: $scope.user.username,
                password: $scope.user.password
            })
            .then(function (response) {
                if (response.data.success) {
                    $state.go('app.dashboard');
                } else {
                    $scope.authError = response.data.error;
                    $state.go('auth.login');
                }
            });
    }
});