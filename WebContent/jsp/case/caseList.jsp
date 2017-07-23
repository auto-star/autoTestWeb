<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Case管理</title>
<script>
	
	$(function() {
		getAllUser(<%=session.getAttribute("userId")%>);
		getAllCateogry($("#secCategoryList"),$("#secUserList").val());
		findCaseList();
	});
	
	function findCaseList() {
		var data={ 
				"executeCase.userId":$("#secUserList").val(),
				"executeCase.name":$("#txtName").val(),
				"executeCase.category":$("#secCategoryList").val(),
				"executeCase.projectId":$("#secProjectList").val()
			};
		var columns=[
						{
							"data" : "id",
							"width":"40px"
							
						},
						{
							"targets" : -1,//编辑
							"data" : null,
							"width":"20px",
							"render" : function(data) {
								var str = "<input type='checkbox' id='chk_"+data.id+"' value='"+data.id+"' name='chkAction' class='chkCase'/>";
								return str;
							}
						},
						{
							"targets" : -1,//编辑
							"data" : null,
							"width":"200px",
							"render" : function(data) {
								var str = "<a href='javascript:void(0);' value='case/initBaseCase?caseId="+data.id+"' class='link'>"+data.name+"</a>";
								return str;
							}
						},
						{
							"data" : "comment",
							"width":"250px"
						},
						{
							"data" : "projectName"
						},
						{
							"data" : "categoryName"
						},
						{
							"data" : "userName"
						},
						{
							"data" : "insertTime",
							"width":"120px"
						},
						{
							"data" : "updateTime",
							"width":"120px"
						},
						{
							"targets" : -1,//编辑
							"data" : null,
							"width":"100px",
							"render" : function(data) {
								var sessionUserId=<%=session.getAttribute("userId")%>;
								var isAdmin=<%=session.getAttribute("isAdmin")%>;
								var str="";
								if(sessionUserId==data.userId||isAdmin==2){
									str+="<a class='glyphicon glyphicon-pencil' onclick='showUpdateCasePanel(this)' style='cursor:pointer;'></a>";
									str+= "&nbsp;&nbsp;&nbsp;&nbsp;<a class='glyphicon glyphicon-trash'  style='cursor:pointer;' onclick='deleteCase(this);'></a>";
								}
								str+= "&nbsp;&nbsp;&nbsp;&nbsp;<a class='glyphicon glyphicon-copy' title='Copy Case' style='cursor:pointer;' onclick='showCopyCasePanel(this);'></a>";
								str+= "&nbsp;&nbsp;&nbsp;&nbsp;<a class='glyphicon glyphicon-play' title='执行'  style='cursor:pointer;' onclick='executeCase(this);'></a>";
								return str;
							}
						}];
		var url="case/findCaseList";
		findList($('#tableCaseList'),url,data,columns);
	}
	function addCase() {
		$.ajax({
			type : 'POST',
			url : "case/insertCase",
			data : {
				"executeCase.name" : $("#txtCaseName").val(),
				"executeCase.comment" : $("#txtCaseComment").val(),
				"executeCase.projectId" : $("#secProject").val(),
				"executeCase.category" : $("#secCategory").val()
				
			},
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					findCaseList();
				}
			}
		});

	}
	function updateCase() {
		$.ajax({
			type : 'POST',
			url : "case/updateCase",
			data : {
				"executeCase.id" : $("#txtCaseId").val(),
				"executeCase.name" : $("#txtCaseName").val(),
				"executeCase.comment" : $("#txtCaseComment").val(),
				"executeCase.projectId" : $("#secProject").val(),
				"executeCase.category" : $("#secCategory").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("修改成功");
					findCaseList();
				}
			}
		});
	}
	function deleteCase(obj) {
		if(confirm("确定删除？")){
			$.ajax({
				type : 'POST',
				url : "case/deleteCase?caseId=" + $(obj).parent("td").siblings().eq(0).text(),
				success : function(data) {
					if (data > 0) {
						alert("删除成功");
						findCaseList();
					}
				},
				error : function() {   
		          	alert("删除失败,请联系开发人员");  
		          	findCaseList();
		      	}  
			});
		}
		
	}
	function showAddCasePanel() {
		getAllCateogry($("#secCategory"),$("#secUserList").val());
		$("#btnUpdateCase").hide();
		$("#btnAddCase").show();
		$("#btnCopyCase").hide();
		$("#btnCopyCheckCase").hide();
		$("#caseModalTitle").text("Case添加");
		$('#caseModal').modal('show');
	}
	function showUpdateCasePanel(obj) {
		var caseId = $(obj).parent("td").siblings().eq(0).text();
		$("#txtCaseId").val(caseId);
		$.ajax({
			type : 'POST',
			url : "case/findCaseById?caseId=" + caseId,
			async : false,
			success : function(data) {
				getAllCateogry($("#secCategory"),$("#secUserList").val());
				var obj=data["aaData"];
				$("#btnAddCase").hide();
				$("#btnUpdateCase").show();
				$("#btnCopyCase").hide();
				$("#btnCopyCheckCase").hide();
				$("#txtCaseId").val(obj[0]["id"]);
				$("#txtCaseName").val(obj[0]["name"]);
				$("#txtCaseComment").val(obj[0]["comment"]);
				$("#secProject").val(obj[0]["projectId"]);
				$("#secCategory").val(obj[0]["category"]);
				$('#caseModal').modal('show');
			}
		});

	}
	function checkAll()
	{
		if($("#chk_all").is(':checked')){
			$(".chkCase").each(function(){
				$(this).prop("checked",true);
			});
		}else{
			$(".chkCase").each(function(){
				$(this).prop("checked",false);
			});
		}
		
	}
	function executeCase(obj)
	{
		var caseId=$(obj).parent("td").siblings().eq(0).text();
		$("#txtExecuteCaseId").val(caseId);
		getEnvironmentByProjectId($("#secEnvironment"));
		$('#caseExecuteConditionModal').modal('show');
	}
	function executeCheckCase()
	{
		var arr = new Array();
		$(".chkCase").each(function() {
			if ($(this).is(':checked')) {
				arr.push($(this).val());
			}
		});
		if(arr==""){
			alert("请选择Case")
			return;
		}
		$("#txtExecuteCaseId").val(arr);
		getEnvironmentByProjectId($("#secEnvironment"));
		$('#caseExecuteConditionModal').modal('show');
		
	}
	function getEnvironmentByProjectId(e){
		$.ajax({
			type : 'POST',
			url : "manage/findEnvironmentListByProjectId",
			data : {
				"projectId" : $("#secProjectList").val()
			},
			success : function(data) {
				var str="";
				var o=data["aaData"];
				for(i=0;i<o.length;i++){
					var obj=o[i];
					str+="<option value='"+obj["id"]+"'>"+obj["name"]+"</option>";
				}
				$(e).append(str);
			}
		});
	}
	function confirmExecute()
	{
		var caseIds=$("#txtExecuteCaseId").val();
		var environmentId=$("#secEnvironment").val();
		var ip=$("#secClient").val();
		if(environmentId==""){
			alert("请选择执行环境");
			return;
		}
		var screenShot=$("#secScreenShot").val();
		$.ajax({
			type : 'POST',
			url : "case/insertRunCaseResult",
			data : {
				"caseIds" : caseIds,
				"environmentId":environmentId,
				"ip":ip,
				"screenShot":screenShot
			},
			beforeSend:function(){
				loading();
			},
			success : function(data) {
				if (data > 0) {
					alert("请耐心等待执行");
					redirect("Case执行结果","case/initRunCaseResult");
					
				}
			},
			complete: function () {
				removeLoading();
			}
		});
	}
	function copyCase(obj)
	{
		var caseId=$(obj).parent("td").siblings().eq(0).text();
		$.ajax({
			type : 'POST',
			url : "case/copyCase?caseId="+caseId,
			data : {
				"executeCase.id" : $("#txtCaseId").val(),
				"executeCase.name" : $("#txtCaseName").val(),
				"executeCase.comment" : $("#txtCaseComment").val(),
				"executeCase.projectId" : $("#secProject").val(),
				"executeCase.category" : $("#secCategory").val()
			},	
			success : function(data) {
				if (data > 0) {
					alert("Copy成功");
					findCaseList();
				}
			}
		});
	}
	function showCopyCasesPanel(){
		var arr = new Array();
		$(".chkCase").each(function() {
			if ($(this).is(':checked')) {
				arr.push($(this).val());
			}
		});
		if(arr==""){
			alert("请选择要Copy的Case")
			return;
		}
		getAllCateogry($("#secCategory"),<%=session.getAttribute("userId")%>);
		$("#txtCaseId").val(arr);
		$("#btnAddCase").hide();
		$("#btnUpdateCase").hide();
		$("#btnCopyCase").hide();
		$("#btnCopyCheckCase").show();
		$("#caseCommentContainer").hide();
		$("#caseNameContainer").hide();
		$("#caseModalTitle").text("Copy Case");
		$('#caseModal').modal('show');
	}
	function copyCheckCase()
	{
		$.ajax({
			type : 'POST',
			url : "case/copyCheckCase",
			data : {
				"caseIds" : $("#txtCaseId").val(),
				"executeCase.projectId" : $("#secProject").val(),
				"executeCase.category" : $("#secCategory").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("Copy成功");
					findCaseList();
				}
			}
		});
	}
	function showStrategyPanel(){
		var arr = new Array();
		$(".chkCase").each(function() {
			if ($(this).is(':checked')) {
				arr.push($(this).val());
			}
		});
		if(arr==""){
			alert("请选择Case")
			return;
		}
		$("#txtCaseStrategyId").val(arr);
		getEnvironmentByProjectId($("#secEnvironment2"));
		$('#caseStrategyModal').modal('show');
	}
	function confirmStrategy(){
		var caseIds=$("#txtCaseStrategyId").val();
		var environmentId=$("#secEnvironment2").val();
		if(environmentId==""){
			alert("请选择执行环境");
			return;
		}
		var screenShot=$("#secScreenShot2").val();
		var category=$("#secExecuteStrategy").val();
		var executeTime=$("#txtExecuteTime").val().replace("T"," ");
		if(executeTime==""){
			alert("请输入执行时间");
			return;
		}
		
		$.ajax({
			type : 'POST',
			url : "case/insertStrategy",
			data : {
				"caseIds" : caseIds,
				"strategy.environmentId":environmentId,
				"strategy.screenShot":screenShot,
				"strategy.category":category,
				"strategy.executeTime":executeTime
			},
			success : function(data) {
				if (data > 0) {
					alert("成功");
					findCaseList();
				}
			}
		});
	}
	function showCopyCasePanel(obj){
		var caseId = $(obj).parent("td").siblings().eq(0).text();
		$("#txtCaseId").val(caseId);
		$.ajax({
			type : 'POST',
			url : "case/findCaseById?caseId=" + caseId,
			async : false,
			success : function(data) {
				getAllCateogry($("#secCategory"),<%=session.getAttribute("userId")%>);
				var obj=data["aaData"];
				$("#btnAddCase").hide();
				$("#btnUpdateCase").hide();
				$("#btnCopyCase").show();
				$("#btnCopyCheckCase").hide();
				$("#txtCaseId").val(obj[0]["id"]);
				$("#txtCaseName").val(obj[0]["name"]+"_copy");
				$("#txtCaseComment").val(obj[0]["comment"]+"_copy");
				$("#secProject").val(obj[0]["projectId"]);
				$("#secCategory").val(0);
				$("#caseModalTitle").text("Copy Case");
				$('#caseModal').modal('show');
			}
		});
	}
	function changeStrategy(obj){
		if($(obj).val()==1){
			$("#txtExecuteTime").attr("type","datetime-local");
		}
		if($(obj).val()==2){
			$("#txtExecuteTime").attr("type","time");
		}
		
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
</head>

<body>
	<div class="maincontent">
		<div class="searchBox">
			<div class="search-line">
				<label>用户名</label><select id="secUserList" class="form-control search-control" onchange="getAllCateogry($('#secCategoryList'),this.value);findCaseList();"></select>
			</div>
			<div class="search-line">
				<label>项目</label><s:select id="secProjectList" list="projectList" listKey="id" listValue="name" cssClass="form-control search-control" onchange="findCaseList();"/>
			</div>
			<div class="search-line">
				<label>Case名称</label>
				<input type="text"  id="txtName" class="form-control search-control" onkeyup="findCaseList();" />
			</div>
			<div class="search-line">
				<label>文件夹</label><select id="secCategoryList" class="form-control search-control" onchange="findCaseList();"></select>
			</div>
			<div class="clear"></div>
		</div>
		
		<div class="maincontent" style="text-align:center;">
			<input type="button" value="批量执行" onclick="executeCheckCase()" class="btn btn-primary"/>
			<input type="button" value="策略执行" onclick="showStrategyPanel()" class="btn btn-primary"/>
			<input type="button" value="查询" onclick="findCaseList()" class="btn btn-default"/>
			<input type="button" value="批量Copy" onclick="showCopyCasesPanel()" class="btn btn-primary"/>
			<input type="button" value="新增Case" onclick="showAddCasePanel()" class="btn btn-primary"/>
		</div>
		<hr/>
		<div class="maincontent">
			<table id="tableCaseList" class="table table-striped table-bordered" style="table-layout:fixed">
				<thead>
					<tr>
						<th>序号</th>
						<th><input type='checkbox' id='chk_all' onclick="checkAll()"/></th>
						<th>Case名称</th>
						<th>描述</th>
						<th>项目</th>
						<th>文件夹</th>
						<th>用户</th>
						<th>创建时间</th>
						<th>更新时间</th>
						<th>操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div class="modal fade" id="caseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="caseModalTitle">Case编辑</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" id="txtCaseId" />
					<div class='maincontent' id="caseNameContainer">
						<lable>Case名称</lable>
						<input type='text' id="txtCaseName" maxLength="40"  class="form-control"/>
					</div>
					<div class='maincontent' ID="caseCommentContainer">
						<lable>Case描述</lable>
						<textarea id="txtCaseComment" style="width:300px;height:45px;" maxLength="255" class="form-control" ></textarea>
					</div>
					<div class='maincontent'>
						<lable>所属项目</lable>
						<s:select id="secProject" list="projectList" listKey="id" listValue="name" headerValue='请选择' headerKey='' cssClass="form-control"/>
					</div>
					<div class='maincontent'>
						<lable>所属文件夹</lable>
						<select id="secCategory" class="form-control">
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addCase();" id="btnAddCase">确定</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateCase();" id="btnUpdateCase">确定</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="copyCase();" id="btnCopyCase">确定</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="copyCheckCase();" id="btnCopyCheckCase">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="caseExecuteConditionModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="caseExecuteConditionModalTitle">Case执行条件</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" id="txtExecuteCaseId" />
					<div class='maincontent'>
						<lable>环境选择</lable>
						<select id="secEnvironment" class="form-control">
						</select>
					</div>
					<div class='maincontent'>
						<lable>指定客户端</lable>
						<s:select id="secClient" list="clientList" listKey="ip" listValue="name" headerValue='随缘' headerKey='' cssClass="form-control"/>
					</div>
					<div class='maincontent'>
						<lable>是否截图</lable>
						<select id="secScreenShot" class="form-control">
							<option value="1">是</option>
							<option value="2">否</option>
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="confirmExecute();" id="btnConfirmExecute">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="caseStrategyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="caseStrategyModalTitle">Case执行策略</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" id="txtCaseStrategyId" />
					<div class='maincontent'>
						<lable>环境选择</lable>
						<select id="secEnvironment2" class="form-control">
						</select>
					</div>
					<div class='maincontent'>
						<lable>执行策略</lable>
						<select id="secExecuteStrategy" onchange="changeStrategy(this)" class="form-control">
							<option value="1">定时</option>
							<option value="2">每天</option>
						</select>
					</div>
					<div class='maincontent'>
						<lable>执行时间</lable>
						<input type="datetime-local" id="txtExecuteTime" class="form-control"/>
					</div>
					<div class='maincontent'>
						<lable>是否截图</lable>
						<select id="secScreenShot2" class="form-control">
							<option value="1">是</option>
							<option value="2">否</option>
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="confirmStrategy();" id="btnAddStrategy">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>