<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="footer">

</div>

<script type="application/javascript">
    //console.log($("#footer").offset().top);
    //console.log($(window).height());
    if($("#footer").offset().top + $("#footer").height() + 1 < $(window).height()) {
        //console.log("add navbar-fixed-bottom");
        $("#footer").addClass("navbar-fixed-bottom");
    } else {
        //console.log("remove navbar-fixed-bottom");
        $("#footer").removeClass("navbar-fixed-bottom");
    }
</script>
