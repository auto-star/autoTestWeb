<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>组管理</title>
<script>
	$(function() {
		findGroupListByProjectId();
	});
	function findGroupListByProjectId() {
		 
		 var table =$('#tableGroupList').DataTable(
		{
			"ordering":false,
			"searching":false,
			"ajax" : "manage/findGroupListByProjectId?projectId=" + <%=request.getAttribute("projectId")%> ,
			"columns" : [
					{
						"data" : "id"
					},
					{
						"data" : "name"
					},
					{
						"data" : "code"
					},
					{
						"data" : "parentGroupName"
					},
					{
						"targets" : -1,//编辑
						"data" : null,
						"defaultContent" : "<span class='glyphicon glyphicon-pencil' onclick='showUpdateGroupPanel(this)' style='cursor:pointer;'>"
								+ "</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='glyphicon glyphicon-trash'  style='cursor:pointer;' onclick='deleteGroup(this);'></span>"
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
		 $('#tableGroupList thead tr th').each( function () {
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
	function showAddGroupPanel() {
		$("#btnUpdateGroup").hide();
		$("#btnAddGroup").show();
		$("#groupModalTitle").text("Group添加");
		$('#groupModal').modal('show');
	}
	function addGroup() {
		$.ajax({
			type : 'POST',
			url : "manage/findGroupByCode?code="+$("#txtGroupCode").val(),
			async : false,
			success : function(data) {
				if(data==1){
					alert("code已经存在，请使用其他code");
					return;
				}else{
					$.ajax({
						type : 'POST',
						url : "manage/insertGroup",
						data : {
							"group.name" : $("#txtGroupName").val(),
							"group.projectId" : $("#txtProjectId").val(),
							"group.parentGroupId" : $("#secParentGroup").val(),
							"group.code" : $("#txtGroupCode").val()
						},
						success : function(data) {
							if (data > 0) {
								alert("添加成功");
								refresh($.cookie("url"));
								$('#groupModal').modal('hide');
							}
						}
					});
				}
			}
		});
		

	}
	function showUpdateGroupPanel(obj){
		var groupId = $(obj).parent("td").siblings().eq(0).text();
		$.ajax({
			type : 'POST',
			url : "manage/findGroupById?groupId="+groupId,
			async : false,
			success : function(data) {
				$("#btnUpdateGroup").show();
				$("#btnAddGroup").hide();
				$("#txtGroupId").val(groupId);
				$("#txtGroupName").val(data["name"]);
				$("#secParentGroup").val(data["parentGroupId"]);
				$("#txtGroupCode").val(data["code"]);
				$('#groupModal').modal('show');
			}
		});
		
		
	}
	function updateGroup(){
		$.ajax({
			type : 'POST',
			url : "manage/updateGroup",
			data : {
				"group.name" : $("#txtGroupName").val(),
				"group.id" : $("#txtGroupId").val(),
				"group.parentGroupId" : $("#secParentGroup").val(),
				"group.code" : $("#txtGroupCode").val()
				
			},
			success : function(data) {
				if (data > 0) {
					alert("更新成功");
					refresh($.cookie("url"));
					$('#groupModal').modal('hide');
				}
			}
		});
	}
	function deleteGroup(obj) {
		if(confirm("确定要删除")){
			$.ajax({
				type : 'POST',
				url : "manage/deleteGroup?groupId=" + $(obj).parent("td").siblings().eq(0).text(),
				async : false,
				success : function(data) {
					if (data > 0) {
						alert("删除成功");
						refresh($.cookie("url"));
					}else{
						alert("删除失败,请联系开发人员");  
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
			<div class="glyphicon glyphicon-plus right add" onclick="showAddGroupPanel();"></div>
			<div class="clear"></div>
		</div>
		<div class="maincontent maincontenttop">
			<table id="tableGroupList" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>序号</th>
						<th>组名称</th>
						<th>Code</th>
						<th>父级组</th>
						<th>操作</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>序号</th>
						<th>组名称</th>
						<th>Code</th>
						<th>父级组</th>
						<th>操作</th>
					</tr>
				</tfoot>
			</table>
		</div>
		<div class="modal fade" id="groupModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title" id="groupModalTitle">Group编辑</h4>
					</div>
					<div class="modal-body">
						<input type="hidden" id="txtGroupId" /> <input type="hidden" id="txtProjectId" value="<s:property value='projectId' />" />
						<div class='maincontent'>
							<lable>Group名称</lable>
							<input type='text' id="txtGroupName" />
						</div>
						<div class='maincontent'>
							<lable>Group Code</lable>
							<input type='text' id="txtGroupCode" />
						</div>
						<div class='maincontent'>
							<lable>父级组</lable>
							<s:select id="secParentGroup" list="groupList" listKey="id" listValue="name" headerValue='无' headerKey='-1'/>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addGroup();" id="btnAddGroup">确定</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateGroup();" id="btnUpdateGroup">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>
</html>