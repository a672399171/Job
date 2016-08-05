<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<a target="_blank" id="right" href="http://wpa.qq.com/msgrd?v=3&uin=672399171&site=qq&menu=yes">
    <img border="0" src="http://wpa.qq.com/pa?p=2:672399171:53" alt="点击这里给我发消息" title="点击这里给我发消息"/>
</a>

<script type="application/javascript">
    $(function () {
        //qq交流随页面滚动
        $(window).scroll(function () {
            var myTop = $("#right").offset().top;
            var top = $(document).scrollTop() + $(window).height() * 0.3 ;
            if (Math.abs(top - myTop) > 100) {
                $("#right").animate({top: top + 'px'}, 100);
            }
        });
    });
</script>
