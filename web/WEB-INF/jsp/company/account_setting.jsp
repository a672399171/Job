<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
    <title>账号设置</title>
    <script type="text/javascript"
            src="${root}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
    <link rel="stylesheet" href="${root}/bootstrap-3.3.4-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${root}/bootstrapvalidator/css/bootstrapValidator.min.css">
    <link rel="stylesheet" href="${root}/font-awesome-4.3.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${root}/css/common.css"/>
    <script src="${root}/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
    <script src="${root}/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <script src="${root}/js/ajaxfileupload.js"></script>
    <style type="text/css">
        #container {
            background: white;
        }

        #mapContainer {
            height: 300px;
        }

        .title {
            border-bottom: 1px solid #F4F4F4;
            font-size: 20px;
            height: 50px;
            line-height: 50px;
            font-weight: bold;
            padding-left: 50px;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>

<div class="shade"></div>
<div class="pop" id="modifyPassword">
    <div class="popTitle">修改密码</div>
    <div class="popBody">
        <div class="form-group">
            <input type="password" class="form-control" id="password" placeholder="输入旧密码">
        </div>
        <div class="form-group">
            <input type="password" class="form-control" id="newPassword" placeholder="输入新密码">
        </div>
        <div class="form-group">
            <input type="password" class="form-control" id="newPassword2" placeholder="确认新密码">
        </div>
        <div class="form-group">
            <button class="btn btn-danger" onclick="modifyPassword()">确认</button>
            <button class="btn btn-default" onclick="$('.shade').click()">取消</button>
        </div>
    </div>
</div>

<div class="container" id="container">
    <div class="row">
        <div class="col-md-12 title">
            账号信息
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <a href="#" onclick="openDlg()">修改密码</a>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 title">
            公司信息
        </div>
    </div>
    <div class="row">
        <div class="col-md-8">
            <form class="form-horizontal" action="${root}/user/updateCompany.do" method="post"
                  enctype="multipart/form-data">
                <div class="form-group">
                    <label class="col-sm-2 control-label">公司名称</label>

                    <div class="col-sm-10">
                        <c:choose>
                            <c:when test="${empty company.company_name}">
                                <input type="email" class="form-control" name="company_name" placeholder="公司名称">
                            </c:when>
                            <c:otherwise>
                                <p class="form-control-static">${company.company_name}</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">公司地址</label>

                    <div class="col-sm-10">
                        <c:choose>
                            <c:when test="${empty company.address}">
                                <input type="text" class="form-control" name="address" placeholder="公司地址">
                            </c:when>
                            <c:otherwise>
                                <p class="form-control-static">${company.address}</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">标明地址</label>

                    <div class="col-sm-10" id="mapContainer">

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">公司类型</label>

                    <div class="col-sm-10">
                        <c:choose>
                            <c:when test="${empty company.type}">
                                <input type="text" class="form-control" name="type" placeholder="公司类型">
                            </c:when>
                            <c:otherwise>
                                <p class="form-control-static">${company.type}</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">公司规模</label>

                    <div class="col-sm-10">
                        <c:choose>
                            <c:when test="${empty company.scope}">
                                <input type="text" class="form-control" name="scope" placeholder="公司规模">
                            </c:when>
                            <c:otherwise>
                                <p class="form-control-static">${company.scope}</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">公司简介</label>

                    <div class="col-sm-10">
                        <c:choose>
                            <c:when test="${empty company.introduce}">
                                <textarea class="form-control" rows="5" name="introduce" placeholder="公司简介"></textarea>
                            </c:when>
                            <c:otherwise>
                                <p class="form-control-static">${company.introduce}</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label for="logo" class="col-sm-2 control-label">公司logo</label>

                    <div class="col-sm-10">
                        <c:choose>
                            <c:when test="${empty company.introduce}">
                                <input type="file" id="logo" name="logo">
                            </c:when>
                            <c:otherwise>
                                <img src="${root}/images/${company.logo}"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">联系人姓名</label>

                    <div class="col-sm-10">
                        <c:choose>
                            <c:when test="${empty company.name}">
                                <input type="text" class="form-control" name="name" placeholder="联系人姓名">
                            </c:when>
                            <c:otherwise>
                                <p class="form-control-static">${company.name}</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">联系人手机号</label>

                    <div class="col-sm-10">
                        <c:choose>
                            <c:when test="${empty company.phone}">
                                <input type="text" class="form-control" name="phone" placeholder="联系人手机号">
                            </c:when>
                            <c:otherwise>
                                <p class="form-control-static">${company.phone}</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">公司邮箱</label>

                    <div class="col-sm-10">
                        <c:choose>
                            <c:when test="${empty company.email}">
                                <input type="email" class="form-control" name="email" placeholder="公司邮箱">
                            </c:when>
                            <c:otherwise>
                                <p class="form-control-static">${company.email}</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <%--记录经纬度--%>
                <input type="hidden" value="113.649171" id="lng" name="lng">
                <input type="hidden" value="34.757521" id="lat" name="lat">

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-default" onclick="return addParams()">保存信息</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="application/javascript">
    //页面加载完后获取当前位置
    $(function () {
        //getLocation();
        var x = ${company.x};
        var y = ${company.y};
        if(x != 0 && y != 0) {
            $("#lng").val(x);
            $("#lat").val(y);
        }

        initMap();
    });

    //初始化地图
    function initMap() {
        var map = new BMap.Map("mapContainer");
        var point = new BMap.Point($("#lng").val(), $("#lat").val());
        map.centerAndZoom(point, 15);
        var opts = {type: BMAP_NAVIGATION_CONTROL_LARGE};
        map.addControl(new BMap.NavigationControl(opts));
        var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});
        map.addControl(top_left_control);
        map.enableScrollWheelZoom();
        map.enableContinuousZoom();
        var marker = new BMap.Marker(point);        // 创建标注
        map.addOverlay(marker);                     // 将标注添加到地图中
        marker.enableDragging();                    //允许拖拽
        marker.addEventListener("dragend", function (e) {
            $("#lng").val(e.point.lng);
            $("#lat").val(e.point.lat);
        })
    }

    //打开对话框
    function openDlg() {
        $(".shade").show();
        $(".pop").show();

        $(".shade").click(function () {
            $(".shade").hide();
            $(".pop").hide();
        });
    }

    //修改密码
    function modifyPassword() {
        $.post("${root}/user/modifyCompanyPassword.do",
                {
                    password: $("#password").val(),
                    newPassword: $("#newPassword").val()
                }, function (data) {
                    if (data.msg == true) {
                        $(".shade").click();
                    } else {
                        alert(data.msg);
                    }
                }, "JSON"
        );
    }

    //html5获取当前位置
    function getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition, showError);
        } else {
            alert("您的浏览器不支持地理定位");
        }
    }

    function showPosition(position) {
        var str = "Latitude: " + position.coords.latitude +
                "Longitude: " + position.coords.longitude;
        console.log(str);
    }

    function showError(error) {
        switch (error.code) {
            case error.PERMISSION_DENIED:
                alert("定位失败,用户拒绝请求地理定位");
                break;
            case error.POSITION_UNAVAILABLE:
                alert("定位失败,位置信息是不可用");
                break;
            case error.TIMEOUT:
                alert("定位失败,请求获取用户位置超时");
                break;
            case error.UNKNOWN_ERROR:
                alert("定位失败,定位系统失效");
                break;
        }
    }
</script>
</body>
</html>

