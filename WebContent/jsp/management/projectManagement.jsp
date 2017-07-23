<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件夹管理</title>
<script>
	$(function() {
		findProjectList();
	});
	function findProjectList() {
		var data={ 
				"project.name":$("#txtProjectName2").val()
			};
		var columns=[
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
				"targets" : -1,//编辑
				"data" : null,
				"render" : function(data) {
					var str="<span class='glyphicon glyphicon-pencil' onclick='showUpdateProjectPanel(this)' style='cursor:pointer;'>";
					str+= "</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='glyphicon glyphicon-trash'  style='cursor:pointer;' onclick='deleteProject(this);'></span>";
					str+= "&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:void(0);' value='manage/initGroup?projectId="+data.id+"'  class='link'>组管理</a>";
					str+= "&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:void(0);' value='manage/initEnvironment?projectId="+data.id+"'  class='link'>测试环境</a>";
					return str;
				}
						
			} ]
		var url="manage/findProjectList";
		findList($('#tableProjectList'),url,data,columns);
	}
	function showAddProjectPanel() {
		$("#btnUpdateProject").hide();
		$("#btnAddProject").show();
		$("#projectModalTitle").text("项目添加");
		$('#projectModal').modal('show');
	}
	function addProject() {
		$.ajax({
			type : 'POST',
			url : "manage/insertProject",
			data : {
				"project.name" : $("#txtProjectName").val(),
				"project.code" : $("#txtCode").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					refresh($.cookie("url"));
					$('#projectModal').modal('hide');
				}
			}
		});

	}
	function showUpdateProjectPanel(obj){
		var projectId = $(obj).parent("td").siblings().eq(0).text();
		$.ajax({
			type : 'POST',
			url : "manage/findProjectById?projectId="+projectId,
			async : false,
			success : function(data) {
				$("#btnUpdateProject").show();
				$("#btnAddProject").hide();
				$("#txtProjectId").val(projectId);
				$("#txtProjectName").val(data["name"]);
				$("#txtCode").val(data["code"])
				$("#txtCode").attr("readonly","readonly");
				$('#projectModal').modal('show');
			}
		});
		
		
	}
	function updateProject(){
		$.ajax({
			type : 'POST',
			url : "manage/updateProject",
			data : {
				"project.name" : $("#txtProjectName").val(),
				"project.id" : $("#txtProjectId").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("更新成功");
					refresh($.cookie("url"));
					$('#projectModal').modal('hide');
				}
			}
		});
	}
	function deleteProject(obj){
		if(confirm("确定要删除")){
			var projectId = $(obj).parent("td").siblings().eq(0).text();
			$.ajax({
				type : 'POST',
				url : "manage/deleteProject?id="+projectId,
				
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
		<div class="searchBox">
			<div class="search-line">
				<label>项目名</label>
				<input id="txtProjectName2" class="form-control search-control" onkeyup="findProjectList();" />
			</div>
			
			<div class="clear"></div>
		</div>
		<div class="maincontent" style="text-align:center;">
			<input type="button" value="新增项目" onclick="showAddProjectPanel()" class="btn btn-primary"/>
			<input type="button" value="查询" onclick="findProjectList()" class="btn btn-default"/>
		</div>
		<hr/>
		<div class="maincontent maincontenttop">
			<table id="tableProjectList" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>序号</th>
						<th>Project名称</th>
						<th>Code</th>
						<th>操作</th>
					</tr>
				</thead>
			</table>
		</div>
		<div class="modal fade" id="projectModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title" id="projectModalTitle">项目编辑</h4>
					</div>
					<div class="modal-body">
						<input type="hidden" id="txtProjectId" />
						<div class='maincontent'>
							<lable>项目名称</lable>
							<input type='text' id="txtProjectName" />
						</div>
						<div class='maincontent'>
							<lable>Code</lable>
							<input type='text' id="txtCode" />
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addProject();" id="btnAddProject">确定</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateProject();" id="btnUpdateProject">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>
</html>