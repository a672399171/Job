<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<div id="footer">

</div>

<script type="application/javascript">
    var height = document.body.scrollHeight;
    $("#footer").css("top", (height - 20) + "px");
</script>
