<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>页面管理</title>
</head>
<script>
	$(function() {
		getAllUser(<%=session.getAttribute("userId")%>);
		findPageList();
	});
	function findPageList() {
		var table = $('#tablePageList').DataTable(
		{
			"ordering" : false,
			"destroy":true,
			"searching":false,
			"serverSide":true,
			"ajax" : {
				"type" : 'POST',
				"url":"page/findPageList",
				"data":{
					"page.insertUser":$("#secUserList").val(),
					"page.title":$("#txtPageTitle2").val(),
					"page.projectId":$("#secProjectList").val()
				}
			},
			"columns" : [
					{
						"data" : "id"
					},
					{
						"targets" : -1,//编辑
						"data" : null,
						"render" : function(data) {
							var str = "<a href='javascript:void(0);' value='page/initAction?pageId="+data.id+"' class='link'>"+data.title+"</a>";
							return str;
						}
					},
					{
						"data" : "comment"
					},
					{
						"data" : "code"
					},
					{
						"data" : "groupName"
					},
					{
						"data" : "parentGroupName"
					},
					{
						"data" : "projectName"
					},
					{
						"data" : "isVisible"
					},
					{
						"targets" : -1,//编辑
						"data" : null,
						"render" : function(data){
							var str="<a  onclick='showUpdatePagePanel(this)' style='cursor:pointer;'>修改</a>"
								+ "&nbsp;<a style='cursor:pointer;' onclick='deletePage(this);'>删除</a>"
								+ "&nbsp;<a style='cursor:pointer;' value='page/initDataMap?pageId="+data.id+"' class='link'>DataMap</a>"
								+ "&nbsp;<a style='cursor:pointer;' onclick='showCopyPagePanel(this);'>Copy</a>"
								+ "&nbsp;<a style='cursor:pointer;' value='page/initElement?pageId="+data.id+"' class='link'>Element</a>";
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
	}
	function addPage() {
		$.ajax({
			type : 'POST',
			url : "page/insertPage",
			data : {
				"page.title" : $("#txtPageTitle").val(),
				"page.comment" : $("#txtPageComment").val(),
				"page.groupId" : $("#secGroup").val(),
				"page.projectId" : $("#secProject").val(),
				"page.isVisible" : $("#secIsVisible").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					findPageList();
					$('#pageModal').modal('hide');
				}
			}
		});

	}
	function updatePage() {
		$.ajax({
			type : 'POST',
			url : "page/updatePage",
			data : {
				"page.id" : $("#txtPageId").val(),
				"page.title" : $("#txtPageTitle").val(),
				"page.comment" : $("#txtPageComment").val(),
				"page.groupId" : $("#secGroup").val(),
				"page.projectId" : $("#secProject").val(),
				"page.isVisible" : $("#secIsVisible").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("修改成功");
					findPageList();
				}
			}
		});
	}
	function deletePage(obj) {
		if(confirm("确定要删除")){
			$.ajax({
				type : 'POST',
				url : "page/deletePageById?pageId=" + $(obj).parent("td").siblings().eq(0).text(),
				async : false,
				success : function(data) {
					if (data > 0) {
						alert("删除成功");
						findPageList();
					}
				},  
				error : function() {   
		          	alert("删除失败,请联系开发人员");  
		          	findPageList();
		      	}  
			});
		}
	}
	function showAddPagePanel() {
		$("#btnUpdatePage").hide();
		$("#btnAddPage").show();
		$("#btnCopyPage").hide();
		$("#pageModalTitle").text("页面添加");
		$('#pageModal').modal('show');
	}
	function showUpdatePagePanel(obj) {
		var pageId = $(obj).parent("td").siblings().eq(0).text();
		$("#txtPageId").val(pageId);
		$.ajax({
			type : 'POST',
			url : "page/findPageById?id=" + pageId,
			async : false,
			success : function(data) {
				$("#btnAddPage").hide();
				$("#btnUpdatePage").show();
				$("#btnCopyPage").hide();
				$("#txtPageTitle").val(data["title"]);
				$("#txtPageComment").val(data["comment"]);
				$("#secIsVisible").val(data["isVisible"]);
				$("#secProject").val(data["projectId"]);
				changeParentGroup($("#secProject"));
				$("#secParentGroup").val(data["parentGroupId"]);
				changeGroup($("#secParentGroup"));
				$("#secGroup").val(data["groupId"]);
				$('#pageModal').modal('show');
			}
		});

	}
	function redirectToAction(obj) {
		var pageId = $(obj).parent("td").siblings().eq(0).text();
		window.location.href = "initAction?pageId=" + pageId;
	}
	function redirectToContext(obj){
		var pageId = $(obj).parent("td").siblings().eq(0).text();
		window.location.href = "initContext?pageId=" + pageId;
	}
	function redirectToDataMap(obj) {
		var pageId = $(obj).parent("td").siblings().eq(0).text();
		window.location.href = "initDataMap?pageId=" + pageId;
	}
	function changeParentGroup(obj) {
		$.ajax({
			type : 'POST',
			url : "page/findGroupList?projectId=" + $(obj).val()
					+ "&parentGroupId=-1",
			async : false,
			success : function(data) {
				var obj = data["aaData"];
				$("#secParentGroup").empty();
				$("#secParentGroup").append("<option value='0'>请选择</option>")
				for (i = 0; i < obj.length; i++) {
					var object = obj[i];
					$("#secParentGroup").append("<option value='"+object["id"]+"'>" + object["name"] + "</option>")
				}
			}
		});
	}
	function changeGroup(obj) {
		$.ajax({
			type : 'POST',
			url : "page/findGroupList?parentGroupId=" + $(obj).val(),
			async : false,
			success : function(data) {
				var obj = data["aaData"];
				$("#secGroup").empty();
				$("#secGroup").append("<option value='0'>请选择</option>")
				for (i = 0; i < obj.length; i++) {
					var object = obj[i];
					$("#secGroup").append("<option value='"+object["id"]+"'>"+ object["name"] + "</option>")
				}
			}
		});
	}
	function copyPage(obj) {
		var pageId = $("#txtPageId").val();
		$.ajax({
			type : 'POST',
			url : "page/copyPage",
			data : {
				"page.id" : $("#txtPageId").val(),
				"page.title" : $("#txtPageTitle").val(),
				"page.comment" : $("#txtPageComment").val(),
				"page.groupId" : $("#secGroup").val(),
				"page.projectId" : $("#secProject").val(),
				"page.isVisible" : $("#secIsVisible").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("Copy成功");
					findPageList();
				}
			}
		});
	}
	function showCopyPagePanel(obj){
		var pageId = $(obj).parent("td").siblings().eq(0).text();
		$("#txtPageId").val(pageId);
		$.ajax({
			type : 'POST',
			url : "page/findPageById?id=" + pageId,
			async : false,
			success : function(data) {
				$("#btnAddPage").hide();
				$("#btnUpdatePage").hide();
				$("#btnCopyPage").show();
				$("#txtPageTitle").val(data["title"]+"_copy");
				$("#txtPageComment").val(data["comment"]+"_copy");
				$("#secProject").val(data["projectId"]);
				$("#secIsVisible").val(data["isVisible"]);
				changeParentGroup($("#secProject"));
				$("#secParentGroup").val(data["parentGroupId"]);
				changeGroup($("#secParentGroup"));
				$("#secGroup").val(data["groupId"]);
				$("#pageModalTitle").text("页面Copy");
				$('#pageModal').modal('show');
			}
		});
	}
</script>
<style>
	.h2{
		margin-bottom:0;
	}
	.form-control{
		display:inline-block;
	}
</style>
<body>
	<div class="maincontent">
		<div class="searchBox">
			<div class="search-line">
				<label>用户名</label>
				<select id="secUserList" class="form-control search-control" onchange="findPageList();"></select>
			</div>
			<div class="search-line">
				<label>项目</label><s:select id="secProjectList" list="projectList" listKey="id" listValue="name" cssClass="form-control search-control" onchange="findPageList();"/>
			</div>
			<div class="search-line">
				<label>Page Title</label>
				<input id="txtPageTitle2" class="form-control search-control" onkeyup="findPageList();" />
			</div>
			
			<div class="clear"></div>
		</div>
		<div class="maincontent" style="text-align:center;">
			<input type="button" value="新增Page" onclick="showAddPagePanel()" class="btn btn-primary"/>
			<input type="button" value="查询" onclick="findPageList()" class="btn btn-default"/>
		</div>
		<hr/>
		<div class="maincontent">


			<table id="tablePageList" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th style="width:30px;">序号</th>
						<th>页面Title</th>
						<th>Comment</th>
						<th>页面编号</th>
						<th>组</th>
						<th>父级组</th>
						<th>客户</th>
						<th>是否可见</th>
						<th style="width:200px;">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div class="modal fade" id="pageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="pageModalTitle">页面编辑</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" id="txtPageId" class="form-control"/>
					<div class='maincontent'>
						<lable>页面Title</lable>
						<input type='text' id="txtPageTitle"  class="form-control"/>
					</div>
					<div class='maincontent'>
						<lable>Comment</lable>
						<input type='text' id="txtPageComment"  class="form-control"/>
					</div>
					<div class='maincontent'>
						<lable>所属项目</lable>
						<s:select id="secProject" list="projectList" listKey="id" listValue="name" headerValue='请选择' headerKey='0' onchange="changeParentGroup(this)" cssClass="form-control" />
					</div>
					<div class='maincontent'>
						<lable>父级组</lable>
						<select id="secParentGroup" onchange="changeGroup(this)" class="form-control"></select>
					</div>
					<div class='maincontent'>
						<lable>组</lable>
						<select id="secGroup" class="form-control"></select>
					</div>
					<div class='maincontent'>
						<lable>是否可见</lable>
						<select id="secIsVisible" class="form-control">
							<option value="1">可见</option>
							<option value="2">不可见</option>
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addPage();" id="btnAddPage">确定</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updatePage();" id="btnUpdatePage">确定</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="copyPage();" id="btnCopyPage">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>