<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>后台管理系统</title>
    <link rel="stylesheet" type="text/css"
          href="${root}/jquery-easyui-1.4.4/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css"
          href="${root}/jquery-easyui-1.4.4/themes/icon.css"/>
    <link rel="stylesheet" type="text/css"
          href="${root}/css/common.css"/>
    <link rel="stylesheet" type="text/css"
          href="${root}/css/admin/style_index.css"/>
    <script type="text/javascript"
            src="${root}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${root}/js/jquery.fullPage.min.js"></script>
    <script type="text/javascript"
            src="${root}/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${root}/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
</head>
<body class="easyui-layout">
<div data-options="region:'north'" style="height:100px;"></div>
<div data-options="region:'south'" style="height:100px;"></div>
<div data-options="region:'west',title:'导航',split:true" id="navigation">
    <ul>

    </ul>
</div>
<div id="tt" class="easyui-tabs" data-options="region:'center'"
     style="padding:5px;background:#eee;">
</div>

<script type="application/javascript">
    var vos = [
        {"text": "用户管理", "url": "${root}/user/admin/user_manage.do", "id": "user_manage"},
        {"text": "职位类型管理", "url": "${root}/user/admin/type_manage.do", "id": "type_manage"},
        {"text": "职位管理", "url": "${root}/user/admin/job_manage.do", "id": "job_manage"},
        {"text": "公司管理", "url": "${root}/user/admin/company_manage.do", "id": "company_manage"}
    ];

    //初始化
    $(function () {
        $('#tt').tabs('add', {
            title: "首页",
            href: "",
            closable: false
        });

        for (var i = 0; i < vos.length; i++) {
            $("#navigation ul").append("<li><a href='javascript:void(0)' id='" + vos[i].id + "'>" + vos[i].text + "</a></li>");
            $("#" + vos[i].id).click(vos[i],openTab);
        }
    });

    function openTab(obj) {
        if ($("#tt").tabs('exists', obj.data.text)) {
            $("#tt").tabs('select', obj.data.text)
        } else {
            $('#tt').tabs('add', {
                title: obj.data.text,
                href: obj.data.url,
                closable: true,
                tools: [{
                    iconCls: 'icon-mini-refresh',
                    handler: function () {
                        var tab = $('#tt').tabs('getSelected');  // 获取选择的面板
                        tab.panel('refresh', obj.data.url);
                    }
                }]
            });
        }
    }


</script>
</body>
</html>
