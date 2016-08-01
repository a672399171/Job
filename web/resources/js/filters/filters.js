(function () {
    Vue.filter('dateFilter', function (value, pattern) {
        return moment(value, pattern).fromNow();
    });
    Vue.filter('timestampFilter', function (value, pattern) {
        // 时间戳转化为日期格式
        return moment(new Date(value)).format(pattern);
    });
})();