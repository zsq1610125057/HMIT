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
<style type="text/css">
.datagrid-row{height: 50px;}

</style>
<script type="text/javascript">
var editFlag = undefined;
var artchange = false;
var selectRow;
$(function (){
	window.cuslist = getCustomerList('<%=basePath%>getCustomerList');
	
	$("#dg").datagrid({
	url: "<%=basePath%>getProject1", //指向一个一般处理程序或者一个控制器，返回数据要求是Json格式，直接赋值Json格式数据也可，我以demo中自带的Json数据为例，就不写后台代码了，但是我会说下后台返回的注意事项
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
			field: 'ifInv', title: '是否开发票', width: 80,hidden : 'true' 
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
	field: 'paymoney', title: '已付款', width: 50
	},
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

			if (row.ifInv == '0'&&(row.proMoney-row.payMoney)!=0) {	
				return "<a href='javascript:void(0);' onclick='saveProInv("+index+")'>添加发票</a><br><a href='javascript:void(0);' onclick='payProHis("+index+")'>添加付款信息</a> ";
			} else if (row.ifInv == '1'&&(row.proMoney-row.payMoney)!=0) {
				return "<a href='javascript:void(0);' onclick='addpayProHis("+index+")'>添加付款信息</a> ";
			}else if (row.ifInv == '0'&&(row.proMoney-row.payMoney)==0) {
				return "<a href='javascript:void(0);' onclick='saveProInv("+index+")'>添加发票</a> ";
			}else {
				 return "<a href='javascript:void(0);' onclick='lookpayProHis("+index+")'>查看付款信息</a> ";
				
			}
	}
	}
	]],
	onAfterEdit: function (rowIndex, rowData, changes) {
		editFlag = undefined;
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
	 $('#empName1').combobox({   

	      url:'<%=basePath%>getPaywayList',

	      valueField:'PWName',

	      textField:'PWName',
	      
	      editable : false,
	      
	      method : 'get',
	  });
	//加载表格
		$('#dg1').datagrid(
				{
					loadMsg : '数据加载中请稍后',
					
					url : '<%=basePath%>getproPayHistory', //请求方法的地址
	title : '',
	nowrap : false, //文字自动换行
	fitColumns : true, //列自适应
	pagination : true, //底部显示分页工具栏
	fit : true,
	pageSize:10,
	pageList: [10, 20, 30],
	rownumbers : true, // 当true时显示行号 
	singleSelect : true, // 只允许当前选择一行
	iconCls : 'icon-save',
	idField : 'id', //标识列
	columns : [ [ {
		field: 'pHId', title: '编号', width: 80,hidden : 'true'
//			editor: {//设置其为可编辑
//			type: 'validatebox',//设置编辑样式 自带样式有：text，textarea，checkbox，numberbox，validatebox，datebox，combobox，combotree 可自行扩展
//			options: {}
//			}    
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
	},{
		title:'付款备注',
		field:'payRemarks',
		editor : 'text',
		align : 'center',
		width : 100
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

function saveProInv(index) {
	$("#dg").datagrid('selectRow',index);
	//$("#dg").datagrid('endEdit', editFlag);
	var row = $("#dg").datagrid('getSelected');
	var data = encodeURI(JSON.stringify(row),"UTF-8");
	 $('#inv').dialog("open").dialog('setTitle', '添加发票信息');
	  $('#inv').form("load", row);
}
function addpayProHis(index) {
	$("#dg").datagrid('selectRow',index);
	//$("#dg").datagrid('endEdit', editFlag);
	var row = $("#dg").datagrid('getSelected');
	var data = encodeURI(JSON.stringify(row),"UTF-8");
	var inv=getCustomerList('<%=basePath%>getproinv?proId='+row.proId);
	//document.getElementById('1').valueOf(inv.invId);	
   $('#1').text(inv[0].invId);
   $('#2').text(inv[0].invMoney);
   $('#3').text(inv[0].invContent);
   $('#4').text(inv[0].invDate);
   $('#5').text(inv[0].remainingSum);
	 $('#pro').dialog("open").dialog('setTitle', '添加付款信息');
	 $('#dg1').datagrid("load",row);
	  $('#proTable').form("load", row);
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
//添加发票信息
function saveInv() {	
	 var data1 = sy.serializeObject($('#inv-fm').form());
	 var data = encodeURI(JSON.stringify(data1),"UTF-8");  	  
	 $.ajax({
			url : '<%=basePath%>addproInvoice',
			data : 'data=' + data,
			dataType : 'json',
			type : 'post',
			success : function(r) {
				if(r) {
					$.messager.alert('操作提示', r.msg, r.result);
					$('#inv').dialog("close");
                    $('#dg').datagrid("load");
				}
			},
			error : function() {
				$.messager.alert('操作提示', '服务器出错', 'error');
			}	
		}); 
}
//添加收款信息
function saveprohistoye() {	
	 var data1 = sy.serializeObject($('#proTable').form());
	 var data = encodeURI(JSON.stringify(data1),"UTF-8");  	  
	 $.ajax({
			url : '<%=basePath%>saveprohistoye',
			data : 'data=' + data,
			dataType : 'json',
			type : 'post',
			success : function(r) {
				if(r) {
					$.messager.alert('操作提示', r.msg, r.result);
                    $('#dg1').datagrid("load",data1);
                    $('#dg').datagrid("load");
				}
			},
			error : function() {
				$.messager.alert('操作提示', '服务器出错', 'error');
			}	
		}); 
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
		<table id="dg">
		</table>
	</div>
    <div id="inv" class="easyui-dialog"
		style="width: 320px; height: 270px; padding: 10px 20px;" closed="true"
		buttons="#inv-buttons">
		<form id="inv-fm" method="post">
		    <div class="fitem" style="display: none;">
				<label >　发票号:</label> <input name="proId"
					class="easyui-validatebox" style="width: 140px;" required="true" />
			</div>
		    <div class="fitem">
				<label>项目名称:</label> <input id="proName" type="text"
				style="width: 140px;" class="easyui-validatebox" name="proName"  editable="false" />
			</div>
			<div class="fitem">
				<label >　发票号:</label> <input name="invId"
					class="easyui-validatebox" style="width: 140px;" required="true" />
			</div>
			<div class="fitem" >
				<label >开票金额:</label> <input id="proMoney" type="text" min="1" max="10000000"
							precision="2" required="true" missingMessage="非法金额"
							class="easyui-numberbox" style="width: 140px;" name="proMoney"/>
			</div>
			<div class="fitem" >
				<label >尾款金额:</label> <input id="remainingSum" type="text" min="1" max="10000000"
							precision="2" required="true" missingMessage="非法金额"
							class="easyui-numberbox" style="width: 140px;" name="remainingSum"/>
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
    <div id="pro" class="easyui-dialog" style="width: 800px; height: 500px;" closed="true" buttons="#pro-buttons">
        <div id="pro2"  buttons="#pro2-buttons">
			<form id="proTable1">
				<table id="proForm1" class="proTable1 datagrid-toobar"
					style="width: 100%; height: 100%;background-color: #b9d8f3">
					<tr>
						<th>发票id:</th><td id="1" style="width: 50px"></td>
						<th>开票金额:</th><td id="2" style="width: 50px"></td>
						<th>开票内容:</th><td id="3" style="width: 50px"></td>
						<th>开票时间:</th><td id="4" style="width: 50px"></td>				
						<th>尾款：</th><td id="5" style="width: 50px"></td>
					</tr>

			</table>
			</form>
		</div>
		<div id="pro1"  buttons="#pro1-buttons">
			<form id="proTable">
				<table id="proForm" class="proTable datagrid-toobar"
					style="width: 100%; height: 100%">
					<tr>
						<th>项目id:</th>
						<td><input id="proId" type="text"
							class="text" name="proId" style="width: 50px;" readonly="readonly"></td>
							<th>项目名称:</th>
						<td><input id="proName" type="text"
							class="text" name="proName" style="width: 150px;" readonly="readonly"></td>
						<th>付款金额:</th>
						<td><input id="paidMoney" name="paidMoney" type="text" min="1" max="20000000" precision="2" required="true" missingMessage="非法金额"
							class="easyui-numberbox" /></td>
							</tr><tr>
						<th>付款时间:</th>
						<td><input id="paidDate" type="text"
							class="easyui-datebox" name="paidDate"
							style="width: 100px;" required="true" editable="false" /></td>				
						<th>付款方式：</th>
						<td><input id="empName1" type="text"
				style="width: 100px;" class="easyui-combobox" name="payWay" editable="false" /></td>
						<th>付款备注：</th>
						<td><input name="payRemarks"
					class="easyui-validatebox" style="width:200px;" required="true" /></td>
					</tr>

			</table>
			<div>
			<a class="easyui-linkbutton" onclick="saveprohistoye();">添加</a>
		</div>
			</form>
		</div>
		<div id="g1" region="center"  >
		<table id="dg1" class="easyui-datagrid" style="height: 320px;" >
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
