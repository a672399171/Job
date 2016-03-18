<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css"
          href="${root}/jquery-easyui-1.4.4/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css"
          href="${root}/jquery-easyui-1.4.4/themes/icon.css"/>
    <link rel="stylesheet" type="text/css"
          href="${root}/css/common.css"/>
    <script type="text/javascript"
            src="${root}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${root}/js/jquery.fullPage.min.js"></script>
    <script type="text/javascript"
            src="${root}/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${root}/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
<h2 align="center">用户管理</h2>
<table id="dg"></table>

<div id="userDialog" class="easyui-dialog" title="用户信息" style="width: 400px;height: 400px"
     data-options="resizable:false,modal:true,closed:true">
    <form id="userForm" method="post">
        <input type="hidden" name="id"/>
        <table>
            <tr>
                <td><label>用户名：</label></td>
                <td><input class="easyui-validatebox" type="text" name="username" data-options="required:true"/></td>
            </tr>
            <tr>
                <td><label>密码：</label></td>
                <td><input class="easyui-validatebox" type="password" name="password" data-options="required:true"/>
                </td>
            </tr>
            <tr>
                <td><label>学号：</label></td>
                <td><input class="easyui-validatebox" type="text" name="school_num" data-options="required:true"/></td>
            </tr>
            <tr>
                <td><label>昵称：</label></td>
                <td><input class="easyui-validatebox" type="text" name="nickname" data-options="required:true"/></td>
            </tr>
            <tr>
                <td><label>性别：</label></td>
                <td>
                    <select name="sex">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label>手机号：</label></td>
                <td><input class="easyui-validatebox" type="text" name="phone" data-options="required:true"/></td>
            </tr>
            <tr>
                <td><label>邮箱：</label></td>
                <td><input class="easyui-validatebox" type="text" name="email" data-options="required:true"/></td>
            </tr>
            <tr>
                <td><label>推送：</label></td>
                <td>
                    <select name="push">
                        <option value="true">接受推送</option>
                        <option value="false">拒绝推送</option>
                    </select>
                </td>
            </tr>
            <tr style="text-align: center">
                <td colspan="2">
                    <input type="button" value="确认" onclick="postData()"/>
                    <input type="button" value="取消" onclick="closeDialog()"/>
                </td>
            </tr>
        </table>
    </form>
</div>

<script type="application/javascript">
    var url = "${root}/user/admin/addUser.do";

    $(function () {
        $('#dg').datagrid({
            url: '${root}/user/admin/searchUsers.do',
            columns: [[
                {field: 'username', title: '用户名', width: 100},
                {field: 'school_num', title: '学号', width: 100},
                {field: 'nickname', title: '昵称', width: 100},
                {field: 'phone', title: '手机号', width: 100},
                {field: 'email', title: '邮箱', width: 100},
                {field: 'school_num', title: '学号', width: 100},
                {field: 'photo_src', title: '头像路径', width: 100},
                {field: 'sex', title: '性别', width: 100},
                {field: 'push', title: '是否接受推送', width: 100}
            ]],
            striped: true,
            loadMsg: "加载中...",
            pagination: true,
            rownumbers: true,
            ctrlSelect: true,
            multiSort: true,
            remoteSort: false,
            singleSelect: true,
            toolbar: [{
                iconCls: 'icon-add',
                handler: function () {
                    $('#userDialog').dialog("open");
                    $("#userForm").form("clear");
                    url = "${root}/user/admin/addUser.do";
                }
            }, {
                iconCls: 'icon-edit',
                handler: function () {
                    var row = $("#dg").datagrid('getSelected');
                    if (row != null) {
                        $("#userForm").form("clear");
                        $("#userForm").form("load", row);
                        console.log(row.push);
                        $("#userForm select[name='push']").val(row.push + "");
                        $('#userDialog').dialog("open");
                        url = "${root}/user/admin/modifyUser.do";
                    }
                }
            }, {
                iconCls: 'icon-remove',
                handler: function () {
                    var row = $("#dg").datagrid('getSelected');
                    if (row != null) {
                        deleteUser(row.id);
                    }
                }
            }]
        });
    });

    //发送数据
    function postData() {
        $.post(url,
                $("#userForm").serialize(),
                function (data) {
                    $('#userDialog').dialog("close");
                    $("#dg").datagrid("reload");
                }, "JSON");
    }

    //删除用户
    function deleteUser(id) {
        $.post(url, {
            id: id
        }, function (data) {
            $("#dg").datagrid("reload");
        }, "JSON");
    }

    //关闭对话框
    function closeDialog() {
        $('#userDialog').dialog("close");
    }
</script>
</body>
</html>
