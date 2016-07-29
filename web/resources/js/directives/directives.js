(function () {
    Vue.elementDirective('zl-page', {
        bind: function () {
            // 准备工作
            // 例如，添加事件处理器或只需要运行一次的高耗任务
            this.el.innerHTML =
                "<div class='sui-pagination' style='margin: 0 auto'>" +
                "<ul>" +
                "<li class='prev disabled'><a href='#'>«上一页</a></li>" +
                "<li class='active'><a href='#'>1</a></li>" +
                "<li><a href='#'>2</a></li>" +
                "<li><a href='#'>3</a></li>" +
                "<li><a href='#'>4</a></li>" +
                "<li><a href='#'>5</a></li>" +
                "<li class='dotted'><span>...</span></li>" +
                "<li class='next'><a href='#'>下一页»</a></li>" +
                "</ul>" +
                "<div><span>共10页&nbsp;</span><span>" +
                "到" +
                "<input type='text' class='page-num'><button class='page-confirm' onclick='alert(1)'>确定</button>" +
                "页</span></div>" +
                "</div>";
        },
        update: function (newValue, oldValue) {
            // 值更新时的工作
            // 也会以初始值为参数调用一次
        },
        unbind: function () {
            // 清理工作
            // 例如，删除 bind() 添加的事件监听器
        }
    })
})();