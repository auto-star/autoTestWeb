<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>组管理</title>
<script>
	$(function() {
		findRoleList();
	});
	function findRoleList() {
		 
		 var table =$('#tableRoleList')
				.DataTable(
						{
							"ordering":false,
							"searching":false,
							"ajax" : "authority/findRoleList?",
							"columns" : [
									{
										"data" : "id"
									},
									{
										"data" : "name"
									},
									{
										"data" : "comment"
									},
									{
										"data" : "isAdmin"
									},
									{
										"targets" : -1,//编辑
										"data" : null,
										"render" :function(data){
											var str="<a class='glyphicon glyphicon-pencil' onclick='showUpdateRolePanel(this)' style='cursor:pointer;'></a>"
											+ "&nbsp;&nbsp;&nbsp;&nbsp;<a class='glyphicon glyphicon-trash'  style='cursor:pointer;' onclick='deleteRole(this);'></a>"
											+ "&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:void(0);' value='authority/initRoleMenu?roleId="+data.id+"' class='link'>菜单</a>";
											return str;
										} 
									} ],
									"oLanguage" : {
										"sLengthMenu" : "每页显示 _MENU_ 条记录",
										"sZeroRecords" : "抱歉， 没有找到",
										"sInfo" : "从 _START_ 到 _END_ 共 _TOTAL_ 条数据",
										"sInfoEmpty" : "没有数据",
										"sInfoFiltered" : "(从 _MAX_ 条数据中检索)",
										"oPaginate" : {
											"sFirst" : "首页",
											"sPrevious" : "前一页",
											"sNext" : "后一页",
											"sLast" : "尾页"
										}
									},
							"aoColumnDefs" : [ {
								sDefaultContent : '',
								aTargets : [ '_all' ]
							} ]
						});
		 $('#tableRoleList thead tr th').each( function () {
		        var title = $(this).text();
		        if(title=="环境名称"){
		        	$(this).html( '<input type="text" placeholder="'+title+'" />' );
		        }
		        
		    });
		 table.columns().every( function () {
		        var that = this;
		 
		        $( 'input', this.header() ).on( 'keyup change', function () {
		            if ( that.search() !== this.value ) {
		                that
		                    .search( this.value )
		                    .draw();
		            }
		        } );
		    } );
	}
	function showAddRolePanel() {
		$("#btnUpdateRole").hide();
		$("#btnAddRole").show();
		$("#roleModalTitle").text("Role添加");
		$('#roleModal').modal('show');
	}
	function addRole() {
		$.ajax({
			type : 'POST',
			url : "authority/insertRole",
			data : {
				"role.name" : $("#txtRoleName").val(),
				"role.comment" : $("#txtRoleComment").val(),
				"role.isAdmin" : $("#secIsAdmin").val()
				
			},
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					refresh($.cookie("url"));
					$('#roleModal').modal('hide');
				}
			}
		});

	}
	function showUpdateRolePanel(obj){
		var roleId = $(obj).parent("td").siblings().eq(0).text();
		$.ajax({
			type : 'POST',
			url : "authority/findRoleById?roleId="+roleId,
			async : false,
			success : function(data) {
				$("#btnUpdateRole").show();
				$("#btnAddRole").hide();
				$("#txtRoleId").val(roleId);
				$("#txtRoleName").val(data["name"]);
				$("#txtRoleComment").val(data["comment"]);
				$("#secIsAdmin").val(data["isAdmin"]);
				$('#roleModal').modal('show');
			}
		});
		
		
	}
	function updateRole(){
		$.ajax({
			type : 'POST',
			url : "authority/updateRole",
			data : {
				"role.name" : $("#txtRoleName").val(),
				"role.id" : $("#txtRoleId").val(),
				"role.comment" : $("#txtRoleComment").val(),
				"role.isAdmin" : $("#secIsAdmin").val()
				
			},
			success : function(data) {
				if (data > 0) {
					alert("更新成功");
					refresh($.cookie("url"));
					$('#roleModal').modal('hide');
				}
			}
		});
	}
	function deleteRole(obj){
		if(confirm("确定要删除")){
			var roleId = $(obj).parent("td").siblings().eq(0).text();
			$.ajax({
				type : 'POST',
				url : "authority/deleteRole?roleId="+roleId,
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
	
</script>
</head>
<body>
	<div class="maincontent">
		<div class="mainheader">
			<div class="glyphicon glyphicon-plus right add" onclick="showAddRolePanel();"></div>
			<div class="clear"></div>
		</div>
		<div class="maincontent maincontenttop">
			<table id="tableRoleList" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>序号</th>
						<th>角色名称</th>
						<th>描述</th>
						<th>是否有权限操作他人数据</th>
						<th>操作</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>序号</th>
						<th>角色名称</th>
						<th>描述</th>
						<th>是否有权限操作他人数据</th>
						<th>操作</th>
					</tr>
				</tfoot>
			</table>
		</div>
		<div class="modal fade" id="roleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title" id="roleModalTitle">Role编辑</h4>
					</div>
					<div class="modal-body">
						<input type="hidden" id="txtRoleId" />
						<div class='maincontent'>
							<lable>Role名称</lable>
							<input type='text' id="txtRoleName" />
						</div>
						<div class='maincontent'>
							<lable>描述</lable>
							<input type='text' id="txtRoleComment" />
						</div>
						<div class='maincontent'>
							<lable>是否有权限操作他人数据</lable>
							<select id="secIsAdmin">
								<option value="1">无</option>
								<option value="2">有</option>
							</select>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addRole();" id="btnAddRole">确定</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateRole();" id="btnUpdateRole">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>
</html>