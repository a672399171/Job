(function () {
    Vue.filter('dateFilter', function (value, pattern) {
        return moment(value, pattern).fromNow()
    })
})();