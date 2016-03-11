<%@page import="com.util.HmitUtil"%>
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
<script type="text/javascript" src="jquery/datagrid-detailview.js"></script>
<script type="text/javascript" src="jquery/easyui-lang-zh_CN.js"></script>

<style type="text/css">
.datagrid-row{height: 50px;}

</style>
<script type="text/javascript">
var editFlag = undefined;
var artchange = false;
var selectRow;
$(function (){
	window.cuslist = getCustomerList('<%=basePath%>getCustomerList');
	window.Suplist = getCustomerList('<%=basePath%>getSupplierList');
	$("#pro_dg").datagrid({
	view: detailview, 
	url: "<%=basePath%>getProject", //指向一个一般处理程序或者一个控制器，返回数据要求是Json格式，直接赋值Json格式数据也可，我以demo中自带的Json数据为例，就不写后台代码了，但是我会说下后台返回的注意事项
	iconCls: "icon-add",
	fitColumns: true, //设置为true将自动使列适应表格宽度以防止出现水平滚动,false则自动匹配大小
	//toolbar设置表格顶部的工具栏，以数组形式设置
	striped : true,
	fit : true,
	nowrap : false,
	idField: 'id', //标识列，一般设为id，可能会区分大小写，大家注意一下
	loadMsg: "正在努力为您加载数据", //加载数据时向用户展示的语句
	pagination: true, //显示最下端的分页工具栏
	rownumbers: true, //显示行数 1，2，3，4...
	singleSelect:true,
	pageSize: 10, //读取分页条数，即向后台读取数据时传过去的值
	pageList: [10, 20, 30], //可以调整每页显示的数据，即调整pageSize每次向后台请求数据时的数据
	sortOrder: "asc", //正序
	columns: [[
	 {
			field: 'proId', title: '项目编号', width: 80,hidden : 'true' 
	 },
	{
		field: 'proName', title: '项目名称', width: 80
	},
	{
		field: 'pTName', title: '项目类型', width: 50
	},
	{
	field: 'proMoney', title: '项目金额', width: 50
	},//sortable:true点击该列的时候可以改变升降序
	{
	field: 'proBrokerage', title: '经手人', width: 90,
	},
	{
		field: 'cusId', title: '客户', width: 80,
		formatter:  function(value,row,index) {
			for(var i=0; i<cuslist.length; i++){
				if(cuslist[i].cusId == value){
					return cuslist[i].compName;
				}
			}
		}
	},
	{
		field: 'conId', title: '合同编号', width: 80,
	},
	{
		field: 'signDate', title: '项目签订日期', width: 80
	},
	{
		field: 'beginDate', title: '项目开始日期', width: 80
	},
	{
		field: 'status', title: '状态', width: 80,
	},
	{
		title:'操作',
		field:'Id',
		width:60,
		formatter:  function(value,row,index) {		

			if (row.status == '<%=HmitUtil.ORDER_STATUS_NEW%>') {	
				return "<a href='javascript:void(0);' onclick='saveChange("+index+")'>确认验收</a> ";
			} else if (row.status == '<%=HmitUtil.ORDER_STATUS_COMPLETION%>') {
				return "<a href='javascript:void(0);' onclick='reiewOrder("+index+")'>确认竣工</a> ";
			}else {
				return '<%=HmitUtil.ORDER_STATUS_INVED%>';
				
			}
	}
	}
	]],
	toolbar: [
	      	{
	      		text : '添加查询施工进度',
	      		iconCls: "icon-tip",
	      		handler: function () {
	      			var rows = $("#pro_dg").datagrid('getSelections');
	      			var row = $('#pro_dg').datagrid("getSelected");
	      			if (rows.length < 1) {
	      				$.messager.alert('操作提示', '请选择要修改的行', 'warning');
	      			} else{
	      				 $('#pro').dialog("open").dialog('setTitle', '施工进度信息');
	      				 $('#proTable').form("load", row);
	      				 $('#pro_dg1').datagrid('load',row);
	      			}
	      		}
	      		
	      	}          
	      	],
	 detailFormatter:function(index,row){//注意2 
	        return '<div style="padding:2px"><table id="ddv-' + index + '"></table></div>';  
},
onExpandRow:function(index,row){//注意3  
	$('#ddv-'+index).datagrid({
		url: "<%=basePath%>getOrderListByPager?proId="+row.proId, //指向一个一般处理程序或者一个控制器，返回数据要求是Json格式，直接赋值Json格式数据也可，我以demo中自带的Json数据为例，就不写后台代码了，但是我会说下后台返回的注意事项
		iconCls: "icon-add",
		fitColumns: true, //设置为true将自动使列适应表格宽度以防止出现水平滚动,false则自动匹配大小
		//toolbar设置表格顶部的工具栏，以数组形式设置
		striped : true,
		nowrap : false,
		idField: 'id', //标识列，一般设为id，可能会区分大小写，大家注意一下
		rownumbers: true, //显示行数 1，2，3，4...
		singleSelect:true,
		sortName: "equName", //初始化表格时依据的排序 字段 必须和数据库中的字段名称相同
		sortOrder: "asc", //正序
		columns: [[
		 {
				field: 'ordId', title: '订单号', width: 80,hidden : 'true'
		 },
		{
			field: 'equName', title: '设备名称', width: 80
		},
		{
			field: 'equDescription', title: '品牌型号', width: 200	
		},
		{
		field: 'equNumber', title: '数量', width: 40, sortable: true

		},//sortable:true点击该列的时候可以改变升降序
		{
		field: 'sellPrice', title: '销售单价', width: 90

		},

		{
			field: 'sellTotalPrice', title: '销售总价', width: 80
		},
		{
			field: 'supId', title: '厂商', width: 80,
				formatter:  function(value,row,index) {
					if(value==0){
						return null;
					}
					var i;
					for(i=0; i<Suplist.length; i++){
						if(Suplist[i].supId == value){
							return Suplist[i].supName;
						}
					}
					if(i==Suplist.length){
						return value;
					}
				}
			
			
		},
		{
			field: 'costUnitPrice', title: '进货单价', width: 80,
			formatter : function(value,row,index) {
				if(value == 0) {
					return null;
				} else {
					return value;
				}
			}
			
			
		},
		{
			field: 'costPrice', title: '进货总价', width: 80,
			formatter : function(value,row,index) {
				if(value == 0) {
					return null;
				} else {
					return value;
				}
			}
		},
		{
			field: 'payables', title: '应付款', width: 80
		},
		{
			field: 'invId', title: '进项发票号', width: 80
		},
		{
			field: 'payRemarks', title: '付款到货备注', width: 80,
			editor: {//设置其为可编辑
			type: 'validatebox',
			options: {
			required: true//设置编辑规则属性
			}
			}			
		},
		{
			field: 'status', title: '状态', width: 60
				
		}
		]],
		onResize:function(){  
            $("#pro_dg").datagrid('fixDetailRowHeight',index);  
        },  
        onLoadSuccess:function(){  
            setTimeout(function(){  
                $("#pro_dg").datagrid('fixDetailRowHeight',index);  
            },0);  
        }  
    });  
	 $("#pro_dg").datagrid('fixDetailRowHeight',index);  
}  
	});
	//获取经手人
	 $('#proBrokerage').combobox({   

	      url:'<%=basePath%>getProBrokeragList',

	      valueField:'empName',

	      textField:'empName',
	      
	      editable : false,
	      
	      method : 'get',
	  });
	//获取客户名
	 $('#cusId').combobox({   

		  url:'<%=basePath%>getCustomerList',

	      valueField:'cusId',

	      textField:'compName',
	      
	      editable : true,
	      
	      method : 'get',
	  });
	//加载表格
	$('#pro_dg1').datagrid(
								{
									loadMsg : '数据加载中请稍后',
									
									url : '<%=basePath%>getProSchedule', //请求方法的地址
					title : '',
					nowrap : false, //文字自动换行
					fitColumns : true, //列自适应
					pagination : true, //底部显示分页工具栏
					fit : true,
					pageSize:5,
					pageList: [5, 10, 15],
					rownumbers : true, // 当true时显示行号 
					singleSelect : true, // 只允许当前选择一行
					iconCls : 'icon-save',
					idField : 'id', //标识列
					columns : [ [ {
						title : '添加信息者',
						field : 'addPeople',
						editor : 'text',
						align : 'center',
						width : 50,
					}, {
						title : '添加时间',
						field : 'addDate',
						editor : 'text',
						align : 'center',
						width : 50
					}, {
						title : '添加信息',
						field : 'schedule',
						editor : 'text',
						align : 'center',
						width : 200
					}
					] ]
				 
				});
	});	

