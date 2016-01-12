<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%String path = request.getContextPath(); 
      String basePath = request.getScheme()+"://"+ request.getServerName()+":"+request.getServerPort()+path+"/";%>
<base href="<%=basePath%>">
<head>
<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="themes/icon.css">
<link rel="stylesheet" type="text/css" href="themes/demo.css">
<script type="text/javascript" src="jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
<script type="text/javascript">
var editFlag = undefined;

$(function (){
	$("#dg").datagrid({
	url: "<%=basePath%>getDeviceByPager?pageSize=10&pageNumber=1", //指向一个一般处理程序或者一个控制器，返回数据要求是Json格式，直接赋值Json格式数据也可，我以demo中自带的Json数据为例，就不写后台代码了，但是我会说下后台返回的注意事项
	iconCls: "icon-add",
	fitColumns: false, //设置为true将自动使列适应表格宽度以防止出现水平滚动,false则自动匹配大小
	//toolbar设置表格顶部的工具栏，以数组形式设置
	striped : true,
	idField: 'id', //标识列，一般设为id，可能会区分大小写，大家注意一下
	loadMsg: "正在努力为您加载数据", //加载数据时向用户展示的语句
	pagination: true, //显示最下端的分页工具栏
	rownumbers: true, //显示行数 1，2，3，4...
	singleSelect:true,
	//pageSize: 10, //读取分页条数，即向后台读取数据时传过去的值
	//pageList: [10, 20, 30], //可以调整每页显示的数据，即调整pageSize每次向后台请求数据时的数据
	//由于datagrid的属性过多，我就不每个都介绍了，如有需要，可以看它的API
	sortName: "name", //初始化表格时依据的排序 字段 必须和数据库中的字段名称相同
	sortOrder: "asc", //正序
	columns: [[
	{
	field: 'brand', title: '品牌', width: 50,
	editor: {//设置其为可编辑
	type: 'validatebox',//设置编辑样式 自带样式有：text，textarea，checkbox，numberbox，validatebox，datebox，combobox，combotree 可自行扩展
	options: {}
	}
	},
	{
		field: 'type', title: '类型', width: 50,
		editor: {//设置其为可编辑
		type: 'validatebox',
		options: {
		required: true//设置编辑规则属性
		}
		}	
		
		
	},
	{
	field: 'modelNo', title: '型号', width: 80, sortable: true,
	editor: {//设置其为可编辑
	type: 'validatebox',//设置编辑格式
	options: {
	required: true//设置编辑规则属性
	}
	}
	},//sortable:true点击该列的时候可以改变升降序
	{
	field: 'seriesNo', title: '序列号', width: 90,
	editor: {//设置其为可编辑
	type: 'validatebox',//这里我们将进行一个datetimebox的扩展
	options: {
	required: true//设置编辑规则属性
	}
	}
	},

	{
		field: 'bDate', title: '采购时间', width: 80,
		editor: {//设置其为可编辑
		type: 'datebox',//这里我们将进行一个datetimebox的扩展
		options: {
		required: true//设置编辑规则属性
		}
		}		
		
		
	},
	{
		field: 'bCompany', title: '采购单位', width: 80,
		editor: {//设置其为可编辑
		type: 'validatebox',//这里我们将进行一个datetimebox的扩展
		options: {
		required: true//设置编辑规则属性
		}
		}		
		
		
	},
	{
		field: 'bPrice', title: '价格', width: 50,
		editor: {//设置其为可编辑
		type: 'validatebox',//这里我们将进行一个datetimebox的扩展
		options: {
		required: true//设置编辑规则属性
		}
		}		
		
		
	},
	{
		field: 'guaranteeDate', title: '质保期', width: 80,
		editor: {//设置其为可编辑
		type: 'datebox',//这里我们将进行一个datetimebox的扩展
		options: {
		required: true//设置编辑规则属性
		}
		}			
	},
	{
		field: 'expireDate', title: '报废日期', width: 80,
		editor: {//设置其为可编辑
		type: 'datebox',//这里我们将进行一个datetimebox的扩展
		options: {
		required: true//设置编辑规则属性
		}
		}			
	},
	{
		field: 'company', title: '维护单位', width: 150,
		editor: {//设置其为可编辑
		type: 'validatebox',
		options: {
		required: true//设置编辑规则属性
		}
		}			
	},
	{
		field: 'contract', title: '联系人', width: 50,
		editor: {//设置其为可编辑
		type: 'validatebox',
		options: {
		required: true//设置编辑规则属性
		}
		}			
	},
	{
		field: 'contractNo', title: '联系方式', width: 85,
		editor: {//设置其为可编辑
		type: 'validatebox',
		options: {
		required: true//设置编辑规则属性
		}
		}			
	},
	{
		field: 'loginName', title: '登录名', width: 80,
		editor: {//设置其为可编辑
		type: 'validatebox',
		options: {
		required: true//设置编辑规则属性
		}
		}			
	},
	{
		field: 'loginPwd', title: '密码', width: 80,
		editor: {//设置其为可编辑
		type: 'validatebox',
		options: {
		required: true//设置编辑规则属性
		}
		}			
	},
	{
		field: 'portNumber', title: '端口数', width: 50,
		editor: {//设置其为可编辑
		type: 'validatebox',
		options: {
		required: true//设置编辑规则属性
		}
		}			
	},
	{
		field: 'id', title: 'id', width: 50,
		formatter:  function(value,row,index) {
			return "<a href='javascript:void(0)' onclick=\"$('#configWin').window('open');\">操作</a>";
		}
	}
	]],//这里之所以有两个方括号，是因为可以做成水晶报表形式，具体可看demo
	toolbar:'#tb',
	onAfterEdit: function (rowIndex, rowData, changes) {//在添加完毕endEdit，保存时触发
	console.info(rowData);
	var rows = $("#dg").datagrid('getSelected');
	var id;
	if (rows.id == "") {
		id=0;
	} else {
		id = rows.id;
	}
	console.info(rows.id);
	var data = encodeURI(JSON.stringify(rowData));
		$.ajax({
			type : "POST",
			dataType : "json",
			url : "<%=basePath%>addDevice?id=" + id,
			data : "jsonDate=" + data,
			success : function(data) {
				if(data) {
					 $.messager.alert("操作提示", "添加成功","warning");
					 $("#dg").datagrid('reload');
					 $("#dg").datagrid('unselectAll');
				}
			},
			error : function() {
				 $.messager.alert('操作提示', '添加设备失败，请重新操作', 'error');
				 $("#dg").datagrid('loaded');
			}

		});
	editFlag = undefined;//重置
	}
//	,onDblClickCell: function(rowIndex, field, value){//双击该行修改内容
// 	 	if (editFlag != undefined) {
// 			$("#dg").datagrid('endEdit', editFlag);//结束编辑，传入之前编辑的行
// 			}
// 		if (editFlag == undefined) {
// 			$("#dg").datagrid('beginEdit', rowIndex);//开启编辑并传入要编辑的行
// 			editFlag = rowIndex;
// 			}
//		 var rows = $("#dg").datagrid('getSelected');
//		 var id = rows.id;
	//	 $('#updateDeviceWin').window('open');
//		 $('#updateDeviceWin').window('refresh',"<%=basePath%>device/maintain_detail.jsp?id="+ id);
			
	//}
	});

	$("#dg").datagrid('hideColumn','id');
	var pager = $("#dg").datagrid('getPager');
	pager.pagination({
		pageSize:3,
		beforePageText: '第',//页数文本框前显示的汉字  
		afterPageText: '页    共 {pages} 页',
		displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
		onBeforeRefresh:function(){
			
		},
		onSelectPage:function(pageNumber,pageSize) {
			find(pageNumber,pageSize);
		}
		
	});
	function find(pageNumber,pageSize) {
		$("#dg").datagrid('getPager').pagination({pageSize : pageSize, pageNumber : pageNumber});//reset
		$("#dg").datagrid("loading"); 
		$.ajax({
			type:"post",
			url:"<%=basePath%>getDeviceByPager?pageSize=" + pageSize + "&pageNumber=" + pageNumber,
			success:function(data) {
			 	$("#dg").datagrid('loadData',pageData(data.rows,data.total));//加载数据
			 	$("#dg").datagrid("loaded"); 
			}
		});
	}
	function pageData(list,total){
	     var obj=new Object(); 
	     obj.total=total; 
	     obj.rows=list; 
	     return obj; 
	 }
	
	
	portInfoWin();
	configUpdateWin();
	});	
	
	function downloadFile() {
		var rows = $("#dg").datagrid('getSelections');
		if (rows.length < 0 || rows.length == 0) {
			 $.messager.alert('提示','请选择行','error');  
		} else {
			 var id = rows[0].id; 
	       	 var form = $("<form>");  
	       	 form.attr('style','display:none');  
	       	 form.attr('target','');  
	       	 form.attr('method','post');  
	       	 form.attr('action','<%=basePath%>getConfigFile?id='+id);  
	       	 $('body').append(form); 
	       	 form.form('submit',{
	       		success:function(data){   
	       		//var res = jQuery.parseJSON(data);
// 				if (!res.result) {
 					 $.messager.alert('提示',data,'error');  
// 				}
	     	}
	       });
		}

	}
	function portInfoWin() {
		$('#portInfoWin').window({
			title : '端口信息',
			width : 800,
			modal : true,
			shadow : true,
			closed : true,
			height : 250,
			resizable : false,
			onBeforeOpen : function() {
				
			}
		});
	}
	function configUpdateWin() {
		$('#updateConfigWin').window({
			title : '配置更换',
			width : 320,
			modal : true,
			shadow : true,
			closed : true,
			height : 300,
			resizable : false,
			onBeforeOpen : function() {
				
			}
		});
	}
	function openPortInfoWin() {
		var rows = $("#dg").datagrid('getSelections');
		if (rows.length < 0 || rows.length == 0) {
			 $.messager.alert('提示','请选择行','error');  
		} else {
			$('#portInfoWin').window('open');
			$('#portInfoWin').window('refresh',"<%=basePath%>maintain/portInfo.jsp");
		}

	}
	function openUpateConfigWin() {
		var rows = $("#dg").datagrid('getSelections');
		if (rows.length < 0 || rows.length == 0) {
			 $.messager.alert('提示','请选择行','error');  
		} else {
			$('#updateConfigWin').window('open');
			$('#updateConfigWin').window('refresh',"<%=basePath%>maintain/updateConfig.jsp");
		}

	}
	
    function closeLogin() {
        close();
    }
    function close() {
    	$('#portInfoWin').window('close');
    	$('#updateConfigWin').window('close');
    }
