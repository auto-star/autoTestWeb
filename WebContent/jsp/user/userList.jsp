<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表</title>
<script type="text/javascript">
	var columns=[
				{
					"data" : "id"
				},
				{
					"data" : "name"
				},
				{
					"data" : "password",
					"visible":false
				},
				{
					"data" : "userGroupName"
				},
				{
					"data" : "roleName"
				},
				{
					"targets" : -1,//编辑
					"data" : null,
					"defaultContent" : "<span class='glyphicon glyphicon-pencil' onclick='showUpdateUserPanel(this)' style='cursor:pointer;'>"
							+ "</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='glyphicon glyphicon-trash'  style='cursor:pointer;' onclick='deleteUser(this);'></span>"
				} ];
	var url="user/findUserList";
	$(function() {
		findList($('#tableUserList'),url,"",columns);
	});
	function addUser() {
		$.ajax({
			type : 'POST',
			url : "user/insertUser",
			data : {
				"user.name" : $("#txtUserName").val(),
				"user.password" : $("#txtPassword").val(),
				"user.userGroupId" : $("#secUserGroup").val(),
				"user.roleId" : $("#secRole").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					refresh($.cookie("url"));
					$('#userModal').modal('hide');
				}
			}
		});

	}
	function updateUser() {
		$.ajax({
			type : 'POST',
			url : "user/updateUser",
			data : {
				"user.id" : $("#txtUserId").val(),
				"user.name" : $("#txtUserName").val(),
				"user.password" : $("#txtPassword").val(),
				"user.userGroupId" : $("#secUserGroup").val(),
				"user.roleId" : $("#secRole").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("修改成功");
					refresh($.cookie("url"));
					$('#userModal').modal('hide');
				}
			}
		});
	}
	function deleteUser(obj) {
		if(confirm("确定要删除")){
			$.ajax({
				type : 'POST',
				url : "user/deleteUser?userId="
						+ $(obj).parent("td").siblings().eq(0).text(),
				async : false,
				success : function(data) {
					if (data > 0) {
						alert("删除成功");
						refresh($.cookie("url"));
					}
				},  
				error : function() {   
		          	alert("删除失败,请联系开发人员");  
		          	refresh($.cookie("url"));
		      	}  
			});
		}
		
	}
	function showAddUserPanel() {
		$("#btnUpdateUser").hide();
		$("#btnAddUser").show();
		$("#userModalTitle").text("用户添加");
		$('#userModal').modal('show');
	}
	function showUpdateUserPanel(obj) {
		var userId = $(obj).parent("td").siblings().eq(0).text();
		$.ajax({
			type : 'POST',
			url : "user/findUserById?userId="+userId,
			async : false,
			success : function(data) {
				$("#btnAddUser").hide();
				$("#btnUpdateUser").show();
				$("#txtUserId").val(data["id"]);
				$("#txtUserName").val(data["name"]);
				$("#txtPassword").val(data["password"]);
				$("#secUserGroup").val(data["userGroupId"]);
				$("#secRole").val(data["roleId"]);
				$('#userModal').modal('show');
			}
		});
		
	}
</script>
<style>
</style>
</head>
<body>
	<div class="maincontent">
		<div class="mainheader">
			<div class="glyphicon glyphicon-plus right add" onclick="showAddUserPanel();"></div>
			<div class="clear"></div>
		</div>
		<div class="maincontent maincontenttop">


			<table id="tableUserList" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>ID</th>
						<th>用户名</th>
						<th>密码</th>
						<th>组</th>
						<th>权限</th>
						<th>操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="userModalTitle">用户编辑</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" id="txtUserId" />
					<div class='maincontent'>
						<lable>用户名</lable>
						<input type='text' id="txtUserName" maxLength="50"/>
					</div>
					<div class='maincontent'>
						<lable>密码</lable>
						<input type='text' id="txtPassword" />
					</div>
					<div class='maincontent'>
						<lable>所属组</lable>
						<s:select id="secUserGroup" list="userGroupList" listKey="id" listValue="name" headerValue='请选择' headerKey='0'/>
					</div>
					<div class='maincontent'>
						<lable>角色</lable>
						<s:select id="secRole" list="roleList" listKey="id" listValue="name" headerValue='请选择' headerKey='0'/>
					</div>
				</div>
				<div class="modal-footer">
					
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addUser();" id="btnAddUser">确定</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateUser();" id="btnUpdateUser">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>