<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>组管理</title>
<script>
	$(function() {
		findUserGroupList();
	});
	function findUserGroupList() {
		 
		 var table =$('#tableUserGroupList').DataTable({
			"ordering":false,
			"searching":false,
			"ajax" : "user/findUserGroupList",
			"columns" : [
					{
						"data" : "id"
					},
					{
						"data" : "name"
					},
					{
						"targets" : -1,//编辑
						"data" : null,
						"defaultContent" : "<span class='glyphicon glyphicon-pencil' onclick='showUpdateUserGroupPanel(this)' style='cursor:pointer;'>"
								+ "</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='glyphicon glyphicon-trash'  style='cursor:pointer;' onclick='deleteUserGroup(this);'></span>"
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
		 $('#tableUserGroupList thead tr th').each( function () {
		        var title = $(this).text();
		        if(title!="操作"&&title!="序号"){
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
	function showAddUserGroupPanel() {
		$("#btnUpdateUserGroup").hide();
		$("#btnAddUserGroup").show();
		$("#userGroupModalTitle").text("用户组添加");
		$('#userGroupModal').modal('show');
	}
	function addUserGroup() {
		$.ajax({
			type : 'POST',
			url : "user/insertUserGroup",
			data : {
				"userGroup.name" : $("#txtUserGroupName").val()
			},
			async : false,
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					refresh($.cookie("url"));
					$('#userGroupModal').modal('hide');
				}
			}
		});

	}
	function showUpdateUserGroupPanel(obj){
		var userGroupId = $(obj).parent("td").siblings().eq(0).text();
		$.ajax({
			type : 'POST',
			url : "user/findUserGroupById?userGroupId="+userGroupId,
			async : false,
			success : function(data) {
				$("#btnUpdateUserGroup").show();
				$("#btnAddUserGroup").hide();
				$("#txtUserGroupId").val(userGroupId);
				$("#txtUserGroupName").val(data["name"]);
				$('#userGroupModal').modal('show');
			}
		});
		
		
	}
	function updateUserGroup(){
		$.ajax({
			type : 'POST',
			url : "user/updateUserGroup",
			data : {
				"userGroup.name" : $("#txtUserGroupName").val(),
				"userGroup.id" : $("#txtUserGroupId").val()
				
			},
			success : function(data) {
				if (data > 0) {
					alert("更新成功");
					refresh($.cookie("url"));
					$('#userGroupModal').modal('hide');
				}
			}
		});
	}
	function deleteUserGroup(obj) {
		if(confirm("确定要删除")){
			$.ajax({
				type : 'POST',
				url : "user/deleteUserGroup?userGroupId="
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
</script>
</head>
<body>
	<div class="maincontent">
		<div class="mainheader">
			<div class="glyphicon glyphicon-plus right add" onclick="showAddUserGroupPanel();"></div>
			<div class="clear"></div>
		</div>
		<div class="maincontent maincontenttop">
			<table id="tableUserGroupList" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>序号</th>
						<th>组名称</th>
						<th>操作</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>序号</th>
						<th>组名称</th>
						<th>操作</th>
					</tr>
				</tfoot>
			</table>
		</div>
		<div class="modal fade" id="userGroupModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title" id="userGroupModalTitle">Group编辑</h4>
					</div>
					<div class="modal-body">
						<input type="hidden" id="txtUserGroupId" />
						<div class='maincontent'>
							<lable>Group名称</lable>
							<input type='text' id="txtUserGroupName" />
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addUserGroup();" id="btnAddUserGroup">确定</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateUserGroup();" id="btnUpdateUserGroup">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>
</html>