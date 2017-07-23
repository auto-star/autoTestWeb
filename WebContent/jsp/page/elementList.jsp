<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Element管理</title>
</head>
<script>
	
	$(function() {
		findElementListByPageId();
	});
	function findElementListByPageId() {
		var obj=$('#tableElementList');
		var url="page/findElementListByPageId";
		var data={
				"element.pageId":<%=request.getAttribute("pageId")%>
		};
		var columns=[
						{
							"data" : "id"
						},
						{
							"data" : "name"
						},
						{
							"data" : "xpath"
						},
						{
							"data" : "contextKey"
						},
						{
							"targets" : -1,//编辑
							"data" : null,
							"render" : function(data) {
								var str = "";
								if(data.isCompare==0){
									str="否";
								}else if(data.isCompare==1){
									str="是";
								}else{
									str="无法确定";
								}
								return str;
							}
						},
						{
							"targets" : -1,//编辑
							"data" : null,
							"render" : function(data) {
								var str = "";
								str += "&nbsp;&nbsp;&nbsp;&nbsp;<a title='编辑' style='cursor:pointer;' onclick='showUpdateElementPanel(this);'>编辑</a>";
								str += "&nbsp;&nbsp;&nbsp;&nbsp;<a title='删除' style='cursor:pointer;' onclick='deleteElement(this);'>删除</a>";
								return str;
							}
		} ];
		
		findList(obj,url,data,columns);
		
	}
	function updateElementSort(obj,option){
		
		var elementId = $(obj).parent("td").siblings().eq(0).text();
		$.ajax({
			type : 'POST',
			url : "page/updateElementSort?elementId=" + elementId+"&option="+option+ "&pageId=" +<%=request.getAttribute("pageId")%>,
			success : function(data) {
				if (data > 0) {
					alert("更新成功");
					refresh($.cookie("url"));
				}
			}
		});
	}
	function addElement() {
		$.ajax({
			type : 'POST',
			url : "page/insertElement",
			data : {
				"element.name" : $("#txtName").val(),
				"element.xpath" : $("#txtXpath").val(),
				"element.pageId" : <%=request.getAttribute("pageId")%>,
				"element.isCompare" : $("#secIsCompare").val(),
				"element.contextKey" : $("#txtContextKey").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					findElementListByPageId();
				}
			}
		});

	}
	function updateElement() {
		$.ajax({
			type : 'POST',
			url : "page/updateElement",
			data : {
				"element.id" : $("#txtElementId").val(),
				"element.name" : $("#txtName").val(),
				"element.xpath" : $("#txtXpath").val(),
				"element.isCompare" : $("#secIsCompare").val(),
				"element.contextKey" : $("#txtContextKey").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("修改成功");
					findElementListByPageId();
				}
			}
		});
	}
	function deleteElement(obj) {
		if(confirm("确定要删除")){
			$.ajax({
				type : 'POST',
				url : "page/deleteElement?id="+ $(obj).parent("td").siblings().eq(0).text(),
				async : false,
				success : function(data) {
					if (data > 0) {
						alert("删除成功");
						findElementListByPageId();
					}
				},  
				error : function() {   
		          	alert("删除失败,请联系开发人员");  
		          	findElementListByPageId();
		      	}  
			});
		}
	}
	function showAddElementPanel() {
		$("#btnUpdateElement").hide();
		$("#btnAddElement").show();
		$("#elementModalTitle").text("元素添加");
		$('#elementModal').modal('show');
	}
	function showUpdateElementPanel(obj) {
		var elementId = $(obj).parent("td").siblings().eq(0).text();
		$("#txtElementId").val(elementId);
		$.ajax({
			type : 'POST',
			url : "page/findElementById?id=" + elementId,
			async : false,
			dataType: "json",
			success : function(data) {
				$("#btnAddElement").hide();
				$("#btnUpdateElement").show();
				$("#txtName").val(data["name"]);
				$("#txtXpath").val(data["xpath"]);
				$("#secIsCompare").val(data["isCompare"]);
				$("#txtContextKey").val(data["contextKey"])
				$('#elementModal').modal('show');
			}
		});

	}
	
	
	
</script>
<body>
	<div class="maincontent">
		<div class="maincontent" style="text-align:center;">
			<input type="button" value="新增页面元素" onclick="showAddElementPanel()" class="btn btn-primary"/>
		</div>
		<hr/>
		<div class="maincontent">


			<table id="tableElementList"
				class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>序号</th>
						<th>名称</th>
						<th>xpath</th>
						<th>内存Key</th>
						<th>是否比较</th>
						<th>操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<div class="modal fade" id="elementModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="elementModalTitle">编辑Element</h4>
				</div>
				<div class="modal-body">
					<input type='hidden' id="txtElementId" />
					<div class='maincontent'>
						<label>Name</label>
						<input type='text' id="txtName" class="form-control" />
					</div>
					<div class='maincontent'>
						<label>Xpath</label>
						<input type='text' id="txtXpath" class="form-control" />
					</div>
					<div class='maincontent'>
						<label>是否比较</label>
						<select id="secIsCompare" class="form-control">
							<option value="0">否</option>
							<option value="1">是</option>
						</select>
					</div>
					<div class='maincontent'>
						<label>内存Key</label>
						<input type='text' id="txtContextKey" class="form-control" />
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateElement();" id="btnUpdateElement">确定</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addElement();" id="btnAddElement">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>