/**
 * Created by Administrator on 2016/3/24.
 */
'use strict';

app.run(
    function ($rootScope, $state, $stateParams) {
        $rootScope.$state = $state;
        $rootScope.$stateParams = $stateParams;
    }
).config(
    function ($stateProvider, $urlRouterProvider, $httpProvider) {
        //处理post，put请求服务器接收参数问题
        $httpProvider.defaults.headers.put['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';
        $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8';

        // Override $http service's default transformRequest
        $httpProvider.defaults.transformRequest = [function (data) {
            /**
             * The workhorse; converts an object to x-www-form-urlencoded serialization.
             * @param {Object} obj
             * @return {String}
             */
            var param = function (obj) {
                var query = '';
                var name, value, fullSubName, subName, subValue, innerObj, i;

                for (name in obj) {
                    value = obj[name];

                    if (value instanceof Array) {
                        for (i = 0; i < value.length; ++i) {
                            subValue = value[i];
                            fullSubName = name + '[]';
                            innerObj = {};
                            innerObj[fullSubName] = subValue;
                            query += param(innerObj) + '&';
                        }
                    } else if (value instanceof Function) {

                    } else if (name.substr(0, 1) == '$') {

                    } else if (value instanceof Object) {
                        for (subName in value) {
                            subValue = value[subName];
                            fullSubName = name + '[' + subName + ']';
                            innerObj = {};
                            innerObj[fullSubName] = subValue;
                            query += param(innerObj) + '&';
                        }
                    } else if (value !== undefined && value !== null) {
                        query += encodeURIComponent(name) + '='
                            + encodeURIComponent(value) + '&';
                    }
                }

                return query.length ? query.substr(0, query.length - 1) : query;
            };

            return angular.isObject(data) && String(data) !== '[object File]'
                ? param(data)
                : data;
        }];

        $urlRouterProvider
            .otherwise('/app/dashboard');
        $stateProvider
            .state('app', {
                abstract: true,
                url: '/app',
                templateUrl: 'tpl/app.html'
            })
            .state('app.dashboard', {
                url: '/dashboard',
                templateUrl: 'tpl/blocks/dashboard.html'
            })
            .state('app.users', {
                abstract: true,
                url: '/users',
                template: '<div ui-view class="fade-in"></div>',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('users/ctrl.js');
                        }]
                }
            })
            .state('app.users.list', {
                url: '/list?page',
                templateUrl: 'users/list.html'
            })
            .state('app.users.detail', {
                url: '/detail/{id}',
                templateUrl: 'users/detail.html'
            })
            .state('app.users.create', {
                url: '/create',
                templateUrl: 'users/detail.html'
            })
            .state('app.companies', {
                abstract: true,
                url: '/companies',
                template: '<div ui-view class="fade-in"></div>',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('companies/ctrl.js');
                        }]
                }
            })
            .state('app.companies.list', {
                url: '/list?page',
                templateUrl: 'companies/list.html'
            })
            .state('app.companies.detail', {
                url: '/detail/{id}',
                templateUrl: 'companies/detail.html'
            })
            .state('app.companies.create', {
                url: '/create',
                templateUrl: 'companies/detail.html'
            })
            .state('app.classifies', {
                abstract: true,
                url: '/classifies',
                template: '<div ui-view class="fade-in"></div>',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('angularBootstrapNavTree').then(
                                function () {
                                    return $ocLazyLoad.load('classifies/ctrl.js');
                                }
                            );
                        }]
                }
            })
            .state('app.classifies.list', {
                url: '/list?page',
                templateUrl: 'classifies/ui_tree.html',
            })
    }
);
