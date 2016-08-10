<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>${job.name}</title>
    <%@include file="common/head.jsp" %>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
    <link href="http://g.alicdn.com/sj/dpl/1.5.1/css/sui.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/resources/css/style_job_detail.css"/>
    <script src="/resources/js/dateformat.js"></script>
    <script src="//cdn.bootcss.com/moment.js/2.14.1/moment-with-locales.min.js"></script>
    <script src="/resources/scripts/vue.js"></script>
    <script src="/resources/js/filters/filters.js"></script>
    <script src="/resources/js/directives/directives.js"></script>
    <style>
        .red {
            color: red;
        }
    </style>
</head>
<body>
<div class="big container">
    <%@include file="common/header.jsp" %>

    <div class="row">
        <div class="col-md-8" id="top">
            <h2>${job.name}
                <i class="fa fa-star" id="collect" v-on:click="updateCollection()" v-bind:class="{'red':collection}"></i>
            </h2>

            <div class="require">
                <span class="font4" style="margin-right: 30px">${job.low_salary}-${job.high_salary}</span>
                <span class="date" style="margin-right: 30px">
                    <fmt:formatDate pattern="yyyy-MM-dd hh:MM" value="${requestScope.job.post_time}"/>
                </span>
                <span class="font5">${job.type.name}</span>
                <c:if test="${requestScope.job.status == 0}">
                    <span style="color: red;font-size: 18px">该职位暂未运行</span>
                </c:if>
                <c:if test="${requestScope.job.status == 1}">
                    <c:choose>
                        <c:when test="${requestScope.apply == null}">
                            <button class="btn btn-danger" id="apply">申请职位</button>
                        </c:when>
                        <c:otherwise>
                            <button class="btn btn-danger" id="apply" disabled>申请中</button>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </div>
            <ul class="sui-tag tag-selected">
                <c:forEach var="item" items="${fn:split(job.tag,'#')}">
                    <li class="tag-selected">${item}</li>
                </c:forEach>
            </ul>
            <div>
                <h4>职位介绍</h4>

                <h5>招聘人数：${job.person_count}</h5>
                <p>
                    技能要求：${job.skill}
                </p>

                <p>
                    职位描述：${job.description}
                </p>

                <p>
                    工作时间：
                <table id="table" class="weekTable">
                    <tr>
                        <td>星期一</td>
                        <td>星期二</td>
                        <td>星期三</td>
                        <td>星期四</td>
                        <td>星期五</td>
                        <td>星期六</td>
                        <td>星期日</td>
                    </tr>
                    <tr id="week">
                        <td><input type="checkbox"/></td>
                        <td><input type="checkbox"/></td>
                        <td><input type="checkbox"/></td>
                        <td><input type="checkbox"/></td>
                        <td><input type="checkbox"/></td>
                        <td><input type="checkbox"/></td>
                        <td><input type="checkbox"/></td>
                    </tr>
                </table>
                </p>
            </div>
            <h4>公司介绍</h4>

            <h5>公司全名：${job.post_company.company_name}</h5>
            <h5>公司地址：${job.post_company.address}</h5>
            <h5>公司规模：${job.post_company.scope}</h5>
            <h5>联系人：${job.post_company.name}</h5>
            <h5>手机号：${job.post_company.phone}</h5>
            <h5>邮箱：${job.post_company.email}</h5>
            <p>公司简介：${job.post_company.introduce}</p>
            <div id="container"></div>
        </div>

        <div class="col-md-4">
            <div class="companyLogo">
                <img src="/resources/images/${job.post_company.logo}">
                <table style="margin-top: 10px">
                    <tr>
                        <td>公司全名：</td>
                        <td>${job.post_company.company_name}</td>
                    </tr>
                    <tr>
                        <td>公司规模：</td>
                        <td>${job.post_company.scope}</td>
                    </tr>
                    <tr>
                        <td>联系人：</td>
                        <td>${job.post_company.name}</td>
                    </tr>
                    <tr>
                        <td>手机号：</td>
                        <td>${job.post_company.phone}</td>
                    </tr>
                    <tr>
                        <td>邮箱：</td>
                        <td>${job.post_company.email}</td>
                    </tr>
                </table>
            </div>
            <div class="comment" id="allComments">
                <h4>评论列表</h4>

                <div id="content">
                    <div v-for="item in list">
                        <div>
                            <img src="/resources/images/{{item.user.photo_src}}" class='headPhoto'>
                            <span style="color: #2b542c">{{item.user.nickname}}</span>
                            <span>{{item.c_time | timestampFilter 'YYYY-MM-DD hh:mm'}}</span>
                        </div>
                        <div class='contentDiv'>
                            <p>{{item.content}}</p>
                        </div>
                    </div>
                </div>

                <div class="sui-pagination pagination-naked pagination-large">
                    <ul>
                        <li class="prev" v-bind:class="{'disabled':page<=1}"><a href="javascript:void(0)"
                                                                                v-on:click="toPage(page-1)">上一页</a></li>
                        <li><span class="ex-page-status">{{page}}/{{totalPage}}</span></li>
                        <li class="next" v-bind:class="{'disabled':page>=totalPage}"><a href="javascript:void(0)"
                                                                                        v-on:click="toPage(page+1)">下一页 </a>
                        </li>
                    </ul>
                </div>

                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <div style="width: 100%">
                            <textarea rows="3" style="width: 100%" id="comment"></textarea>
                            <button class="btn btn-danger" ng-click="postComment()">发表评论</button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <span class="font3"><a href="/login" style="color: red" id="loginHref">登录</a>后才能评论哦~</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="allJobs" id="allJobs">
                    <h4>该公司所有职位</h4>

                    <div class="job_item" style="display: block" v-for="item in list" v-on:click="toUrl(item.id)">
                        <table>
                            <tr>
                                <td width="30%"><a href="#" class="link">{{item.name}}</a></td>
                                <td width="30%" class="font3">{{item.post_time | timestampFilter 'YYYY-MM-DD hh:mm'}}
                                </td>
                                <td width="30%" class="font5">{{item.post_company.company_name}}</td>
                            </tr>
                            <tr>
                                <td class="font5">{{item.type.name}}</td>
                                <td class="font4">{{item.low_salary}}-{{item.high_salary}}</td>
                                <td class="font3">{{item.post_company.scope}}</td>
                            </tr>
                        </table>
                    </div>

                    <div class="sui-pagination">
                        <ul>
                            <li class="prev" v-bind:class="{'disabled':page <= 1}"><a href="javascript:void(0)">«上一页</a>
                            </li>
                            <li v-bind:class="{'active':item+1 == page}" v-for="item in totalPage">
                                <a href="javascript:void(0)" v-on:click="load(item+1)">{{ item+1 }}</a>
                            </li>
                            <li class="dotted" v-if="totalPage < 5"><span>...</span></li>
                            <li class="next" v-bind:class="{'disabled':page == totalPage}"><a href="javascript:void(0)">下一页»</a>
                            </li>
                        </ul>
                        <div>
                            <span>共{{ totalPage }}页&nbsp;</span>
                            <span v-if="totalPage >= 10">
                                到<input type="text" class="page-num">
                                <button class="page-confirm" onclick="alert(1)">确定</button>页
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="otherJobs">
                    <h4>职位推荐</h4>
                    <c:if test="${sessionScope.user == null}">
                        <span style="color: red">登录后可见</span>
                    </c:if>

                    <div class="job_item" style="display: block" ng-repeat="item in data" ng-click="toUrl(item.id)">
                        <table>
                            <tr>
                                <td width="30%"><a href="#" class="link">{{item.name}}</a></td>
                                <td width="30%" class="font3">{{item.post_time.time | dateFilter 'YYYY-MM-DD hh:mm'}}
                                </td>
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
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>

