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
	   field: 'proId', title: '项目编号',align:'center', width: 80,hidden : 'true' 
	},
	{
		field: 'proName', title: '项目名称',align:'center', width: 80
	},
	{
	    field: 'proBrokerage', title: '经理',align:'center', width: 90,
	},
	{
		field: 'beginDate', title: '项目开始日期',align:'center', width: 80
	},
	{
		field: 'orderStatue', title: '采购状态',align:'center', width: 80,
		editor: {//设置其为可编辑
			type: 'text',
			options: {
			required: true//设置编辑规则属性
			}
			}		
	},
	{
		field: 'expecteAT', title: '预计收货时间',align:'center', width: 80,
		editor: {//设置其为可编辑
			type: 'datebox',
			options: {
			required: true//设置编辑规则属性
			}
			}		
	},
	{
		field: 'confirmArrival', title: '到货确认',align:'center', width: 80,
		editor: {//设置其为可编辑
			type: 'text',
			options: {
			required: true//设置编辑规则属性
			}
			}		
	}
	]],
	toolbar: [
{
	text : "编辑",
	iconCls : "icon-edit",
	handler : function() {
		var rows = $("#pro_dg").datagrid('getSelections');
		if (rows.length < 1) {
			$.messager.alert('操作提示', '请选择要修改的行', 'warning');
		} else {
		 	if (editFlag != undefined) {
		 		$("#pro_dg").datagrid('endEdit', editFlag);//结束编辑，传入之前编辑的行
		 	}
		 	if (editFlag == undefined) {		 	
				var rows = $("#pro_dg").datagrid('getSelections');
				var index = $("#pro_dg").datagrid('getRowIndex', rows[0]);
				$("#pro_dg").datagrid('beginEdit', index);
				editFlag = index;
				
		 	}	
		}
	}
},"-",
{
 	text: "保存",
 	iconCls: "icon-save",
 	handler: function () {
 		$("#pro_dg").datagrid('endEdit', editFlag);
 		var row = $('#pro_dg').datagrid("getSelected");
 		var data = encodeURI(JSON.stringify(row),"UTF-8");
 		$.ajax({
 			url:'<%=basePath%>updateprojectsatue',
 			data:'data='+data,
 			dataType:'json',
 			type:'post',
 		});
 		$("#pro_dg").datagrid("load");
 	}
},"-",
{
	text : "撤销",
	iconCls : "icon-redo",
	handler : function() {
		$("#pro_dg").datagrid('rejectChanges');
		editFlag = undefined;
	}
},"-", 
	    	{
	    		text : "进项发票信息",
	    		iconCls : "icon-print",
	    		handler : function() {
	    			 $('#inv').dialog("open").dialog('setTitle', '添加发票信息');
	    		}
	    	}          
	      	],
	 detailFormatter:function(index,row){//注意2 
	        return '<div style="padding:2px"><table id="ddv-' + row.proId + '"></table></div>';  
},
onExpandRow:function(index,row){//注意3  
	$('#ddv-'+row.proId).datagrid({
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
	         field: 'proId', title: '项目编号',align:'center', width: 80,hidden : 'true' 
	       },
		 {
			field: 'ordId', title: '订单号', width: 80,align:'center',hidden : 'true'
		 },
		{
			field: 'equName', title: '设备名称',align:'center', width: 80
		},
		{
			field: 'equDescription', title: '品牌型号',align:'center', width: 100
		},
		{
		field: 'equNumber', title: '数量', width: 30, align:'center',sortable: true

		},//sortable:true点击该列的时候可以改变升降序
		{
		field: 'sellPrice', title: '销售单价',align:'center', width: 50

		},

		{
			field: 'sellTotalPrice', title: '销售总价',align:'center', width: 50
		},
		{
			field: 'supId', title: '厂商',align:'center', width: 100,
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
			field: 'costUnitPrice', title: '进货单价',align:'center', width: 50,
			formatter : function(value,row,index) {
				if(value == 0) {
					return null;
				} else {
					return value;
				}
			}
			
			
		},
		{
			field: 'costPrice', title: '进货总价',align:'center', width: 50,
			formatter : function(value,row,index) {
				if(value == 0) {
					return null;
				} else {
					return value;
				}
			}
		},
		{
			field: 'payables', title: '应付款',align:'center', width: 50
		},
		{
			field: 'invId', title: '进项发票号',align:'center', width: 80
		},
		{
			field: 'payRemarks', title: '备注', width: 100,align:'center',
			editor: {//设置其为可编辑
			type: 'validatebox',
			options: {
			required: true//设置编辑规则属性
			}
			}			
		},
		{
			field: 'status', title: '状态',align:'center', width: 50
				
		},
		{
			field: 'id1', title: '编辑',align:'center', width: 50,
			formatter: function(value,row,index){
				var indexofid=index+'.'+row.proId;
				return "<a href='javascript:void(0);' onclick='edit("+indexofid+")'>编辑</a><br><a href='javascript:void(0);' onclick='save("+row.proId+")'>保存</a><br><a href='javascript:void(0);' onclick='back("+row.proId+")'>撤销</a>  ";
			}
		},
		{
			title:'操作',field:'id',width:50,align:'center',
			formatter:  function(value,row,index) {		
				var indexofid=index+'.'+row.proId;
				var a="<a href='javascript:void(0);' onclick='selepay("+indexofid+")'>付款纪律</a><br> ";
				if (row.status == '<%=HmitUtil.ORDER_STATUS_NEW%>' || row.status == null) {		
					return a+"<a href='javascript:void(0);' onclick='saveChange("+indexofid+")'>进价确认</a> ";
				} else if (row.status == '<%=HmitUtil.ORDER_STATUS_ORDER%>') {
					return a+"<a href='javascript:void(0);' onclick='reiewOrder("+indexofid+")'>审核</a> ";
				} else if (row.status == '<%=HmitUtil.ORDER_STATUS_CONFIRMED%>') {
					return a+"<a href='javascript:void(0);' onclick='confirmArrived("+indexofid+")'>确认到货</a> ";
				} else if (row.invId == null && row.payables != 0 ) {
					return a+"<a href='javascript:void(0);' onclick='confirmPay("+indexofid+")'>确认付款</a><br><a href='javascript:void(0);' onclick='confirmInv("+indexofid+")'>确认收票</a>  ";
				} else if (row.invId == null && row.payables == 0 ) {
					return a+"<a href='javascript:void(0);' onclick='confirmInv("+indexofid+")'>确认收票</a> ";
				}else if (row.invId != null && row.payables != 0 ) {
					return a+"<a href='javascript:void(0);' onclick='confirmPay("+indexofid+")'>确认付款</a> ";
				}else {
					return a;
					
				}
				

		}
		}
		]],
		onAfterEdit: function (rowIndex, rowData, changes) {
			editFlag = undefined;
		},
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
} ,
onAfterEdit: function (rowIndex, rowData, changes) {
	editFlag = undefined;
}
	});
	$('#empName1').combobox({   

	      url:'<%=basePath%>getPaywayList',

	      valueField:'PWName',

	      textField:'PWName',
	      
	      editable : false,
	      
	      method : 'get',
	  });
	//获取立项项目
	$('#proId1').combobox({   

	      url:'<%=basePath%>getProjectNameList',

	      valueField:'id',

	      textField:'proName',
	      
	      editable : false,
	      
	      method : 'get',
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
	//加载表格
	$('#dg2').datagrid(
							{
								loadMsg : '数据加载中请稍后',
								
								url : '<%=basePath%>getOrderPayHistory', //请求方法的地址
				title : '',
				nowrap : false, //文字自动换行
				fitColumns : true, //列自适应	
				fit : true,		
			
				singleSelect : true, // 只允许当前选择一行
				iconCls : 'icon-save',
				idField : 'id', //标识列
				columns : [ [ {
					field: 'pHId', title: '编号', width: 80,hidden : 'true'
//		  			editor: {//设置其为可编辑
//		  			type: 'validatebox',//设置编辑样式 自带样式有：text，textarea，checkbox，numberbox，validatebox，datebox，combobox，combotree 可自行扩展
//		  			options: {}
//		  			}    
		 	 },{
					title : '采购单号',
					field : 'ordId',
					editor : 'text',
					align : 'center',
					width : 50,
					hidden : 'true'
				}, {
					title : '付款金额',
					field : 'paidMoney',
					editor : 'text',
					align : 'center',
					width : 50
				}, {
					title : '付款时间',
					field : 'paidDate',
					editor : 'text',
					align : 'center',
					width : 50
				},{
					title:'付款方式',
					field:'pWName',
					editor : 'text',
					align : 'center',
					width : 50
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
//撤销
function back(proId){
	$('#ddv-'+proId).datagrid('rejectChanges');
	editFlag = undefined;
}
//保存
function save(proId){
	$('#ddv-'+proId).datagrid('endEdit', editFlag);
}
//查看付款记录
function selepay(indexofid){
	var indexofid1=indexofid.toString().split('.');
	index=indexofid1[0];
	proId=indexofid1[1];
	$('#ddv-'+proId).datagrid('selectRow',index);
	var row = $('#ddv-'+proId).datagrid("getSelected");
	$('#dg2').datagrid('load', row);
	$('#details').dialog("open").dialog('setTitle', '付款记录查询'); 
}
//确认开票
function confirmInv(indexofid) {
	var indexofid1=indexofid.toString().split('.');
	index=indexofid1[0];
	proId=indexofid1[1];
	$('#ddv-'+proId).datagrid('selectRow',index);
	var row = $('#ddv-'+proId).datagrid("getSelected");
	if (editFlag != undefined) {
		$.messager.alert('操作提示', '您尚未保存', 'warning');
		return;
	}  
    if (proId) {
    	$('#invId').combobox({   

  	      url:'<%=basePath%>getInvoiceList?proId='+proId,

  	      valueField:'invId',

  	      textField:'invId',
  	      
  	      editable : false,
  	      
  	      method : 'get',
  	  });
        $('#orderofinv').dialog("open").dialog('setTitle', '添加发票');
        $('#orderofinv').form("load", row);
      
    }
}
//确认付款
function confirmPay(indexofid) {
	if (editFlag != undefined) {
		$.messager.alert('操作提示', '您尚未保存', 'warning');
		return;
	}
	var indexofid1=indexofid.toString().split('.');
	index=indexofid1[0];
	proId=indexofid1[1];
	$('#ddv-'+proId).datagrid('selectRow',index);
    var row = $('#ddv-'+proId).datagrid("getSelected");
    if (row) {
        $('#dlg').dialog("open").dialog('setTitle', '添加付款信息');  
        $('#fm').form("load", row);
        $("#money").numberbox({
            max:row.payables,
            value:row.payables
        });
    }  
}
//确认到货
function confirmArrived(indexofid) {
	if (editFlag != undefined) {
		$.messager.alert('操作提示', '您尚未保存', 'warning');
		return;
	}
	var indexofid1=indexofid.toString().split('.');
	index=indexofid1[0];
	proId=indexofid1[1];
	$('#ddv-'+proId).datagrid('selectRow',index);
    var row = $('#ddv-'+proId).datagrid("getSelected");
    if (row) {
        $('#arrival').dialog("open").dialog('setTitle', '添加收获信息');
        $('#arrival-fm').form("load", row);
        //
    }
}
//审核
function reiewOrder(indexofid) {
	var indexofid1=indexofid.toString().split('.');
	index=indexofid1[0];
	proId=indexofid1[1];
	$('#ddv-'+proId).datagrid('selectRow',index);
	var row = $('#ddv-'+proId).datagrid('getSelected');
	if (editFlag != undefined) {
		$.messager.alert('操作提示', '您尚未保存', 'warning');
		return;
	}
	if (row.supId == null || row.supId == '') {
		$.messager.alert('操作提示', '请确认供应商', 'warning');
		return;
	}
	if (row.costUnitPrice == null || row.costUnitPrice == '') {
		$.messager.alert('操作提示', '请确认进货单价', 'warning');
		return;
		
	}
	if (row.costPrice == null || row.costPrice == '') {
		$.messager.alert('操作提示', '请确认进货总价', 'warning');
		return;
		
	}
	var data = encodeURI(JSON.stringify(row),"UTF-8");
	$.messager.defaults = { ok: "是", cancel: "否" }; 
	 $.messager.confirm("操作提示","请确认订单无误，是否继续?" , function (d) {  
		 if(d) {
	    		$.ajax({
	    			url : '<%=basePath%>updateOrderStatus',
	    			data : 'data=' + data + '=' + '<%=HmitUtil.ORDER_STATUS_CONFIRMED%>',
	    			dataType : 'json',
	    			type : 'post',
	    			success : function(r) {
	    				if(r) {
	    					$.messager.alert('操作提示', r.msg, r.result);
	    					Suplist=getSupplierList('<%=basePath%>getSupplierList');
	    					$('#ddv-'+proId).datagrid('reload');
	    				}
	    			},
	    			error : function() {
	    				$.messager.alert('操作提示', '服务器出错', 'error');
	    			}	
	    		}); 
		 }
	 });
}
//进阶确认
function saveChange(indexofid) {
	var indexofid1=indexofid.toString().split('.');
	index=indexofid1[0];
	proId=indexofid1[1];
	$('#ddv-'+proId).datagrid('selectRow',index);
	//$("#dg").datagrid('endEdit', editFlag);
	var row = $('#ddv-'+proId).datagrid('getSelected');
	if (editFlag != undefined) {
		$.messager.alert('操作提示', '您尚未保存', 'warning');
		return;
	}
	if (row.supId == null || row.supId == '') {
		$.messager.alert('操作提示', '请确认供应商', 'warning');
		return;
	}
	if (row.costUnitPrice == null || row.costUnitPrice == '') {
		$.messager.alert('操作提示', '请确认进货单价', 'warning');
		return;
		
	}
	if (row.costPrice == null || row.costPrice == '') {
		$.messager.alert('操作提示', '请确认进货总价', 'warning');
		return;
		
	}
	var data = encodeURI(JSON.stringify(row),"UTF-8");
	$.messager.defaults = { ok: "是", cancel: "否" }; 
    $.messager.confirm("操作提示","订单交由业务经理审核，是否继续?" , function (d) { 
    	if (d) {
    		$.ajax({
    			url : '<%=basePath%>updateOrderStatus',
    			data : 'data=' + data + '=' + '<%=HmitUtil.ORDER_STATUS_ORDER%>',
    			dataType : 'json',
    			type : 'post',
    			success : function(r) {
    				if(r) {
    					$.messager.alert('操作提示', r.msg, r.result);
    					Suplist=getSupplierList('<%=basePath%>getSupplierList');
    					$('#ddv-'+proId).datagrid('reload');
    				}
    			},
    			error : function() {
    				$.messager.alert('操作提示', '服务器出错', 'error');
    			}	
    		});
    	}
	});
}
//编辑
function edit(indexofid){
	var indexofid1=indexofid.toString().split('.');
	index=indexofid1[0];
	proId=indexofid1[1];
	if (editFlag != undefined) {
		$.messager.alert('操作提示', '您尚未保存', 'warning');
		return;
	}  
	$('#ddv-'+proId).datagrid('selectRow',index);
	var row = $('#ddv-'+proId).datagrid("getSelected");
	if(row.status== '<%=HmitUtil.ORDER_STATUS_NEW%>' || row.status == null || row.status == '<%=HmitUtil.ORDER_STATUS_ORDER%>'){
		if(editFlag!=undefined){
		$('#ddv-'+proId).datagrid('endEdit',editFlag);
	}
	if(editFlag==undefined){
		addeditor(proId);
		addeditor1(proId);
		$('#ddv-'+proId).datagrid('beginEdit', index);
		editFlag=index;
	}
	}else{
		if(editFlag!=undefined){
			$('#ddv-'+proId).datagrid('endEdit',editFlag);
		}
		if(editFlag==undefined){
			deleteeditor(proId);
			$('#ddv-'+proId).datagrid('beginEdit', index);
			editFlag=index;
		}
	}
}
//确定验收
function acceptance(index) {
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
//确定竣工
function reiewPro(index) {
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
//动态增加editor

function addeditor1(proId){
	
	$('#ddv-'+proId).datagrid('addEditor',{
		field:'supId',
		editor: {//设置其为可编辑
			type: 'combobox',
			options: {
			valueField : 'supId',
			editable: true,
			textField : 'supName',
			data : Suplist,
			required: true,
			filter : function(q,row) {
				      var opts = $(this).combobox('options');
				      
				     // $(this).combobox('setText', _row["supName"]);
			          return row[opts.textField].indexOf(q) > -1;
			          
			},
			onChange: function (newValue, oldValue) {	  
				     artchange = true;
				     //$(this).combobox('setText', "ningbo");
		    },
		   onHidePanel: function () {
				 var t = $(this).combobox('getText');
				 var listdata = $.data(this, "combobox");
				 var rowdata = listdata.data;
				 for (var i = 0; i < rowdata.length; i++) {
	                    var _row = rowdata[i];
	                    var txt_Val = _row["supName"];
	                    if (txt_Val.toLowerCase().indexOf(t.toLowerCase()) > -1) {
	                        $(this).combobox('setText', _row["supName"]);
	                       //
	                        $(this).val(_row["supName"]);
	                       
	                        return;
	                    }
	                }
				// alert($(this).combobox('getText'));
	          // artChanged = false;
	            // selectRow = null;
				 
		 },
			 onSelect : function(record) {		 
				 selectRow = record;
		},
			}
			}
	});
}

function addeditor(proId){
	//数量
	$('#ddv-'+proId).datagrid('addEditor',{
			field:'equNumber',
			editor:{
				type:'numberbox',
				options:{
					required:true
				}
			}
		});
	
	//销售单价
	$('#ddv-'+proId).datagrid('addEditor',{
			field:'sellPrice',
			editor:{
				type:'numberbox',
				options:{
					required:true
				}
			}
		});
	//销售总价
	$('#ddv-'+proId).datagrid('addEditor',{
			field:'sellTotalPrice',
			editor:{
				type:'numberbox',
				options:{
					required:true
				}
			}
		});
	
	//进货单价
	$('#ddv-'+proId).datagrid('addEditor',{
			field:'costUnitPrice',
			editor: {//设置其为可编辑
				type: 'numberbox',
				options: {
				required: true//设置编辑规则属性
				}
				}				
		});
	//进货总价
	$('#ddv-'+proId).datagrid('addEditor',{
			field:'costPrice',
			editor: {//设置其为可编辑
				type: 'numberbox',
				options: {
				required: true//设置编辑规则属性
				}
				}				
		});
	
}
//动态删除editor
function deleteeditor(proId){
	//数量
	$('#ddv-'+proId).datagrid('removeEditor','equNumber');
	$('#ddv-'+proId).datagrid('removeEditor','sellPrice');
	$('#ddv-'+proId).datagrid('removeEditor','sellTotalPrice');
	$('#ddv-'+proId).datagrid('removeEditor','supId');
	$('#ddv-'+proId).datagrid('removeEditor','costUnitPrice');
	$('#ddv-'+proId).datagrid('removeEditor','costPrice');
}
//动态添加和删除Editor函数
$.extend($.fn.datagrid.methods, {
    addEditor : function(jq, param) {
        if (param instanceof Array) {
            $.each(param, function(index, item) {
                var e = $(jq).datagrid('getColumnOption', item.field);
                e.editor = item.editor;
            });
        } else {    	
        		var e = $(jq).datagrid('getColumnOption', param.field);
                e.editor = param.editor;          
        }
    },
    removeEditor : function(jq, param) {
        if (param instanceof Array) {
            $.each(param, function(index, item) {
                var e = $(jq).datagrid('getColumnOption', item);
                e.editor = {};
            });
        } else {
            var e = $(jq).datagrid('getColumnOption', param);
            e.editor = {};
        }
    }
});
//添加收货信息
function saveArrival(){
	 var data1 = sy.serializeObject($('#arrival-fm').form());
	 var data = encodeURI(JSON.stringify(data1),"UTF-8"); 
	 $.ajax({
			url : '<%=basePath%>updateOrderStatus2',
			data : 'data=' + data + '=' + '<%=HmitUtil.ORDER_STATUS_ARRIVED%>',
			dataType : 'json',
			type : 'post',
			success : function(r) {
				if(r) {
					$.messager.alert('操作提示', r.msg, r.result);
					$('#arrival').dialog("close");
                 $('#ddv-'+data1.proId).datagrid("load");
				}
			},
			error : function() {
				$.messager.alert('操作提示', '服务器出错', 'error');
			}	
		}); 
	
}
//添加付款信息
function savePay() {	
	 var data1 = sy.serializeObject($('#fm').form());
	 var data = encodeURI(JSON.stringify(data1),"UTF-8");  	  
	 $.ajax({
			url : '<%=basePath%>updateOrderStatus1',
			data : 'data=' + data + '=' + '<%=HmitUtil.ORDER_STATUS_PAYED%>',
			dataType : 'json',
			type : 'post',
			success : function(r) {
				if(r) {
					$.messager.alert('操作提示', r.msg, r.result);
					$('#dlg').dialog("close");
                    $('#ddv-'+data1.proId).datagrid("load");
				}
			},
			error : function() {
				$.messager.alert('操作提示', '服务器出错', 'error');
			}	
		}); 
}
//添加发票
function addorderofinv(){
	 var data1 = sy.serializeObject($('#orderofinv-fm').form());
	 var data = encodeURI(JSON.stringify(data1),"UTF-8"); 
	 $.ajax({
			url : '<%=basePath%>updateorderofinv',
			data : 'data=' + data + '=' + '<%=HmitUtil.ORDER_STATUS_INVED%>',
			dataType : 'json',
			type : 'post',
			success : function(r) {
				if(r) {
					$.messager.alert('操作提示', r.msg, r.result);
					$('#orderofinv').dialog("close");
                 $('#ddv-'+data1.proId).datagrid("load");
				}
			},
			error : function() {
				$.messager.alert('操作提示', '服务器出错', 'error');
			}	
		}); 
	
}
//添加发票信息
function saveInv() {	
	 var data1 = sy.serializeObject($('#inv-fm').form());
	 var data = encodeURI(JSON.stringify(data1),"UTF-8");  	  
	 $.ajax({
			url : '<%=basePath%>addInvoice',
			data : 'data=' + data,
			dataType : 'json',
			type : 'post',
			success : function(r) {
				if(r) {
					$.messager.alert('操作提示', r.msg, r.result);
					$('#inv').dialog("close");
                    //$('#dg').datagrid("load");
				}
			},
			error : function() {
				$.messager.alert('操作提示', '服务器出错', 'error');
			}	
		}); 
}
</script>

<body class="easyui-layout">
	<div region="north" style="height: 90px; background: #F4F4F4;" class="easyui-tabs"  border="false">
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
						<td colspan="2"><a class="easyui-linkbutton"
							icon="icon-search" href="javascript:void(0);"
							onclick="searchProject();">查找</a></td>
						</tr>
							<tr>
						<th>状态:</th>
						<td><input id="status" class="easyui-validatebox" type="text" name="status"/></td>
				
						<th>经手人:</th>
						<td><input id="proBrokerage" type="text" class="easyui-combobox"
							name="proBrokerage" editable="false" /></td>	
					<td colspan="2"><a id="clearBtn"
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
    <div id="arrival" class="easyui-dialog"
		style="width: 320px; height: 270px; padding: 10px 20px;" closed="true"
		buttons="#arrival-buttons">
		<form id="arrival-fm" method="post">
			<div class="fitem">
				<label >采　购　单　号:</label> <input name="ordId"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>
			<div class="fitem" style="display: none;">
				<label >生　产　商　号:</label> <input name="supId"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>
			<div class="fitem" style="display: none;">
				<label >项　目　id:</label> <input name="proId"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>
			<div class="fitem">
				<label >进　货　总　价:</label> <input name="costPrice"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>			
			<div class="fitem">
				<label>收　货　时　间:</label> <input id="arrivalTime" type="text"
							class="easyui-datebox" name="arrivalTime"
							style="width: 145px;" required="true" editable="false" />
			</div>
			<div class="fitem">
				<label ">付款，到货备注:</label> <input name="payRemarks"
					class="easyui-validatebox" style="width: 140px;" required="true" />
			</div>		
		</form>
	</div>
	<div id="arrival-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="saveArrival();" iconcls="icon-save">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#arrival').dialog('close')" iconcls="icon-cancel">取消</a>
	</div>
    <div id="dlg" class="easyui-dialog"
		style="width: 400px; height: 280px; padding: 10px 20px;" closed="true"
		buttons="#dlg-buttons">
		<form id="fm" method="post">
		    <div class="fitem" style="display: none;">
				<label >项　目　id:</label> <input name="proId"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>
			<div class="fitem">
				<label >采　购　单　号:</label> <input name="ordId"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>
			<div class="fitem" style="display: none;">
				<label >生　产　商　号:</label> <input name="supId"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>
			<div class="fitem">
				<label >进　货　总　价:</label> <input name="costPrice"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>
			<div class="fitem">
				<label >应　付　金　额:</label> <input name="payables"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>
			<div class="fitem" >
				<label >付　款　金　额:</label> <input id="money" name="money" type="text" min="1" max=""
							precision="2" required="true" missingMessage="非法金额"
							class="easyui-numberbox" />
			</div>
			<div class="fitem" style="display: none;">
				<label >发票号:</label> <input name="invId"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>
			<div class="fitem">
				<label>付　款　时　间:</label> <input id="payDate" type="text"
							class="easyui-datebox" name="payDate"
							style="width: 145px;" required="true" editable="false" />
			</div>
			
			<div class="fitem">
				<label>付　款　方　式:</label> <input id="empName1" type="text"
				style="width: 145px;" class="easyui-combobox" name="payWay" editable="false" />
			</div>
			<div class="fitem">
				<label ">付款，到货备注:</label> <input name="payRemarks"
					class="easyui-validatebox" style="width: 140px;" required="true" />
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="savePay();" iconcls="icon-save">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#dlg').dialog('close')" iconcls="icon-cancel">取消</a>
	</div>
    <div id="orderofinv" class="easyui-dialog"
		style="width: 320px; height: 270px; padding: 10px 20px;" closed="true"
		buttons="#orderofinv-buttons">
		<form id="orderofinv-fm" method="post">
			<div class="fitem">
				<label >采　购　单　号:</label> <input name="ordId"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>
			<div class="fitem" style="display: none;">
				<label >项   目     编    号:</label> <input name="proId"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>
			<div class="fitem">
				<label >项　目　名　称:</label> <input name="proName"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>
			<div class="fitem">
				<label >进　货　总　价:</label> <input name="costPrice"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>
			<div class="fitem" style="display: none;">
				<label >应　付　金　额:</label> <input name="payables"
					class="easyui-validatebox" style="width: 140px;" required="true" readonly="readonly"/>
			</div>
			<div class="fitem">
				<label>发　票　单　号:</label> <input id="invId" type="text"
				style="width: 145px;" class="easyui-combobox" name="invId" editable="false" />
			</div>				
		</form>
	</div>
	<div id="orderofinv-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="addorderofinv();" iconcls="icon-save">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#orderofinv').dialog('close')" iconcls="icon-cancel">取消</a>
	</div>
    <div id="inv" class="easyui-dialog"
		style="width: 320px; height: 270px; padding: 10px 20px;" closed="true"
		buttons="#inv-buttons">
		<form id="inv-fm" method="post">
			<div class="fitem">
				<label >　发票号:</label> <input name="invId"
					class="easyui-validatebox" style="width: 140px;" required="true" />
			</div>
			<div class="fitem" >
				<label >开票金额:</label> <input id="invMoney" type="text" min="1" max="10000000"
							precision="2" required="true" missingMessage="非法金额"
							class="easyui-numberbox" name="invMoney"/>
			</div>
			<div class="fitem">
				<label >开票内容:</label> <input name="invContent"
					class="easyui-validatebox" style="width: 140px;" required="true" />
			</div>
			<div class="fitem">
				<label>开票日期:</label> <input id="invDate" type="text"
							class="easyui-datebox" name="invDate"
							style="width: 145px;" required="true" editable="false" />
			</div>
			<div class="fitem">
				<label>项目名称:</label> <input id="proId1" type="text"
				style="width: 145px;" class="easyui-combobox" name="proId"  editable="false" />
			</div>
			<div class="inv-fitem">
				<label style="height: 48px;">备　　注:</label>
					<textarea id="invRemarks" name="invRemarks"
						class="easyui-validatebox" style="height: 48px;"></textarea>
			</div>
		</form>
	</div>
	<div id="inv-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="saveInv();" iconcls="icon-save">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#inv').dialog('close')" iconcls="icon-cancel">取消</a>
	</div>
    <div id="details" class="easyui-dialog"
		style="width: 420px; height: 300px;" closed="true"
		buttons="#details-buttons">
		
		<table id="dg2" class="easyui-datagrid" style="height: 200px;" >
		</table>
	
	</div>
	<div id="details-buttons">
		 <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#details').dialog('close')" iconcls="icon-cancel">取消</a>
	</div>
</body>
</html>
