<%--
  Created by IntelliJ IDEA.
  User: 李淋峰
  Date: 2019/8/6
  Time: 11:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("PATH", request.getContextPath());
    %>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
            http://localhost:3306/crud
     -->
    <script type="text/javascript" src="${PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link href="${PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>


<!-- 修改员工的模态框 -->
<div class="modal fade" id="employeeUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">dept</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="employee_update_btn">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>


<!-- 新增员工的模态框 -->
<div class="modal fade" id="employeeAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">dept</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId" id="dept_add_select"></select>
                            </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="employee_save_btn">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!--搭建显示页面-->
<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary btn-sm" id="employee_add_modal_btn">新增</button>
            <button class="btm btn-danger btn-sm" id="employee_delete_all_btn">删除</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="employees_table">
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
    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area"></div>
        <!--分页文条信息-->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>

</div>

<script type="text/javascript">

    var totalRecord,currentPage;

    //1.页面加载完成以后直接去发送ajax请求，得到分页数据
    $(function () {
        to_page(1);
    });

    //跳转到指定页码
    function to_page(pn) {
        $.ajax({
            url: "${PATH}/employees",
            data: "pn="+pn,
            type: "GET",
            success: function (result) {
                // console.log(result);
                //1.解析并显示员工数据
                build_employees_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析显示分页条信息
                build_page_nav(result);
            }
        });
    }

    //建立员工数据表格
    function build_employees_table(result) {
        //清空表格
        $("#employees_table tbody").empty();

        var employees = result.extend.pageInfo.list;
        $.each(employees, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender);
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.dept.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义的属性，来表示当前员工id
            editBtn.attr("edit_id",item.empId);
            var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义的属性来表示当前删除的员工id
            delBtn.attr("delete_id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#employees_table tbody");
        })
    }

    //解析显示分页信息
    function build_page_info(result) {
        //清空分页信息
        $("#page_info_area").empty();

        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"+
            result.extend.pageInfo.pages+"页,总"+
            result.extend.pageInfo.total+"条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析显示分页条
    function build_page_nav(result) {

        //清空分页条信息
        $("#page_nav_area").empty();

        var ul = $("<ul></ul>").addClass("pagination");

        //构建元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

        //判断首页和前一页是否能点击
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //为元素添加点击翻页的事件
            firstPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum -1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));

        //判断下一页与尾页是否能点击
        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum +1);
            });
            lastPageLi.click(function(){
                to_page(result.extend.pageInfo.pages);
            });
        }



        //添加首页和前一页 的提示
        ul.append(firstPageLi).append(prePageLi);
        //1,2，3遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums,function(index,item){
            var numLi = $("<li></li>").append($("<a></a>").append(item));

            if(result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function(){
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

    //点击新增按钮打开模态框
    $("#employee_add_modal_btn").click(function () {
        //清除表单数据（重置）
        $("#employeeAddModal form")[0].reset();
        $("#empName_add_input").parent().removeClass("has-success has-error");
        $("#empName_add_input").next("span").text("");
        $("#email_add_input").parent().removeClass("has-success has-error");
        $("#email_add_input").next("span").text("");

        //发送Ajax请求，查出部门信息，显示在新增界面
        getDepts("#dept_add_select");

        //弹出模态框
        $("#employeeAddModal").modal({
            backdrop:"static"
        });
    });

    //查询所有部门信息,并显示在下拉框
    function getDepts(e) {
        //清空之前下拉列表的值
        $(e).empty();

        $.ajax({
            url:"${PATH}/depts",
            type:"GET",
            success:function (result) {
               //显示在下拉列表
                $.each(result.extend.depts,function () {
                    var options = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    options.appendTo(e);
                });
            }
        });
    }

    //校验表单数据
    function validate_add_form(){
        //拿到要校验的数据，使用正则表达式
        //1.校验用户名
        var empName = $("#empName_add_input").val();
        //校验用户名的正则
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)){
            //alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            show_validate_message("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        }else{
            show_validate_message("#empName_add_input", "success", "");
        }

        //2.校验邮箱
        var email= $("#email_add_input").val();
        //校验邮箱的正则
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            show_validate_message("#email_add_input", "error", "邮箱格式不正确");
            return false;
        }else{
            show_validate_message("#email_add_input", "success", "");
        }
        return true;
    }

    //显示校验结果的提示信息
    function show_validate_message(ele,status,msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");


        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    
    //校验用户名是否可用
    $("#empName_add_input").change(function () {
        var empName = this.value;
        $.ajax({
            url:"${PATH}/checkName",
            type:"POST",
            data:"empName="+empName,
            success:function (result) {
                if(result.code==100){
                    show_validate_message("#empName_add_input","success","用户名可用");
                    //自定义保存状态是否成功
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_message("#empName_add_input","error","用户名重复");
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        })
    });
    
    //点击保存，保存员工
    $("#employee_save_btn").click(function () {
        //模态框中填写的表单数据提交给服务器进行保存
        //1.前端校验需要提交的数据
        if(!validate_add_form()){
          return false;
        }
        //判断之前的ajax用户名校验是否成功。如果成功。
        if($(this).attr("ajax-va")=="error"){
            return false;
        }

        //2.发送Ajax请求新增员工
        $.ajax({
            url:"${PATH}/employee",
            type:"POST",
            data:$("#employeeAddModal form").serialize(),
            success:function (result) {
                if(result.code == 100){
                    //员工保存成功
                    //1.关闭模态框
                    $("#employeeAddModal").modal("hide");
                    //2.来到末页，显示刚才保存的数据
                    to_page(totalRecord);
                }else{
                    //后端校验失败
                    //有哪个字段的错误信息就显示哪个字段的；
                    if(undefined != result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if(undefined != result.extend.errorFields.empName){
                        //显示员工名字的错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }
            }
        });
    })

    //点击编辑弹出修改模态框
    $(document).on("click",".edit_btn",function () {
        //1.查出员工信息
        getEmployee($(this).attr("edit_id"));
        //2.查出部门信息
        getDepts("#employeeUpdateModal select");
        //3.把员工的id传递给模态框的更新按钮
        $("#employee_update_btn").attr("edit_id",$(this).attr("edit_id"));
        //4.弹出模态框
        $("#employeeUpdateModal").modal({
            backdrop:"static"
        });
    });

    //根据ID获取员工信息
    function getEmployee(id) {
        $.ajax({
            url:"${PATH}/employee/"+id,
            type:"GET",
            success:function (result) {
                var data = result.extend.employee;
                $("#empName_update_static").text(data.empName);
                $("#email_update_input").val(data.email);
                $("#employeeUpdateModal  input[name=gender]").val([data.gender]);
                $("#employeeUpdateModal select").val([data.dId]);
            }
        });
    }

    //点击更新，保存员工信息
    $("#employee_update_btn").click(function () {
        //1.验证邮箱是否合法
        //2.校验邮箱
        var email= $("#email_update_input").val();
        //校验邮箱的正则
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            show_validate_message("#email_update_input", "error", "邮箱格式不正确");
            return false;
        }else{
            show_validate_message("#email_update_input", "success", "");
        }

        //2.发送Ajax,保存更新
        $.ajax({
            url:"${PATH}/employee/"+$(this).attr("edit_id"),
            type:"PUT",
            data:$("#employeeUpdateModal form").serialize(),
            success:function (result) {
                //1.关闭模态框
                $("#employeeUpdateModal").modal("hide");
                //2.跳转到修改记录的页面
                to_page(currentPage);
            }
        });
    });

    //删除单个员工
    $(document).on("click",".delete_btn",function () {
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("delete_id");
        //1.弹出确认删除的对话框

        if(confirm("确认删除【"+empName+"】吗？")){
            //1.确认，发送Ajax请求
            $.ajax({
                url:"${PATH}/employee/"+empId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);

                    to_page(currentPage);
                }
            })
        }
    })
    
    //完成全选/全部选功能
    $("#check_all").click(function () {
        //attr获取自定义的属性值，prop修改和读取dom原生属性的值
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    //check_item
    $(document).on("click",".check_item",function () {
        //判断当前选择是否选满
        var  flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //点击全部删除，批量删除
    $("#employee_delete_all_btn").click(function () {

        var empNames = "";
        var ids_str = "";

        $.each($(".check_item:checked"),function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            //组装id字符串
            ids_str += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除多余的,
        empNames = empNames.substring(0,empNames.length-1);
        ids_str = ids_str.substring(0,ids_str.length-1);
        if(confirm("确认删除【"+empNames+"】吗？")){
            //发送ajax
            $.ajax({
                url:"${PATH}/employee/"+ids_str,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //回到当前页面
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