<script type="application/javascript">

    //记录收藏按钮的状态
    var flag = true;

    function initMap() {
        var map = new BMap.Map("container");          // 创建地图实例
        var point = new BMap.Point(${job.post_company.x}, ${job.post_company.y});  // 创建点坐标
        map.centerAndZoom(point, 15);               // 初始化地图，设置中心点坐标和地图级别
        var opts = {type: BMAP_NAVIGATION_CONTROL_LARGE};
        map.addControl(new BMap.NavigationControl(opts));
        var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
        map.addControl(top_left_control);
        map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
        map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
        var marker = new BMap.Marker(point);        // 创建标注
        map.addOverlay(marker);                     // 将标注添加到地图中
    }

    //格式化时间
    function formatDate() {
        moment.locale("zh_cn");

        var dates = $(".date");
        for (var i = 0; i < dates.length; i++) {
            var dText = dates.eq(i).text();
            dates.eq(i).text(moment(dText, "YYYY-MM-DD hh:mm").fromNow());
        }
    }

    $(function () {
        formatDate();

        flag = ${requestScope.collection != null};
        initMap();
        var spareStr = parseInt(${requestScope.job.work_time}).toString(2);
        var timeLength = spareStr.length;
        if (spareStr.length < 7) {
            for (var i = 0; i < 7 - timeLength; i++) {
                spareStr = "0" + spareStr;
            }
        } else {
            spareStr = spareStr.substr(spareStr.length - 7);
        }

        var week = $("#week td :checkbox");

        for (var i = 0; i < spareStr.length; i++) {
            var c = spareStr.charAt(i);
            week.eq(i).attr("checked", c == '1');
        }
        $(":checkbox").attr("disabled", "disabled");
    });

    //申请职位
    $("#apply").click(function () {
        if (${sessionScope.user == null}) {
            window.location = "/login?from=" + window.location.href;
        } else {
            $.post("/user/applyJob", {
                j_id:'${job.id}'
            }, function (data) {
                if(data.success) {
                    window.location = "/applySuccess";
                } else {
                    alert(data.error);
                }
            }, "JSON");
        }
    });

    var vm = undefined;

    $(function () {
        // 该公司所有职位
        $.get('/job/company/' + '${requestScope.job.post_company.id}' + '/page/1', function (data) {
            if (data.success) {
                vm = new Vue({
                    el: '#allJobs',
                    data: data,
                    methods: {
                        toUrl: function (id) {
                            window.location = '/job/' + id;
                        },
                        load: function (page) {
                            if (page == vm.data.page) {
                                return;
                            }
                            $.get('/job/company/' + '${requestScope.job.post_company.id}' + '/page/' + page, function (data) {
                                if (data.success) {
                                    vm.data = data;
                                }
                            }, 'JSON');
                        }
                    }
                })
            } else {
                alert(data.error);
            }
        }, 'JSON');
        if (${sessionScope.user != null}) {
            $.post('/user/getCollection', {
                j_id: '${job.id}'
            }, function (data) {
                if (data.success) {
                    new Vue({
                        el: '#top',
                        data: data.data,
                        methods: {
                            updateCollection: function () {
                                if (${sessionScope.user == null}) {
                                    window.location = "/login?from=" + window.location.href;
                                } else {
                                    var that = this;
                                    if(that.collection) {
                                        $.post("/user/cancelCollection", {
                                            u_id: '${sessionScope.user.id}',
                                            j_id: '${job.id}'
                                        }, function (data) {
                                            if (data.success) {
                                                that.collection = undefined;
                                            } else {
                                                alert(data.error);
                                            }
                                        }, "JSON");
                                    } else {
                                        $.post("/user/addCollection", {
                                            u_id: '${sessionScope.user.id}',
                                            j_id: '${job.id}'
                                        }, function (data) {
                                            if (data.success) {
                                                that.collection = {id:1};
                                            } else {
                                                alert(data.error);
                                            }
                                        }, "JSON");
                                    }
                                }
                            }
                        }
                    });
                }
            })
        }

        loadComments(1);
    });

    var commentsVm = undefined;

    function loadComments(page) {
        page = page ? page : 1;
        // 职位评论
        $.get('/job/' + '${requestScope.job.id}' + '/comment/page/' + page, function (data) {
            if (data.success) {
                if (commentsVm) {
                    commentsVm.$set('page', data.page);
                    commentsVm.$set('totalPage', data.totalPage);
                    commentsVm.$set('totalItem', data.totalItem);
                    commentsVm.$set('list', data.list);
                } else {
                    commentsVm = new Vue({
                        el: '#allComments',
                        data: data,
                        methods: {
                            toPage: function (p) {
                                console.log(p);
                                if (p > 1 && p <= data.totalPage) {
                                    loadComments(p);
                                }
                            }
                        }
                    })
                }
            } else {
                alert(data.error);
            }
        }, 'JSON');
    }

</script>
</body>
</html>

