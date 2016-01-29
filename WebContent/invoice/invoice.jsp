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
		window.prolist = getproList('<%=basePath%>getProjectAllNameList');
		$('#dg').datagrid(
						{
							loadMsg : '数据加载中请稍后',
							url : '<%=basePath%>getAllInvoice', //请求方法的地址
			title : '发票信息',
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
				field: 'invId', title: '编号', width: 80
//	  			editor: {//设置其为可编辑
//	  			type: 'validatebox',//设置编辑样式 自带样式有：text，textarea，checkbox，numberbox，validatebox，datebox，combobox，combotree 可自行扩展
//	  			options: {}
//	  			}    
	 	 },{
				title : '开票金额',
				field : 'invMoney',
				editor : 'text',
				align : 'center',
				width : 50
			}, {
				title : '开票内容',
				field : 'invContent',
				editor : 'text',
				align : 'center',
				width : 50
			}, {
				title : '开票类型',
				field : 'invType',
				editor : 'text',
				align : 'center',
				width : 50
			}, {
				title : '开票日期',
				field : 'invDate',
				editor : 'text',
				align : 'center',
				width : 50
			}, {
				title : '项目名称',
				field : 'proId',
				editor : 'text',
				align : 'center',
				width : 50,
				formatter:  function(value,row,index) {
					for(var i=0; i<prolist.length; i++){
						if(prolist[i].id == value){
							return prolist[i].proName;
						}
					}
				}
			}
			] ],
			
		});
		 $('#proName').combobox({   

		      url:'<%=basePath%>getProjectAllNameList',

		      valueField:'id',

		      textField:'proName',
		      
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
	
	
	function searchInvoice() {
		var data1 = sy.serializeObject($('#invoiceTable').form());
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
	
	function clearInvoice(){
		$('#dg').datagrid("load", {});
		$('#invoiceTable').form("clear");
	}
	
    var url;
    var type;
   
   
    function getproList(url) {
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
			<div title="发票信息查询" >
			<form id="invoiceTable">
				<table id="invoiceTable" class="invoiceTable datagrid-toobar"
					style="width: 90%; height: 100%">
					<tr>
						<th>开票类型:</th>
						<td><input id="invType" type="text" class="easyui-validatebox textbox" name="invType"/></td>
						<th>开票日期:</th>
						<td><input id="invDate" class="easyui-datebox" type="text" name="invDate"/></td>
						
					</tr>
					<tr>
					
						<th>项目名称:</th>
						<td><input id="proName" type="text" class="easyui-combobox"
							name="proName" editable="false" /></td>
						<th>开票金额:</th>
						<td><input id="beginMoney" class="easyui-validatebox"
							type="text" name="beginMoney"/></td>
							<td>至<input id="endMoney" class="easyui-validatebox"
							type="text" name="endMoney"/></td>
						
					</tr>
					<tr>
						<td colspan="2"><a class="easyui-linkbutton"
							icon="icon-search" href="javascript:void(0);"
							onclick="searchInvoice();">查找</a> <a id="clearBtn"
							class="easyui-linkbutton" icon="icon-cancel"
							href="javascript:void(0);" onclick="clearInvoice();">重置</a></td>
					</tr>
				</table>
				</form>
			</div>
		</div>

    <div id="g" region="center" style="margin-top: 3px;" >
		<table id="dg" class="easyui-datagrid" style="height: 350px;" title="Invoice">
		</table>
	</div>


	

</body>
</html>