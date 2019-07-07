<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel_update">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel_update">编辑员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_update_input" placeholder="Email">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="deps_update">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_update_btn">保存</button>
            </div>
        </div>
    </div>
</div>

    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增员工</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
                                <span  class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" id="email_add_input" placeholder="Email">
                                <span  class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId" id="deps_add">

                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="save_change_btn">保存</button>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h1>SSM_CRUD</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8 col-md-offset-8">
                <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
                <button class="btn btn-danger" id="emp_delete_btn">删除</button>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="emps_table">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="check_all"/>
                            </th>
                            <th>#</th>
                            <th>lastName</th>
                            <th>email</th>
                            <th>gender</th>
                            <th>deptName</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody></tbody>

                </table>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6" id="page_info">

            </div>
            <div class="col-md-6" id="page_nav">

            </div>

        </div>
    </div>
    <script type="text/javascript">
        var totalRecord;
        var currentPage;
        $(function () {
            toPage(1);
        });

        function toPage(pn){
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn=" + pn,
                type:"get",
                success:function (result) {
                    // console.log(result);
                    build_emps_table(result);
                    build_page_info(result);
                    build_page_nav(result)
                }
            })
        }

        function build_emps_table(result){
            $("#emps_table tbody").empty();
            var emps = result.extend.pageInfo.list;
            $.each(emps, function (index, emp) {
                var checkTd = $("<td></td>").append("<input type='checkbox' class='check_item'/>")
                var empTdTd = $("<td></td>").append(emp.empId);
                var empempNameTd = $("<td></td>").append(emp.empName);
                var emailTd = $("<td></td>").append(emp.email);
                var genderTd = $("<td></td>").append(emp.gender);
                var deptNameTd = $("<td></td>").append(emp.department.deptName);
                /**
                 * <button class="btn btn-primary btn-sm">
                 <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                 编辑
                 </button>
                 <button class="btn btn-danger btn-sm">
                 <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                 删除
                 </button>
                 * @type {jQuery|HTMLElement}
                 */
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm btn_update")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                editBtn.attr("edit_id", emp.empId);
                $("#save_update_btn").attr("update_id",emp.empId);
                var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm btn_delete")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                deleteBtn.attr("delete_id", emp.empId);
                var btnTd = $("<td></td>").append(editBtn).append(deleteBtn);

                $("<tr></tr>").append(checkTd).append(empTdTd).append(empempNameTd).append(emailTd)
                    .append(genderTd).append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");
            });
        }

        function build_page_info(result){
            $("#page_info").empty();
            $("#page_info").append("当前第"+result.extend.pageInfo.pageNum+"页,共有"+result.extend.pageInfo.pages+"页," +
                "总计"+result.extend.pageInfo.total+"条记录");
            totalRecord = result.extend.pageInfo.total;
            currentPage = result.extend.pageInfo.pageNum;
        }

        function build_page_nav(result){
            $("#page_nav").empty();
            var ul = $("<ul></ul>").addClass("pagination");
            var firstPage = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
            var prePage = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));
            if(result.extend.pageInfo.hasPreviousPage == false){
                firstPage.addClass("disabled");
                prePage.addClass("disabled");
            }else{
                firstPage.click(function(){
                    toPage(1);
                });
                prePage.click(function(){
                    toPage(result.extend.pageInfo.pageNum - 1);
                });
            }

            ul.append(firstPage).append(prePage);
            $.each(result.extend.pageInfo.navigatepageNums, function(index, num){
                var numLi = $("<li></li>").append($("<a></a>").append(num).attr("href", "#"));
                if(num == result.extend.pageInfo.pageNum){
                    numLi.addClass("active");
                }
                numLi.click(function(){
                    toPage(num);
                });
                ul.append(numLi);
            });
            var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href", "#"));
            var lastPage = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
            if(result.extend.pageInfo.hasNextPage == false){
                lastPage.addClass("disabled");
                nextPage.addClass("disabled");
            }else{
                lastPage.click(function(){
                    toPage(result.extend.pageInfo.pages);
                });
                nextPage.click(function(){
                    toPage(result.extend.pageInfo.pageNum + 1);
                });
            }
            ul.append(nextPage).append(lastPage);
            var nav = $("<nav></nav>").append(ul);
            nav.appendTo("#page_nav");
        }

        function reset_form(ele){
            $(ele)[0].reset();
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }

        $("#emp_add_modal_btn").click(function () {
            // $("#empAddModal form ")[0].reset();
            reset_form("#empAddModal form ");
            getDeps("#deps_add");
            $("#empAddModal").modal({
                backdrop:"static"
            });
        });

        //部门查询下拉框
        function getDeps(ele){
            $(ele).empty();
            $.ajax({
                url:"${APP_PATH}/deps",
                type:"get",
                success:function (result) {
                    // console.log(result);
                    $.each(result.extend.deps, function (index, item) {
                        $(ele).append($("<option></option>").append(item.deptName).attr("value",item.depatId));
                    })

                }
            });
        }

        $("#save_change_btn").click(function () {
            保存之前进行校验
            if(!verification_add_emp()){
                return false;
            }
            重名校验
            if($(this).attr("ajax-va") == "error"){
                return false;
            }
            // alert($("#empAddModal form").serialize());
            saveEmp();
        });

        function saveEmp(){
            $.ajax({
                url:"${APP_PATH}/empSave",
                type:"POST",
                data:$("#empAddModal form").serialize(),
                success:function (result) {
                    if(result.code == 100){
                        alert(result.msg);
                        $('#empAddModal').modal('hide');
                        toPage(totalRecord);
                    }else{
                        // console.log(result);
                        if(undefined != result.extend.fieldErrors.email){
                            show_verification("#email_add_input","error",result.extend.fieldErrors.email);
                        }
                        if(undefined != result.extend.fieldErrors.empName){
                            show_verification("#empName_add_input","error",result.extend.fieldErrors.empName);
                        }
                    }
                }
            });
        }
        //校验函数
        function verification_add_emp(){
            //拿到要验证的数据，使用正则表达式
            var empName = $("#empName_add_input").val();
            var reName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if(!reName.test(empName)){
                // alert("用户名可以是6-16位英文跟数字以及2-5位中文的组合");
                show_verification("#empName_add_input","error","用户名可以是6-16位英文跟数字以及2-5位中文的组合");
                return false;
            }else{
                show_verification("#empName_add_input","success","");
            }
            var email = $("#email_add_input").val();
            var reEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!reEmail.test(email)){
                // alert("邮箱格式不正确");
                show_verification("#email_add_input","error","邮箱格式不正确");
                return false;
            }else{
                show_verification("#email_add_input","success","");
            }
            return true;
        }


        $("#empName_add_input").change(function () {
            var name = this.value;
            $.ajax({
                url:"${APP_PATH}/check_name",
                type:"get",
                data:"name="+name,
                success:function (result) {
                    if(result.code == 100){
                        show_verification("#empName_add_input", "success", "用户名可用");
                        $("#save_change_btn").attr("ajax-va","success");
                    }else{
                        show_verification("#empName_add_input", "error", result.extend.va_msg);
                        $("#save_change_btn").attr("ajax-va","error");
                    }
                }
                    });
        });



        function show_verification(ele, status, msg){
            $(ele).parent().removeClass("has-error has-success");
            $(ele).next("span").text();
            if("error" == status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
                return false;
            }else if("success" == status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }
        }

        $(document).on("click",".btn_update",function () {
            getDeps("#deps_update");
            getEmp($(this).attr("edit_id"));
            $("#empUpdateModal").modal({
                backdrop:"static"
            });
        })

        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/getEmp/" + id,
                type:"get",
                success:function (result) {
                    // console.log(result);
                    var empData = result.extend.emp;
                    $("#empName_update_static").text(empData.empName);
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#empUpdateModal select").val([empData.dId]);
                }
            });
        }

        //员工更改后保存
        $("#save_update_btn").click(function () {
            //进行邮箱验证
            var email = $("#email_update_input").val();
            var reEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!reEmail.test(email)){
                // alert("邮箱格式不正确");
                show_verification("#email_update_input","error","邮箱格式不正确");
                return false;
            }else{
                show_verification("#email_update_input","success","");
            }

            //发下请求更改员工数据
            $.ajax({
                url:"${APP_PATH}/updatSave/" + $(this).attr("update_id"),
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function (result) {
                    // console.log(result);
                    $("#empUpdateModal").modal('hide');
                    toPage(currentPage);
                }
            });
        });

        //单个删除
        $(document).on("click",".btn_delete",function () {
            var empName = $(this).parents("tr").find("td:eq(1)").text();
            var empId = $(this).attr("delete_id");
            if(confirm("确认删除【"+empName+"】吗?")){
                $.ajax({
                    url:"${APP_PATH}/deleteEmp/"+empId,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        toPage(currentPage);
                    }
                })
            }
        })

        $("#check_all").click(function () {
            // alert($(this).prop("checked"));
            $(".check_item").prop("checked",$(this).prop("checked"));
        });
        
        $(document).on("click",".check_item",function () {
            // alert($(".check_item:checked").length);
            var flag = $(".check_item:checked").length == $(".check_item").length;
                $("#check_all").prop("checked",flag);
        });

        $("#emp_delete_btn").click(function () {
            var names ="";
            var ids = "";
            // alert($(".check_item:checked").parents("tr").find("td:eq(2)").text());
            $.each($(".check_item:checked"),function () {
                names += $(this).parents("tr").find("td:eq(2)").text() + ",";
                ids += $(this).parents("tr").find("td:eq(1)").text() + "-";
            });
            names = names.substring(0, names.length-1);
            ids = ids.substring(0, ids.length-1);
            if(confirm("确定要删除【" + names + "】吗")){
                $.ajax({
                    url:"${APP_PATH}/deleteEmp/" + ids,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        toPage(currentPage);
                    }
                });
            }
        });
    </script>
</body>
</html>
