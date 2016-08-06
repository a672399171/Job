<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>发布新职位</title>
    <%@include file="../common/head.jsp" %>
    <link rel="stylesheet" type="text/css" href="/resources/css/post.css"/>
    <link href="/resources/js/summernote/summernote.css" rel="stylesheet">
    <script src="/resources/js/summernote/summernote.js"></script>
    <script src="/resources/js/summernote/lang/summernote-zh-CN.js"></script>
    <script src="/resources/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <link href="http://g.alicdn.com/sj/dpl/1.5.1/css/sui.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp"/>
<div id="bigDiv"></div>
<div class="container" id="container">
    <div class="row">
        <div class="col-md-8">
            <form class="form-horizontal" method="post" action="/job/add" id="postForm">
                <div class="form-group">
                    <label for="name" class="col-sm-2 control-label">职位名称</label>

                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="name" id="name" placeholder="职位名称">
                    </div>
                </div>
                <div class="form-group">
                    <label for="type" class="col-sm-2 control-label">职位类型</label>

                    <div class="col-sm-10" id="typeDiv">
                        <input type="text" class="form-control" id="type" placeholder="请选择职位类型">

                        <div id="hideJobDiv">
                            <div id="leftList">
                                <ul></ul>
                            </div>
                            <div id="rightList">
                                <ul></ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">月薪范围</label>

                    <div class="col-sm-3">
                        <input type="number" class="form-control" id="low_salary" name="low_salary" placeholder="最低月薪">
                    </div>
                    <div class="col-sm-3">
                        <input type="number" class="form-control" id="high_salary" name="high_salary"
                               placeholder="最高月薪">
                    </div>
                </div>
                <div class="form-group">
                    <label for="type" class="col-sm-2 control-label">职位描述</label>

                    <div class="col-sm-10">
                        <div id="description"></div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">招聘人数</label>

                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="person_count" name="person_count"
                               placeholder="招聘人数">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">技能要求</label>

                    <div class="col-sm-10">
                        <div id="skill"></div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">职位标签</label>

                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="addInput"/>
                        <button type="button" class="btn btn-default" onclick="addTag()">添加</button>
                        <label>添加自定义标签</label>
                        <ul id="tagContainer" class="sui-tag tag-bordered"></ul>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">工作时间</label>

                    <div class="col-sm-10">
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
                    </div>
                </div>
                <input type="hidden" name="work_time" id="work_time"/>
                <input type="hidden" name="tag" id="tag"/>
                <input type="hidden" name="type" id="typeHidden"/>
                <input type="hidden" name="description" id="des"/>
                <input type="hidden" name="skill" id="sk"/>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-default" onclick="return setData()">保存职位</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="application/javascript">
    var objs = [];
    var tags = undefined;

    $("#typeDiv").click(function () {
        $("#hideJobDiv").show();
        $("#bigDiv").show();
    });

    //初始化编辑器
    function initEditer() {
        var config = {
            height: 100,
            minHeight: null,
            maxHeight: null,
            focus: true,
            lang: 'zh-CN',
            toolbar: [
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['fontname']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height', 'link']]
            ]
        };

        $('#description').summernote(config);
        $('#skill').summernote(config);
    }

    function addTag() {
        var tagText = $('#addInput').val();

        if (tagText.trim().length > 0) {
            var li = $("<li class='tag-selected with-x'>" + tagText + "<i>×</i></li>");

            $('#tagContainer').append(li);
            $('#addInput').val("");

            li.click(function () {
                li.toggleClass("tag-selected");
            });
            li.children('i').click(function () {
                $(this).parent().remove();
            });
        } else {
            alert("请输入标签内容");
        }
    }

    $(function () {
        $("#hrefUl li a").removeClass("activeTitle");
        $("#job_manage a").addClass("activeTitle");

        //初始化编辑器
        initEditer();

        $("#bigDiv").width(window.screen.availWidth - 40);
        $("#bigDiv").height(window.screen.availHeight - 40);
        initData();

        $('#postForm').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                name: {
                    message: '职位名称不能为空',
                    validators: {
                        notEmpty: {
                            message: '职位名称不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 30,
                            message: '职位名称为1-30位之间'
                        }
                    }
                },
                type: {
                    message: '类型不能为空',
                    validators: {
                        notEmpty: {
                            message: '类型不能为空'
                        }
                    }
                },
                low_salary: {
                    validators: {
                        notEmpty: {
                            message: '工资不能为空'
                        }
                    }
                },
                high_salary: {
                    validators: {
                        notEmpty: {
                            message: '工资不能为空'
                        }
                    }
                }
            }
        });
    });

    $("#rightList ul li").click(function () {
        $("#rightList ul li").css("background", "white");
        $(this).css("background", "grey");
    });

    function initData() {
        $.getJSON('/resources/json/tags.json', function (data) {
            tags = data;
            $('#tagContainer').html('');

            tags.forEach(function (e) {
                $('#tagContainer').append("<li>" + e + "</li>");
            });

            $('#tagContainer li').click(function () {
                $(this).toggleClass("tag-selected");
            });
        });

        $.getJSON("/job/typeData", function (data) {
            var classifies = data;
            var classify = undefined;
            for (var i = 0; i < classifies.length; i++) {
                classify = classifies[i];
                var li = $("<li>" + classify.name + "</li>");
                $("#leftList ul").append(li);
            }
            $("#leftList ul li").click(function () {
                $("#leftList ul li").css("background", "white");
                $(this).css("background", "grey");

                var text = $(this).text();

                $("#rightList ul").html("");

                classifies.forEach(function (e) {
                    if (e.name === text) {
                        for (var i = 0; i < e.positions.length; i++) {
                            var position = e.positions[i];
                            $("#rightList ul").append("<li id='" + position.id + "'>" + position.name + "</li>");
                        }
                        $("#rightList ul li").click(function () {
                            $("#rightList ul li").css("background", "white");
                            $(this).css("background", "grey");
                            $("#type").val($(this).text());
                            $("#typeHidden").val($(this).attr("id"));
                        });

                        return;
                    }
                });
            });
        });
    }

    $("#bigDiv").click(function () {
        $("#hideJobDiv").hide();
        $("#bigDiv").hide();
    });

    $("#type").focus(function () {
        $("#type").blur();
    });

    function getSpareTime() {
        var number = 0;
        var week = $("#week td :checkbox");
        for (var i = 0; i < week.length; i++) {
            if (week.eq(i).is(":checked")) {
                number += Math.pow(2, 7 - 1 - i);
            }
        }

        return number;
    }

    function setData() {
        $("#work_time").val(getSpareTime());
        var array = [];

        $('#tagContainer .tag-selected').forEach(function (e) {
            array.push($(this).text());
        });

        $("#tag").val(array.join("#"));
        $("#des").val($('#description').summernote('code'));
        $("#sk").val($('#skill').summernote('code'));

        if ($("input[name='type']").val() == 0) {
            alert("填写类型");
            return false;
        }

        if ($("input[name='low_salary']").val() > $("input[name='high_salary']").val()) {
            alert("工资范围错误");
            return false;
        }

        $.post('/job/add', {
            "type.id": $('#typeHidden').val(),
            "name": $('#name').val(),
            "description": $('#des').val(),
            "person_count": $('#person_count').val(),
            "skill": $('#sk').val(),
            "high_salary": $('#high_salary').val(),
            "low_salary": $('#low_salary').val(),
            "post_company.id": '${sessionScope.company.id}',
            "tag": $('#tag').val(),
            "work_time": $("#work_time").val()
        }, function (data) {
            if (data.success) {
                window.location = '/company/jobManage';
            } else {
                alert(data.error);
            }
        }, 'JSON');

        return false;
    }

</script>
</body>
</html>

