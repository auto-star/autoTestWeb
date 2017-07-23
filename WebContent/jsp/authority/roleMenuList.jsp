<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>组管理</title>
<script>
	$(function(){
		findRoleMenuListByRoleId();
	});
	function findRoleMenuListByRoleId(){
		$.ajax({
			type : 'POST',
			url : "authority/findRoleMenuListByRoleId?roleId="+<%=request.getAttribute("roleId")%>,
			async : false,
			success : function(data) {
				for(i=0;i<data.length;i++){
					$("#chk_"+data[i]["menuId"]).prop("checked",true);
				}
				
			}
		});
	}
	function checkAllChild(obj){
		if ($(obj).is(':checked')) {
			$(".chk_"+$(obj).val()).each(function(){
				$(this).prop("checked",true);
			});
		}else{
			$(".chk_"+$(obj).val()).each(function(){
				$(this).prop("checked",false);
			});
		}
	}
	function checkParent(obj){
		if ($(obj).is(':checked')) {
			$("#"+$(obj).attr("class")).prop("checked",true);
		}
	}
	function insertRoleMenu(){
		var arr = new Array();
		$("input[type='checkbox']").each(function(){
			if ($(this).is(':checked')) {
				arr.push($(this).val());
			}
		})
		$("#txtMenuId").val(arr);
		$.ajax({
			type : 'POST',
			url : "authority/insertRoleMenu?menuId="+$("#txtMenuId").val()+"&roleId="+<%=request.getAttribute("roleId")%>,
			async : false,
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					refresh($.cookie("url"));
				}
			}
		});
	}
</script>
<style>
	.parentMenuContent{
		background:#286090;
		color:white;
		padding-left:10px;
		width:20%;
	}
	.childMenuContainer{
		padding-left:30px;
	}
</style>
</head>
<body>
	<div class="maincontent">
		<div class="maincontent maincontenttop">
			<div class="menuContainer">
				<input type="hidden" id="txtMenuId"/>
				<s:iterator value="menuList" id="menu">
					<div class="parentMenuContaier">
						<div class="parentMenuContent">
							<input type='checkbox' id="chk_<s:property value='#menu.id'/>" onclick="checkAllChild(this)" value="<s:property value='#menu.id'/>" />
							<s:property value="#menu.name" />
						</div>
						<div class="childMenuContainer">
							<s:iterator value="#menu.menuList" id="childMenu">
								<div>
									<input type='checkbox' class="chk_<s:property value='#menu.id'/>" id="chk_<s:property value='#childMenu.id'/>" value="<s:property value='#childMenu.id'/>"  onclick="checkParent(this)"/>
									<s:property value="#childMenu.name" />
								</div>
							</s:iterator>
						</div>
						
					</div>
					
				</s:iterator>
			</div>
			<div style="margin-top:5px;padding-top:10px;border-top:1px solid gray;width:20%;">
				<input type="button" value="保存" onclick="insertRoleMenu()" class="btn btn-primary"/>
			</div>
			
		</div>
		

	</div>
</body>
</html>