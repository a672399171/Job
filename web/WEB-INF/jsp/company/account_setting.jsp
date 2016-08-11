<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>账号设置</title>
    <%@include file="../common/head.jsp" %>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
    <script src="/resources/js/ajaxfileupload.js"></script>
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
<jsp:include page="header.jsp"/>

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
        <div class="col-xs-12">
            <c:if test="${sessionScope.company.auth != 2}">
                <span style="color: red">当前公司暂未通过认证，为了用户的安全，请认真填写公司信息，我们将在1个工作日内给予认证回复，谢谢合作。</span>
            </c:if>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 title">
            账号信息
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <button class="btn btn-danger" onclick="openDlg()" style="margin: 10px;margin-left: 30px">修改密码</button>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 title">
            公司信息
        </div>
    </div>
    <div class="row">
        <div class="col-xs-8">
            <form class="form-horizontal" action="/company/updateCompany" method="post"
                  enctype="multipart/form-data">
                <div class="form-group">
                    <label class="col-xs-2 control-label">公司名称</label>

                    <div class="col-xs-10">
                        <c:choose>
                            <c:when test="${empty company.company_name}">
                                <input type="text" class="form-control" name="company_name" placeholder="公司名称">
                            </c:when>
                            <c:otherwise>
                                <p class="form-control-static">${company.company_name}</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">公司地址</label>

                    <div class="col-xs-10">
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
                    <label class="col-xs-2 control-label">标明地址</label>

                    <div class="col-xs-10" id="mapContainer">

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">公司类型</label>

                    <div class="col-xs-10">
                        <c:choose>
                            <c:when test="${empty company.type}">
                                <select name="type" class="form-control">
                                    <option value="民营">民营</option>
                                    <option value="国企">国企</option>
                                    <option value="中外合资">中外合资</option>
                                    <option value="个人单位">个人单位</option>
                                    <option value="其他">其他</option>
                                </select>
                            </c:when>
                            <c:otherwise>
                                <p class="form-control-static">${company.type}</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">公司规模</label>

                    <div class="col-xs-10">
                        <c:choose>
                            <c:when test="${empty company.scope}">
                                <select name="scope" class="form-control">
                                    <option value="10人以下">10人以下</option>
                                    <option value="10-100人">10-100人</option>
                                    <option value="100-500人">100-500人</option>
                                    <option value="500-1000人">500-1000人</option>
                                    <option value="1000人以上">1000人以上</option>
                                </select>
                            </c:when>
                            <c:otherwise>
                                <p class="form-control-static">${company.scope}</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">公司简介</label>

                    <div class="col-xs-10">
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
                    <label for="logo" class="col-xs-2 control-label">公司logo</label>

                    <div class="col-xs-10">
                        <c:choose>
                            <c:when test="${empty company.logo}">
                                <input type="file" id="logo" name="logo">
                            </c:when>
                            <c:otherwise>
                                <img src="/resource/images/${company.logo}"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-2 control-label">联系人姓名</label>

                    <div class="col-xs-10">
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
                    <label class="col-xs-2 control-label">联系人手机号</label>

                    <div class="col-xs-10">
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
                    <label class="col-xs-2 control-label">公司邮箱</label>

                    <div class="col-xs-10">
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
                    <div class="col-xs-offset-2 col-xs-10">
                        <button type="submit" class="btn btn-default">保存信息</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="../common/footer.jsp" %>
<script type="application/javascript">
    //页面加载完后获取当前位置
    $(function () {
        if ("${requestScope.msg}" != "") {
            alert("${requestScope.msg}");
        }

        $("#hrefUl li a").removeClass("activeTitle");
        $("#account_setting a").addClass("activeTitle");

        if ("${company.x}" >= 0.1 && "${company.y}" >= 0.1) {
            var x = ${company.x};
            var y = ${company.y};
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
        $.post("/company/modifyPassword", {
                    password: $("#password").val(),
                    newPassword: $("#newPassword").val()
                }, function (data) {
                    if(data.success) {
                        $(".shade").click();
                    } else {
                        alert(data.error);
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