</script>
<body>
	<div data-options="region:'center',split:false">
		<table id="dg">
		</table>
	</div>
	<div id="tb" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
			<a href="javascript:void(0);" class="easyui-linkbutton"
				iconCls="icon-tip" plain="true" onclick="downloadFile();">网络配置</a> <a
				href="javascript:void(0);" class="easyui-linkbutton"
				iconCls="icon-edit" plain="true" onclick="openPortInfoWin()">端口配置</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"
				iconCls="icon-cut" plain="true" onclick="openUpateConfigWin()">更改配置</a>
		</div>
		<div>
			Date From: <input class="easyui-datebox" style="width: 80px">
			To: <input class="easyui-datebox" style="width: 80px">
			<!-- 			Language:  -->
			<!-- 			<select class="easyui-combobox" panelHeight="auto" style="width:100px"> -->
			<!-- 				<option value="java">Java</option> -->
			<!-- 				<option value="c">C</option> -->
			<!-- 				<option value="basic">Basic</option> -->
			<!-- 				<option value="perl">Perl</option> -->
			<!-- 				<option value="python">Python</option> -->
			<!-- 			</select> -->
			<a href="javascript:void(0);" class="easyui-linkbutton"
				iconCls="icon-search">Search</a>
		</div>
	</div>

	<div id="portInfoWin" class="easyui-window" title="端口信息"
		collapsible="false" minimizable="false" maximizable="false"
		icon="icon-save"
		style="width: 300px; height: 150px; padding: 5px; background: #fafafa;">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false"
				style="padding: 10px; background: #fff; border: 1px solid #ccc;">

			</div>
		</div>
	</div>

	<div id="updateConfigWin" class="easyui-window" title="端口信息"
		collapsible="false" minimizable="false" maximizable="false"
		icon="icon-save"
		style="width: 300px; height: 150px; padding: 5px; background: #fafafa;">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false"
				style="padding: 10px; background: #fff; border: 1px solid #ccc;">

			</div>
		</div>
	</div>
</body>
</html>