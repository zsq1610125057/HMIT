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
		  window.customerlist = getCustomerList('<%=basePath%>getCustomerList');
		$('#dg').datagrid(
						{
							loadMsg : '数据加载中请稍后',
							url : '<%=basePath%>getContract', //请求方法的地址
			title : '合同信息',
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
				field: 'contId', title: '合同编号', width: 50
//	  			editor: {//设置其为可编辑
//	  			type: 'validatebox',//设置编辑样式 自带样式有：text，textarea，checkbox，numberbox，validatebox，datebox，combobox，combotree 可自行扩展
//	  			options: {}
//	  			}    
	 	 },{
				title : '客户名称',
				field : 'cusId',
				editor : 'text',
				align : 'center',
				width : 50,
				formatter:  function(value,row,index) {
					for(var i=0; i<customerlist.length; i++){
						if(customerlist[i].cusId == value){
							return customerlist[i].compName;
						}
					}
				}
			}, {
				title : '合同金额',
				field : 'contMoney',
				editor : 'text',
				align : 'center',
				width : 50
			}, {
				title : '签订时间',
				field : 'signDate',
				editor : 'text',
				align : 'center',
				width : 50
			}, {
				title : '归档时间',
				field : 'fileDate',
				editor : 'text',
				align : 'center',
				width : 50
			}
			] ],
			toolbar : [ {
				id : 'btnAdd',
				text : '添加',
				iconCls : 'icon-add',
				handler : function() {
					addContract('add');
				}
			}, '-', {
				id : 'btnEdit',
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					var rows = $("#dg").datagrid('getSelections');
					if (rows.length < 1) {
						$.messager.alert('操作提示', '请选择要修改的行', 'warning');
					} else{
						editContract('edit');
						}				
				}
			}, '-', {
				id : 'btnDel',
				text : '删除',
				iconCls : 'icon-cancel',
				handler : function() {
					var rows = $("#dg").datagrid('getSelections');
					if (rows.length < 1) {
						$.messager.alert('操作提示', '请选择要修改的行', 'warning');
					} else{
						deleteContract();
						}	
					
				}
			}, '-' ],
		});
		 $('#cusName').combobox({   

		      url:'<%=basePath%>getCustomerList',

		      valueField:'cusId',

		      textField:'compName',
		      
		      editable : false,
		      
		      method : 'get',
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
	
	
	function searchContract() {
		var data1 = sy.serializeObject($('#contractTable').form());
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
		$('#contractTable').form("clear");
	}
	
    var url;
    var type;
    function addContract() {
        $('#dlg').dialog("open").dialog('setTitle', '添加合同信息'); ;
        $('#fm').form("clear");    
    }
    function editContract() {
        var row = $('#dg').datagrid("getSelected");
        if (row) {
            $('#dlg').dialog("open").dialog('setTitle', '修改合同信息');
            $('#fm').form("load", row);
        }
    }
    function saveContract() {	
    	 var data1 = sy.serializeObject($('#fm').form());
    	 var data = encodeURI(JSON.stringify(data1),"UTF-8");  	 
    	 var title = $('#dlg').panel('options').title;
    	 if (title.indexOf('添加') >=0) {
    		 url = '<%=basePath%>addContract';
    	 } else {
    		 var row = $('#dg').datagrid("getSelected");
    		 url = '<%=basePath%>editContract?contId=' + row.contId;
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
    function deleteContract() {
        var row = $('#dg').datagrid('getSelected');
      
                if (row) {
                	$.ajax({
                		url:'<%=basePath%>deleteContract?contId=' + row.contId,
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
</script>
</head>
<body class="easyui-layout">
	
		<div region="north" style="height: 120px; background: #F4F4F4;" class="easyui-tabs"  border="false">
			<div title="合同信息查询" >
			<form id="contractTable">
				<table id="contractTable" class="contractTable datagrid-toobar"
					style="width: 90%; height: 100%">
					<tr>
						<th>合同编号:</th>
						<td><input id="contId" type="text" class="easyui-validatebox textbox" name="contId"/></td>
						<th>归档时间:</th>
						<td><input id="beginDate" class="easyui-datebox"
							type="text" name="beginDate"/></td>
							<td>至<input id="endDate" class="easyui-datebox"
							type="text" name="endDate"/></td>
					</tr>
	
					<tr>
						<td colspan="2"><a class="easyui-linkbutton"
							icon="icon-search" href="javascript:void(0);"
							onclick="searchContract();">查找</a> <a id="clearBtn"
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
				<label> 合同编号</label> <input name="contId"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label> 合同金额</label> <input name="contMoney"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label> 签订时间</label> <input name="signDate" class="easyui-datebox"
					required="true" />
			</div>
			<div class="fitem">
				<label> 归档时间</label> <input name="fileDate"
					class="easyui-datebox" required="true" />
			</div>
			<div class="fitem">
				<label>客户名称</label> <input id="cusName" type="text"
					class="easyui-combobox" name="cusId" editable="false" />
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="saveContract();" iconcls="icon-save">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#dlg').dialog('close')" iconcls="icon-cancel">取消</a>
	</div>

</body>
</html>