<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Degrade管理</title>
<script>
	
	$(function() {
		getDate();
		findDegradeList();
	});
	function getDate(){
		$("#secDateList").append("<option value=''>All</option>");
		for(i=0;i<100;i++){
			var date=new Date();
			date.setDate(date.getDate()-i);
			var day=date.getDate();
			if(day.toString().length==1){
				day="0"+day;
			}
			var month=date.getMonth()+1;
			var year=date.getFullYear();
			var realDate=year+"-"+month+"-"+day;
			$("#leftExecuteDate").append("<option value='"+realDate+"'>"+realDate+"</option>");
			$("#rightExecuteDate").append("<option value='"+realDate+"'>"+realDate+"</option>");
		}
	}
	function findDegradeList() {
		var obj=$('#tableDegradeList');
		var url="case/findDegradeList";
		var data={
				"degrade.leftEnvironmentId":$("#leftEnvironmentId").val(),
				"degrade.rightEnvironmentId":$("#rightEnvironmentId").val(),
				"degrade.leftExecuteDate":$("#leftExecuteDate").val(),
				"degrade.rightExecuteDate":$("#rightExecuteDate").val(),
				"degrade.caseName":$("#txtName").val()
		};
		var columns=[
						{
							"targets" : -1,//编辑
							"data" : null,
							"render" : function(data) {
								var str = "<input type='checkbox' class='chkThis' value='"+data.leftRunCaseResultId+"_"+data.rightRunCaseResultId+"'/>";
								
								return str;
							}
						},
						{
							"data" : "caseId"
						},
						{
							"data" : "caseName"
						},
						{
							"data" : "leftEnvrionmentName"
						},
						{
							"data" : "leftExecuteDate"
						},
						{
							"data" : "rightEnvironmentName"
						},
						{
							"data" : "rightExecuteDate"
						},
						{
							"targets" : -1,//编辑
							"data" : null,
							"render" : function(data) {
								var str = "未比较";
								return str;
							}
						},
						{
							"targets" : -1,//编辑
							"data" : null,
							"render" : function(data) {
								var str = "";
								str += "&nbsp;&nbsp;&nbsp;&nbsp;<a title='编辑' style='cursor:pointer;' onclick='downloadDegradeFile("+data.leftRunCaseResultId+","+data.rightRunCaseResultId+");'>下载</a>";
								return str;
							}
		} ];
		
		findList(obj,url,data,columns);
	}
	function downloadDegradeFile(leftRunCaseResultId,rightRunCaseResultId){
		window.location.href="case/downloadDegradeFile?leftRunCaseResultId="+leftRunCaseResultId+"&rightRunCaseResultId="+rightRunCaseResultId;
	}
	function checkAll(){
		if($("#chkAll").is(':checked')){
			$(".chkThis").each(function(){
				$(this).prop("checked",true);
			});
		}else{
			$(".chkThis").each(function(){
				$(this).prop("checked",false);
			});
		}
	}
	function compare(){
		var arr = new Array();
		var flag=false;
		$(".chkThis").each(function() {
			if ($(this).is(':checked')) {
				flag=true;
				arr=$(this).val().split("_");
				var obj=$(this);
				$(obj).parent("td").parent("tr").find("td").eq(7).html("");
				$.ajax({
					type : 'POST',
					url : "case/compare",
					data : {
						"leftRunCaseResultId" : arr[0],
						"rightRunCaseResultId":arr[1]
					},
					success : function(data) {
						if (data > 0) {
							$(obj).parent("td").siblings().eq(6).append("一致");
						}else{
							$(obj).parent("td").siblings().eq(6).append("不一致");
						}
					}
				});
				arr.push($(this).val());
			}
		});
		if(!flag){
			alert("请选择Case")
			return;
		}
	}
	
</script>
<style>
	.search-left{
		width:50%;
		float:left;
		margin-top:2px;
	}
	.search-line{
		width:40%;
	}
</style>
</head>
<body>
	<div class="maincontent">
		<div class="searchBox">
			<div class="search-line" style="border-bottom:1px dotted gray;width:100%;">
				<label>Case名称</label>
				<input type="text"  id="txtName" class="form-control" onkeyup="findDegradeList();"/>
			</div>
			<div class="search-left" style="border-right:1px dotted gray;">
				<div class="search-line" style="width:50%;">
					<label>环境</label>
					<s:select id="leftEnvironmentId" list="environmentList" listKey="id" listValue="name" headerValue='请选择' headerKey='' cssClass="form-control search-control" onchange="findDegradeList();"/>
				</div>
				<div class="search-line">
					<label>执行日期</label>
					<select id="leftExecuteDate" class="form-control search-control" onchange="findDegradeList();">
					</select>
				</div>
			</div>
			
			<div class="search-left">
				<div class="search-line" style="width:50%;">
					<label>环境</label>
					<s:select id="rightEnvironmentId" list="environmentList" listKey="id" listValue="name" headerValue='请选择' headerKey='' cssClass="form-control search-control" onchange="findDegradeList();"/>
				</div>
				<div class="search-line">
					<label>执行日期</label>
					<select id="rightExecuteDate" class="form-control search-control" onchange="findDegradeList();">
					</select>
				</div>
			</div>
			<div class="search-line" style="border-top:1px dotted gray;width:100%;padding-top:2px;">
				<input type="button" value="查询" onclick="findDegradeList()" class="btn"/>
				<input type="button" value="对比" onclick="compare()" class="btn btn-primary"/>
			</div>
			<div class="clear"></div>
			
		</div>
		<div class="maincontent">
			<table id="tableDegradeList"
				class="table table-striped table-bordered">
				<thead>
					<tr>
						<th><input type="checkbox" id="chkAll" onclick="checkAll();"></th>
						<th>CaseId</th>
						<th>名称</th>
						<th>左环境</th>
						<th>左日期</th>
						<th>右环境</th>
						<th>右日期</th>
						<th>是否一致</th>
						<th>操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
</body>
</html>