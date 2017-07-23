<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RunCaseResult管理</title>
</head>
<script>
	$(function() {
		getAllUser(<%=session.getAttribute("userId")%>);
		getAllCateogry($("#secCategoryList"),$("#secUserList").val());
		getAllEnvironment();
		getDate();
		findRunCaseResultList();
	});
	function getDate(){
		$("#secDateList").append("<option value=''>All</option>");
		for(i=0;i<20;i++){
			var date=new Date();
			date.setDate(date.getDate()-i);
			var day=date.getDate();
			if(day.toString().length==1){
				day="0"+day;
			}
			var month=date.getMonth()+1;
			var year=date.getFullYear();
			var realDate=year+"-"+month+"-"+day;
			$("#secDateList").append("<option value='"+realDate+"'>"+realDate+"</option>");
		}
	}
	function findRunCaseResultList() {
		var table=$('#tableRunCaseResultList').DataTable(
		{
			"processing": true,
			"serverSide":true,
			"ordering" : false,
			"destroy":true,
			"searching":false,
			"ajax" : {
				"url":"case/findRunCaseResultList",
				"data": { 
					"runCaseResult.caseName": $("#txtCaseName").val(),
					"runCaseResult.insertUser": $("#secUserList").val(),
					"runCaseResult.status":$("#secStatus").val(),
					"runCaseResult.environmentId":$("#secEnvironmentList").val(),
					"runCaseResult.insertTime":$("#secDateList").val(),
					"runCaseResult.categoryId":$("#secCategoryList").val()
				},
				"type":"post"
			},
			"columns" : [
					{
						"data" : "id",
						"width":"40px"
					},
					{
						"targets" : -1,//编辑
						"data" : null,
						"width":"20px",
						"render" : function(data) {
							var str = "<input type='checkbox' id='chk_"+data.caseId+"' value='"+data.caseId+"' name='chkAction' class='chkCase'/>";
							return str;
						}
					},
					{
						"data" : "caseName"
					},
					{
						"data" : "caseCategory",
						"width":"100px"
					},
					{
						"data" : "status",
						"width":"100px"
					},
					{
						"data" : "userName",
						"width":"40px"
					},
					{
						"data" : "ip",
						"width":"100px"
					},
					{
						"data" : "environmentName",
						"width":"100px"
					}
					,
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
							var str = "<span style='cursor:pointer;' onclick='deleteRunCaseResult(this);'>删除</span>";
							if (data.resultFile != undefined) {
								str += "&nbsp;&nbsp;<a style='cursor:pointer;' onclick=\"downloadFile(\'" + data.id + "\');\">报告</a>";
							}
							if (data.logFile != undefined) {
								str += "&nbsp;&nbsp;<a style='cursor:pointer;' onclick=\"downloadLogFile(\'" + data.id + "\');\">日志</a>";
							}
							return str;
						}
					} ],
			"aoColumnDefs" : [ {
				sDefaultContent : '',
				aTargets : [ '_all' ]
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
			}
		});
	}

	function deleteRunCaseResult(obj) {
		if (confirm("确定删除？")) {
			$.ajax({
				type : 'POST',
				url : "case/deleteRunCaseResult?runCaseResultId="
						+ $(obj).parent("td").siblings().eq(0).text(),
				async : false,
				success : function(data) {
					if (data > 0) {
						alert("删除成功");
						findRunCaseResultList();
					}
				},  
				error : function() {   
		          	alert("删除失败,请联系开发人员");  
		          	findRunCaseResultList();
		      	}  
			});
		}

	}
	function downloadFile(id) {
		window.location.href = "case/downloadFile?runCaseResultId=" + id;
	}
	function downloadLogFile(id){
		window.location.href = "case/downloadLogFile?runCaseResultId=" + id;
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
		$('#caseExecuteConditionModal').modal('show');
		
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
			success : function(data) {
				if (data > 0) {
					alert("请耐心等待执行");
					findRunCaseResultList();
					
				}
			}
		});
	}
	function deleteCheckCase(){
		var arr = new Array();
		$(".chkCase").each(function() {
			if ($(this).is(':checked')) {
				arr.push($(this).parent("td").siblings().eq(0).text());
			}
		});
		if(arr==""){
			alert("请选择Case")
			return;
		}
		if (confirm("确定删除？")) {
			var j=0;
			for(i=0;i<arr.length;i++){
				$.ajax({
					type : 'POST',
					url : "case/deleteRunCaseResult?runCaseResultId=" + arr[i],
					async : false,
					success : function(data) {
						if (data > 0) {
							j++;
						}
					},  
					error : function() {   
			          	alert("删除失败,请联系开发人员");
			      	}  
				});
			}
			if(j>0){
				alert("删除成功");
				findRunCaseResultList();
			}
		}
	}
</script>
<body>
	<div class="maincontent">
		<div class="searchBox">
			<div class="search-line">
				<label>用户名</label>
				<select id="secUserList" class="form-control search-control" onchange="getAllCateogry($('#secCategoryList'),this.value);findRunCaseResultList();"></select>
			</div>
			<div class="search-line">
				<label>Case名称</label>
				<input type="text"  id="txtCaseName" class="form-control search-control" onkeyup="findRunCaseResultList();" />
			</div>
			<div class="search-line">
				<label>执行状态</label>
				<select id="secStatus" class="form-control search-control" onchange="findRunCaseResultList();">
					<option value="1000">All</option>
					<option value="0">等待执行中</option>
					<option value="1">执行中</option>
					<option value="4">执行成功,一致</option>
					<option value="5">执行成功,不一致</option>
					<option value="6">执行失败,一致</option>
					<option value="7">执行失败,不一致</option>
				</select>
			</div>
			
			<div class="search-line">
				<label>执行环境</label>
				<s:select id="secEnvironmentList" list="environmentList" listKey="id" listValue="name" headerValue='请选择' onchange="findRunCaseResultList();" headerKey='' cssClass="form-control search-control"/>
			</div>
			<div class="search-line">
				<label>执行日期</label>
				<select id="secDateList" class="form-control search-control" onchange="findRunCaseResultList();">
				</select>
			</div>
			<div class="search-line">
				<label>文件夹</label><select id="secCategoryList" class="form-control search-control" onchange="findRunCaseResultList();"></select>
			</div>
			<div class="clear"></div>
			
		</div>
		
		<div class="maincontent" style="text-align:center;">
			<input type="button" value="批量执行" onclick="executeCheckCase()" class="btn btn-primary"/>
			<input type="button" value="查询" onclick="findRunCaseResultList()" class="btn btn-default"/>
			<input type="button" value="批量删除" onclick="deleteCheckCase()" class="btn btn-primary"/>
		</div>
		<hr/>
		<div class="maincontent">
			<table id="tableRunCaseResultList" class="table table-striped table-bordered" style="table-layout:fixed">
				<thead>
					<tr>
						<th>序号</th>
						<th><input type='checkbox' id='chk_all' onclick="checkAll()"/></th>
						<th>Case名称</th>
						<th>所属文件夹</th>
						<th>状态</th>
						<th>执行者</th>
						<th>执行机器</th>
						<th>执行环境</th>
						<th>开始时间</th>
						<th>结束时间</th>
						<th>操作</th>
					</tr>
				</thead>
			</table>
			
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
						<s:select id="secEnvironment" list="environmentList" listKey="id" listValue="name" headerValue='请选择' headerKey='' cssClass="form-control"/>
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
</body>
</html>