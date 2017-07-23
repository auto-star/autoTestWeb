<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DataMap管理</title>
</head>
<script>
	$(function() {
		findDataMapListByPageId();
	});
	function findDataMapListByPageId() {
		var table = $('#tableDataMapList').DataTable({
			"order" : [ [ 4, "asc" ] ],
			"stateSave":true,
			"searching":false,
			"ajax" : "page/findDataMapListByPageId?pageId="+<%=request.getAttribute("pageId")%>,
			"columns" : [
					{
						"data" : "id"
					},
					{
						"data" : "code"
					},
					{
						"data" : "elementName"
					},
					{
						"data" : "category"
					},
					{
						"data" : "pageTitle"
					},
					{
						"data" : "sort"
					},
					{
						"targets" : -1,//编辑
						"data" : null,
						"render" : function(data) {
							var str = "";
							if(data.sort>1){
								str += "&nbsp;&nbsp;&nbsp;&nbsp;<a class='glyphicon glyphicon-arrow-up' title='上移' style='cursor:pointer;' onclick='updateDataMapSort(this,1);'></a>";
							}
							str += "&nbsp;&nbsp;&nbsp;&nbsp;<a class='glyphicon glyphicon-arrow-down' title='下移' style='cursor:pointer;' onclick='updateDataMapSort(this,2);'></a>";
							str += "&nbsp;&nbsp;&nbsp;&nbsp;<a title='编辑' style='cursor:pointer;' onclick='showEditPanel(this);'>编辑</a>";
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
		$('#tableDataMapList tfoot tr th').each(function() {
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
	function updateDataMapSort(obj,option){
		
		var dataMapId = $(obj).parent("td").siblings().eq(0).text();
		$.ajax({
			type : 'POST',
			url : "page/updateDataMapSort?dataMapId=" + dataMapId+"&option="+option+ "&pageId=" +<%=request.getAttribute("pageId")%>,
			success : function(data) {
				if (data > 0) {
					alert("更新成功");
					refresh($.cookie("url"));
				}
			}
		});
	}
	function addDataMap() {
		$.ajax({
			type : 'POST',
			url : "page/insertDataMap",
			data : {
				"dataMap.title" : $("#txtDataMapTitle").val(),
				"dataMap.comment" : $("#txtDataMapComment").val(),
				"dataMap.code" : $("#txtDataMapCode").val(),
				"dataMap.groupId" : $("#secGroup").val(),
				"dataMap.customerId" : $("#secCustomer").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					refresh($.cookie("url"));
					$('#dataMapModal').modal('hide');
				}
			}
		});

	}
	function updateDataMapCode() {
		$.ajax({
			type : 'POST',
			url : "page/updateDataMapCode",
			data : {
				"dataMap.id" : $("#txtDataMapId").val(),
				"dataMap.code" : $("#txtDataMapCode").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("修改成功");
					refresh($.cookie("url"));
					$('#dataMapModal').modal('hide');
				}
			}
		});
	}
	function deleteDataMap(obj) {
		if(confirm("确定要删除")){
			$.ajax({
				type : 'POST',
				url : "page/deleteDataMapById?id="+ $(obj).parent("td").siblings().eq(0).text(),
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
	function showAddDataMapPanel() {
		$("#btnUpdateDataMap").hide();
		$("#btnAddDataMap").show();
		$("#dataMapModalTitle").text("页面添加");
		$('#dataMapModal').modal('show');
	}
	function showUpdateDataMapPanel(obj) {
		var dataMapId = $(obj).parent("td").siblings().eq(0).text();
		$("#txtDataMapId").val(dataMapId);
		$.ajax({
			type : 'POST',
			url : "page/findDataMapById?id=" + dataMapId,
			async : false,
			success : function(data) {
				$("#btnAddDataMap").hide();
				$("#btnUpdateDataMap").show();
				$("#txtDataMapTitle").val(data["title"]);
				$("#txtDataMapComment").val(data["comment"]);
				$("#txtDataMapCode").val(data["code"]);
				$("#secCustomer").val(data["customerId"]);
				changeParentGroup($("#secCustomer"));
				$("#secParentGroup").val(data["parentGroupId"]);
				changeGroup($("#secParentGroup"));
				$("#secGroup").val(data["groupId"]);
				$('#dataMapModal').modal('show');
			}
		});

	}
	function redirectToElement(obj) {
		var dataMapId = $(obj).parent("td").siblings().eq(0).text();
		window.location.href = "initAction?dataMapId=" + dataMapId;
	}
	function changeParentGroup(obj) {
		$.ajax({
			type : 'POST',
			url : "page/findGroupList?customerId=" + $(obj).val()
					+ "&parentGroupId=-1",
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
			url : "page/findGroupList?parentGroupId=" + $(obj).val(),
			async : false,
			success : function(data) {
				var obj = data["aaData"];
				$("#secGroup").empty();
				$("#secGroup").append("<option value='0'>请选择</option>")
				for (i = 0; i < obj.length; i++) {
					var object = obj[i];
					$("#secGroup").append("<option value='"+object["id"]+"'>" + object["name"] + "</option>")
				}
			}
		});
	}
	function copyDataMap(obj) {
		var dataMapId = $(obj).parent("td").siblings().eq(0).text();
		$.ajax({
			type : 'POST',
			url : "case/copyDataMap?dataMapId=" + dataMapId,
			async : false,
			success : function(data) {
				if (data > 0) {
					alert("Copy成功");
					refresh($.cookie("url"));
				}
			}
		});
	}
	function showEditPanel(obj){
		debugger;
		var dataMapId = $(obj).parent("td").siblings().eq(0).text();
		var dataMapCode = $(obj).parent("td").siblings().eq(1).text();
		$("#txtDataMapId").val(dataMapId);
		$("#txtDataMapCode").val(dataMapCode);
		$('#dataMapModal').modal('show');
	}
</script>
<body>
	<div class="maincontent">
		<div class="mainheader">
			<div class="left h2">DataMap列表</div>
			<div class="clear"></div>
		</div>
		<div class="maincontent maincontenttop">


			<table id="tableDataMapList" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>序号</th>
						<th>Code</th>
						<th>Element名称</th>
						<th>类型</th>
						<th>页面</th>
						<th>顺序</th>
						<th>操作</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>序号</th>
						<th>Code</th>
						<th>Element名称</th>
						<th>类型</th>
						<th>页面</th>
						<th>顺序</th>
						<th>操作</th>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
	<div class="modal fade" id="dataMapModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="dataMapModalTitle">编辑DataMap</h4>
				</div>
				<div class="modal-body">
					<input type='hidden' id="txtDataMapId" />
					<div class='maincontent'>
						<lable>Code</lable>
						<input type='text' id="txtDataMapCode" />
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateDataMapCode();" id="btnUpdateDataMap">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>