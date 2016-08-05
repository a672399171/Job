<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html ng-app="jobList" lang="zh-CN">
<head>
    <title>工作列表</title>
    <%@include file="common/head.jsp" %>
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
<body ng-controller="JobListController">
<div class="big container" id="app">
    <%@include file="/WEB-INF/jsp/header.jsp" %>

    <div class="container">
        <div class="row selectType" id="positionDiv">
            <div class="col-md-1">
                类别:
            </div>
            <div class="col-md-11">
                <ul>
                    <li v-bind:class="{'on':param.pId == null}" v-on:click="param.pId=null">不限</li>
                    <li v-bind:class="{'on':item.id == param.pId}" v-for="item in positions"
                        v-on:click="param.pId=item.id">
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
                <%--<ul>
                    <li v-bind:class="{'on':timeArray[0]}" v-on:click="changeTime(0)">不限</li>
                    <li v-bind:class="{on:timeArray[1]}" v-on:click="changeTime(1)">周一</li>
                    <li v-bind:class="{on:timeArray[2]}" v-on:click="changeTime(2)">周二</li>
                    <li v-bind:class="{on:timeArray[3]}" v-on:click="changeTime(3)">周三</li>
                    <li v-bind:class="{on:timeArray[4]}" v-on:click="changeTime(4)">周四</li>
                    <li v-bind:class="{on:timeArray[5]}" v-on:click="changeTime(5)">周五</li>
                    <li v-bind:class="{on:timeArray[6]}" v-on:click="changeTime(6)">周六</li>
                    <li v-bind:class="{on:timeArray[7]}" v-on:click="changeTime(7)">周日</li>
                </ul>--%>
            </div>
        </div>

        {{flags | json}}
        <div class="row selectType" id="salaryDiv">
            <div class="col-md-1">
                月薪:
            </div>
            <div class="col-md-11">
                <ul>
                    <li v-bind:class="flags[0]"
                        v-on:click="changeSalary(0,0,0)">不限
                    </li>
                    <li v-bind:class="flags[1]"
                        v-on:click="changeSalary(0,500,1)">
                        500以下
                    </li>
                    <li v-bind:class="flags[2]"
                        v-on:click="changeSalary(500,1000,2)">
                        500-1000
                    </li>
                    <li v-bind:class="flags[3]"
                        v-on:click="changeSalary(1000,2000,3)">
                        1000-2000
                    </li>
                    <li v-bind:class="flags[4]"
                        v-on:click="changeSalary(2000,3000,4)">
                        2000-3000
                    </li>
                    <li v-bind:class="flags[5]"
                        v-on:click="changeSalary(3000,4000,5)">
                        3000-4000
                    </li>
                    <li v-bind:class="flags[6]"
                        v-on:click="changeSalary(4000,0,6)">
                        4000以上
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div id="middle">
        <div class="job_item" style="display: block" v-for="item in list">
            <table>
                <tr>
                    <td width="30%"><a href="#" class="link">{{item.name}}</a></td>
                    <td width="30%" class="font3">{{item.post_time.time | timestampFilter 'YYYY-MM-DD hh:mm'}}</td>
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
<jsp:include page="/WEB-INF/jsp/footer.jsp"/>

<script type="application/javascript">
    var vueData = {};
    vueData.param = {
        pId:${param.pId},
        cId:${param.cId}
    };

    function loadPositions() {
        $.getJSON('/job/positionData?cId=${param.cId}', function (data) {
            vueData.positions = data;
        });
    }

    $(function () {
        loadPositions();

        $.post('/job/listData', vueData.param, function (data) {
            if (data.success) {
                vueData.list = data.list;
                vueData.totalItem = data.totalItem;
                vueData.totalPage = data.totalPage;
                vueData.page = data.page;

                vueData.flags = new Array(7);
                vueData.flags.fill({
                    'on': false
                });

                new Vue({
                    el: '#app',
                    data: vueData,
                    methods: {
                        changeSalary: function (low, high, i) {
                            vueData.param.low = low;
                            vueData.param.high = high;
                            vueData.flags[1]['on'] = true;
                        }
                    },
                    computed: {}
                });
            } else {
                alert(data.error);
            }
        }, 'JSON');
    });
</script>
</body>
</html>