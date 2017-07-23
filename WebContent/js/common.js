function loading(){ 
	$("body").append("<div id='loading'></div>")
	$("#loading").addClass("loading");
    $("#loading").append("<img src='css/images/loading.gif' class='loadingimage'/>"); 
}
function removeLoading(){ 
	$("#loading").remove();
} 
function getAllUser(userId){
	$.ajax({
		type : 'POST',
		url : "user/findUserList",
		async : false,
		success : function(data) {
			var userList=data["aaData"];
			$("#secUserList").append("<option value='0'>All</option>");
			for(i=0;i<userList.length;i++){
				var user=userList[i];
				if(userId==user["id"]){
					$("#secUserList").append("<option value='"+user["id"]+"' selected>"+user["name"]+"</option>");
				}else{
					$("#secUserList").append("<option value='"+user["id"]+"'>"+user["name"]+"</option>");
				}
				
			}
			
		}
	});
}
function getAllEnvironment(){
	$.ajax({
		type : 'POST',
		url : "manage/findEnvironmentList",
		async : false,
		success : function(data) {
			var environmentList=data["aaData"];
			$("#secEnvironmentList").append("<option value=''>All</option>");
			for(i=0;i<environmentList.length;i++){
				var environment=environmentList[i];
				$("#secEnvironmentList").append("<option value='"+environment["id"]+"'>"+environment["name"]+"</option>");
				
			}
			
		}
	});
}
function getAllCateogry(obj,userId){
	$.ajax({
		type : 'POST',
		url : "manage/findCategoryListByUserId?category.userId="+userId,
		async : false,
		success : function(data) {
			var categoryList=data["aaData"];
			$(obj).empty();
			$(obj).append("<option value=''>All</option>");
			for(i=0;i<categoryList.length;i++){
				var category=categoryList[i];
				$(obj).append("<option value='"+category["id"]+"'>"+category["name"]+"</option>");
				
			}
			
		}
	});
}
function findList(o,u,d,c){
	$(o).DataTable({
		"processing": true,
		"ordering" :false,
		"destroy":true,
		"searching":false,
		"serverSide":true,
		"lengthMenu": [[10, 20, 50,100, 1000], ["10", "20", "50", "100", "1000"]],
		"ajax" : {
			"type":"post",
			"url":u,
			"data":d,
		},
		"columns" : c,
				"aoColumnDefs" : [ {
					sDefaultContent : '',
					aTargets : [ '_all' ]
				} ],
				"oLanguage" : {
					"sLengthMenu" : "每页显示 _MENU_ 条记录",
					"sZeroRecords" : "抱歉， 没有找到",
					"sInfo" : "从 _START_ 到 _END_ 共 _TOTAL_ 条数据",
					"sInfoEmpty" : "没有数据",
					"sInfoFiltered" : "(从 _MAX_ 条数据中检索)",
					"oPaginate" : {
						"sFirst" : "首页",
						"sPrevious" : "上一页",
						"sNext" : "后一页",
						"sLast" : "尾页"
					}
				}
	});
}
