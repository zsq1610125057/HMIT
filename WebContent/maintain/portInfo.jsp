<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<%String path = request.getContextPath(); 
      String basePath = request.getScheme()+"://"+ request.getServerName()+":"+request.getServerPort()+path+"/";%>
<base href="<%=basePath%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<script type="text/javascript">
$(function(){
	var rows = $("#dg").datagrid('getSelections');
	 $('#portDg').datagrid({
		 fitColumns: false,
		 loadMsg: "正在努力为您加载数据", //加载数据时向用户展示的语句
		 columns:[[   
			{field:'selfDevice',title:'本端设备名',width:100},
			{field:'selfSeries',title:'序列号',width:100},
			{field:'selfPort',title:'设备端口',width:100},   
			{field:'nextDevice',title:'对端设备名',width:100,align:'right'},
			{field:'nextSeries',title:'序列号',width:100,align:'right'},
			{field:'nextPort',title:'设备端口',width:100,align:'right'},
			{field:'operate',title:'选择',width:100,		
				formatter:  function(value,row,index) {
				return "<input type='radio' name='portSelected'>";
			}}
      ]]  
		 
		 
	 });
	  $('#portnumber').combobox({   

		      url:'<%=basePath%>getPortNumber?id=' + rows[0].id,

		      valueField:'id',   

		      textField:'id',
		      
		      editable : false,
		      
		      method : 'get',
		      
		      onSelect : function(record) {
		    	  loadPortInfo(record.id,rows[0].id);	    	  
		      }
		  }); 
	  
	  
	  $('#nextDeviceType').combobox({   

		      url:'<%=basePath%>getDeviceType',

 		      valueField:'name',   

 		      textField:'name',
 		      
 		      editable : false,
 		      
 		      method : 'get',
	      
	     	  onSelect : function(record) {
	     		 loadType(record.id,rows[0].id);
	     		 $('#nextportnumber').combobox('clear');
	     		 
	    	  	
	      }

	  });
	  
	 
});
function loadPortInfo(portId,deviceId) {
	 $('#portDg').datagrid({
		 fitColumns: false,
		 loadMsg: "正在努力为您加载数据", //加载数据时向用户展示的语句
		 url : '<%=basePath%>getPortInfo?id=' + deviceId +'&portId=' + portId,
		 columns:[[   
			{field:'sName',title:'本端设备名',width:100},
			{field:'sNo',title:'序列号',width:100},
			{field:'sPort',title:'设备端口',width:100},   
			{field:'nName',title:'对端设备名',width:100,align:'right'},
			{field:'nNo',title:'序列号',width:100,align:'right'},
			{field:'nPort',title:'设备端口',width:100,align:'right'},
			{field:'operate',title:'选择',width:100,		
				formatter:  function(value,row,index) {
				return "<input id='r1' type='radio' name='portSelected' class='easyui-validatebox' value="+row.nName+" checked='true'>";
			}}
      ]]  
		 
		 
	 });
	 
}

