<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<base href="<%=basePath%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="themes/icon.css">
<link rel="stylesheet" type="text/css" href="themes/demo.css">
<script type="text/javascript" src="jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>
<script type="text/javascript" src="locale/easyui-lang-zh_CN.js"></script>
<style type="text/css">
#fm {
	margin: 0;
	padding: 10px 30px;
}

.ftitle {
	font-size: 14px;
	font-weight: bold;
	padding: 5px 0;
	margin-bottom: 10px;
	border-bottom: 1px solid #ccc;
}

.fitem {
	margin-bottom: 5px;
}

.fitem label {
	display: inline-block;
	width: 80px;
}
</style>
<script type="text/javascript">
	$(function() {
		window.emplist = getempList('<%=basePath%>getProBrokeragList');
		$('#dg').datagrid(
						{
							loadMsg : '数据加载中请稍后',
							url : '<%=basePath%>getAllSupplier', //请求方法的地址
			title : '供应商信息',
			nowrap : false, //文字自动换行
			fitColumns : true, //列自适应
			pagination : true, //底部显示分页工具栏
			fit : true,
			pageSize:10,
			pageList:[3,5,10],
			rownumbers : true, // 当true时显示行号 
			singleSelect : true, // 只允许当前选择一行
			iconCls : 'icon-save',
			idField : 'id', //标识列
			columns : [ [ {

			 			field: 'supId', title: '编号', width: 80
//			  			editor: {//设置其为可编辑
//			  			type: 'validatebox',//设置编辑样式 自带样式有：text，textarea，checkbox，numberbox，validatebox，datebox，combobox，combotree 可自行扩展
//			  			options: {}
//			  			}    
			 	 },{
				title : '供应商名',
				field : 'supName',
				editor : 'text',
				align : 'center',
				width : 50
			}, {
				title : '主要联系人',
				field : 'contactPersonName',
				editor : 'text',
				align : 'center',
				width : 50
			}, {
				title : '联系电话',
				field : 'contact',
				editor : 'text',
				align : 'center',
				width : 50
			}, {
				title : '地址',
				field : 'address',
				editor : 'text',
				align : 'center',
				width : 50
			}, {
				title : '业务代表',field : 'empId',align : 'center',width : 50,
				/*
				editor: {//设置其为可编辑
					type: 'validatebox',
					options: {
					valueField : 'empId',
					textField : 'empName',
					data : emplist,
					required: true,
					}
					},
					*/
					formatter:  function(value,row,index) {
						for(var i=0; i<emplist.length; i++){
							if(emplist[i].empId == value){
								return emplist[i].empName;
							}
						}
					}
				
				
				
			}, 
			 {
				title : '应付款',
				field : 'totalPaymentAmount',
				editor : 'text',
				align : 'center',
				width : 50
			},
			{	
				title:'操作',
			    field:'id',
			    width:50,
			    formatter:  function(value,row,index) {		
				return "<a href='javascript:void(0);' onclick='editpay("+index+")'>付款详情</a> ";
			}
		}
						
			] ],
			toolbar : [ {
				id : 'btnAdd',
				text : '添加',
				iconCls : 'icon-add',
				handler : function() {
					addSupplier('add');
				}
			}, '-', {
				id : 'btnEdit',
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					editSupplier('edit');
				}
			}, '-', {
				id : 'btnDel',
				text : '删除',
				iconCls : 'icon-cancel',
				handler : function() {
					deleteSupplier();
				}
			}, '-' ],
		});
		 $('#empName').combobox({   

		      url:'<%=basePath%>getProBrokeragList',

		      valueField:'empId',

		      textField:'empName',
		      
		      editable : false,
		      
		      method : 'get',
		  });
		 
		 $('#empName1').combobox({   

		      url:'<%=basePath%>getProBrokeragList',

		      valueField:'empId',

		      textField:'empName',
		      
		      editable : false,
		      
		      method : 'get',
		  });
		 $("#dg").datagrid('hideColumn','supId');
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
	
	function editpay(index) {
		//$("#dg").datagrid('selectRow',index);
	    //var row = $('#dg').datagrid("getSelected");
	    //if (row) {
	        $('#inv').dialog("open").dialog('setTitle', '付款详细信息');
	     //   $('#dg1').form("clear"); 
	        $("#dg").datagrid('selectRow',index);
	        var row = $('#dg').datagrid("getSelected");
	   	    $('#dg1').datagrid('load', row);
	    //}
	    
		 
	}
	function searchSupplier() {
		var data1 = sy.serializeObject($('#supplierTable').form());
		 var data = encodeURI(JSON.stringify(data1),"UTF-8");
		 $('#dg').datagrid('load', data1);
// 		 $.ajax({
//     		 url : url,
//     		 data : 'data=' + data,
//     		 dataType : 'json',
//     		 type : 'post',
//     		 success : function(result) {
//                  if (result) {
//                 	 $('#dg').datagrid('loadData', { total: 0, rows: [] });
//                 	 $('#dg').datagrid('loadData',{});
//                  }
//                  else {
//                      $.messager.alert("提示信息", "操作失败");
//                  }
//     		 },
//     		 error : function() {
    			 
//     		 }
//     	 });
	}
	
	function clearSearch(){
		$('#dg').datagrid("load", {});
		$('#supplierTable').form("clear");
	}
	
    var url;
    var type;
    function addSupplier() {
        $('#dlg').dialog("open").dialog('setTitle', '添加供应商信息'); 
        $('#fm').form("clear");    
    }
    function editSupplier() {
        var row = $('#dg').datagrid("getSelected");
        if (row) {
            $('#dlg').dialog("open").dialog('setTitle', '修改供应商信息');
            $('#fm').form("load", row);
        }
    }
    function saveSupplier() {	
    	 var data1 = sy.serializeObject($('#fm').form());
    	 var data = encodeURI(JSON.stringify(data1),"UTF-8");  	 
    	 var title = $('#dlg').panel('options').title;
    	 if (title.indexOf('添加') >=0) {
    		 url = '<%=basePath%>addSupplier';
    	 } else {
    		 var row = $('#dg').datagrid("getSelected");
    		 url = '<%=basePath%>editSupplier?supId=' + row.supId;
    	 }
    	 $.ajax({
    		 url : url,
    		 data : 'data=' + data,
    		 dataType : 'json',
    		 type : 'post',
    		 success : function(result) {
                 if (result) {
                     $.messager.alert("提示信息", result.msg);
                     $('#dlg').dialog("close");
                     $('#dg').datagrid("load");
                 }
                 else {
                     $.messager.alert("提示信息", "操作失败");
                 }
    		 },
    		 error : function() {
    			 
    		 }
    	 });
    }
    function deleteSupplier() {
        var row = $('#dg').datagrid('getSelected');
      
                if (row) {
                	$.ajax({
                		url:'<%=basePath%>deleteSupplier?supId=' + row.supId,
                		dataType : 'json',
                		type : 'post',
                		success : function(result){
                            if (result) {
                                $('#dg').datagrid('reload');
                                $.messager.alert("提示信息", result.msg);
                            } else {
                            	$.messager.alert("提示信息", "操作失败");
                            
                		
                		
                	}   
                }
            });
        }
    }
    function getempList(url) {
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
</script>
</head>
<body class="easyui-layout">
	
    <div region="north" style="height: 120px; background: #F4F4F4;" class="easyui-tabs"  border="false">
			<div title="供应商信息查询" fit="true" border='false'>
				<form id="supplierTable">
				<table id="supplierTable" class="supplierTable datagrid-toobar"
					style="width: 100%; height: 100%">
					<tr>
						<th>供应商名称:</th>
						<td><input id="supName" type="text" class="easyui-validatebox textbox" name="supName"/></td>
						<th>主要联系人:</th>
						<td><input id="contactPersonName" class="easyui-validatebox" type="text" name="contactPersonName"/></td>
						<th>联系电话:</th>
						<td><input id="contact" class="easyui-validatebox" type="text" name="contact"/></td>
					</tr>
					<tr>
						<th>地址:</th>
						<td><input id="address" class="easyui-validatebox"
							type="text" name="address"/></td>
						<th>经手人:</th>
						<td><input id="empName" type="text" class="easyui-combobox"
							name="empName" editable="false" /></td>
					</tr>
					<tr>
						<td colspan="2"><a class="easyui-linkbutton"
							icon="icon-search" href="javascript:void(0);"
							onclick="searchSupplier();">查找</a> <a id="clearBtn"
							class="easyui-linkbutton" icon="icon-cancel"
							href="javascript:void(0);" onclick="clearSearch();">重置</a></td>
					</tr>
				</table>
				</form>
			</div>
		</div>
	
	 <div id="g" region="center" style="margin-top: 3px;" >
		<table id="dg" class="easyui-datagrid" style="height: 350px;" title="Customer">
		</table>
	</div>


	<div id="dlg" class="easyui-dialog"
		style="width: 400px; height: 280px; padding: 10px 20px;" closed="true"
		buttons="#dlg-buttons">
		<form id="fm" method="post">
			<div class="fitem">
				<label> 供应商名称 </label> <input name="supName"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label> 客户联系人</label> <input name="contactPersonName"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label> 联系电话</label> <input name="contact"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label> 地址</label> <input name="address" class="easyui-validatebox"
					required="true" />
			</div>
			<div class="fitem">
				<label> 经手人</label> <input id="empName1" type="text"
					class="easyui-combobox" name="empId" editable="false" />
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="saveSupplier();" iconcls="icon-save">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#dlg').dialog('close')" iconcls="icon-cancel">取消</a>
	</div>
<div id="inv" class="easyui-dialog"
		style="width:420px; height:370px; padding: 10px 20px;" closed="true"
		buttons="#inv-buttons">
		<div style="width:320px; height:270px; padding: 10px 20px;">
		<table id="dg1" class="easyui-datagrid" style="height:300px;"
			title="">
		</table>
		
	</div>
		<script type="text/javascript">
			$('#dg1').datagrid({    
				url: '<%=basePath%>getPayInfo', 
        	//title : '供应商信息',
			nowrap : false, //文字自动换行
			fitColumns : true, //列自适应
			pagination : true, //底部显示分页工具栏
			fit : true,
			pageSize:10,
			pageList:[3,5,10],
			rownumbers : true, // 当true时显示行号 
			singleSelect : true, // 只允许当前选择一行	
			iconCls : 'icon-save',
			idField : 'id', //标识列 
			columns : [ [ {
				title : '设备名称',
				field : 'equName',
				editor : 'text',
				align : 'center',
				width : 60
			}, {
				title : '设备数量',
				field : 'equNumber',
				editor : 'text',
				align : 'center',
				width : 60
			}, {
				title : '进货总价',
				field : 'costPrice',
				editor : 'text',
				align : 'center',
				width : 60
			}, {
				title : '应付款',
				field : 'payables',
				editor : 'text',
				align : 'center',
				width : 60
			}
			] ]
});

			</script>

		<div id="inv-buttons">
 <a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#inv').dialog('close')" iconcls="icon-cancel">取消</a>
	</div>
	
	</div>
</body>
</html>