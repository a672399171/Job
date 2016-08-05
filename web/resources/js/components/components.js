// 定义
var ZlPageer = Vue.extend({
    pops:[],
    template: `
        <div class="sui-pagination">
        <ul>
        <li class="prev disabled"><a href="#">«上一页</a></li>
        <li class="active"><a href="#">1</a></li>
        <li><a href="#">2</a></li>
        <li><a href="#">3</a></li>
        <li><a href="#">4</a></li>
        <li><a href="#">5</a></li>
        <li class="dotted"><span>...</span></li>
        <li class="next"><a href="#">下一页»</a></li>
        </ul>
        <div><span>共10页&nbsp;</span><span>
          到
          <input type="text" class="page-num"><button class="page-confirm" onclick="alert(1)">确定</button>
          页</span></div>
        </div>
    `
});

// 注册
Vue.component('zl-pager', ZlPageer);

