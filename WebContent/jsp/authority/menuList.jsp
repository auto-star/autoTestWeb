<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>组管理</title>
<script>
	$(function() {
		findMenuList();
	});
	function findMenuList() {
		 
		 var table =$('#tableMenuList').DataTable(
			{
				"ordering":false,
				"searching":false,
				"ajax" : "authority/findMenuList?",
				"columns" : [
						{
							"data" : "id"
						},
						{
							"data" : "name"
						},
						{
							"data" : "action"
						},
						{
							"data" : "level"
						},
						{
							"data" : "parentMenuId"
						},
						{
							"targets" : -1,//编辑
							"data" : null,
							"defaultContent" : "<span class='glyphicon glyphicon-pencil' onclick='showUpdateMenuPanel(this)' style='cursor:pointer;'>"
									+ "</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class='glyphicon glyphicon-trash'  style='cursor:pointer;' onclick='deleteMenu(this);'></span>"
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
		 $('#tableMenuList thead tr th').each( function () {
		        var title = $(this).text();
		        if(title=="环境名称"){
		        	$(this).html( '<input type="text" placeholder="'+title+'" />' );
		        }
		        
		    });
		 table.columns().every( function () {
		        var that = this;
		 
		        $( 'input', this.header() ).on( 'keyup change', function () {
		            if ( that.search() !== this.value ) {
		                that
		                    .search( this.value )
		                    .draw();
		            }
		        } );
		    } );
	}
	function showAddMenuPanel() {
		$("#btnUpdateMenu").hide();
		$("#btnAddMenu").show();
		$("#menuModalTitle").text("Menu添加");
		$('#menuModal').modal('show');
	}
	function addMenu() {
		$.ajax({
			type : 'POST',
			url : "authority/insertMenu",
			data : {
				"menu.name" : $("#txtMenuName").val(),
				"menu.action" : $("#txtMenuAction").val(),
				"menu.level" : $("#secMenuLevel").val(),
				"menu.parentMenuId" : $("#secParentMenu").val()
			},
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					refresh($.cookie("url"));
				}
			}
		});

	}
	function showUpdateMenuPanel(obj){
		var menuId = $(obj).parent("td").siblings().eq(0).text();
		$.ajax({
			type : 'POST',
			url : "authority/findMenuById?menuId="+menuId,
			async : false,
			success : function(data) {
				$("#btnUpdateMenu").show();
				$("#btnAddMenu").hide();
				$("#txtMenuId").val(menuId);
				$("#txtMenuName").val(data["name"]);
				$("#txtMenuAction").val(data["action"]);
				$("#secMenuLevel").val(data["level"]);
				$("#secParentMenu").val(data["parentMenuId"]);
				$('#menuModal').modal('show');
			}
		});
		
		
	}
	function updateMenu(){
		$.ajax({
			type : 'POST',
			url : "authority/updateMenu",
			data : {
				"menu.name" : $("#txtMenuName").val(),
				"menu.id" : $("#txtMenuId").val(),
				"menu.action" : $("#txtMenuAction").val(),
				"menu.level" : $("#secMenuLevel").val(),
				"menu.parentMenuId" : $("#secParentMenu").val()
				
			},
			success : function(data) {
				if (data > 0) {
					alert("更新成功");
					refresh($.cookie("url"));
				}
			}
		});
	}
	function deleteMenu(obj){
		if(confirm("确定要删除")){
			var menuId = $(obj).parent("td").siblings().eq(0).text();
			$.ajax({
				type : 'POST',
				url : "authority/deleteMenu?menuId="+menuId,
				async : false,
				success : function(data) {
					if (data > 0) {
						alert("删除成功");
						refresh($.cookie("url"));
					}
				},  
				error : function() {   
		          	alert("删除失败,请联系开发人员");  
		          	refresh($.cook("url"));
		      	}  
			});
		}
	}
	
</script>
</head>
<body>
	<div class="maincontent">
		<div class="mainheader">
			<div class="glyphicon glyphicon-plus right add" onclick="showAddMenuPanel();"></div>
			<div class="clear"></div>
		</div>
		<div class="maincontent maincontenttop">
			<table id="tableMenuList" class="table table-striped table-bordered">
				<thead>
					<tr>
						<th>序号</th>
						<th>菜单名称</th>
						<th>动作</th>
						<th>级别</th>
						<th>父菜单</th>
						<th>操作</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th>序号</th>
						<th>菜单名称</th>
						<th>动作</th>
						<th>级别</th>
						<th>父菜单</th>
						<th>操作</th>
					</tr>
				</tfoot>
			</table>
		</div>
		<div class="modal fade" id="menuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title" id="menuModalTitle">Menu编辑</h4>
					</div>
					<div class="modal-body">
						<input type="hidden" id="txtMenuId" />
						<div class='maincontent'>
							<lable>Menu名称</lable>
							<input type='text' id="txtMenuName" />
						</div>
						<div class='maincontent'>
							<lable>动作</lable>
							<input type='text' id="txtMenuAction" />
						</div>
						<div class='maincontent'>
							<lable>级别</lable>
							<select id="secMenuLevel">
								<option value="1">一级菜单</option>
								<option value="2">二级菜单</option>
							</select>
						</div>
						<div class='maincontent'>
							<lable>父菜单</lable>
							<s:select id="secParentMenu" list="parentMenuList" listKey="id" listValue="name" headerValue='请选择' headerKey='-1'/>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addMenu();" id="btnAddMenu">确定</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateMenu();" id="btnUpdateMenu">确定</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>
</html>