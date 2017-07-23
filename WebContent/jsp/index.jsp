<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AutoTestWeb</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/jquery.cookie.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<link href="css/main.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-dialog.css" rel="stylesheet" type="text/css">
<link href="css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">
<script src="js/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="js/dataTables.bootstrap.min.js" type="text/javascript"></script>
<script src="js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="js/common.js" type="text/javascript"></script>
<script src="js/bootstrap-dialog.js" type="text/javascript"></script>
<style>



</style>
<script>
	var index=-1;
	var array=new Array();
	//退出系统.aaaaaaaaafadasfdaaa
	
	function downloadClient(){
		window.location.href="file://192.168.140.151/autoTest/software/Client.rar";
	}
	function logout(){
		$.ajax({
			type : 'POST',
			url : "user/logout",
			async : false,
			success : function(data) {
				if (data > 0) {
					window.location.reload();
				}
			}
		});

	}
	function downloadBrowser(){
		window.location.href="browser.exe";
	}
	function getHeight() {
		if (window.innerHeight != window.undefined)// FF
		{
			return window.innerHeight;
		}
		if (document.compatMode == 'CSS1Compat')// IE
		{
			return document.documentElement.clientHeight;
		}
		if (document.body)// other
		{
			return document.body.clientHeight;
		}
		return window.undefined;
	}
	function reinitIframe() {
		var height=getHeight() - 83 + "px";
		$("#maincontent").height(height);
	}
	window.onload = window.setInterval("reinitIframe()", 100);
	$(function(){
		var u=$.cookie("url");
		var p=$.cookie("pageTitle");
		if(u==undefined){
			index=index+1;
			array[index]={title:"AutoTest",url:"welcome"};
			$.get("welcome", function(data) {
	            $('#maincontent').html(data);
	        });
		}else{
			index=index+1;
			array[index]={title:p,url:u};
			$.get(u, function(data) {
	            $('#maincontent').html(data);
	        });
		}
		if(p!=undefined){
			$("#pageTitle").text(p);
		}
		$(document).on("click",".link",function(){
			index=index+1;
			array[index]={title:$(this).text(),url:$(this).attr("value")};
			$("#pageTitle").text($(this).text());
			$.cookie("pageTitle",$(this).text());
			var url = $(this).attr("value");
			$.cookie("url",url);
            $.get(url, function(data) {
                $('#maincontent').html(data);
            });
		});
	});
	function back(){
		if(index==0){
			alert("已经到最后一步");
			return;
		}
		index=index-1;
		$("#pageTitle").text(array[index].title);
	 	$.get(array[index].url, function(data) {
            $('#maincontent').html(data);
        });
	 	$.cookie("url",array[index].url);
	 	$.cookie("pageTitle",array[index].title);
	}
	function refresh(url){
		$.get(url, function(data) {
            $('#maincontent').html(data);
        });
	}
	function redirect(title,url){
		$("#pageTitle").text(title);
	 	$.get(url, function(data) {
            $('#maincontent').html(data);
        });
	 	$.cookie("url",url);
	 	$.cookie("pageTitle",title);
	}
</script>
</head>
<body>
	<div style="width:100%;">
		<nav class="navbar navbar-default" role="navigation" style="margin-bottom:0;">
			<div class="navbar-header">
		      <span class="navbar-brand" id="pageTitle">AutoTest</span>
		   	</div>
		   	<div class="collapse navbar-collapse" id="example-navbar-collapse" style="width:50%;float:left;">
				<ul class="nav navbar-nav">
				<s:iterator value="menuList" id="menu">
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><s:property value="#menu.name" /><b class="caret"></b></a>
						<ul class="dropdown-menu">
							<s:iterator value="#menu.menuList" id="childMenu">
								<li><a href="javascript:void(0))" value="<s:property value="#childMenu.action" />" class="link"><s:property value="#childMenu.name" /></a></li>
								<li class="divider"></li>
							</s:iterator>
						</ul>
					</li>
				</s:iterator>
				</ul>
				
				
			</div>
			<div style="float:right;width:20%;text-align:right;font-size:12px;margin-top:20px;padding-right:15px;">
				<a class="glyphicon glyphicon-share-alt" style="cursor:pointer;-moz-transform:scaleX(-1);-webkit-transform:scaleX(-1);-o-transform:scaleX(-1);transform:scaleX(-1); /*IE*/filter:FlipH;" onclick="back();"></a>
				<span>欢迎您，${user.name }</span>
				<a href="Client.rar" class='glyphicon glyphicon-save'  style='cursor:pointer;' title="下载客户端"></a>&nbsp;&nbsp;
				<!-- <img src="css/images/browser.jpg" style="width:15px;height:15px;cursor:pointer;" onclick="downloadBrowser();"/>&nbsp;&nbsp; -->
				<a href="XpathCheck.rar"  class='glyphicon glyphicon-save'  style='cursor:pointer;color:gray;' title="下载Xpath校验工具"></a>
				<a href="javascript:void(0);" onclick="logout()">退出</a>
			</div>
			<div class="clear"></div>
		</nav>
		<div id="maincontent" style="overflow-y:scroll;">
		</div>
		<div class="clear"></div>
		<div id="bottom">
			<div id="bottomcontent">cd</div>
		</div>
	</div>
</body>
</html>

