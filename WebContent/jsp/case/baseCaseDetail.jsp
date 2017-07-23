<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BaseCase详情</title>
</head>
<script>
	function showAddCasePagePanel(value) {
		$("#baseCaseModalTitle").text("BaseCae Page添加");
		$("#txtCasePageId").val(value)
		$("#newContainer").show();
		$("#btnAddRefCasePage").hide();
		$("#btnAddCasePage").show();
		$('#baseCaseModal').modal('show');
	}
	function showPageList(obj)
	{
		var url;
		url="page.groupId="+$(obj).val()+"&page.isVisible=1";
		$.ajax({
			type : 'POST',
			url : "case/findPageList?"+url,
			async : false,
			success : function(data) {
				var obj=data["aaData"];
				$("#secPage").empty();
				$("#secPage").append("<option value='0'>请选择</option>");
				for(i=0;i<obj.length;i++){
					var object=obj[i];
					$("#secPage").append("<option value='"+object["id"]+"'>"+object["title"]+"</option>")
				}
			}
		});
	}
	function changePage(obj)
	{
		$.ajax({
			type : 'POST',
			url : "case/findPageById?id="+$(obj).val(),
			async : false,
			success : function(data) {
				$("#txtCasePageName").val(data["title"]);
				$("#txtCasePageComment").val(data["comment"]);
			}
		});
	}
	function addCasePage(){
		$.ajax({
			type : 'POST',
			url : "case/insertCasePage?casePageId="+$("#txtCasePageId").val(),
			data : {
				"casePage.pageId" : $("#secPage").val(),
				"casePage.name" : $("#txtCasePageName").val(),
				"casePage.comment" : $("#txtCasePageComment").val(),
				"casePage.parentId" : 0,
				"casePage.baseCaseId" : <%=request.getAttribute("baseCaseId")%>
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
	function updateCaseData(casePageId){
		var jsonObject="[";
		var i=0;
		var len=$("[name='caseData_"+casePageId+"']").length;
		$("[name='caseData_"+casePageId+"']").each(function(){
			i++;
			if(i==len){
				jsonObject+="{'id':'"+$(this).attr("id").split("_")[1]+"','dataValue':'"+$(this).val()+"'}";
			}else{
				jsonObject+="{'id':'"+$(this).attr("id").split("_")[1]+"','dataValue':'"+$(this).val()+"'},";
			}
			
		})
		jsonObject+="]";
		$.ajax({
			type : 'POST',
			url : "case/updateCaseData",
			data:"dataJson="+jsonObject,
			dataType:"json",
			async : false,
			success : function(data) {
				if(data>0){
					alert("更新成功");
				}
			}
		});
	}
	function deleteCasePage(value)
	{
		if(confirm("确定要删除？")){
			$.ajax({
				type : 'POST',
				url : "case/deleteCasePage?casePageId=" + value,
				async : false,
				success : function(data) {
					if(data>0){
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
	function changeParentGroup(obj)
	{
		$.ajax({
			type : 'POST',
			url : "case/findGroupList?projectId=" + $(obj).val()+"&parentGroupId=-1",
			async : false,
			success : function(data) {
				var obj=data["aaData"];
				$("#secParentGroup").empty();
				$("#secParentGroup").append("<option value='0'>请选择</option>")
				for(i=0;i<obj.length;i++){
					var object=obj[i];
					$("#secParentGroup").append("<option value='"+object["id"]+"'>"+object["name"]+"</option>")
				}
			}
		});
	}
	function changeGroup(obj)
	{
		$.ajax({
			type : 'POST',
			url : "case/findGroupList?parentGroupId=" + $(obj).val(),
			async : false,
			success : function(data) {
				var obj=data["aaData"];
				$("#secGroup").empty();
				$("#secGroup").append("<option value='0'>请选择</option>")
				for(i=0;i<obj.length;i++){
					var object=obj[i];
					$("#secGroup").append("<option value='"+object["id"]+"'>"+object["name"]+"</option>")
				}
			}
		});
	}
	function togglePageContent(obj)
	{
		if($(obj).text()=="收起"){
			$(obj).text("展开")
			$(".pagecontent").each(function(){
				$(this).hide();
			});
		}
		else{
			$(obj).text("收起")
			$(".pagecontent").each(function(){
				$(this).show();
			});
		}
	}
	$(function(){
		findBaseCaseList();
	});
	function findBaseCaseList(){
		
		$.ajax({
			type : 'POST',
			url : "case/findCasePageList?baseCaseId="+<%=request.getAttribute("baseCaseId")%>,
			beforeSend:function(){
				loading();
			},
			success : function(data) {
				var str=showCasePage(data);
				$("#casecontainer").empty();
				$("#casecontainer").append(str);
			},
			complete: function () {
				removeLoading();
			}
		});
	}
	function showCasePage(data){
		var str="";
		var m=0;
		for (i = 0; i < data.length; i++) {
			m=i;
			var casePageObj=data[i];
			str+="<div class='pagecontainer'>";
			str+="	<div class='pageheader'>"+casePageObj["name"]+"</div>";
			str+="	<div class='pagecontent'>";
			str+="		<div class='maincontent' id='caseDataContainer_"+casePageObj["id"]+"'>";
			for(j=0;j<casePageObj["dataMapList"].length;j++){
				
				var dataMapObj=casePageObj["dataMapList"][j];
				var actionObj=dataMapObj["action"];
				var caseDataObj=dataMapObj["caseData"];
				var dataMapCollectionList=dataMapObj["dataMapCollection"]
				if(dataMapObj["category"]!=4){
					str+="	<div class='left datacontainer'>";
					if(actionObj["commandName"]=='html.gatherData'){
						str+="	<lable style='color:red;'> "+actionObj["elementName"]+"</lable>";
					}else{
						str+="	<lable> "+actionObj["elementName"]+"</lable>";
					}
					if(dataMapObj["category"]==1){
						str+="	<input type='text' value='"+caseDataObj["dataValue"]+"' name='caseData_"+casePageObj["id"]+"' id='caseData_"+caseDataObj["id"]+"'/>";
						str+="	<lable>"+actionObj["defaultValue"]+"</label>";
					}
					if(dataMapObj["category"]==2||dataMapObj["category"]==3){
						str+="	<select name='caseData_"+casePageObj["id"]+"' id='caseData_"+caseDataObj["id"]+"'>";
						str+="		<option value=''></option>";
						for(k=0;k<dataMapCollectionList.length;k++){
							var dataMapCollectionObj=dataMapCollectionList[k];
							if(dataMapCollectionObj["value"]==caseDataObj["dataValue"]){
								str+="<option value='"+dataMapCollectionObj["value"]+"' selected='selected' title='"+dataMapCollectionObj["value"]+"'>"+dataMapCollectionObj["name"]+"</option>";
							}else{
								str+="<option value='"+dataMapCollectionObj["value"]+"' title='"+dataMapCollectionObj["value"]+"'>"+dataMapCollectionObj["name"]+"</option>";
							}
						}
						str+="	</select>";
						str+=actionObj["defaultValue"];
					}
					str+="	</div>";
				}else{
					str+="	<div class='left datacontainer'>";
					str+="		<a href='javascript:void(0);' onclick='showAddRefPage("+casePageObj["id"]+","+dataMapObj["refPageId"]+")'>"+actionObj["elementName"]+"</a>";
					str+="	</div>";
				}
			}
			str+="			<div class='clear'></div>";
			if(casePageObj["childCasePageList"].length>0){
				str+=showCasePage(casePageObj["childCasePageList"]);
			}
			str+="		</div>";
			str+="	</div>";
			str+="</div>";
			str+="<div style='cursor: pointer; padding: 3px; text-align: center;'>";
			if(<%=session.getAttribute("userId")%>==casePageObj["userId"]||<%=session.getAttribute("isAdmin")%>==2){
				
				str+="	<span class='glyphicon glyphicon-ok' onclick='updateCaseData("+casePageObj["id"]+")'></span>";
				if(casePageObj["parentId"]==0){
					str+="	<span class='glyphicon glyphicon-plus' onclick='showAddCasePagePanel("+casePageObj["id"]+");'></span>";
				}
				str+="	<span class='glyphicon glyphicon-minus' onclick='deleteCasePage("+casePageObj["id"]+");'></span>";
			}
			str+="</div>";
			i=m;
			
		}
		return str;
	}
	function showAddRefPage(parentId,refPageId){
		$.ajax({
			type : 'POST',
			url : "page/findPageById?id=" + refPageId,
			async : false,
			success : function(data) {
				$("#txtCasePageName").val(data["title"]);
				$("#txtCasePageComment").val(data["comment"]);
				$("#baseCaseModalTitle").text("BaseCae Page添加");
				$("#txtPageId").val(refPageId);
				$("#txtParentId").val(parentId);
				$("#newContainer").hide();
				$("#btnAddRefCasePage").show();
				$("#btnAddCasePage").hide();
				$('#baseCaseModal').modal('show');
			}
		});
		
	}
	function addRefCasePage(){
		$.ajax({
			type : 'POST',
			url : "case/insertCasePage?casePageId="+$("#txtCasePageId").val(),
			data : {
				"casePage.pageId" : $("#txtPageId").val(),
				"casePage.name" : $("#txtCasePageName").val(),
				"casePage.comment" : $("#txtCasePageComment").val(),
				"casePage.parentId" : $("#txtParentId").val(),
				"casePage.baseCaseId" : <%=request.getAttribute("baseCaseId")%>
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
</script>
<style>
lable {
	width: 200px;
}
</style>
<body>
	<div class="maincontent">
		<div class="left"><a href="javascript:void(0)" id="toggle" onclick="togglePageContent(this);">收起</a></div>
		<div class="glyphicon glyphicon-plus right" style="cursor: pointer;line-height:25px;" onclick="showAddCasePagePanel();"></div>
		
		<div class="clear"></div>
		<hr />
		<div class="maincontent">
			<div id="casecontainer">
				
			</div>
		</div>
	</div>
	<div class="modal fade" id="baseCaseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="baseCaseModalTitle">BaseCase Page追加</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" id="txtCasePageId" />
					<input type="hidden" id="txtPageId" />
					<input type="hidden" id="txtParentId" />
					<div id="newContainer">
						<div class='maincontent'>
							<lable>所属项目</lable>
							<s:select id="secProject" list="projectList" listKey="id" listValue="name" headerValue='请选择' headerKey='' onchange="changeParentGroup(this);" cssClass="form-control"/>
						</div>
						<div class='maincontent'>
							<lable>父级组</lable>
							<select id="secParentGroup" onchange="changeGroup(this)" class="form-control"></select>
							
						</div>
						<div class='maincontent'>
							<lable>组</lable>
							<select id="secGroup" onchange="showPageList(this)" class="form-control"></select>
							
						</div>
						<div class='maincontent'>
							<lable>Page</lable>
							<select id="secPage" onchange="changePage(this)" class="form-control"></select>
						</div>
					</div>
					<div class='maincontent'>
						<lable>自定义Case Page名称</lable>
						<input type='text' id="txtCasePageName" class="form-control" />
					</div>
					<div class='maincontent'>
						<lable>描述</lable>
						<input type='text' id="txtCasePageComment" class="form-control" />
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addCasePage();" id="btnAddCasePage">确定</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addRefCasePage();" id="btnAddRefCasePage">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>