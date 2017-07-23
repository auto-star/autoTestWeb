<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>元素列表</title>
</head>
<script>
	var jsonAction;
	$(function() {
		$.getJSON("js/action.json",function(data){
			jsonAction=data["action"];
			createActionPanel(jsonAction,1,1);
		});
		findActionListByPageId();
	});
	function createActionPanel(obj,category,commandCategory){
		for(i=0;i<obj.length;i++){
			var object=obj[i];
			if(category==object["actionCategory"]){
				var commandObj=object["command"];
				$("#secCommandCategory").empty();
				$("#secCommandName").empty();
				for(j=0;j<commandObj.length;j++){
					var command=commandObj[j];
					if(commandCategory==command["id"]){
						$("#secCommandCategory").append("<option value='"+command["id"]+"' selected>"+command["name"]+"</option>");
					}else{
						$("#secCommandCategory").append("<option value='"+command["id"]+"'>"+command["name"]+"</option>");
					}
					var commandList=command["commandList"];
					if(commandCategory==command["id"]){
						for(k=0;k<commandList.length;k++){
							var commandDetail=commandList[k];
							$("#secCommandName").append("<option value='"+commandDetail["commandName"]+"'>"+commandDetail["commandText"]+"</option>");
						}
						changeCommandName($("#secCommandName"));
					}
					
					
				}
				
				
			}
		}
	}
	function changeCommandCategory(obj){
		createActionPanel(jsonAction,$("#secActionCategory").val(),$(obj).val());
	}
	
	
	function addAction() {
		var xpath = "";
		var jsonDataMapCollection="";
		if ($("#secActionCategory").val() == 1 || $("#secActionCategory").val() == 4) {
			xpath = $("#txtsinglexpath").val().replace(/'/g, "\"");
		} else if ($("#secActionCategory").val() == 2) {
			xpath = "{";
			jsonDataMapCollection = "{";
			i = 0;
			$("input[name='txtXpathKey']").each(function() {
				i++;
				if (i == $("input[name='txtXpathKey']").length) {
					xpath += "'" + $(this).val() + "':'" + $(this).next().next().val().replace(/'/g, "\"") + "'";
				} else {
					xpath += "'" + $(this).val() + "':'" + $(this).next().next().val().replace(/'/g, "\"") + "',";
				}
				if (i == $("input[name='txtXpathKey']").length) {
					jsonDataMapCollection += "'" + $(this).val() + "':'" + $(this).next().val() + "'";
				} else {
					jsonDataMapCollection += "'" + $(this).val() + "':'" + $(this).next().val() + "',";
				}
			});
			xpath += "}";
			jsonDataMapCollection += "}";
		} else if ($("#secActionCategory").val() == 3) {
			xpath = "{'xpath':'" + $("#txtElementXpath").val().replace(/'/g, "\"") + "','data':{";
			jsonDataMapCollection = "{";
			i = 0;
			$("input[name='txtChoiceKey']").each(function() {
				i++;
				if (i == $("input[name='txtChoiceKey']").length) {
					xpath += "'" + $(this).val() + "':'" + $(this).next().val() + "'";
				} else {
					xpath += "'" + $(this).val() + "':'" + $(this).next().val() + "',";
				}
				if (i == $("input[name='txtChoiceKey']").length) {
					jsonDataMapCollection += "'" + $(this).val() + "':'" + $(this).next().val() + "'";
				} else {
					jsonDataMapCollection += "'" + $(this).val() + "':'" + $(this).next().val() + "',";
				}		
			});
			xpath += "}}";
			jsonDataMapCollection += "}";
		}
		var contextKey = $("#txtContextKey").val();
		var defaultValue = "";
		if ($("#secValueCategory").val() == 1) {
			defaultValue = $("#txtDefaultValue").val();
		} else if ($("#secValueCategory").val() == 2) {
			defaultValue = $("#txtContextValue").val();
		} else {
			if ($("#secDefaultValueCategory").val() == 1) {
				defaultValue = $("#secDefaultValueCategory").val() + "_"
						+ $("#txtDefaultValuePre").val() + "_"
						+ $("#secAutoDate").val();
			} else {
				defaultValue = $("#secDefaultValueCategory").val() + "_"
						+ $("#secDateFormat").val() + "_"
						+ $("#secAutoDate").val();
			}
		}
		var actionId = $("#txtActionId").val();
		$.ajax({
			type : 'POST',
			url : "page/insertAction?actionId=" + actionId,
			data : {
				"action.name" : $("#txtActionName").val(),
				"action.elementName" : $("#txtElementName").val(),
				"action.actionCategory" : $("#secActionCategory").val(),
				"action.elementXpath" : xpath,
				"action.commandCategory" : $("#secCommandCategory").val(),
				"action.commandName" : $("#secCommandCategory  option:selected").text()+ "."+ $("#secCommandName").val(),
				"action.contextKey" : contextKey,
				"action.valueCategory" : $("#secValueCategory").val(),
				"action.defaultValue" : defaultValue,
				"jsonDataMapCollection":jsonDataMapCollection,
				"action.parentActionId":$("#txtParentActionId").val(),
				"action.pageId" :<%=request.getAttribute("pageId")%>
			},
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
					refresh($.cookie("url"));
					$('#actionModal').modal('hide');
				}
			}
		});

	}

	function deleteAction(actionId) {
		if (confirm("确定 要删除")) {
			$.ajax({
				type : 'POST',
				url : "page/deleteAction?actionId=" + actionId,

				async : false,
				success : function(data) {
					if (data > 0) {
						alert("删除成功");
						refresh($.cookie("url"));
					}
					if(data==0){
						alert("删除失败,请先删除子Action")
					}
				},  
				error : function() {   
		          	alert("删除失败,请联系开发人员");  
		          	refresh($.cookie("url"));
		      	}
			});
		}

	}

	function updateAction() {
		var xpath = "";
		var jsonDataMapCollection="";
		if ($("#secActionCategory").val() == 1 || $("#secActionCategory").val() == 4) {
			xpath = $("#txtsinglexpath").val().replace(/'/g, "\"");
		} else if ($("#secActionCategory").val() == 2) {
			xpath = "{";
			jsonDataMapCollection = "{";
			i = 0;
			$("input[name='txtXpathKey']").each(function() {
				i++;
				if (i == $("input[name='txtXpathKey']").length) {
					xpath += "'" + $(this).val() + "':'" + $(this).next().next().val().replace(/'/g, "\"") + "'";
				} else {
					xpath += "'" + $(this).val() + "':'" + $(this).next().next().val().replace(/'/g, "\"") + "',";
				}
				if (i == $("input[name='txtXpathKey']").length) {
					jsonDataMapCollection += "'" + $(this).val() + "':'" + $(this).next().val() + "'";
				} else {
					jsonDataMapCollection += "'" + $(this).val() + "':'" + $(this).next().val() + "',";
				}
			})
			xpath += "}";
			jsonDataMapCollection += "}";
		} else if ($("#secActionCategory").val() == 3) {
			jsonDataMapCollection = "{";
			xpath = "{'xpath':'" + $("#txtElementXpath").val().replace(/'/g, "\"") + "','data':{";
			i = 0;
			$("input[name='txtChoiceKey']").each(function() {
				i++;
				if (i == $("input[name='txtChoiceKey']").length) {
					xpath += "'" + $(this).val() + "':'" + $(this).next().val() + "'";
				} else {
					xpath += "'" + $(this).val() + "':'" + $(this).next().val() + "',";
				}
				if (i == $("input[name='txtChoiceKey']").length) {
					jsonDataMapCollection += "'" + $(this).val() + "':'" + $(this).next().val() + "'";
				} else {
					jsonDataMapCollection += "'" + $(this).val() + "':'" + $(this).next().val() + "',";
				}
			})
			xpath += "}}";
			jsonDataMapCollection += "}";
		}
		var contextKey = $("#txtContextKey").val();
		var defaultValue = "";
		if ($("#secValueCategory").val() == 1) {
			defaultValue = $("#txtDefaultValue").val();
		} else if ($("#secValueCategory").val() == 2) {
			defaultValue = $("#txtContextValue").val();
		} else {
			if ($("#secDefaultValueCategory").val() == 1) {
				defaultValue = $("#secDefaultValueCategory").val() + "_" + $("#txtDefaultValuePre").val() + "_" + $("#secAutoDate").val();
			} else {
				defaultValue = $("#secDefaultValueCategory").val() + "_" + $("#secDateFormat").val() + "_" + $("#secAutoDate").val();
			}
		}
		var actionId = $("#txtActionId").val();
		$.ajax({
			type : 'POST',
			url : "page/updateAction",
			data : {
				"action.id" : $("#txtActionId").val(),
				"action.name" : $("#txtActionName").val(),
				"action.elementName" : $("#txtElementName").val(),
				"action.actionCategory" : $("#secActionCategory").val(),
				"action.elementXpath" : xpath,
				"action.commandCategory" : $("#secCommandCategory").val(),
				"action.commandName" : $("#secCommandCategory  option:selected").text() + "." + $("#secCommandName").val(),
				"action.contextKey" : contextKey,
				"action.valueCategory" : $("#secValueCategory").val(),
				"action.defaultValue" : defaultValue,
				"jsonDataMapCollection":jsonDataMapCollection,
				"action.pageId" :<%=request.getAttribute("pageId")%>
			},
			success : function(data) {
				if (data > 0) {
					alert("更新成功");
					refresh($.cookie("url"));
					$('#actionModal').modal('hide');
				}
			}
		});
	}
	function showAddActionPanel(actionId,parentActionId) {
		$("#txtActionId").val(actionId);
		$("#txtParentActionId").val(parentActionId);
		$("#secActionCategory").show();
		$("#lbActionCategory").hide();
		$("#btnUpdateAction").hide();
		$("#btnAddAction").show();
		$("#actionModalTitle").text("Action添加");
		$('#actionModal').modal('show');
	}
	function showUpdateActionPanel(actionId) {
		$("#txtActionId").val(actionId);
		$("#secActionCategory").hide();
		$("#lbActionCategory").show();
		$.ajax({
			type : 'POST',
			url : "page/findActionById?actionId=" + actionId,
			async : false,
			success : function(data) {
				var obj = data["aaData"];
				createActionPanel(jsonAction,obj[0]["actionCategory"],obj[0]["commandCategory"]);
				$("#txtActionName").val(obj[0]["name"]);
				$("#txtElementName").val(obj[0]["elementName"]);
				$("#secActionCategory").val(obj[0]["actionCategory"]);
				$("#lbActionCategory").text($("#secActionCategory  option:selected").text());
				if(obj[0]["actionCategory"] == 4){
					$("#elementNameContainer").hide();
					$("#notActionContainer").hide();
					$("#contextContainer").hide();
				}else{
					$("#elementNameContainer").show();
					$("#notActionContainer").show();
					$("#contextContainer").show();
				}
				if (obj[0]["actionCategory"] == 1 || obj[0]["actionCategory"] == 4) {
					$("#txtsinglexpath").val(obj[0]["elementXpath"]);
					$("#actionCategory_2").hide();
					$("#actionCategory_1").show();
					$("#actionCategory_3").hide();
				} else if (obj[0]["actionCategory"] == 2) {
					var xpathObj = eval("(" + obj[0]["elementXpath"]+ ")")
					var i = 0;
					$("#actionCategory_2").empty();
					$.each(xpathObj,function(key, value) {
						var str = "<div name='xpathcontainer_2' style='padding:2px 0 0 0'>";
						str += "<lable>xpath KeyAndValue</lable>";
						str += "&nbsp;<input type='text' name='txtXpathKey' style='width:80px;' value='"+key+"'/>";
						str += "&nbsp;<input type='text' name='txtXpathName' style='width:80px;' />";
						str += "&nbsp;<input type='text' name='txtXpath' value='"+value+"' style='width:350px;'/>";
						str += "&nbsp;<span class='glyphicon glyphicon-plus' onclick='addXpathKeyAndValue();' style='cursor:pointer;'></span>";
						if (i != 0) {
							str += "&nbsp;<span class='glyphicon glyphicon-minus' onclick='deleteThis(this);' style='cursor:pointer;'></span>";
						}
						str += "</div>";
						$("#actionCategory_2").append(str);
						i++;
					});
					var dataMapCollectionObj = eval("(" + obj[0]["dataMapCollection"]+ ")");
					$.each(dataMapCollectionObj,function(key, value) {
						$("input[name='txtXpathKey']").each(function() {
							if($(this).val()==key){
								$(this).next().val(value);
							}
						});
					});
					$("#actionCategory_2").show();
					$("#actionCategory_1").hide();
					$("#actionCategory_3").hide();
				} else if (obj[0]["actionCategory"] == 3) {
					var xpathObj = eval("(" + obj[0]["elementXpath"]+ ")")
					$("#txtElementXpath").val(xpathObj["xpath"]);
					var datas = xpathObj["data"];
					$("div[name='choicecontainer']").remove();
					var i = 0;

					$.each(datas,function(key, value) {
						var str = "<div name='choicecontainer' style='padding:2px 0 0 0'>";
						str += "<lable>Choice KeyAndValue</lable>";
						str += "&nbsp;<input type='text' name='txtChoiceKey' style='width:80px;' value='"+key+"' />";
						str += "&nbsp;<input type='text' name='txtChoiceValue' value='"+value+"' />";
						str += "&nbsp;<span class='glyphicon glyphicon-plus' onclick='addChoiceKeyAndValue();' style='cursor:pointer;'></span>";
						if (i != 0) {
							str += "&nbsp;<span class='glyphicon glyphicon-minus' onclick='deleteThis(this);' style='cursor:pointer;'></span>";
						}
						str += "</div>";
						$("#actionCategory_3").append(str);
						i++;
					});
					$("#actionCategory_2").hide();
					$("#actionCategory_1").hide();
					$("#actionCategory_3").show();
				}
				$("#secCommandName option").each(function(){
					if($(this).val()==obj[0]["commandName"].substring(obj[0]["commandName"].indexOf(".")+1)){
						$(this).attr("selected",true);
					}
				})
				changeCommandName($("#secCommandName"));
				$("#txtContextKey").val(obj[0]["contextKey"]);
				$("#secValueCategory").val(obj[0]["valueCategory"]);
				if (obj[0]["valueCategory"] == 1) {
					$("#txtDefaultValue").val(obj[0]["defaultValue"]);
					$("#valueCategory_1").show();
					$("#valueCategory_2").hide();
					$("#valueCategory_3").hide();
				} else if (obj[0]["valueCategory"] == 2) {
					$("#txtContextValue").val(obj[0]["defaultValue"]);
					$("#valueCategory_2").show();
					$("#valueCategory_1").hide();
					$("#valueCategory_3").hide();
				} else if (obj[0]["valueCategory"] == 3) {
					var arr = obj[0]["defaultValue"].split("_");
					$("#secDefaultValueCategory").val(arr[0]);
					$("#secAutoDate").val(arr[2]);
					if (arr[0] == 1) {
						$("#txtDefaultValuePre").val(arr[1]);
						$("#defaultValueCategory_1").show();
						$("#defaultValueCategory_2").hide();
					} else if (arr[0] == 2) {
						$("#secDateFormat").val(arr[1]);
						$("#defaultValueCategory_2").show();
						$("#defaultValueCategory_1").hide();
					}
					$("#valueCategory_3").show();
					$("#valueCategory_1").hide();
					$("#valueCategory_2").hide();
				}
				$("#btnUpdateAction").show();
				$("#btnAddAction").hide();
				$("#actionModalTitle").text("页面元素编辑");
				$('#actionModal').modal('show');
			}
		});

	}
	function changeActionCategory(obj) {
		createActionPanel(jsonAction,$(obj).val(),1);
		if ($(obj).val() == 4) {
			$("#actionCategory_1").show();
			$("#actionCategory_2").hide();
			$("#actionCategory_3").hide();
			$("#elementNameContainer").hide();
			$("#notActionContainer").hide();
			$("#contextContainer").hide();
			changeCommandName($("#secCommandName"));
		} else {
			$("#elementNameContainer").show();
			$("#notActionContainer").show();
			$("#contextContainer").show();
			for (i = 1; i <= 4; i++) {
				if (i == $(obj).val()) {
					$("#actionCategory_" + i).show();
				} else {
					$("#actionCategory_" + i).hide();
				}
			}
		}

	}
	function showValueContainer(obj) {
		for (i = 1; i <= 3; i++) {
			if (i == $(obj).val()) {
				$("#valueCategory_" + i).show();
			} else {
				$("#valueCategory_" + i).hide();
			}
		}
	}
	function changeDefaultValueCategory(obj) {
		for (i = 1; i <= 2; i++) {
			if (i == $(obj).val()) {
				$("#defaultValueCategory_" + i).show();
			} else {
				$("#defaultValueCategory_" + i).hide();
			}
		}
	}
	function addXpathKeyAndValue() {
		var str = "<div name='xpathcontainer_2' style='padding:2px 0 0 0'>";
		str += "<lable>xpath KeyAndValue</lable>";
		str += "&nbsp;<input type='text' name='txtXpathKey' style='width:80px;' />";
		str += "&nbsp;<input type='text' name='txtXpathName' style='width:80px;' />";
		str += "&nbsp;<input type='text' name='txtXpath'  style='width:350px;'/>";
		str += "&nbsp;<span class='glyphicon glyphicon-plus' onclick='addXpathKeyAndValue();' style='cursor:pointer;'></span>";
		str += "&nbsp;<span class='glyphicon glyphicon-minus' onclick='deleteThis(this);' style='cursor:pointer;'></span>";
		str += "</div>";
		$("#actionCategory_2").append(str);
	}
	function deleteThis(obj) {
		$(obj).parent("div").remove();
	}
	function addChoiceKeyAndValue() {
		var str = "<div name='choicecontainer' style='padding:2px 0 0 0'>";
		str += "<lable>Choice KeyAndValue</lable>";
		str += "&nbsp;<input type='text' name='txtChoiceKey' style='width:80px;' />";
		str += "&nbsp;<input type='text' name='txtChoiceValue' />";
		str += "&nbsp;<span class='glyphicon glyphicon-plus' onclick='addChoiceKeyAndValue();' style='cursor:pointer;'></span>";
		str += "&nbsp;<span class='glyphicon glyphicon-minus' onclick='deleteThis(this);' style='cursor:pointer;'></span>";
		str += "</div>";
		$("#actionCategory_3").append(str);
	}
	function deleteCheckAction() {
		if (confirm("确定要删除")) {
			var arr = new Array();
			$(".chkAction").each(function() {
				if ($(this).is(':checked')) {
					arr.push($(this).val());
				}
			});
			$.ajax({
				type : 'POST',
				url : "page/deleteCheckAction",
				data : {
					"actionIdArr[]" : arr
				},
				async : false,
				success : function(data) {
					if (data > 0) {
						alert("删除成功");
						refresh($.cookie("url"));
					}
				}
			});
		}

	}
	function showContextPanel(option) {
		$("#txtContextOption").val(option);
		var url = "page/findContextList";
		var table = $('#tableContextList').DataTable({
				"destroy": true,
				"ajax" : url,
				"columns" : [
						{
							"data" : "id"
						},
						{
							"targets" : -1,//编辑
							"data" : null,
							"render" : function(data) {
								var str = "<input type='radio' id='rad_"+data.id+"' value='"+data.id+"' name='chkContextKey' class='chkContextKey'/>";
								return str;
							}
						},
						{
							"data" : "name"
						},
						{
							"data" : "contextKey"
						}],
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
		$('#tableContextList tfoot tr th').each(function() {
			var title = $(this).text();
			if (title != "操作" && title != "序号"&& title != "") {
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
		$("#tableContextList").css("width","100%");
		$('#contextListModal').modal('show');
	}
	function showAddContextPanel(){
		$('#contextModal').modal('show');
	}
	function addContext(){
		$.ajax({
			type : 'POST',
			url : "page/insertContext",
			data : {
				"context.name" : $("#txtContextName").val(),
				"context.contextKey" : $("#txtContextKey2").val(),
				"context.pageId" : <%=request.getAttribute("pageId")%>
			},
			async : false,
			success : function(data) {
				if (data > 0) {
					alert("添加成功");
				}
			}
		});
	}
	function confirmContextKey(){
		$(".chkContextKey").each(function(){
			if($(this).is(':checked')){
				if($("#txtContextOption").val()==1){
					$("#txtContextKey").val($(this).parent("td").siblings().eq(2).text());
				}else if($("#txtContextOption").val()==2){
					$("#txtContextValue").val($(this).parent("td").siblings().eq(2).text());
				}else{
					$("#txtsinglexpath").val($("#txtsinglexpath").val()+"\\${context."+$(this).parent("td").siblings().eq(2).text()+"}");
				}
				
			}
		})
	}
	
	function findActionListByPageId(obj) {
		$.ajax({
			type : 'POST',
			url : "page/findActionList?action.pageId="+<%=request.getAttribute("pageId")%>,
			async : false,
			success : function(data) {
				var str="";
				for (i = 0; i < data.length; i++) {
					var action = data[i];
					
					str += "<div class='actionContainer'>";
					str += "<div class='actionHeader'>" + action["name"]+"-"+action["id"]+"</div>";
					str += "<div class='actionContentContainer'>";
					str += "<div class='left borderbottom'><lable>Action类型</lable><span>" + action["actionCategoryName"] + "</span></div>";
					str += "<div class='left borderbottom'><lable>Command类型</lable><span>" + action["commandCategoryName"] + "</span></div>";
					str += "<div class='left borderbottom'><lable>Command</lable><span>" + action["commandName"] + "</span></div>";
					str += "<div class='left borderbottom'><lable>Element名称</lable><span>" + action["elementName"] + "</span></div>";
					str += "<div class='left borderbottom'><lable>Xpath</lable><span>" + action["elementXpath"] + "</span></div>";
					str += "<div class='left borderbottom'><lable>内存Key</lable><span>" + action["contextKey"] + "</span></div>";
					str += "<div class='left borderbottom'><lable>值类型</lable><span>" + action["valueCategoryName"] + "</span></div>";
					str += "<div class='left borderbottom'><lable>默认值</lable><span>" + action["defaultValue"] + "</span></div>";
					str += "<div class='left'><lable>排序</lable><span>" + action["sort"] + "</span></div>";
					str += "<div class='clear'></div>";
					if(action["commandCategory"]=="2"&&action["commandName"]!="logical.refPage"){
						str += "<div class='actionOperation' style='text-align:center;line-height:25px;border-top:1px solid gray;'>";
						str += "&nbsp;<span class='glyphicon glyphicon-plus' style='cursor:pointer;' onclick='showAddActionPanel(0,"+action["id"]+");'></span>&nbsp;</div>";
					}
					str += "</div>";
					var childActionList = action["childActionList"];
					if (childActionList != undefined && childActionList.length > 0) {
						
						str+=showChildActionList(childActionList,action["id"])
					}
					str += "</div>";
					str += "<div class='actionOperation' style='text-align:center;line-height:25px;'><span class='glyphicon glyphicon-pencil' onclick='showUpdateActionPanel("+action["id"]+")' style='cursor:pointer;'></span>&nbsp;&nbsp;"
					str += "<span class='glyphicon glyphicon-trash' style='cursor:pointer;' onclick='deleteAction("+action["id"]+");'></span>&nbsp;&nbsp;";
					str += "<span class='glyphicon glyphicon-plus' style='cursor:pointer;' onclick='showAddActionPanel("+action["id"]+",0);'></span></div>";
				}

				$("#actionList").append(str);
			}
		});
	}
	function showChildActionList(childActionList,parentActionId){
		var str="";
		var i=0;
		for (j = 0; j < childActionList.length; j++) {
			i=j;
			var childAction = childActionList[j];
			str += "<div style='margin:0px 20px ' class='actionContainer'>";
			str += "<div class='actionHeader'>" + childAction["name"] + "</div>";
			str += "<div class='actionContentContainer'>";
			str += "<div class='left borderbottom'><lable>Action类型</lable><span>" + childAction["actionCategoryName"] + "</span></div>";
			str += "<div class='left borderbottom'><lable>Command类型</lable><span>" + childAction["commandCategoryName"] + "</span></div>";
			str += "<div class='left borderbottom'><lable>Command</lable><span>" + childAction["commandName"] + "</span></div>";
			str += "<div class='left borderbottom'><lable>Element名称</lable><span>" + childAction["elementName"] + "</span></div>";
			str += "<div class='left borderbottom'><lable>Xpath</lable><span>" + childAction["elementXpath"] + "</span></div>";
			str += "<div class='left borderbottom'><lable>内存Key</lable><span>" + childAction["contextKey"] + "</span></div>";
			str += "<div class='left borderbottom'><lable>值类型</lable><span>" + childAction["valueCategoryName"] + "</span></div>";
			str += "<div class='left borderbottom'><lable>默认值</lable><span>" + childAction["defaultValue"] + "</span></div>";
			str += "<div class='left'><lable>排序</lable><span>" + childAction["sort"] + "</span></div>";
			str += "<div class='clear'></div>";
			if(childAction["commandCategory"]=="2"&&childAction["commandName"]!="logical.refPage"){
				str += "<div class='actionOperation' style='text-align:center;line-height:25px;border-top:1px solid gray;'>";
				str += "&nbsp;<span class='glyphicon glyphicon-plus' style='cursor:pointer;' onclick='showAddActionPanel(0,"+childAction["id"]+");'></span>&nbsp;</div>";
			}
			str += "</div>";
			var list = childAction["childActionList"];
			
			if (list != undefined && list.length > 0) {
				str+=showChildActionList(list,childAction["id"]);
			}
			str += "</div>";
			str += "<div class='actionOperation' style='text-align:center;line-height:25px;'><span class='glyphicon glyphicon-pencil' onclick='showUpdateActionPanel("+childAction["id"]+")' style='cursor:pointer;'></span>&nbsp;&nbsp;"
			str += "<span class='glyphicon glyphicon-trash' style='cursor:pointer;' onclick='deleteAction("+childAction["id"]+");'></span>&nbsp;&nbsp;";
			str += "<span class='glyphicon glyphicon-plus' style='cursor:pointer;' onclick='showAddActionPanel("+childAction["id"]+","+parentActionId+");'></span></div>";
			j=i;
		}
		
		return str;
	}
	function togglePageContent(obj)
	{
		if($(obj).text()=="收起"){
			$(obj).text("展开")
			$(".actionContentContainer").each(function(){
				$(this).hide();
			});
			$(".actionOperation").each(function(){
				$(this).hide();
			})
		}
		else{
			$(obj).text("收起")
			$(".actionContentContainer").each(function(){
				$(this).show();
			});
			$(".actionOperation").each(function(){
				$(this).show();
			})
		}
	}
	function changeCommandName(obj){
		if($("#secActionCategory").val()==4){
			if($(obj).val()=="refPage"){
				$("#elementNameContainer").show();
				$("#commonNameContainer").text("页面Id");
			}else{
				$("#elementNameContainer").hide();
			}
			if($(obj).val()=="singleIf"){
				$("#commonNameContainer").text("逻辑表达式");
				$("#dataAndContextContainer").show();
			}else{
				$("#dataAndContextContainer").hide();
			}
			if($(obj).val()=="setContext"||$(obj).val()=="getTextOrValue"||$(obj).val()=="click"){
				$("#contextContainer").show();
				
				if($(obj).val()=="click"){
					$("#commonNameContainer").text("动态Or静态Xpath");
				}
				
				if($(obj).val()=="setContext"){
					$("#commonNameContainer").text("表达式或静态值");
					$("#dataAndContextContainer").show();
				}else{
					$("#dataAndContextContainer").hide();
				}
				
			}else{
				$("#contextContainer").hide();
			}
			
			if($(obj).val()=="wait"){
				$("#commonNameContainer").text("时间（s）");
			}
			if($(obj).val()=="getTextOrValue"||$(obj).val()=="onMouseOver"||$(obj).val()=="waitDisplay"){
				$("#commonNameContainer").text("Element Xpath");
			}
			if($(obj).val()=="switchTitle"||$(obj).val()=="switchTab"){
				$("#commonNameContainer").text("cd页面Title");
			}
		}else{
			$("#commonNameContainer").text("Element Xpath");
			$("#dataAndContextContainer").hide();
		}
		
	}
	function clearContext(){
		$("#txtContextKey").val("");
	}
	function showDataMapPanel(){
		var table = $('#tableDataMapList').DataTable({
			"destroy": true,
			"ajax" : "page/findDataMapListByPageId?pageId="+<%=request.getAttribute("pageId")%>,
			"columns" : [
					{
						"data" : "id"
					},
					{
						"targets" : -1,//编辑
						"data" : null,
						"render" : function(data) {
							var str = "<input type='radio' id='rad_"+data.id+"' value='"+data.id+"' name='chkDataMap' class='chkDataMap'/>";
							return str;
						}
					},
					{
						"data" : "elementName"
					}],
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
		$("#tableDataMapList").css("width","100%");
		$('#dataMapListModal').modal('show');
	}
	function confirmDataMap(){
		$(".chkDataMap").each(function(){
			if($(this).is(':checked')){
				$("#txtsinglexpath").val($("#txtsinglexpath").val()+"\\${data."+$(this).parent("td").prev("td").text()+"}");
			}
		})
	}
</script>
<style>
.modal-dialog {
	width: 900px;
}

lable {
	width: 200px;
}
.actionHeader{
	background:#286090;
	line-height:30px;
	border:gray;
	color:white;
	text-align:center;
}
.actionContainer{
	border:1px solid gray;
}
.actionContentContainer{
}
.left{
	float:left;
	width:50%;
	line-height:25px;
}
.left lable{
	background:#eeeeee;
	padding-left:10px;
	margin-right:5px;
}
.left span{
	background:#ffffff;
}
.borderbottom{
	border-bottom:1px solid gray;
}
</style>
<body>
<div class="maincontent">
	<div class="left"><a href="javascript:void(0)" id="toggle" onclick="togglePageContent(this);">收起</a></div>
	<div class="glyphicon glyphicon-plus right" onclick="showAddActionPanel(0,0);" style="cursor:pointer;"></div>
	<div class="clear"></div>
	<hr/>
	<div class="maincontent">
		<div id="actionList">
		
		</div>
	</div>

	<div class="modal fade" id="actionModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="actionModalTitle">Action编辑</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" id="txtActionId" />
					<input type="hidden" id="txtParentActionId" />
					<div class='maincontent'>
						<lable>Action名称</lable>
						<input type='text' id="txtActionName" class="form-control" />
					</div>
					<div class='maincontent'>
						<lable>Action类型</lable>
						<select id="secActionCategory" onchange="changeActionCategory(this)" class="form-control" >
							<option value="1">输入型</option>
							<option value="2">多选操作型</option>
							<option value="3">选择型</option>
							<option value="4">动作型</option>
						</select>
						<lable id="lbActionCategory"></lable>
					</div>
					<div class='maincontent'>
						<lable>命令类型</lable>
						<select id="secCommandCategory"
							onchange="changeCommandCategory(this)" class="form-control" >
							<option value="1">html</option>
							<option value="2">logical</option>
						</select>
					</div>
					<div class='maincontent'>
						<lable>可执行命令</lable>
						<select id="secCommandName" onchange="changeCommandName(this)" class="form-control" >
						</select>
					</div>
					<div class='maincontent' id="elementNameContainer">
						<lable>Element名称</lable>
						<input type='text' id="txtElementName"  class="form-control" />
					</div>


					<div class='maincontent'>

						<div id="actionCategory_1">
							<lable id="commonNameContainer">Element xpath</lable>
							<input type="text" id="txtsinglexpath" style="width: 350px;"  class="form-control" />
							<span id="dataAndContextContainer" style="display:none;">
								<a href="javascript:void(0);" onclick="showDataMapPanel();">data</a>&nbsp;&nbsp;
								<a href="javascript:void(0);" onclick="showContextPanel(3);">context</a>
							</span>
						</div>
						<div id="actionCategory_2" style="display: none;">
							<div name="xpathcontainer">
								<lable>Element xpath KeyAndValue</lable>
								<input type="text" name="txtXpathKey" style="width: 80px;"  class="form-control" /> <input
									type="text" name="txtXpathName" style="width: 80px;"  class="form-control" /> <input
									type="text" name="txtXpath" style='width: 350px;'  class="form-control" /> <span
									class="glyphicon glyphicon-plus"
									onclick="addXpathKeyAndValue();" style="cursor: pointer;"></span>
							</div>
						</div>
						<div id="actionCategory_3" style="display: none;">
							<lable>xpath</lable>
							<input type="text" id="txtElementXpath" style="width: 350px;" class="form-control"  />
							<div name="choicecontainer" style='padding: 2px 0 0 0'>
								<lable>Choice KeyAndValue</lable>
								<input type="text" name="txtChoiceKey" style="width: 80px;"  class="form-control" />
								<input type="text" name="txtChoiceValue"  class="form-control" /> <span
									class="glyphicon glyphicon-plus"
									onclick="addChoiceKeyAndValue();" style="cursor: pointer;"></span>
							</div>
						</div>
					</div>

					<div class='maincontent' id="contextContainer">
						<lable>内存Key</lable>
						<input type="text" id="txtContextKey" readonly="true"  class="form-control" /> 
						<a href="javascript:void(0)" onclick="showContextPanel(1)">选择</a>&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="showAddContextPanel()">添加</a>&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="clearContext();">清空</a>
					</div>
					<div id="notActionContainer">
						<div class='maincontent' id="valueCategoryContainer">
							<lable>值类型</lable>
							<select id="secValueCategory" onchange="showValueContainer(this)" class="form-control" >
								<option value="1">静态值</option>
								<option value="2">内存值</option>
								<option value="3">动态生成值</option>
							</select>
						</div>
						<div class='maincontent' id="defaultValueContainer">
	
							<div id="valueCategory_1">
								<lable>默认值</lable>
								<input type="text" id="txtDefaultValue"  class="form-control" />
							</div>
							<div id="valueCategory_2" style="display: none;">
								<lable>默认值</lable>
								<input type="text" id="txtContextValue"  class="form-control" /><a
									href="javascript:void(0)" onclick="showContextPanel(2)">选择</a>
							</div>
							<div id="valueCategory_3" style="display: none;">
								<lable>默认值</lable>
								<select id="secDefaultValueCategory"
									onchange="changeDefaultValueCategory(this)" class="form-control"  style="width:150px;" >
									<option value="1">动态字符串</option>
									<option value="2">动态日期</option>
								</select> <span id="defaultValueCategory_1"> <input type="text"
									id="txtDefaultValuePre" style="width: 180px;"  class="form-control" />
								</span> <span id="defaultValueCategory_2" style="display: none;">
									<select id="secDateFormat" class="form-control"  style="width:200px;" >
										<option value="1">yyyy-MM-dd</option>
										<option value="2">yyyy-MM-dd HH:mm</option>
										<option value="3">yyyy-MM-dd-HH-mm-ss</option>
								</select>
								</span> <select id="secAutoDate" class="form-control" style="width:80px;" >
									<option value="0">+0</option>
									<option value="1">+1</option>
									<option value="2">+2</option>
									<option value="3">+3</option>
									<option value="4">+4</option>
									<option value="5">+5</option>
									<option value="10">+10</option>
									<option value="15">+15</option>
									<option value="20">+20</option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addAction();" id="btnAddAction">确定</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updateAction();" id="btnUpdateAction">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="contextListModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="contextListModalTitle">选择内存Key</h4>
				</div>
				<div class="modal-body">
					<div class='maincontent'>
						<input type="hidden" id="txtContextOption" />
						<table id="tableContextList"
							class="table table-striped table-bordered">
							<thead>
								<tr>
									<th>序号</th>
									<th></th>
									<th>名称</th>
									<th>Key</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<th>序号</th>
									<th></th>
									<th>名称</th>
									<th>Key</th>
								</tr>
							</tfoot>
						</table>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="confirmContextKey();" id="btnAddContext">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="dataMapListModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="dataMapListModalTitle">选择内存Key</h4>
				</div>
				<div class="modal-body">
					<div class='maincontent'>
						<input type="hidden" id="txtDataMapOption" />
						<table id="tableDataMapList" class="table table-striped table-bordered">
							<thead>
								<tr>
									<th>序号</th>
									<th></th>
									<th>Element名称</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<th>序号</th>
									<th></th>
									<th>Element名称</th>
								</tr>
							</tfoot>
						</table>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="confirmDataMap();" id="btnAddDataMap">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="contextModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="contextModalTitle">添加内存Key</h4>
				</div>
				<div class="modal-body">
					<div class='maincontent'>
						<lable>内存名称</lable>
						<input type='text' id="txtContextName" />
					</div>
					<div class='maincontent'>
						<lable>内存Key</lable>
						<input type='text' id="txtContextKey2" />
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addContext();" id="btnAddContext">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>