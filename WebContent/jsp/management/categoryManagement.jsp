<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件夹管理</title>
<script>
	$(function() {
		findCategoryListByUserId();
	});
	function findCategoryListByUserId() {
		var table = $('#tableCategoryList').DataTable(
			{
				"ordering" : false,
				"ajax" : "manage/findCategoryListByUserId?category.userId="+<%=session.getAttribute("userId")%>,
				"columns" : [
						{
							"data" : "id"
						},
						{
							"data" : "name"
						},
						{
							"targets" : -1,//编辑
							"data" : null,
							"defaultContent" : "<span class='glyphicon glyphicon-pencil' onclick='showUpdateCategoryPanel(this)' style='cursor:pointer;'>"
									+ "</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='glyphicon glyphicon-trash'  style='cursor:pointer;' onclick='deleteCategory(this);'></span>"
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
		$('#tableCategoryList thead tr th')
				.each(
						function() {
							var title = $(this).text();
							if (title == "文件夹名称") {
								$(this)
										.html(
												'<input type="text" placeholder="Search '+title+'" />');
							}

						});
		table.columns().every(function() {
			var that = this;

			$('input', this.header()).on('keyup change', function() {
				if (that.search() !== this.value) {
					that.search(this.value).draw();
				}
			});
		});
	}
	function showAddCategoryPanel() {
		$("#btnUpdateCategory").hide();
		$("#btnAddCategory").show();
		$("#categoryModalTitle").text("文件夹添加");
		$('#categoryModal').modal('show');
	}
	function addCategory() {
		$.ajax({
			type : 'POST',
			url : "manage/insertCategory",
			data : {
				"category.name" : $("#txtCategoryName").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					refresh($.cookie("url"));
					$('#categoryModal').modal('hide');
				}
			}
		});

	}
	function showUpdateCategoryPanel(obj){
		var categoryId = $(obj).parent("td").siblings().eq(0).text();
		$.ajax({
			type : 'POST',
			url : "manage/findCategoryById?categoryId="+categoryId,
			async : false,
			success : function(data) {
				$("#btnUpdateCategory").show();
				$("#btnAddCategory").hide();
				$("#txtCategoryId").val(categoryId);
				$("#txtCategoryName").val(data["name"]);
				$('#categoryModal').modal('show');
			}
		});
		
		
	}
	function updateCategory(){
		$.ajax({
			type : 'POST',
			url : "manage/updateCategory",
			data : {
				"category.name" : $("#txtCategoryName").val(),
				"category.id" : $("#txtCategoryId").val()
				
			},
			success : function(data) {
				if (data > 0) {
					alert("更新成功");
					refresh($.cookie("url"));
					$('#categoryModal').modal('hide');
				}
			}
		});
	}
	function deleteCategory(obj){
		if(confirm("确定要删除")){
			var categoryId = $(obj).parent("td").siblings().eq(0).text();
			$.ajax({
				type : 'POST',
				url : "manage/deleteCategory?categoryId="+categoryId,
				
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
</head>
<body>
	<div class="maincontent">
		<div class="mainheader">
			<div class="glyphicon glyphicon-plus right add" onclick="showAddCategoryPanel();"></div>
			<div class="clear"></div>
		</div>
		<div class="maincontent maincontenttop">
			<table id="tableCategoryList" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>序号</th>
						<th>文件夹名称</th>
						<th>操作</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>序号</th>
						<th>文件夹名称</th>
						<th>操作</th>
					</tr>
				</tfoot>
			</table>
		</div>
		<div class="modal fade" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title" id="categoryModalTitle">文件夹编辑</h4>
					</div>
					<div class="modal-body">
						<input type="hidden" id="txtCategoryId" />
						<div class='maincontent'>
							<lable>文件夹名称</lable>
							<input type='text' id="txtCategoryName" />
						</div>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addCategory();" id="btnAddCategory">确定</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateCategory();" id="btnUpdateCategory">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>
</html>