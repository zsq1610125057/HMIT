 <%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.util.HmitUtil"%>
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
<style type="text/css">
.datagrid-row{height: 50px;}

</style>
<script type="text/javascript">
var editFlag = undefined;
var artchange = false;
var selectRow;

$(function (){
	window.Suplist = getSupplierList('<%=basePath%>getSupplierList');
	$("#dg").datagrid({
	url: "<%=basePath%>getOrderListByPager", //指向一个一般处理程序或者一个控制器，返回数据要求是Json格式，直接赋值Json格式数据也可，我以demo中自带的Json数据为例，就不写后台代码了，但是我会说下后台返回的注意事项
	iconCls: "icon-add",
	fitColumns: true, //设置为true将自动使列适应表格宽度以防止出现水平滚动,false则自动匹配大小
	//toolbar设置表格顶部的工具栏，以数组形式设置
	striped : true,
	nowrap : false,
	idField: 'id', //标识列，一般设为id，可能会区分大小写，大家注意一下
	loadMsg: "正在努力为您加载数据", //加载数据时向用户展示的语句
	pagination: true, //显示最下端的分页工具栏
	rownumbers: true, //显示行数 1，2，3，4...
	singleSelect:true,
	pageSize: 10, //读取分页条数，即向后台读取数据时传过去的值
	pageList: [10, 20, 30], //可以调整每页显示的数据，即调整pageSize每次向后台请求数据时的数据
	sortName: "equName", //初始化表格时依据的排序 字段 必须和数据库中的字段名称相同
	sortOrder: "asc", //正序
	columns: [[
	 {
			field: 'ordId', title: '订单号', width: 80 
	 },
	{
		field: 'equName', title: '设备名称', width: 80
	},
	{
		field: 'equDescription', title: '设备描述', width: 200	
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
				for(var i=0; i<Suplist.length; i++){
					if(Suplist[i].supId == value){
						return Suplist[i].supName;
					}
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
		field: 'proName', title: '项目名称', width: 80
	},
	{
		field: 'proId', title: '项目编号', width: 80,
		editor: {//设置其为可编辑
		type: 'validatebox',
		options: {
		required: true//设置编辑规则属性
		}
		}
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
		field: 'status', title: '状态', width: 50
			
	},{
		title:'操作',
		field:'id',
		width:50,
		formatter:  function(value,row,index) {		

			if (row.status == '<%=HmitUtil.ORDER_STATUS_NEW%>' || row.status == null) {	
				return "<a href='javascript:void(0);' onclick='saveChange("+index+")'>进价确认</a> ";
			} else if (row.status == '<%=HmitUtil.ORDER_STATUS_ORDER%>') {
				return "<a href='javascript:void(0);' onclick='reiewOrder("+index+")'>审核</a> ";
			} else if (row.status == '<%=HmitUtil.ORDER_STATUS_CONFIRMED%>') {
				return "<a href='javascript:void(0);' onclick='confirmArrived("+index+")'>确认到货</a> ";
			} else if (row.status == '<%=HmitUtil.ORDER_STATUS_ARRIVED%>') {
				return "<a href='javascript:void(0);' onclick='confirmPay("+index+")'>确认付款</a> ";
			} else if (row.status == '<%=HmitUtil.ORDER_STATUS_PAYED%>') {
				return "<a href='javascript:void(0);' onclick='confirmInv("+index+")'>确认开票</a> ";
			} else {
				return '<%=HmitUtil.ORDER_STATUS_INVED%>';
				
			}
			

	}
	}
	]],
	toolbar: [
         
	{
		text : "编辑",
		iconCls : "icon-edit",
		handler : function() {
			var rows = $("#dg").datagrid('getSelections');
			if (rows.length < 1) {
				$.messager.alert('操作提示', '请选择要修改的行', 'warning');
			} else if(rows[0].status== '<%=HmitUtil.ORDER_STATUS_NEW%>' || rows[0].status == null || rows[0].status == '<%=HmitUtil.ORDER_STATUS_ORDER%>'){
			 	if (editFlag != undefined) {
			 		$("#dg").datagrid('endEdit', editFlag);//结束编辑，传入之前编辑的行
			 	}
			 	if (editFlag == undefined) {
 			 		addeditor();
 			 	  //var e = $("#dg").datagrid('getColumnOption', 'supId');
 			 		addeditor1();
					var rows = $("#dg").datagrid('getSelections');
					var index = $("#dg").datagrid('getRowIndex', rows[0]);
					$("#dg").datagrid('beginEdit', index);
					editFlag = index;
					
			 	}	
			}else{
				if (editFlag != undefined) {
			 		$("#dg").datagrid('endEdit', editFlag);//结束编辑，传入之前编辑的行
			 	}
			 	if (editFlag == undefined) {
			 		deleteeditor();
					var rows = $("#dg").datagrid('getSelections');
					var index = $("#dg").datagrid('getRowIndex', rows[0]);
					
					$("#dg").datagrid('beginEdit',index);
					editFlag = index;
					//$('#dg').datagrid('getEditor', { index: index, field: 'payRemarks' }).disabled();
			 	}	
			}
		}
	},"-",
	{
	 	text: "保存",
	 	iconCls: "icon-save",
	 	handler: function () {
	 		$("#dg").datagrid('endEdit', editFlag);
	 	}
	},"-",
	{
		text : "撤销",
		iconCls : "icon-redo",
		handler : function() {
			$("#dg").datagrid('rejectChanges');
			editFlag = undefined;
		}
	},"-", 
	{
		text : "进项发票信息",
		iconCls : "icon-print",
		handler : function() {
			 $('#inv').dialog("open").dialog('setTitle', '添加付款信息');
		}
	}
	          
	          
	],
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
	//获取所有的项目
	$('#proId2').combobox({   

	      url:'<%=basePath%>getProjectAllNameList',

	      valueField:'id',

	      textField:'proName',
	      
	      editable : false,
	      
	      method : 'get',
	  });
	$('#supId').combobox({   

	      url:'<%=basePath%>getSupplierList',

	      valueField:'supId',

	      textField:'supName',
	      
	      editable : false,
	      
	      method : 'get',
	  });
	$("#dg").datagrid('hideColumn','ordId');//隐藏属性

	$("#dg").datagrid('hideColumn','proId');
	});	

function editpay(index) {
	$("#dg").datagrid('selectRow',index);
    var row = $('#dg').datagrid("getSelected");
    if (row) {
        $('#dlg').dialog("open").dialog('setTitle', '添加付款信息');
        $('#fm').form("load", row);
    }
}
//进阶确认
function saveChange(index) {
	$("#dg").datagrid('selectRow',index);
	//$("#dg").datagrid('endEdit', editFlag);
	var row = $("#dg").datagrid('getSelected');
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
    					$("#dg").datagrid('reload');
    				}
    			},
    			error : function() {
    				$.messager.alert('操作提示', '服务器出错', 'error');
    			}	
    		});
    	}
	});
}
//审核
function reiewOrder(index) {
	$("#dg").datagrid('selectRow',index);
	var row = $("#dg").datagrid('getSelected');
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
	    					$("#dg").datagrid('reload');
	    				}
	    			},
	    			error : function() {
	    				$.messager.alert('操作提示', '服务器出错', 'error');
	    			}	
	    		}); 
		 }
	 });
}
//确认到货
function confirmArrived(index) {
	$("#dg").datagrid('selectRow',index);
	var row = $("#dg").datagrid('getSelected');
	if (editFlag != undefined) {
		$.messager.alert('操作提示', '您尚未保存', 'warning');
		return;
	}
	var data = encodeURI(JSON.stringify(row),"UTF-8");
	$.messager.defaults = { ok: "是", cancel: "否" };  
	 $.messager.confirm("操作提示","请业务经理确认，是否继续?" , function (d) {  
		 if(d) {
	    		$.ajax({
	    			url : '<%=basePath%>updateOrderStatus',
	    			data : 'data=' + data + '=' + '<%=HmitUtil.ORDER_STATUS_ARRIVED%>',
	    			dataType : 'json',
	    			type : 'post',
	    			success : function(r) {
	    				if(r) {
	    					$.messager.alert('操作提示', r.msg, r.result);
	    					$("#dg").datagrid('reload');
	    				}
	    			},
	    			error : function() {
	    				$.messager.alert('操作提示', '服务器出错', 'error');
	    			}	
	    		}); 
		 }
	 });
}
//确认付款
function confirmPay(index) {
	if (editFlag != undefined) {
		$.messager.alert('操作提示', '您尚未保存', 'warning');
		return;
	}  
			 editpay(index);  
}
//确认开票
function confirmInv(index) {
	$("#dg").datagrid('selectRow',index);
	var row = $("#dg").datagrid('getSelected');
	if (editFlag != undefined) {
		$.messager.alert('操作提示', '您尚未保存', 'warning');
		return;
	}
	var data = encodeURI(JSON.stringify(row),"UTF-8");
	 $.messager.confirm("操作提示","请业务员确认开票，是否继续?" , function (d) {  
		 if(d) {
	    		$.ajax({
	    			url : '<%=basePath%>updateOrderStatus',
	    			data : 'data=' + data + '=' + '<%=HmitUtil.ORDER_STATUS_INVED%>',
	    			dataType : 'json',
	    			type : 'post',
	    			success : function(r) {
	    				if(r) {
	    					$.messager.alert('操作提示', r.msg, r.result);
	    					$("#dg").datagrid('reload');
	    				}
	    			},
	    			error : function() {
	    				$.messager.alert('操作提示', '服务器出错', 'error');
	    			}	
	    		}); 
		 }
	 });
}
function getSupplierList(url) {
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
//动态增加editor

function addeditor1(){
	
	$("#dg").datagrid('addEditor',{
		field:'supId',
		editor: {//设置其为可编辑
			type: 'combobox',
			options: {
			valueField : 'supId',
			editable: false,
			textField : 'supName',
			data : Suplist,
			required: true,
			filter : function(q,row) {
				var opts = $(this).combobox('options');
			return row[opts.textField].indexOf(q) > -1;
			},
			 onChange: function (newValue, oldValue) {
				 artchange = true;
		 },
			 onHidePanel: function () {
				 var t = $(this).combobox('getText');
				 if(artchange) {
				 if (selectRow == null || t != selectRow.supName) {
					 $(this).combobox('setText', '');
					 $(this).combobox('setValue', '');
					 }
				 }
	           artChanged = false;
	             selectRow = null;
		 },
			 onSelect : function(record) {
				 selectRow = record;
		}
			}
			}
	});
}

function addeditor(){
	//数量
	$("#dg").datagrid('addEditor',{
			field:'equNumber',
			editor:{
				type:'numberbox',
				options:{
					required:true
				}
			}
		});
	
	//销售单价
	$("#dg").datagrid('addEditor',{
			field:'sellPrice',
			editor:{
				type:'numberbox',
				options:{
					required:true
				}
			}
		});
	//销售总价
	$("#dg").datagrid('addEditor',{
			field:'sellTotalPrice',
			editor:{
				type:'numberbox',
				options:{
					required:true
				}
			}
		});
	
	//进货单价
	$("#dg").datagrid('addEditor',{
			field:'costUnitPrice',
			editor: {//设置其为可编辑
				type: 'numberbox',
				options: {
				required: true//设置编辑规则属性
				}
				}				
		});
	//进货总价
	$("#dg").datagrid('addEditor',{
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
function deleteeditor(){
	//数量
	$("#dg").datagrid('removeEditor','equNumber');
	$("#dg").datagrid('removeEditor','sellPrice');
	$("#dg").datagrid('removeEditor','sellTotalPrice');
	$("#dg").datagrid('removeEditor','supId');
	$("#dg").datagrid('removeEditor','costUnitPrice');
	$("#dg").datagrid('removeEditor','costPrice');
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
//添加付款到货信息
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
                    $('#dg').datagrid("load");
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
//清空
function clearSearch(){
	//$('#dg').datagrid("load", {});
	$('#orderTable').form("clear");
}
//查询
function searchOrder() {
		var data1 = sy.serializeObject($('#orderTable').form());
		 var data = encodeURI(JSON.stringify(data1),"UTF-8");
		 $('#dg').datagrid('load', data1);
}
</script>

<body class="easyui-layout">
	<div region="north" style="height: 100px; background: #F4F4F4;" class="easyui-tabs"  border="false">
		<div title="高级搜索">
			<form id="orderTable">
				<table id="orderTable" class="customerTable datagrid-toobar"
					style="width: 75%; height: 100%">
					<tr>
						<th>设备名称:</th>
						<td><input id="brand" class="easyui-validatebox" type="text" name="equName"></td>
					
                        <th>厂商:</th>
						<td><input id="supId" type="text"
				style="width: 145px;" class="easyui-combobox" name="supId"  editable="false" />
					</tr>
					<tr>
						<th>项目名称:</th>
						<td><input id="proId2" type="text"
				style="width: 145px;" class="easyui-combobox" name="proId"  editable="false" />
                        <th>状态:</th>
						<td><input class="easyui-validatebox" id="brand" type="text" name="status"></td>
						<td><a class="easyui-linkbutton" onclick="searchOrder();">查找</a></td>
						<td><a class="easyui-linkbutton" onclick="clearSearch();">清空</a></td>
					</tr>

				</table>

			</form>
		</div>
	</div>
	<div id="g" region="center" style="margin-top: 3px;" >
		<table id="dg">
		</table>
	</div>

    <div id="dlg" class="easyui-dialog"
		style="width: 400px; height: 280px; padding: 10px 20px;" closed="true"
		buttons="#dlg-buttons">
		<form id="fm" method="post">
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


</body>
</html>
