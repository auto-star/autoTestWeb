<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>组管理</title>
<script>
	$(function() {
		findEnvironmentList();
	});
	function findEnvironmentList() {
		 
		 var table =$('#tableEnvironmentList')
				.DataTable(
						{
							"ordering":false,
							"searching":false,
							"ajax" : "manage/findEnvironmentListByProjectId?projectId="+<%=request.getAttribute("projectId")%>,
							"columns" : [
									{
										"data" : "id"
									},
									{
										"data" : "name"
									},
									{
										"data" : "frontUrl"
									},
									{
										"data" : "backUrl"
									},
									{
										"targets" : -1,//编辑
										"data" : null,
										"defaultContent" : "<span class='glyphicon glyphicon-pencil' onclick='showUpdateEnvironmentPanel(this)' style='cursor:pointer;'>"
												+ "</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='glyphicon glyphicon-trash'  style='cursor:pointer;' onclick='deleteEnvironment(this);'></span>"
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
		
	}
	function showAddEnvironmentPanel() {
		$("#btnUpdateEnvironment").hide();
		$("#btnAddEnvironment").show();
		$("#environmentModalTitle").text("Environment添加");
		$('#environmentModal').modal('show');
	}
	function addEnvironment() {
		$.ajax({
			type : 'POST',
			url : "manage/insertEnvironment",
			data : {
				"env.name" : $("#txtEnvironmentName").val(),
				"env.frontUrl" : $("#txtFrontUrl").val(),
				"env.backUrl" : $("#txtBackUrl").val(),
				"env.projectId" : <%=request.getAttribute("projectId")%>
			},
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					refresh($.cookie("url"));
					$('#environmentModal').modal('hide');
				}
			}
		});

	}
	function showUpdateEnvironmentPanel(obj){
		var environmentId = $(obj).parent("td").siblings().eq(0).text();
		$.ajax({
			type : 'POST',
			url : "manage/findEnvironmentById?environmentId="+environmentId,
			async : false,
			success : function(data) {
				$("#btnUpdateEnvironment").show();
				$("#btnAddEnvironment").hide();
				$("#txtEnvironmentId").val(environmentId);
				$("#txtEnvironmentName").val(data["name"]);
				$("#txtFrontUrl").val(data["frontUrl"]);
				$("#txtBackUrl").val(data["backUrl"]);
				$('#environmentModal').modal('show');
			}
		});
		
		
	}
	
	function updateEnvironment(){
		$.ajax({
			type : 'POST',
			url : "manage/updateEnvironment",
			data : {
				"env.name" : $("#txtEnvironmentName").val(),
				"env.frontUrl" : $("#txtFrontUrl").val(),
				"env.backUrl" : $("#txtBackUrl").val(),
				"env.id" : $("#txtEnvironmentId").val()
				
			},
			success : function(data) {
				if (data > 0) {
					alert("更新成功");
					refresh($.cookie("url"));
					$('#environmentModal').modal('hide');
				}
			}
		});
	}
	function deleteEnvironment(obj){
		if(confirm("确定要删除")){
			var environmentId = $(obj).parent("td").siblings().eq(0).text();
			$.ajax({
				type : 'POST',
				url : "manage/deleteEnvironment?environmentId="+environmentId,
				
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
			<div class="glyphicon glyphicon-plus right add" onclick="showAddEnvironmentPanel();"></div>
			<div class="clear"></div>
		</div>
		<div class="maincontent maincontenttop">
			<table id="tableEnvironmentList" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>序号</th>
						<th>环境名称</th>
						<th>前台URL</th>
						<th>后台URL</th>
						<th>操作</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>序号</th>
						<th>环境名称</th>
						<th>前台URL</th>
						<th>后台URL</th>
						<th>操作</th>
					</tr>
				</tfoot>
			</table>
		</div>
		<div class="modal fade" id="environmentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title" id="environmentModalTitle">Environment编辑</h4>
					</div>
					<div class="modal-body">
						<input type="hidden" id="txtEnvironmentId" />
						<div class='maincontent'>
							<lable>Environment名称</lable>
							<input type='text' id="txtEnvironmentName" />
						</div>
						<div class='maincontent'>
							<lable>前台URL</lable>
							<input type='text' id="txtFrontUrl" style="width:350px;"/>
						</div>
						<div class='maincontent'>
							<lable>后台URL</lable>
							<input type='text' id="txtBackUrl"  style="width:350px;"/>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addEnvironment();" id="btnAddEnvironment">确定</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateEnvironment();" id="btnUpdateEnvironment">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>
		
	</div>
</body>
</html>