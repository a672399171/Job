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
            {{param | json}}
            <div class="col-md-11">
                <ul>
                    <%--<li v-bind:class="{'on':param}" ng-click="changePid(0)">不限</li>
                    <li v-bind:class="{'on':item.id == param.pId}" v-for="item in positionData"
                        ng-click="changePid(item.id)">
                        {{item.name}}
                    </li>--%>
                </ul>
            </div>
        </div>
        <%--
        <div class="row selectType" id="timeDiv">
            <div class="col-md-1">
                工作时间:
            </div>
            <div class="col-md-11">
                <ul>
                    <li ng-class="{on:timeArray[0]}" ng-click="changeTime(0)">不限</li>
                    <li ng-class="{on:timeArray[1]}" ng-click="changeTime(1)">周一</li>
                    <li ng-class="{on:timeArray[2]}" ng-click="changeTime(2)">周二</li>
                    <li ng-class="{on:timeArray[3]}" ng-click="changeTime(3)">周三</li>
                    <li ng-class="{on:timeArray[4]}" ng-click="changeTime(4)">周四</li>
                    <li ng-class="{on:timeArray[5]}" ng-click="changeTime(5)">周五</li>
                    <li ng-class="{on:timeArray[6]}" ng-click="changeTime(6)">周六</li>
                    <li ng-class="{on:timeArray[7]}" ng-click="changeTime(7)">周日</li>
                </ul>
            </div>
        </div>
        <div class="row selectType" id="salaryDiv">
            <div class="col-md-1">
                月薪:
            </div>
            <div class="col-md-11">
                <ul>
                    <li ng-class="{on:params.low==0 && params.high=='max'}" ng-click="changeSalary(0,'max')">不限</li>
                    <li ng-class="{on:params.low==0 && params.high==500}" ng-click="changeSalary(0,500)">500以下</li>
                    <li ng-class="{on:params.low==500 && params.high==1000}" ng-click="changeSalary(500,1000)">
                        500-1000
                    </li>
                    <li ng-class="{on:params.low==1000 && params.high==2000}" ng-click="changeSalary(1000,2000)">
                        1000-2000
                    </li>
                    <li ng-class="{on:params.low==2000 && params.high==3000}" ng-click="changeSalary(2000,3000)">
                        2000-3000
                    </li>
                    <li ng-class="{on:params.low==3000 && params.high==4000}" ng-click="changeSalary(3000,4000)">
                        3000-4000
                    </li>
                    <li ng-class="{on:params.low==4000 && params.high=='max'}" ng-click="changeSalary(4000,'max')">
                        4000以上
                    </li>
                </ul>
            </div>
        </div>--%>
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
    $(function () {
        $.getJSON('/job/positionData?cId=${param.cId}', function (data) {
            vueData.positionData = data;
        });

        $.post('/job/listData', vueData.param, function (data) {
            if (data.success) {
                vueData = data;

                new Vue({
                    el: '#app',
                    data: vueData,
                    methods: {}
                });
            } else {
                alert(data.error);
            }
        }, 'JSON');
    });
</script>
</body>
</html>