function loadType(typeId,selfId) {
	 $('#typeDg').datagrid({
		 fitColumns: false,
		 loadMsg: "正在努力为您加载数据", //加载数据时向用户展示的语句
		 url : '<%=basePath%>getDeviceTypeByPager?pageSize=10&pageNumber=1&typeId=' + typeId + '&selfId=' + selfId,
		 pagination: true, //显示最下端的分页工具栏
		 rownumbers: true, //显示行数 1，2，3，4...,
		 singleSelect:true,
		 pageList: [10, 20, 30],
		 columns:[[   
			{field:'brand',title:'品牌',width:100},
			{field:'modelNo',title:'型号',width:100},
			{field:'seriesNo',title:'序列号',width:100},   
			{field:'operate',title:'选择',width:100,		
				formatter:  function(value,row,index) {
				return "<input id='r2' type='radio' name='typeSelected' class='easyui-validatebox' value="+row.seriesNo+" onclick='javascript:showDiv3("+row.portNumber+")'>";
			}}
      ]]  
 
	 });
	 
		var pager = $("#typeDg").datagrid('getPager');
		pager.pagination({
			pageSize:3,
			beforePageText: '第',//页数文本框前显示的汉字  
			afterPageText: '页    共 {pages} 页',
			displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
			onBeforeRefresh:function(){
				
			},
			onSelectPage:function(pageNumber,pageSize) {
				find(pageNumber,pageSize ,typeId);
			}
			
		});
		
		

}
function next() {
	var port = $('#portnumber').combobox('getValue');
	var isStep1 = $('#step1').css('display');
	var isStep2 = $('#step2').css('display');
	if (port == null || port == "") {
		$.messager.alert("操作提示", "请选择本端口","info");
		return;
	} else {
		if (isStep1 == 'block') {
			$('#step1').hide();
			$('#step2').show();
			$('#pre').show();
			$('#next').hide();
			$('#btnUpdate').show();
			$('#nextDeviceType').combobox('clear');
		}	
	}

// 	if (isStep2 == 'block') {
// 		var r = $("input:radio[name='typeSelected']:checked").val();
// 		if (r == null) {
// 			alert("请选择");
// 		} else {
// 			$('#step2').hide();
// 			$('#step3').show();
			
			
			
// 		}
// 	}
	
}
function pre() {
	var isStep1 = $('#step1').css('display');
	var isStep2 = $('#step2').css('display');
	var isStep3 = $('#step3').css('display');
	if (isStep2 == 'block') {
		$('#step1').show();
		$('#step2').hide();
		$('#pre').hide();
		$('#step3').hide();
		$('#btnUpdate').hide();
		$('#next').show();
	}
// 	if(isStep3 == 'block') {
// 		$('#step2').show();
// 		$('#step3').hide();
// 		$('#next').show();
// 		$('#btnUpdate').hide();
		
// 	}

	
}
function find(pageNumber,pageSize,typeId) {
	$("#typeDg").datagrid('getPager').pagination({pageSize : pageSize, pageNumber : pageNumber});//reset
	$("#typeDg").datagrid("loading"); 
	$.ajax({
		type:"post",
		url: "<%=basePath%>getDeviceTypeByPager?pageSize=" + pageSize + "&pageNumber=" + pageNumber + "&typeId=" + typeId,
		success:function(data) {
		 	$("#typeDg").datagrid('loadData',pageData(data.rows,data.total));//加载数据
		 	$("#typeDg").datagrid("loaded"); 
		}
	});
}
function pageData(list,total){
     var obj=new Object(); 
     obj.total=total; 
     obj.rows=list; 
     return obj; 
 }
 
 function showDiv3(portNum) {
	 $('#nextportnumber').combobox('clear');
	 $('#nextportnumber').combobox('unselect');
	 var r = $("input:radio[name='typeSelected']:checked").val();
	 $('#step3').show();
	 var arr = new Array();
	 for (i = 1 ; i < portNum+1 ; i++) {
		 arr.push({'text':i,'value':i});
	 }
	 $('#nextportnumber').combobox('loadData',arr); 
	 
 }
 
 function updatePortInfo() {
	 
	 if (!validateType()) {
		$.messager.alert("操作提示", "请选择设备类型","info");
	 } else if (!validateRadio()) {
		 $.messager.alert("操作提示", "请选择设备","info");
	 } else if (!validatePort()) {
		 $.messager.alert("操作提示", "请选择端口","info");
	 } else {
		 var rows = $("#dg").datagrid('getSelections');
		 var selfPort = $('#portnumber').combobox('getValue');
		 var nextType = $('#nextDeviceType').combobox('getValue');
		 var r = $("input:radio[name='typeSelected']:checked").val();
		 var ifFree = $("input:radio[name='portSelected']:checked").val();
		 var nextPort = $('#nextportnumber').combobox('getValue');
		 var obj = getData(rows,r,selfPort,nextPort,nextType,ifFree);
		
		 var jsonStr = JSON.stringify(obj);
		 $.messager.defaults = { ok: "确认", cancel: "取消" };  
	     $.messager.confirm("操作提示", "本端：" + rows[0].type + " 端口 " + selfPort + '<br>'+ "对端：  " + nextType + " 端口 " + nextPort, function (data) {  
	            if (data) {  
	                 $.ajax({
	                	url : '<%=basePath%>updatePortInfo?',
	                	type : 'post',
	                	dataType : "json",
	                	data : "jsonData=" + jsonStr, 
	                	success : function(res) {
	                		$.messager.alert("操作提示", res.msg ,"info");	
	                		$('#portInfoWin').window('close');
	                	},
	                	error : function() {
	                		$.messager.alert("操作提示", "服务器出错,请重试" ,"info");	
	                	}
	                	 
	                 })
	                 
	                 
	            }   
	        });
			
	 }
	 
 }
 function validateType() {
	 var typeChoose = $('#nextDeviceType').combobox('getValue');
	 if (typeChoose == null || typeChoose == "") {
		 return false;
	 }
	 return true;
 }
 
 function validateRadio() {
	 var r = $("input:radio[name='typeSelected']:checked").val();
	 if (r == null || r == "") {
		 return false;
	 }
	 return true;
 }
 
 function validatePort() {
	 var portChoose = $('#nextportnumber').combobox('getValue');
	 if (portChoose == null || portChoose == "") {
		 return false;
	 }
	 return true;
 }
 function getData(rows,r,selfPort,nextPort,nextType,ifFree) {
	 var obj=new Object();
	 obj.sName = rows[0].type;
	 obj.sNo = rows[0].seriesNo;
	 obj.sPort = selfPort;
	 obj.nName = nextType;
	 obj.nNo = r;
	 obj.nPort = nextPort;
	 obj.isAvailable = 'N';
	 console.info(ifFree);
	 if (ifFree == "N/A") {
		 obj.isNewOrUpdate = "New";
	 } else {
		 obj.isNewOrUpdate = "Update"; 
	 }
	 
	 return obj;
 }
