<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html ng-app="jobList" lang="zh-CN">
<head>
    <title>工作列表</title>
    <%@include file="common/head.jsp" %>
    <link href="http://g.alicdn.com/sj/dpl/1.5.1/css/sui.min.css" rel="stylesheet">
    <script src="/resources/scripts/vue.js"></script>
    <script src="/resources/js/filters/filters.js"></script>
    <script src="/resources/layer/layer.js"></script>
    <style type="text/css">
        .row {
            clear: both;
        }

        #middle {
            background: white;
            min-width: 800px;
            width: 100%;
            margin-top: 10px;
            margin-bottom: 20px;
        }

        .job_item {
            width: 100%;
            height: 100px;
            border-bottom: 1px solid #cccccc;
            background: white;
            padding: 10px;
            cursor: pointer;
        }

        .job_item:hover {
            background: #F8F8F8;
        }

        .job_item table tr {
            height: 40px;
            line-height: 40px;
        }

        .link {
            color: dodgerblue;
            font-size: 18px;
        }

        nav {
            text-align: center;
        }

        #emptyDiv {
            width: 100%;
            margin: 0 auto;
            text-align: center;
            font-size: 25px;
            color: orangered;
        }

    </style>
</head>
<body>
<div class="big container" id="app">
    <%@include file="/WEB-INF/jsp/common/header.jsp" %>

    <div class="container">
        <div class="row selectType" id="positionDiv">
            <div class="col-md-1">
                类别:
            </div>
            <div class="col-md-11">
                <ul class="sui-tag">
                    <li v-bind:class="{'tag-selected':0==param.pId || param.pId==undefined}"
                        v-on:click="param.pId=0,getListData()">
                        不限
                    </li>
                    <li v-bind:class="{'tag-selected':item.id==param.pId}"
                        v-for="item in positions" v-on:click="param.pId=item.id,getListData()">
                        {{item.name}}
                    </li>
                </ul>
            </div>
        </div>

        <div class="row selectType" id="timeDiv">
            <div class="col-md-1">
                工作时间:
            </div>
            <div class="col-md-11">
                <ul class="sui-tag" id="time">
                    <li v-bind:class="{'tag-selected':!param.time || param.time <= 0 || param.time == 127}"
                        v-on:click="param.time=127;getListData()">
                        不限
                    </li>
                    <li v-bind:class="{'tag-selected':selected(64)}" v-on:click="changeTime(64)">
                        周一
                    </li>
                    <li v-bind:class="{'tag-selected':selected(32)}" v-on:click="changeTime(32)">
                        周二
                    </li>
                    <li v-bind:class="{'tag-selected':selected(16)}" v-on:click="changeTime(16)">
                        周三
                    </li>
                    <li v-bind:class="{'tag-selected':selected(8)}" v-on:click="changeTime(8)">
                        周四
                    </li>
                    <li v-bind:class="{'tag-selected':selected(4)}" v-on:click="changeTime(4)">
                        周五
                    </li>
                    <li v-bind:class="{'tag-selected':selected(2)}" v-on:click="changeTime(2)">
                        周六
                    </li>
                    <li v-bind:class="{'tag-selected':selected(1)}" v-on:click="changeTime(1)">
                        周日
                    </li>
                </ul>
            </div>
        </div>

        <div class="row selectType" id="salaryDiv">
            <div class="col-md-1">
                月薪:
            </div>
            <div class="col-md-11">
                <ul class="sui-tag" id="salary">
                    <li v-bind:class="{'tag-selected':(!param.low) && (!param.high)}"
                        v-on:click="changeSalary(0,0)">不限
                    </li>
                    <li v-bind:class="{'tag-selected':(param.low==0) && (param.high==500)}"
                        v-on:click="changeSalary(0,500)">500以下
                    </li>
                    <li v-bind:class="{'tag-selected':param.low==500 && param.high==1000}"
                        v-on:click="changeSalary(500,1000)">500-1000
                    </li>
                    <li v-bind:class="{'tag-selected':param.low==1000 && param.high==2000}"
                        v-on:click="changeSalary(1000,2000)">1000-2000
                    </li>
                    <li v-bind:class="{'tag-selected':param.low==2000 && param.high==3000}"
                        v-on:click="changeSalary(2000,3000)">2000-3000
                    </li>
                    <li v-bind:class="{'tag-selected':param.low==3000 && param.high==4000}"
                        v-on:click="changeSalary(3000,4000)">3000-4000
                    </li>
                    <li v-bind:class="{'tag-selected':param.low==4000 && param.high==0}"
                        v-on:click="changeSalary(4000,0)">4000以上
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div id="middle">
        <div class="job_item" style="display: block" v-for="item in list" v-on:click="toUrl(item.id)">
            <table>
                <tr>
                    <td width="30%"><a href="#" class="link">{{item.name}}</a></td>
                    <td width="30%" class="font3">{{item.post_time | timestampFilter 'YYYY-MM-DD hh:mm'}}</td>
                    <td width="30%" class="font5">{{item.post_company.company_name}}</td>
                </tr>
                <tr>
                    <td class="font5">{{item.type.name}}</td>
                    <td class="font4">{{item.low_salary}}-{{item.high_salary}}</td>
                    <td class="font3">{{item.post_company.scope}}</td>
                </tr>
            </table>
        </div>
    </div>

    <div v-if="totalItem <= 0" id="emptyDiv">
        对不起，暂无记录！
    </div>
    <%--<xl-page pageSize="10" n="5" method="load" cla="pagination-lg"></xl-page>--%>
</div>
<jsp:include page="/WEB-INF/jsp/common/footer.jsp"/>

<script type="application/javascript">
    var vueData = {};
    var vm = undefined;
    vueData.param = {
        pId: '${param.pId}',
        cId: '${param.cId}',
        time: 0,
        low: 0,
        high: 0
    };

    function getListData() {
        layer.msg('加载中', {icon: 16});
        $.post('/job/listData', vueData.param, function (data) {
            layer.closeAll();
            if (data.success) {
                vueData.list = data.list;
                vueData.totalPage = data.totalPage;
                vueData.pageSize = data.pageSize;
                vueData.totalItem = data.totalItem;
                vueData.page = data.page;

                vm = new Vue({
                    el: '#app',
                    data: vueData,
                    methods: {
                        getListData: getListData,
                        toUrl: function (id) {
                            window.location = '/job/' + id;
                        },
                        changeTime: function (time) {
                            vueData.param.time %= 127;
                            vueData.param.time |= time;

                            vm.$set('param.time', vueData.param.time);
                            getListData();
                        },
                        changeSalary: function(low, high) {
                            vueData.param.low = low;
                            vueData.param.high = high;
                            vm.$set('param.low', vueData.param.low);
                            vm.$set('param.high', vueData.param.high);

                            getListData();
                        },
                        selected: function (time) {
                            return ((vueData.param.time & time) == time) && vueData.param.time < 127;
                        }
                    }
                });
            } else {
                alert(data.error);
            }
        }, 'JSON');
    }

    $(function () {
        $.getJSON('/job/positionData?cId=${param.cId}', function (data) {
            vueData.positions = data;
        });

        getListData();
    });
</script>
</body>
</html>