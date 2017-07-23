<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Strategy管理</title>
</head>
<script>
	$(function() {
		getAllUser(<%=session.getAttribute("userId")%>);
		findStrategyList();
	});
	function findStrategyList() {
		var data={
				"strategy.userId":$("#secUserList").val(),
				"strategy.caseName":$("#txtCaseName").val()
			};
		var url="case/findStrategyList";
		var columns= [
						{
							"data" : "id"
						},
						{
							"targets" : -1,//编辑
							"data" : null,
							"render" : function(data) {
								var str = "<input type='checkbox' id='chk_"+data.id+"' value='"+data.id+"' name='chkStrategy' class='chkStrategy'/>";
								return str;
							}
						},
						{
							"data" : "caseName"
						},
						{
							"data" : "categoryName"
						},
						{
							"data" : "category"
						},
						{
							"data" : "executeTime"
						},
						{
							"data" : "environmentName"
						},
						{
							"data" : "screenShot"
						},
						{
							"data" : "userName"
						},
						{
							"targets" : -1,//编辑
							"data" : null,
							"render" : function(data) {
								var sessionUserId=<%=session.getAttribute("userId")%>;
								var isAdmin=<%=session.getAttribute("isAdmin")%>;
								var str="";
								if(sessionUserId==data.userId||isAdmin==2){
									str = "<span class='glyphicon glyphicon-trash'  style='cursor:pointer;' onclick='deleteStrategy(this);'></span>";
								}
								return str;
							}
						} ];
		var obj=$('#tableStrategyList');
		findList(obj,url,data,columns);
		
	}

	function deleteStrategy(obj) {
		if (confirm("确定删除？")) {
			$.ajax({
				type : 'POST',
				url : "case/deleteStrategy?strategyId="
						+ $(obj).parent("td").siblings().eq(0).text(),
				async : false,
				success : function(data) {
					if (data > 0) {
						alert("删除成功");
						findStrategyList();
					}
				},  
				error : function() {   
		          	alert("删除失败,请联系开发人员");  
		          	findStrategyList();
		      	}  
			});
		}

	}
	function deleteCheckStrategy(){
		var arr = new Array();
		$(".chkStrategy").each(function() {
			if ($(this).is(':checked')) {
				arr.push($(this).val());
			}
		});
		if(arr==""){
			alert("请选择至少一条策略")
			return;
		}
		if(confirm("确定删除？")){
			var j=0;
			for(i=0;i<arr.length;i++){
				$.ajax({
					type : 'POST',
					url : "case/deleteStrategy?strategyId="
							+ arr[i],
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
				findStrategyList();
			}
		}
	}
	function checkAll()
	{
		if($("#chk_all").is(':checked')){
			$(".chkStrategy").each(function(){
				$(this).prop("checked",true);
			});
		}else{
			$(".chkStrategy").each(function(){
				$(this).prop("checked",false);
			});
		}
		
	}
</script>
<body>
	<div class="maincontent">
		<div class="searchBox">
			<div class="search-line">
				<label>用户名</label>
				<select id="secUserList" class="form-control search-control" onchange="findStrategyList();"></select>
			</div>
			<div class="search-line">
				<label>Case名称</label>
				<input type="text"  id="txtCaseName" class="form-control search-control" onkeyup="findStrategyList();" />
			</div>
			<div class="clear"></div>
		</div>
		<div  class="maincontent" style="text-align:center;">
			<input type="button" value="批量删除" onclick="deleteCheckStrategy()" class="btn btn-primary"/>
			<input type="button" value="查询" onclick="findStrategyList()" class="btn btn-default"/>
		</div>
		<hr/>
		<div class="maincontent" >


			<table id="tableStrategyList" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>序号</th>
						<th><input type='checkbox' id='chk_all' onclick="checkAll()"/></th>
						<th>Case名称</th>
						<th>Case文件夹</th>
						<th>执行策略</th>
						<th>执行时间</th>
						<th>执行环境</th>
						<th>是否截图</th>
						<th>用户</th>
						<th>操作</th>
					</tr>
				</thead>
			</table>
		</div>
		
	</div>

</body>
</html>