/**
 * Created by Administrator on 2016/3/24.
 */
'use strict';

app.run(
    function ($rootScope, $state, $stateParams, $localStorage, $http) {
        $http.defaults.headers.common['Authorization'] = 'Basic ' + $localStorage.auth;
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
            .otherwise('/auth/loading');
        $stateProvider
            .state('auth', {
                abstract: true,
                url: '/auth',
                template: '<div ui-view class="fade-in"></div>',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('auth/ctrl.js');
                        }]
                }
            })
            .state('auth.loading', {
                url: '/loading',
                templateUrl: 'auth/loading.html'
            })
            .state('auth.login', {
                url: '/login',
                templateUrl: 'auth/login.html'
            })
            .state('app', {
                abstract: true,
                url: '/app',
                templateUrl: 'tpl/app.html'
            })
            .state('app.dashboard', {
                url: '/dashboard',
                templateUrl: 'tpl/blocks/dashboard.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('dashboard/ctrl.js');
                        }]
                }
            })//用户管理
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
            })//公司管理
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
            })//职位类型管理
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
                templateUrl: 'classifies/ui_tree.html'
            })//职位管理
            .state('app.jobs', {
                abstract: true,
                url: '/jobs',
                template: '<div ui-view class="fade-in"></div>',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('jobs/ctrl.js');
                        }]
                }
            })
            .state('app.jobs.list', {
                url: '/list?page',
                templateUrl: 'jobs/list.html'
            })
            .state('app.jobs.detail', {
                url: '/detail/{id}',
                templateUrl: 'jobs/detail.html'
            })
            .state('app.jobs.create', {
                url: '/create',
                templateUrl: 'jobs/detail.html'
            })//简历管理
            .state('app.resumes', {
                abstract: true,
                url: '/resumes',
                template: '<div ui-view class="fade-in"></div>',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('resumes/ctrl.js');
                        }]
                }
            })
            .state('app.resumes.list', {
                url: '/list?page',
                templateUrl: 'resumes/list.html'
            })
            .state('app.resumes.detail', {
                url: '/detail/{id}',
                templateUrl: 'resumes/detail.html'
            })
            .state('app.resumes.create', {
                url: '/create',
                templateUrl: 'resumes/detail.html'
            })//贫困生管理
            .state('app.poors', {
                abstract: true,
                url: '/poors',
                template: '<div ui-view class="fade-in"></div>',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('poors/ctrl.js');
                        }]
                }
            })
            .state('app.poors.list', {
                url: '/list?page',
                templateUrl: 'poors/list.html'
            })
            .state('app.poors.detail', {
                url: '/detail/{id}',
                templateUrl: 'poors/detail.html'
            })
            .state('app.poors.create', {
                url: '/create',
                templateUrl: 'poors/detail.html'
            })//公司审核
            .state('app.audits', {
                abstract: true,
                url: '/audits',
                template: '<div ui-view class="fade-in"></div>',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('audits/ctrl.js');
                        }]
                }
            })
            .state('app.audits.list', {
                url: '/list?page',
                templateUrl: 'audits/list.html'
            })
            .state('app.audits.detail', {
                url: '/detail/{id}',
                templateUrl: 'audits/detail.html'
            })//图片轮播管理
            .state('app.picture', {
                abstract: true,
                url: '/picture',
                template: '<div ui-view class="fade-in"></div>',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('pic/ctrl.js');
                        }]
                }
            })
            .state('app.picture.manage', {
                url: '/manage',
                templateUrl: 'pic/pic.html'
            })
    }
);