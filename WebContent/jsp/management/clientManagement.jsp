<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件夹管理</title>
<script>
	$(function() {
		findClientList();
	});
	function findClientList() {
		var table = $('#tableClientList').DataTable({
			"ordering" : false,
			"searching":false,
			"ajax" : "manage/findClientList",
			"columns" : [
					{
						"data" : "id"
					},
					{
						"data" : "name"
					},
					{
						"data" : "ip"
					},
					{
						"data" : "userName"
					},
					{
						"targets" : -1,//编辑
						"data" : null,
						"defaultContent" : "<span class='glyphicon glyphicon-pencil' onclick='showUpdateClientPanel(this)' style='cursor:pointer;'>"
								+ "</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='glyphicon glyphicon-trash'  style='cursor:pointer;' onclick='deleteClient(this);'></span>"
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
		$('#tableClientList thead tr th').each(function() {
			var title = $(this).text();
			if (title == "文件夹名称") {
				$(this).html('<input type="text" placeholder="Search '+title+'" />');
			}
		});
		table.columns().every(function() {
			var that = this;
			$('input', this.header()).on('keyup change', function() {
				if (that.search() !== this.value) {
					that.search(this.value).draw();
				}
			});
		});
	}
	function showAddClientPanel() {
		$("#btnUpdateClient").hide();
		$("#btnAddClient").show();
		$("#clientModalTitle").text("客户端添加");
		$('#clientModal').modal('show');
	}
	function addClient() {
		$.ajax({
			type : 'POST',
			url : "manage/insertClient",
			data : {
				"client.name" : $("#txtClientName").val(),
				"client.ip" : $("#txtClientIp").val(),
				"client.userId" : $("#secUser").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					refresh($.cookie("url"));
					$('#clientModal').modal('hide');
				}
			}
		});

	}
	function showUpdateClientPanel(obj){
		var clientId = $(obj).parent("td").siblings().eq(0).text();
		$.ajax({
			type : 'POST',
			url : "manage/findClientById?clientId="+clientId,
			async : false,
			success : function(data) {
				$("#btnUpdateClient").show();
				$("#btnAddClient").hide();
				$("#txtClientId").val(clientId);
				$("#txtClientName").val(data["name"]);
				$("#txtClientIp").val(data["ip"]);
				$("#secUser").val(data["userId"]);
				$('#clientModal').modal('show');
			}
		});
		
		
	}
	function updateClient(){
		$.ajax({
			type : 'POST',
			url : "manage/updateClient",
			data : {
				"client.name" : $("#txtClientName").val(),
				"client.id" : $("#txtClientId").val(),
				"client.ip" : $("#txtClientIp").val(),
				"client.userId" : $("#secUser").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("更新成功");
					refresh($.cookie("url"));
					$('#clientModal').modal('hide');
				}
			}
		});
	}
	function deleteClient(obj){
		if(confirm("确定要删除")){
			var clientId = $(obj).parent("td").siblings().eq(0).text();
			$.ajax({
				type : 'POST',
				url : "manage/deleteClient?clientId="+clientId,
				
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
			<div class="glyphicon glyphicon-plus right add" onclick="showAddClientPanel();"></div>
			<div class="clear"></div>
		</div>
		<div class="maincontent maincontenttop">
			<table id="tableClientList" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>序号</th>
						<th>Client名称</th>
						<th>IP</th>
						<th>所属用户</th>
						<th>操作</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>序号</th>
						<th>Client名称</th>
						<th>IP</th>
						<th>所属用户</th>
						<th>操作</th>
					</tr>
				</tfoot>
			</table>
		</div>
		<div class="modal fade" id="clientModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title" id="clientModalTitle">客户端编辑</h4>
					</div>
					<div class="modal-body">
						<input type="hidden" id="txtClientId" />
						<div class='maincontent'>
							<lable>客户端名称</lable>
							<input type='text' id="txtClientName" />
						</div>
						<div class='maincontent'>
							<lable>IP地址</lable>
							<input type='text' id="txtClientIp" />
						</div>
						<div class='maincontent'>
							<lable>所属用户</lable>
							<s:select id="secUser" list="userList" listKey="id" listValue="name" headerValue='请选择' headerKey='-1'/>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addClient();" id="btnAddClient">确定</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateClient();" id="btnUpdateClient">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>
</html>