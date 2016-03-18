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
<h2 align="center">职位类型管理</h2>
<ul id="tt1" class="easyui-tree" data-options="
                url: '${root}/user/admin/tree_data.do',
                method: 'post',
                animate: true,
                onContextMenu: function(e,node){
                    e.preventDefault();
                    $(this).tree('select',node.target);
                    if($(this).tree('getParent', node.target) == null) {
                        $('#mm').menu('show',{
                            left: e.pageX,
                            top: e.pageY
                        });
                    } else {
                        $('#mm2').menu('show',{
                            left: e.pageX,
                            top: e.pageY
                        });
                    }
                },
                onDblClick:function() {
                    var node = $(this).tree('getSelected');
                    $(this).tree('beginEdit',node.target);
                },
                onAfterEdit:function(node) {
                    updateNode(node);
                }
            "></ul>
<button type="button" style="clear: both" onclick="addNode()">添加项目</button>
<%--<div id="detailDiv">

</div>--%>

<div id="mm" class="easyui-menu" style="width:120px;">
    <div onclick="append()" data-options="iconCls:'icon-add'">添加</div>
    <div onclick="removeit()" data-options="iconCls:'icon-remove'">移除</div>
</div>

<div id="mm2" class="easyui-menu" style="width:120px;">
    <div onclick="removeit()" data-options="iconCls:'icon-remove'">移除</div>
</div>

<script type="application/javascript">
    //记录增加的节点数
    var no = 0;
    var t = $('#tt1');

    //添加节点
    function append() {
        var node = t.tree('getSelected');
        no++;
        t.tree('append', {
            parent: (node ? node.target : null),
            data: [{
                id: no,
                text: '双击输入'
            }]
        });

        addNodePost(node);
        //t.tree('beginEdit',t.tree('find',no).target);
    }

    //移除节点
    function removeit() {
        var node = t.tree('getSelected');
        t.tree('remove', node.target);

        deleteNode(node);
    }

    //增加节点
    function addNode() {
        no++;
        var node = t.tree("getRoots")[0];
        t.tree('insert', {
            before: node.target,
            data: [{
                text: '双击输入',
                id: no++,
                state: 'closed',
                children: [{
                    id: no++,
                    text: '双击输入'
                }]
            }]
        });
        node = t.tree("find", no - 2);
        var child = t.tree("find", no - 1);

        var nodeData = t.tree("getData", node.target);
        var childData = t.tree("getData", child.target);

        $.post("${root}/job/admin/addClassify.do", {
            text: nodeData.text
        }, function (data) {
            t.tree("reload");
            $.post("${root}/job/admin/addPosition.do", {
                c_id: data.c_id,
                text: childData.text
            }, function (data) {
                t.tree("reload");
            }, "JSON");
        }, "JSON");
    }

    //添加node
    function addNodePost(node) {
        var nodeData = t.tree("getData", node.target);
        var url = "";
        if (t.tree("getParent", node.target) == null) {
            url = "${root}/job/admin/addClassify.do";
            $.post(url, {
                text: nodeData.text
            }, function (data) {
                t.tree("reload");
            }, "JSON");
        } else {
            url = "${root}/job/admin/addPosition.do";
            $.post(url, {
                c_id: c_id,
                text: nodeData.text
            }, function (data) {
                t.tree("reload");
            }, "JSON");
        }
    }

    //更新node
    function updateNode(node) {
        var nodeData = t.tree("getData", node.target);
        var url = "";
        if (t.tree("getParent", node.target) == null) {
            url = "${root}/job/admin/updateClassify.do";
        } else {
            url = "${root}/job/admin/updatePosition.do";
        }

        $.post(url, {
            id: nodeData.id.substr(1),
            text: nodeData.text
        }, function (data) {
            t.tree("reload");
        }, "JSON");
    }

    //删除node
    function deleteNode(node) {
        var nodeData = t.tree("getData", node.target);
        var url = "";
        if (t.tree("getParent", node.target) == null) {
            url = "${root}/job/admin/deleteClassify.do";
        } else {
            url = "${root}/job/admin/deletePosition.do";
        }

        $.post(url, {
            id: nodeData.id.substr(1)
        }, function (data) {
            t.tree("reload");
        }, "JSON");
    }
</script>
</body>
</html>
