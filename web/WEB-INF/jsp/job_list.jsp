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
                    <li onclick="vueData.param.time=127;changTimeDom()">
                        不限
                    </li>
                    <li onclick="changeTime(64)">周一</li>
                    <li onclick="changeTime(32)">周二</li>
                    <li onClick="changeTime(16)">周三</li>
                    <li onClick="changeTime(8)">周四</li>
                    <li onClick="changeTime(4)">周五</li>
                    <li onClick="changeTime(2)">周六</li>
                    <li onClick="changeTime(1)">周日</li>
                </ul>
            </div>
        </div>

        <div class="row selectType" id="salaryDiv">
            <div class="col-md-1">
                月薪:
            </div>
            <div class="col-md-11">
                <ul class="sui-tag" id="salary">
                    <li onclick="changeSalary(0,0)">不限</li>
                    <li onclick="changeSalary(0,500)">500以下</li>
                    <li onclick="changeSalary(500,1000)">500-1000</li>
                    <li onclick="changeSalary(1000,2000)">1000-2000</li>
                    <li onclick="changeSalary(2000,3000)">2000-3000</li>
                    <li onclick="changeSalary(3000,4000)">3000-4000</li>
                    <li onclick="changeSalary(4000,0)">4000以上</li>
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
    vueData.param = {
        pId:'${param.pId}',
        cId:'${param.cId}'
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

                new Vue({
                    el: '#app',
                    data: vueData,
                    methods: {
                        getListData: getListData,
                        toUrl: function (id) {
                            window.location = '/job/' + id;
                        }
                    }
                });
            } else {
                alert(data.error);
            }
        }, 'JSON');
    }
    changTimeDom();
    changeSalaryDom();

    $(function () {
        $.getJSON('/job/positionData?cId=${param.cId}', function (data) {
            vueData.positions = data;
        });

        getListData();
    });

    function changeTime(time) {
        vueData.param.time %= 127;
        vueData.param.time |= time;
        changTimeDom();
    }

    function changTimeDom() {
        getListData();

        var domArr = $('#time li');
        domArr.removeClass('tag-selected');

        if (vueData.param.time == 127
                || vueData.param.time <= 0
                || vueData.param.time == undefined) {
            domArr.eq(0).addClass('tag-selected');
            return;
        }
        for (var i = 1; i <= 7; i++) {
            if ((vueData.param.time & Math.pow(2, 7 - i)) === Math.pow(2, 7 - i)) {
                domArr.eq(i).addClass('tag-selected');
            }
        }

    }

    function changeSalary(low, high) {
        vueData.param.low = low;
        vueData.param.high = high;
        changeSalaryDom();
    }

    function changeSalaryDom() {
        getListData();

        var domArr = $('#salary li');
        domArr.removeClass('tag-selected');

        var low = vueData.param.low;
        var high = vueData.param.high;

        if ((low <= 0 && high <= 0) || (low == undefined && high == undefined)) {
            domArr.eq(0).addClass('tag-selected');
        } else if (low <= 0 && high == 500) {
            domArr.eq(1).addClass('tag-selected');
        } else if (low == 500 && high == 1000) {
            domArr.eq(2).addClass('tag-selected');
        } else if (low == 1000 && high == 2000) {
            domArr.eq(3).addClass('tag-selected');
        } else if (low == 2000 && high == 3000) {
            domArr.eq(4).addClass('tag-selected');
        } else if (low == 3000 && high == 4000) {
            domArr.eq(5).addClass('tag-selected');
        } else if (low == 4000 && (high <= 0 || high == undefined)) {
            domArr.eq(6).addClass('tag-selected');
        }
    }
</script>
</body>
</html>