var sy = $.extend({}, sy);
sy.serializeObject = function (form) { /*将form表单内的元素序列化为对象，扩展Jquery的一个方法*/
    var o = {};
    $.each(form.serializeArray(), function (index) {
        if (o[this['name']]) {
            o[this['name']] = o[this['name']] + "," + this['value'];
        } else {
            o[this['name']] = this['value'];
        }
    });
    return o;
};

function saveChange(index) {
	$("#pro_dg").datagrid('selectRow',index);
	//$("#dg").datagrid('endEdit', editFlag);
	var row = $("#pro_dg").datagrid('getSelected');
	var data = encodeURI(JSON.stringify(row),"UTF-8");
    $.messager.confirm("操作提示","确认验收?" , function (d) { 
    	if (d) {
    		$.ajax({
    			url : '<%=basePath%>updateProjectStatus',
    			data : 'data=' + data + '=' + '<%=HmitUtil.ORDER_STATUS_COMPLETION%>',
    			dataType : 'json',
    			type : 'post',
    			success : function(r) {
    				if(r) {
    					$.messager.alert('操作提示', r.msg, r.result);
    					$("#pro_dg").datagrid('reload');
    				}
    			},
    			error : function() {
    				$.messager.alert('操作提示', '服务器出错', 'error');
    			}	
    		});
    	}
	});
}