</script>

<div region="center" border="false"
	style="padding: 10px; background: #fff; border: 1px solid #ccc;">
	<div id="step1">
		<div style="border: solid 1px red;">
			1-> 请选择端口：<input id="portnumber" class="easyui-combobox"
				style="width: 50px;">
		</div>
		<div style="margin-top: 5px;">
			<table id="portDg" class="easyui-datagrid">

			</table>
		</div>
	</div>
	<div id="step2" style="display: none; border: solid 1px red;">
		<div>
			2 -> 请选择对端设备：<input id="nextDeviceType" class="easyui-combobox"
				style="width: 100px;" editable="false" />
		</div>
		<div style="margin-top: 5px;">
			<table id="typeDg" class="easyui-datagrid">

			</table>
		</div>

	</div>

	<div id="step3"
		style="display: none; margin-top: 5px; border: solid 1px red;">

		3 -> 请选择端口号： <input id="nextportnumber" class="easyui-combobox"
			style="width: 50px;" editable="false" />
	</div>
</div>
<div region="south" border="false"
	style="text-align: right; height: 30px; line-height: 30px;">
	<a id="next" class="easyui-linkbutton" href="javascript:void(0);"
		onclick="next()" style="vertical-align: middle;"> 下一步</a> <a id="pre"
		class="easyui-linkbutton" href="javascript:void(0);" onclick="pre()"
		style="display: none; vertical-align: middle;">上一步</a> <a
		id="btnUpdate" class="easyui-linkbutton" icon="icon-ok"
		href="javascript:void(0);" style="display: none"
		onclick="updatePortInfo()"> 保存</a> <a id="cancel"
		class="easyui-linkbutton" icon="icon-cancel"
		href="javascript:void(0);" onclick="closeLogin()">取消</a>
</div>
</html>