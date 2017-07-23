<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=11">
<title>Login</title>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="css/main.css" rel="stylesheet" type="text/css">
<script>
</script>
</head>
<body>
	<div id="loginbox">
		<s:actionmessage />
		<s:fielderror></s:fielderror>
		<div style="text-align:center;"><h2>自动化</h2></div>
	
		<form action="loginAction" method="post">
			<div class="maincontent">
				<lable>USERNAME:</lable>
				<input type="text" name="userName" class="form-control">
			</div>
			<div class="maincontent">
				<lable>PASSWORD:</lable>
				<input type="password" name="password" class="form-control">
			</div>
			<div class="center maincontent">
				<input type="submit"  value="LOGIN" class="btn btn-primary">
			<div>
		</form>
	</div>
</body>
</html>