function reiewOrder(index) {
	$("#pro_dg").datagrid('selectRow',index);
	var row = $("#pro_dg").datagrid('getSelected');
	var data = encodeURI(JSON.stringify(row),"UTF-8");
	 $.messager.confirm("操作提示","确认竣工?" , function (d) {  
		 if(d) {
	    		$.ajax({
	    			url : '<%=basePath%>updateProjectStatus',
	    			data : 'data=' + data + '=' + '<%=HmitUtil.ORDER_STATUS_INVED%>',
	    			dataType : 'json',
	    			type : 'post',
	    			success : function(r) {
	    				if(r) {
	    					$.messager.alert('操作提示', r.msg, r.result);
	    					$("#pro_dg").datagrid('reload');
	    				}
	    			},
	    			error : function() {
	    				$.messager.alert('操作提示', '服务器出错', 'error');
	    			}	
	    		}); 
		 }
	 });
}
function getCustomerList(url) {
	var temp;
	$.ajax({
		url:url,
		type:"get",
		async:false,
		dataType:"json",
		success:function(data){
			temp = data;
		}
	});
	return temp;
}
function clearSearch(){
	//$('#dg').datagrid("load", {});
	$('#projectTable').form("clear");
}
function clearproSchedule(){
	//$('#dg').datagrid("load", {});
	//$('#proTable').form("clear");
	document.getElementById("schedule").value="";
}
function searchProject() {
	var data1 = sy.serializeObject($('#projectTable').form());
	 var data = encodeURI(JSON.stringify(data1),"UTF-8");
	 $('#pro_dg').datagrid('load', data1);
}
function saveproSchedule() {	
	 var data1 = sy.serializeObject($('#proTable').form());
	 var data = encodeURI(JSON.stringify(data1),"UTF-8");  	  
	 $.ajax({
			url : '<%=basePath%>addSchedule',
			data : 'data=' + data,
			dataType : 'json',
			type : 'post',
			success : function(r) {
				if(r) {
					
				}
			},
			error : function() {
				$.messager.alert('操作提示', '服务器出错', 'error');
			}	
		}); 
	 $('#pro_dg1').datagrid('load',data1);
}
</script>

<body class="easyui-layout">
	<div region="north" style="height: 120px; background: #F4F4F4;" class="easyui-tabs"  border="false">
		<div title="高级搜索">
			<form id="projectTable">
				<table id="projectTable" class="projectTable datagrid-toobar"
					style="width: 70%; height: 100%">
					<tr>
						<th>项目类型:</th>
						<td><input id="pTName" type="text" class="easyui-validatebox textbox" name="pTName"/></td>
						<th>客户:</th>
						<td><input id="cusId" type="text" class="easyui-combobox"
							name="cusId" editable="true" /></td>	
						</tr>
							<tr>
						<th>状态:</th>
						<td><input id="status" class="easyui-validatebox" type="text" name="status"/></td>
				
						<th>经手人:</th>
						<td><input id="proBrokerage" type="text" class="easyui-combobox"
							name="proBrokerage" editable="false" /></td>	
					</tr>
					<tr>
						<td colspan="2"><a class="easyui-linkbutton"
							icon="icon-search" href="javascript:void(0);"
							onclick="searchProject();">查找</a> <a id="clearBtn"
							class="easyui-linkbutton" icon="icon-cancel"
							href="javascript:void(0);" onclick="clearSearch();">重置</a></td>
					</tr>
				</table>
				</form>
		</div>
	</div>
	<div id="g" region="center" style="margin-top: 3px;" >
		<table id="pro_dg">
		</table>
	</div>
     <div id="pro" class="easyui-dialog" style="width: 800px; height: 500px;" closed="true" buttons="#pro-buttons">
		<div id="pro1" title="添加进度信息" buttons="#pro1-buttons">
			<form id="proTable">
				<div class="fitem" style="display: none;">
				<label >项目编号:</label> <input name="proId"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>
			<div class="fitem" style="width: 400px; height: 100px;">
				<label ">施工进度描述:</label> <textarea id="schedule" name="schedule"
					class="easyui-validatebox" style="width:700px;height:75px;" required="true" ></textarea>
			</div>
			<div>
			<a class="easyui-linkbutton" onclick="saveproSchedule();">添加施工进度</a>
			<a class="easyui-linkbutton" onclick="clearproSchedule();">清空</a>
			</div>
			</form>
		</div>
		<div id="g1" region="center"  >
		<table id="pro_dg1" class="easyui-datagrid" style="height: 300px;" >
		</table>
	</div>
	
	</div>
	<div id="pro-buttons">
		 <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#pro').dialog('close')" iconcls="icon-cancel">退出
			</a>
	</div>

</body>
</html>
