<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2022/4/20
  Time: 15:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<jsp:forward page="/getAllEmp"></jsp:forward>--%>
<html>
<head>
    <title>首页</title>
    <% pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--    引入jquery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <%--    引入样式--%>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<%--员工修改模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="empUpdateModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <div class="col-md-12 col-lg-offset-5">
                    <h4 class="modal-title">员工修改</h4>
                </div>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="form_updateEmp">
                    <div class="form-group">
                        <label for="inputEmpName" class="col-sm-2 control-label">empName：</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="updateEmpName" name="empName"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail" class="col-sm-2 control-label">email：</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="updateEmail"
                                   placeholder="default@123.com">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender：</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="1"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="0"
                                       checked="checked"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">dept：</label>
                        <div class="col-xs-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="btn_updateEmp">更新员工</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<%--员工添加模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="empAddModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <div class="col-md-12 col-lg-offset-5">
                    <h4 class="modal-title">员工添加</h4>
                </div>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="form_addEmp">
                    <div class="form-group">
                        <label for="inputEmpName" class="col-sm-2 control-label">empName：</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="inputEmpName"
                                   placeholder="default">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail" class="col-sm-2 control-label">email：</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="inputEmail"
                                   placeholder="default@123.com">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender：</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="inlineRadioGender1" value="1"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="inlineRadioGender0" value="0"
                                       checked="checked"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">dept：</label>
                        <div class="col-xs-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="btn_addEmp">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 搭建显示页面 -->
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!-- 显示分页信息 -->
    <div class="row">
        <!--分页文字信息  -->
        <div class="col-md-6" id="page_info_area"></div>
        <!-- 分页条信息 -->
        <div class="col-md-offset-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord, currentPage;

    //显示校验结果的提示信息
    function show_validate_msg(ele, status, msg) {
        // alert(msg);
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");

        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验用户名是否可用
    function validate_add_form() {
        var empName = $("#inputEmpName").val();
        var empNamePatt = /(^\w{6,16}$)|(^[\u2E80-\u9FFF]{2,10})/;
        if (!empNamePatt.test(empName)) {
            show_validate_msg("#inputEmpName", "error", "名称不合法6-16英文 数字 - _ 或者2-10位中文");
            $("#btn_addEmp").attr("ajax-va", "error");
            return false;
        } else {
            show_validate_msg("#inputEmpName", "success", "");
        }
    }

    //校验邮箱是否可用
    $("#inputEmail").change(function () {
        var email = this.value;
        // var email1 = $("#inputEmail").val();
        // alert(this);
        // alert($("#inputEmail"));
        var emailPatt = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!emailPatt.test(email)) {
            show_validate_msg("#inputEmail", "error", "邮箱格式不对");
            $("#btn_addEmp").attr("ajax-va", "error");
        } else {
            show_validate_msg("#inputEmail", "success", "");
            $("#btn_addEmp").attr("ajax-va", "success");
        }
    });

    //校验用户名是否可用
    $("#inputEmpName").change(function () {
        var empName = this.value;
        var empNamePatt = /^\w{6,16}$|(^[\u2E80-\u9FFF]{2,10})/;
        if (!empNamePatt.test(empName)) {
            show_validate_msg("#inputEmpName", "error", "名称不合法6-16英文 数字 - _ 或者2-10位中文");
            $("#btn_addEmp").attr("ajax-va", "error");
        } else {
            //发送ajax请求校验用户名是否可用
            $.ajax({
                url: "${APP_PATH}/checkEmpNameExist",
                data: "empName=" + empName,
                type: "GET",
                success: function (responseBody) {
                    var result = $.parseJSON(responseBody);
                    // alert(result.extend.ajax_va);
                    if (result.code == 100) {
                        show_validate_msg("#inputEmpName", "success", "");
                        $("#btn_addEmp").attr("ajax-va", "success");
                    } else {
                        show_validate_msg("#inputEmpName", "error", result.extend.ajax_va);
                        $("#btn_addEmp").attr("ajax-va", "error");
                    }
                }
            });
        }
    });

    //保存员工按钮
    $("#btn_addEmp").click(function () {
        //判断之前的ajax用户名校验和用户名格式校验是否成功。如果成功。
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }
        $.ajax({
            url: "${APP_PATH}/emp",
            data: $("#empAddModal form").serialize(),
            type: "POST",
            success: function (responseBody) {
                var result = $.parseJSON(responseBody);
                if (result.code == 100) {
                    $("#empAddModal").modal('hide');
                    to_page(totalRecord);
                } else {
                    //显示失败信息
                    if (undefined != result.extend.fieldErrors.email) {
                        show_validate_msg("#inputEmail", "error", result.extend.fieldErrors.email);
                    }
                    if (undefined != result.extend.fieldErrors.empName) {
                        show_validate_msg("#inputEmpName", "error", result.extend.fieldErrors.empName);
                    }
                }
            }
        });
    });

    //清除表单数据（表单完整重置（表单的数据，表单的样式））
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //发送ajax请求，查出部门信息，显示在下拉列表中
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/getAllDept",
            type: "GET",
            success: function (responseBody) {
                var result = $.parseJSON(responseBody);
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //点击新增按钮弹出模态框。
    $("#emp_add_modal_btn").click(function () {
        //清除表单数据（表单完整重置（表单的数据，表单的样式））
        reset_form("#empAddModal form");
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empAddModal select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    //校验修改的邮箱是否可用
    $("#updateEmail_").change(function () {
        var email = this.value;
        var emailPatt = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!emailPatt.test(email)) {
            show_validate_msg("#updateEmail", "error", "邮箱格式不对");
            $("#btn_addEmp").attr("ajax-va", "error");
        } else {
            show_validate_msg("#updateEmail", "success", "");
            $("#btn_addEmp").attr("ajax-va", "success");
        }
    });

    //根据id查出并且回显需要修改的emp
    function getEmp(empId) {
        $.ajax({
            url: "${APP_PATH}/emp/" + empId,
            type: "GET",
            success: function (responseBody) {
                var result = $.parseJSON(responseBody);
                var emp = result.extend.emp;
                $("#updateEmpName").text(emp.empName);
                $("#updateEmail").val(emp.email);
                $("#empUpdateModal input[name=gender]").val([emp.gender]);
                $("#empUpdateModal select").val([emp.dId]);
            }
        });
    }

    //更新员工按钮
    <%--$("#btn_updateEmp_").click(function () {--%>
    <%--    if ($(this).attr("ajax-va") == "error") {--%>
    <%--        return false;--%>
    <%--    }--%>
    <%--    var empId = $(this).attr("edit-id");--%>
    <%--    // alert(empId)--%>
    <%--    $.ajax({--%>
    <%--        url: "${APP_PATH}/emp/" + empId,--%>
    <%--        data: $("#empUpdateModal form").serialize() + "&_method=PUT",--%>
    <%--        type: "POST",--%>
    <%--        success: function (responseBody) {--%>
    <%--            var result = $.parseJSON(responseBody);--%>
    <%--            if (result.code == 100) {--%>
    <%--                $("#empUpdateModal").modal("hide");--%>
    <%--                alert(currentPage);--%>
    <%--                to_page(currentPage);--%>
    <%--            } else {--%>
    <%--                //显示失败信息--%>
    <%--                show_validate_msg("#updateEmail", "error", result.extend.fieldErrors.email);--%>
    <%--            }--%>

    <%--        }--%>
    <%--    });--%>
    <%--});--%>
    //更新员工按钮
    $("#btn_updateEmp").click(function () {
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }
        var empId = $(this).attr("edit-id");
        // alert(empId)
        $.ajax({
            url: "${APP_PATH}/emp/" + empId,
            data: $("#empUpdateModal form").serialize(),
            type: "PUT",
            success: function (responseBody) {
                var result = $.parseJSON(responseBody);
                if (result.code == 100) {
                    $("#empUpdateModal").modal("hide");
                    // $("#empUpdateModal").modal('toggle');
                    // alert(currentPage);
                    to_page(currentPage);
                } else {
                    //显示失败信息
                    show_validate_msg("#updateEmail", "error", result.extend.fieldErrors.email);
                }

            }
        });
    });

    //点击编辑按钮弹出模态框
    $(document).on("click", ".edit_btn", function () {
        $("#empUpdateModal form").find("*").removeClass("has-error has-success");
        $("#empUpdateModal form").find(".help-block").text("");
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empUpdateModal select");
        //根据id查出需要回显的emp
        var empId = $(this).attr("edit-id");
        // alert(empId);
        getEmp(empId);
        //保存员工empId到模态框的更新按钮
        $("#btn_updateEmp").attr("edit-id", empId);
        //弹出修改模态框
        $("#empUpdateModal").modal({
            // backdrop: false
            backdrop: "static",
            //键盘上的 esc 键被按下时关闭模态框。
            // keyboard: true

        });
    });

    //点击删除单个员工
    $(document).on("click", ".delete_btn", function () {
        var empId = $(this).attr("del-id");
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        if (confirm("确认删除（" + empName + "）么？")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (responseBody) {
                    var result = $.parseJSON(responseBody);
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    //点击删除选中的员工
    $("#emp_delete_all_btn").click(function () {
        var checkedNames = "";
        var checkedEmpId = "";
        $(".check_item:checked").each(function () {
            checkedNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            checkedEmpId += $(this).parents("tr").find("td:eq(1)").text() + "_";
        });
        // alert(checkedEmpId);
        var names = checkedNames.substring(0,checkedNames.length - 1);
        if (confirm("确认删除（" + names + "）这些员工么？")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + checkedEmpId,
                type: "DELETE",
                success: function (responseBody) {
                    var result = $.parseJSON(responseBody);
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    //全选/全不选
    $("#check_all").click(function () {
        $(".check_item").prop("checked", $(this).prop("checked"));
    });
    $(document).on("click", ".check_item", function () {
        //判断选中的个数是不是等于显示的个数,相等全选。
        var flag = $(".check_item").length == $(".check_item:checked").length;
        $("#check_all").prop("checked", flag);
    });


    //1、页面加载完成以后，直接去发送ajax请求,要到分页数据
    $(function () {
        //去首页
        to_page(1);
    });

    //去首页
    function to_page(pn) {
        // $("#check_all").prop("checked","");
        $("#check_all").removeAttr("checked");
        $.ajax({
            url: "${APP_PATH}/getAllEmp",
            data: "pn=" + pn,
            type: "GET",
            success: function (responseBody) {
                // var result = jQuery.parseJSON(responseBody);
                var result = $.parseJSON(responseBody);
                // console.log(result);
                // 1、解析并显示员工数据
                build_emps_table(result);
                // //2、解析并显示分页信息
                build_page_info(result);
                // //3、解析显示分页条数据
                build_page_nav(result);
            }
        });
    }

    function build_emps_table(result) {
        //清空table表格
        $("#emps_table tbody").empty();
        //获取员工数据
        var emps = result.extend.empPageInfo.list;

        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == '1' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.dept.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前员工id
            editBtn.attr("edit-id", item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性来表示当前删除的员工id
            delBtn.attr("del-id", item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            // var delBtn =
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + result.extend.empPageInfo.pageNum + "页,总" +
            result.extend.empPageInfo.pages + "页,总" +
            result.extend.empPageInfo.total + "条记录");
        totalRecord = result.extend.empPageInfo.total;
        currentPage = result.extend.empPageInfo.pageNum;
    }

    //解析显示分页条，点击分页要能去下一页....
    function build_page_nav(result) {
        //page_nav_area
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        //构建元素
        // var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        // var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.empPageInfo.hasPreviousPage == false) {
            // firstPageLi.addClass("disabled");
            // prePageLi.addClass("disabled");
        } else {
            //构建元素
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            //为元素添加点击翻页的事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.empPageInfo.pageNum - 1);
            });
        }


        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.empPageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.empPageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.empPageInfo.pages);
            });
        }
        //添加首页和前一页 的提示
        ul.append(firstPageLi).append(prePageLi);
        //1,2，3遍历给ul中添加页码提示
        $.each(result.extend.empPageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.empPageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加下一页和末页 的提示
        ul.append(nextPageLi).append(lastPageLi);

        //把ul加入到nav
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
</script>
</body>
</html>
