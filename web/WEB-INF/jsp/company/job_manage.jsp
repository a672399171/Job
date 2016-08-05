<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>职位管理</title>
    <%@include file="../common/head.jsp" %>
    <script src="/resources/js/ajaxfileupload.js"></script>
    <script src="/resources/js/moment-with-locales.js"></script>
    <script src="/resources/scripts/vue.js"></script>
    <script src="/resources/js/filters/filters.js"></script>
    <style type="text/css">
        #container {
            background: white;
        }

        #postBtn {
            float: right;
            margin: 10px;
            margin-right: 50px;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="container" id="container">
    <div class="row">
        <div class="col-md-12">
            <a class="btn btn-success" href="/company/postNew" id="postBtn">发布新职位</a>
        </div>
    </div>
    <div class="row">
        <div style="color: red;font-size: 20px;margin: 0 auto;width: 30%" v-if="totalItem <= 0">暂无职位，请先发布职位。</div>
        <table class="table table-hover" v-if="totalItem > 0">
            <thead>
            <tr>
                <td>标题</td>
                <td>类型</td>
                <td>发布时间</td>
                <td>状态</td>
                <td>操作</td>
            </tr>
            </thead>
            <tbody>
            <tr v-for="item in list">
                <td><a href="/job/{{item.id}}">{{item.name}}</a></td>
                <td><span class="font3">{{item.type.name}}</span></td>
                <td>
                    <span class="date">
                        {{item.post_time | timestampFilter 'YYYY-MM-DD hh:mm'}}
                    </span>
                </td>
                <td>
                    <span class="label label-default" v-if="item.status == 0">Stoped</span>
                    <span class="label label-success" v-if="item.status != 0">Running</span>
                </td>
                <td>
                    <a href="javascript:void(0)" style="color: green" v-if="item.status == 0"
                       v-on:click="changeStatus(item,1)">运行</a>
                    <a href="javascript:void(0)" style="color: red" v-if="item.status != 0"
                       v-on:click="changeStatus(item,0)">停止</a>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<%@include file="../common/footer.jsp" %>

<script type="application/javascript">
    var vueData = undefined;
    var vm = undefined;

    // 加载职位信息
    function load() {
        $.post('/job/companyJobs', {
            companyId: '${sessionScope.company.id}'
        }, function (data) {
            if (data.success) {
                vueData = data;

                vm = new Vue({
                    el: '#container',
                    data: vueData,
                    methods: {
                        changeStatus: function (item, status) {
                            $.post("/job/changeJobStatus", {
                                j_id: item.id,
                                status: status
                            }, function (data) {
                                if (data.success) {
                                    item.status = status;
                                } else {
                                    alert(data.error);
                                }
                            }, "JSON");
                        }
                    }
                });
            } else {
                alert(data.error);
            }
        }, 'JSON');
    }

    $(function () {
        load();

        $("#hrefUl li a").removeClass("activeTitle");
        $("#job_manage a").addClass("activeTitle");
    });
</script>
</body>
</html>

