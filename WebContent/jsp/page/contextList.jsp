<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>内存Key管理</title>
</head>
<script>
	$(function() {
		findContextList();
	});
	function findContextList() {
		var table = $('#tableContextList').DataTable(
		{
			"ordering" : [ [ 4, "asc" ] ],
			"searching":false,
			"ajax" : "page/findContextList",
			"columns" : [
					{
						"data" : "id"
					},
					{
						"data" : "name"
					},
					{
						"data" : "contextKey"
					},
					{
						"targets" : -1,//编辑
						"data" : null,
						"defaultContent" : "<a class='glyphicon glyphicon-pencil' onclick='showUpdateContextPanel(this)' style='cursor:pointer;'></a>"
							+ "&nbsp;&nbsp;&nbsp;&nbsp;<a class='glyphicon glyphicon-trash'  style='cursor:pointer;' onclick='deleteContext(this);'></a>"
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
		$('#tableContextList tfoot tr th').each(function() {
			var title = $(this).text();
			if (title != "操作" && title != "" && title != "序号") {
				$(this).html('<input type="text" placeholder="'+title+'" />');
			}

		});
		table.columns().every(function() {
			var that = this;

			$('input', this.footer()).on('keyup change', function() {
				if (that.search() !== this.value) {
					that.search(this.value).draw();
				}
			});
		});
	}
	
	function updateContext() {
		$.ajax({
			type : 'POST',
			url : "page/updateContext",
			data : {
				"context.id" : $("#txtContextId").val(),
				"context.name" : $("#txtContextName").val(),
				"context.contextKey" : $("#txtContextKey").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("修改成功");
					refresh($.cookie("url"));
					$('#contextModal').modal('hide');
				}
			}
		});
	}
	function showAddContextPanel() {
		$("#btnUpdateContext").hide();
		$("#btnAddContext").show();
		$("#contextModalTitle").text("页面添加");
		$('#contextModal').modal('show');
	}
	function showUpdateContextPanel(obj) {
		var contextId = $(obj).parent("td").siblings().eq(0).text();
		$("#txtContextId").val(contextId);
		$.ajax({
			type : 'POST',
			url : "page/findContextById?contextId=" + contextId,
			async : false,
			success : function(data) {
				$("#btnAddContext").hide();
				$("#btnUpdateContext").show();
				$("#txtContextName").val(data["name"]);
				$("#txtContextKey").val(data["contextKey"]);
				$('#contextModal').modal('show');
			}
		});

	}
	
	
	function showAddContextPanel(){
		$("#btnUpdateContext").hide();
		$("#btnAddContext").show();
		$("#pageModalTitle").text("内存Key添加");
		$('#contextModal').modal('show');
	}
	function addContext(){
		$.ajax({
			type : 'POST',
			url : "page/insertContext",
			data : {
				"context.name" : $("#txtContextName").val(),
				"context.contextKey" : $("#txtContextKey").val()
			},
			async : false,
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					refresh($.cookie("url"));
					$('#contextModal').modal('hide');
				}
			}
		});
	}
	function deleteContext(obj) {
		if (confirm("确定 要删除")) {
			$.ajax({
				type : 'POST',
				url : "page/deleteContext?contextId="
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
<body>
	<div class="maincontent">
		<div class="mainheader">
			<div class="glyphicon glyphicon-plus right add" onclick="showAddContextPanel();"></div>
			<div class="clear"></div>
		</div>
		<div class="maincontent maincontenttop">


			<table id="tableContextList" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>序号</th>
						<th>名称</th>
						<th>内存Key</th>
						<th>操作</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>序号</th>
						<th>名称</th>
						<th>内存Key</th>
						<th>操作</th>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
	<div class="modal fade" id="contextModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="contextModalTitle">编辑内存Key</h4>
				</div>
				<div class="modal-body">
					<input type='hidden' id="txtContextId" />
					<div class='maincontent'>
						<lable>内存名称</lable>
						<input type='text' id="txtContextName" />
					</div>
					<div class='maincontent'>
						<lable>内存Key</lable>
						<input type='text' id="txtContextKey" />
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addContext();" id="btnAddContext">确定</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateContext();" id="btnUpdateContext">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>