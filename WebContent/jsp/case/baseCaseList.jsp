<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基础Case管理</title>
</head>
<script>
	$(function() {
		if(<%=request.getAttribute("caseId")%>==0){
			getAllUser(<%=session.getAttribute("userId")%>);
		}
		
		findBaseCaseList();
	});
	
	function findBaseCaseList() {
		var url="case/findBaseCaseList?baseCase.caseId="+<%=request.getAttribute("caseId")%>;
		if(<%=request.getAttribute("caseId")%>>0){
			url+="&baseCase.userId="+<%=session.getAttribute("userId")%>
		}else{
			url+="&baseCase.userId="+$("#secUserList").val()+"&baseCase.projectId="+$("#secProjectList").val()
		}
		
		var table = $('#tableBaseCaseList')
				.DataTable(
						{
							"order" : [ [ 8, "asc" ] ],
							"displayLength" : 25,
							"destroy":true,
							"searching":false,
							"ajax" :url,
							"columns" : [
									{
										"data" : "id"
									},
									{
										"targets" : -1,//编辑
										"data" : null,
										"render" : function(data) {
											var str = "<a href='javascript:void(0);' value='case/initBaseCaseDetail?baseCaseId="+data.id+"' class='link'>"+data.name+"</a>";
											return str;
										}
									},
									{
										"data" : "comment"
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
										"data" : "userName"
									},
									{
										"data" : "status"
									},
									{
										"data" : "kind"
									},
									{
										"data" : "sort"
									},
									{
										"targets" : -1,//编辑
										"data" : null,
										"render" : function(data) {
											var sessionUserId=<%=session.getAttribute("userId")%>;
											var isAdmin=<%=session.getAttribute("isAdmin")%>;
											var str="";
											if(sessionUserId==data.userId||isAdmin==2){
												str += "<a class='glyphicon glyphicon-pencil' onclick='showUpdateBaseCasePanel(this)' style='cursor:pointer;'></a>";
												str += "&nbsp;&nbsp;&nbsp;&nbsp;<a class='glyphicon glyphicon-trash'  style='cursor:pointer;' onclick='deleteBaseCase(this);'></a>";
											}
											str += "&nbsp;&nbsp;&nbsp;&nbsp;<a class='glyphicon glyphicon-copy' title='Copy为基础Case' style='cursor:pointer;' onclick='copyBaseCase(this);'></a>";
											if(sessionUserId==data.userId||isAdmin==2){
												if(data.caseId>0){
													if(data.sort>1){
														str += "&nbsp;&nbsp;&nbsp;&nbsp;<a class='glyphicon glyphicon-arrow-up' title='上移' style='cursor:pointer;' onclick='updateBaseCaseSort(this,1);'></a>";
													}
													str += "&nbsp;&nbsp;&nbsp;&nbsp;<a class='glyphicon glyphicon-arrow-down' title='下移' style='cursor:pointer;' onclick='updateBaseCaseSort(this,2);'></a>";
												}
											}
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
	function updateBaseCaseSort(obj,option){
		var baseCaseId = $(obj).parent("td").siblings().eq(0).text();
		$.ajax({
			type : 'POST',
			url : "case/updateBaseCaseSort?baseCaseId=" + baseCaseId+"&option="+option+ "&caseId=" +<%=request.getAttribute("caseId")%>,
			async : false,
			success : function(data) {
				if (data > 0) {
					alert("更新成功");
					refresh($.cookie("url"));
				}
			}
		});
	}
	function addBaseCase() {
		$.ajax({
			type : 'POST',
			url : "case/insertBaseCase?baseCaseId=" + $("#secBaseCase").val()+ "&caseId=" +<%=request.getAttribute("caseId")%>,
			data : {
				"baseCase.name" : $("#txtBaseCaseName").val(),
				"baseCase.comment" : $("#txtBaseCaseComment").val(),
				"baseCase.groupId" : $("#secGroup").val(),
				"baseCase.projectId" : $("#secCustomer").val(),
				"baseCase.status" : $("#secBaseCaseStatus").val(),
				"baseCase.kind" : $("#secKind").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					refresh($.cookie("url"));
					$('#baseCaseModal').modal('hide');
				}
			}
		});

	}
	function updateBaseCase() {
		$.ajax({
			type : 'POST',
			url : "case/updateBaseCase",
			data : {
				"baseCase.id" : $("#txtBaseCaseId").val(),
				"baseCase.name" : $("#txtBaseCaseName").val(),
				"baseCase.comment" : $("#txtBaseCaseComment").val(),
				"baseCase.groupId" : $("#secGroup").val(),
				"baseCase.projectId" : $("#secCustomer").val(),
				"baseCase.status" : $("#secBaseCaseStatus").val(),
				"baseCase.kind" : $("#secKind").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("修改成功");
					refresh($.cookie("url"));
					$('#baseCaseModal').modal('hide');
				}
			}
		});
	}
	function showUpdateBaseCasePanel(obj) {
		var baseCaseId = $(obj).parent("td").siblings().eq(0).text();
		$("#txtBaseCaseId").val(baseCaseId);
		$.ajax({
			type : 'POST',
			url : "case/findBaseCaseById?baseCaseId=" + baseCaseId,
			async : false,
			success : function(data) {
				var obj = data["aaData"];
				$("#baseCaseContainer").hide();
				$("#btnAddBaseCase").hide();
				$("#btnUpdateBaseCase").show();
				$("#txtBaseCaseId").val(obj[0]["id"]);
				$("#txtBaseCaseName").val(obj[0]["name"]);
				$("#txtBaseCaseComment").val(obj[0]["comment"]);
				$("#secCustomer").val(obj[0]["projectId"]);
				changeParentGroup($("#secCustomer"));
				$("#secParentGroup").val(obj[0]["parentGroupId"]);
				changeGroup($("#secParentGroup"));
				$("#secGroup").val(obj[0]["groupId"]);
				$("#secBaseCaseStatus").val(obj[0]["status"]);
				$("#secKind").val(obj[0]["kind"]);
				$('#baseCaseModal').modal('show');
			}
		});

	}
	function deleteBaseCase(obj) {
		if (confirm("确定删除？")) {
			$.ajax({
				type : 'POST',
				url : "case/deleteBaseCase?baseCaseId="+ $(obj).parent("td").siblings().eq(0).text(),
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
	function showAddBaseCasePanel() {
		$("#baseCaseContainer").show();
		$("#btnUpdateBaseCase").hide();
		$("#btnAddBaseCase").show();
		$("#baseCaseModalTitle").text("BaseCase添加");
		$('#baseCaseModal').modal('show');
	}
	function showBaseCaseList(obj) {
		$.ajax({
			type : 'POST',
			url : "case/findBaseCaseList?baseCase.groupId=" + $(obj).val(),
			async : false,
			success : function(data) {
				var obj = data["aaData"];
				$("#secBaseCase").empty();
				$("#secBaseCase").append("<option value='0'>新增基础case</option>")
				for (i = 0; i < obj.length; i++) {
					var object = obj[i];
					$("#secBaseCase").append("<option value='"+object["id"]+"'>" + object["name"] + "_" + object["comment"] + "</option>")
				}
			}
		});
	}
	function changeParentGroup(obj) {
		$.ajax({
			type : 'POST',
			url : "case/findGroupList?projectId=" + $(obj).val()+"&parentGroupId=-1",
			async : false,
			success : function(data) {
				var obj = data["aaData"];
				$("#secParentGroup").empty();
				$("#secParentGroup").append("<option value='0'>请选择</option>")
				for (i = 0; i < obj.length; i++) {
					var object = obj[i];
					$("#secParentGroup").append("<option value='"+object["id"]+"'>"+ object["name"] + "</option>")
				}
			}
		});
	}
	function changeGroup(obj) {
		$.ajax({
			type : 'POST',
			url : "case/findGroupList?parentGroupId=" + $(obj).val(),
			async : false,
			success : function(data) {
				var obj = data["aaData"];
				$("#secGroup").empty();
				$("#secGroup").append("<option value='0'>请选择</option>")
				for (i = 0; i < obj.length; i++) {
					var object = obj[i];
					$("#secGroup").append(
							"<option value='"+object["id"]+"'>"
									+ object["name"] + "</option>")
				}
			}
		});
	}
	function copyBaseCase(obj) {
		var baseCaseId = $(obj).parent("td").siblings().eq(0).text();
		$.ajax({
			type : 'POST',
			url : "case/copyBaseCase?baseCaseId=" + baseCaseId,
			success : function(data) {
				if (data > 0) {
					alert("Copy成功");
					refresh($.cookie("url"));
				}
			}
		
		});
	}
	function changeBaseCase(obj)
	{
		$.ajax({
			type : 'POST',
			url : "case/findBaseCaseById?baseCaseId=" + $(obj).val(),
			async : false,
			success : function(data) {
				var arr=data["aaData"];
				$("#txtBaseCaseName").val(arr[0]["name"]);
				$("#txtBaseCaseComment").val(arr[0]["comment"]);
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
<body style="background:url('css/images/baseCase.jpg') no-repeat; ">
	<div class="maincontent">
		
		<s:if test="caseId==0">
			<div class="searchBox">
					<div class="search-line">
						<label>用户名</label><select id="secUserList" class="form-control search-control" onchange="findBaseCaseList();"></select>
					</div>
					<div class="search-line">
						<label>项目</label><s:select id="secProjectList" list="projectList" listKey="id" listValue="name" cssClass="form-control search-control" onchange="findBaseCaseList();"/>
					</div>
				<div class="clear"></div>
			</div>
			<div class="maincontent" style="text-align:center;">
				<input type="button" value="查询" onclick="findBaseCaseList()" class="btn btn-default"/>
				<input type="button" value="新增基础Case" onclick="showAddBaseCasePanel()" class="btn btn-primary"/>
			</div>
		</s:if>
		<s:else>
			<div class="maincontent" style="text-align:right;">
				<input type="button" value="新增基础Case" onclick="showAddBaseCasePanel()" class="btn btn-primary"/>
			</div>
		</s:else>
		<div class="maincontent">


			<table id="tableBaseCaseList" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>序号</th>
						<th>Case名称</th>
						<th>描述</th>
						<th>组</th>
						<th>父级组</th>
						<th>项目</th>
						<th>用户</th>
						<th>状态</th>
						<th>前后台</th>
						<th>Sort</th>
						<th>操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div class="modal fade" id="baseCaseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="baseCaseModalTitle">BaseCase编辑</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" id="txtBaseCaseId" />
					
					<div class='maincontent'>
						<lable>所属项目</lable>
						<s:select id="secCustomer" list="projectList" listKey="id" listValue="name" headerValue='请选择' headerKey='' onchange="changeParentGroup(this);"  cssClass="form-control"/>
					</div>
					<div class='maincontent'>
						<lable>父级组</lable>
						<select id="secParentGroup" onchange="changeGroup(this);" class="form-control"></select>
					</div>
					<div class='maincontent'>
						<lable>组</lable>
						<select id="secGroup" onchange="showBaseCaseList(this);" class="form-control"></select>
					</div>
					<div class='maincontent' id="baseCaseContainer">
						<lable>BaseCase选择</lable>
						<select id="secBaseCase" onchange="changeBaseCase(this)" class="form-control">
							<option value='0'>新增基础case</option>
						</select>
					</div>
					<div  class='maincontent'>
						<lable>状态</lable>
						<select id="secBaseCaseStatus" class="form-control" class="form-control">
							<option value="2">打开</option>
							<option value="1">关闭</option>
						</select>
					</div>
					<div  class='maincontent'>
						<lable>前台Or后台</lable>
						<select id="secKind" class="form-control" class="form-control">
							<option value="2">后台</option>
							<option value="1">前台</option>
						</select>
					</div>
					<div class='maincontent'>
						<lable>BaseCase名称</lable>
						<input type='text' id="txtBaseCaseName" class="form-control"/>
					</div>
					<div class='maincontent'>
						<lable>描述</lable>
						<input type='text' id="txtBaseCaseComment"  class="form-control"/>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addBaseCase();" id="btnAddBaseCase">确定</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateBaseCase();" id="btnUpdateBaseCase">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>