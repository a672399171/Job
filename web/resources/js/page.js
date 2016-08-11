//分页指令
app.directive("xlPage", [function () {
    function link(scope, element, attrs) {
        scope.currentPage = 1;
        scope.total = 0;
        scope.pageSize = attrs.pagesize;
        scope.maxPage = 1;
        scope.pages = [];
        scope.N = attrs.n;//最多显示n个页码
        scope.cla = attrs.cla;

        //加载数据的方法未定义
        if (!scope[attrs.method]) {
            throw new Error("load method is undefined");
        }
        //下一页
        scope.next = function () {
            if (scope.currentPage < scope.maxPage) {
                scope.currentPage++;
                scope.getData();
            }
        };
        //上一页
        scope.prev = function () {
            if (scope.currentPage > 1) {
                scope.currentPage--;
                scope.getData();
            }
        };

        scope.createPage = function (data) {
            //最大页
            scope.maxPage = Math.ceil(data.total / scope.pageSize);
            scope.pages = [];

            if (scope.currentPage > Math.ceil(scope.N / 2)) {
                if (scope.maxPage > scope.N) {
                    var temp = scope.maxPage > Math.floor(scope.N / 2) ? Math.floor(scope.N / 2) : scope.maxPage;
                    for (var i = temp - N; i <= temp; i++) {
                        scope.pages.push(i);
                    }
                } else {
                    for (var i = 1; i <= scope.maxPage; i++) {
                        scope.pages.push(i);
                    }
                }
            } else {
                var temp = scope.maxPage > scope.N ? scope.N : scope.maxPage;
                for (var i = 1; i <= temp; i++) {
                    scope.pages.push(i);
                }
            }

            scope.data = data.rows;
            scope.total = data.total;
        };

        //获取数据
        scope.getData = function (page) {
            console.log(page);
            if (page > 0) {
                scope.currentPage = page;
            }

            scope[attrs.method](scope.currentPage, scope.createPage);
        };
        scope.getData();
    }

    return {
        restrict: 'E',
        templateUrl: "/admin/tpl/xl-page.html",
        link: link
    }
}]);