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
<h2 align="center">公司管理</h2>
<table id="dgJob"></table>

<%--<div id="jobDialog" class="easyui-dialog" title="用户信息" style="width: 400px;height: 400px"
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
</div>--%>

<script type="application/javascript">
    var url = "${root}/user/admin/addUser.do";

    $(function () {
        $('#dgJob').datagrid({
            url: '${root}/user/admin/searchCompanies.do',
            columns: [[
                {field: 'username', title: '用户名', width: 100},
                {field: 'company_name', title: '公司名', width: 100,resizable:true},
                {field: 'address', title: '地址', width: 400,resizable:true},
                {field: 'name', title: '负责人', width: 100},
                {field: 'phone', title: '负责人手机号', width: 100,resizable:true},
                {field: 'introduce', title: '公司介绍', width: 100},
                {field: 'type', title: '公司类型', width: 100},
                {field: 'scope', title: '公司规模', width: 100},
                {field: 'email', title: '邮箱', width: 100}
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
                    $('#jobDialog').dialog("open");
                    $("#jobForm").form("clear");
                    url = "${root}/user/admin/addUser.do";
                }
            }, {
                iconCls: 'icon-edit',
                handler: function () {
                    var row = $("#dg").datagrid('getSelected');
                    if (row != null) {
                        $("#jobForm").form("clear");
                        $("#jobForm").form("load", row);
                        console.log(row.push);
                        $("#jobForm select[name='push']").val(row.push + "");
                        $('#jobDialog').dialog("open");
                        url = "${root}/user/admin/modifyUser.do";
                    }
                }
            }, {
                iconCls: 'icon-remove',
                handler: function () {
                    var row = $("#dgJob").datagrid('getSelected');
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
                $("#jobForm").serialize(),
                function (data) {
                    $('#jobDialog').dialog("close");
                    $("#dgJob").datagrid("reload");
                }, "JSON");
    }

    //删除用户
    function deleteUser(id) {
        $.post(url, {
            id: id
        }, function (data) {
            $("#dgJob").datagrid("reload");
        }, "JSON");
    }

    //关闭对话框
    function closeDialog() {
        $('#jobDialog').dialog("close");
    }
</script>
</body>
</html>
