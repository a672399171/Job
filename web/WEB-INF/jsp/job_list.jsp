<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <title>工作列表</title>
    <link rel="stylesheet" type="text/css"
          href="${root}/jquery-easyui-1.4.4/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css"
          href="${root}/jquery-easyui-1.4.4/themes/icon.css"/>
    <link rel="stylesheet" href="${root}/font-awesome-4.3.0/css/font-awesome.min.css">
    <script type="text/javascript"
            src="${root}/js/jquery-1.11.2.js"></script>
    <script type="text/javascript"
            src="${root}/js/jquery.fullPage.min.js"></script>
    <script type="text/javascript"
            src="${root}/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${root}/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="${root}/bootstrap-3.3.4-dist/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${root}/css/common.css"/>
    <script src="${root}/bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
    <style type="text/css">
        #top,#middle {
            background: white;
            min-width: 800px;
            width: 70%;
            margin-left: 150px;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .job_item {
            width: 100%;
            height: 100px;
            border-bottom: 1px solid #cccccc;
            background: white;
            padding: 10px;
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
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/header.jsp"/>

<div id="top" class="container">
    <div class="row">
        <div class="col-md-2">
            类别
        </div>
        <div class="col-md-10">
            leibie
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
            月薪
        </div>
        <div class="col-md-10">
            leibie
        </div>
    </div>
</div>

<div id="middle">
    <div class="job_item" url="www.baidu.com">
        <table>
            <tr>
                <td width="300"><a href="#" class="link">金融销售</a></td>
                <td width="200" class="font3">今天</td>
                <td width="300" class="font5">国晟鸿业(厦门)资产管理有限公司</td>
            </tr>
            <tr>
                <td class="font5">应届生</td>
                <td class="font4">3000-6000</td>
                <td class="font3">民营/私企 | 101－300人</td>
            </tr>
        </table>
    </div>
    <div class="job_item">

    </div>
    <div class="job_item">

    </div>
    <div class="job_item">

    </div>
    <div class="job_item">

    </div>
</div>

<jsp:include page="/WEB-INF/jsp/footer.jsp"/>

<script type="application/javascript">

</script>
</body>
</html>

