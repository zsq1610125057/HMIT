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
		window.rolelist = getroleList('<%=basePath%>getRoleTypeList');
		$('#dg').datagrid(
						{
							loadMsg : '数据加载中请稍后',
							url : '<%=basePath%>getAllEmployee', //请求方法的地址
			title : '员工信息',
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
				field: 'empId', title: '编号', width: 80,hidden : 'true'
//	  			editor: {//设置其为可编辑
//	  			type: 'validatebox',//设置编辑样式 自带样式有：text，textarea，checkbox，numberbox，validatebox，datebox，combobox，combotree 可自行扩展
//	  			options: {}
//	  			}    
	 	 },{
				title : '员工名称',
				field : 'empName',
				editor : 'text',
				align : 'center',
				width : 50
			}, {
				title : '注册日期',
				field : 'regDate',
				editor : 'text',
				align : 'center',
				width : 50
			}, {
				title : '最后登录日期',
				field : 'lastLoginDate',
				editor : 'text',
				align : 'center',
				width : 50
			}, {
				title : 'email',
				field : 'email',
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
				title : '登录名',
				field : 'loginName',
				editor : 'text',
				align : 'center',
				width : 50
				
			}, {
				title : '角色',
				field : 'roleId',
				editor : 'text',
				align : 'center',
				width : 50,
				formatter:  function(value,row,index) {
					for(var i=0; i<rolelist.length; i++){
						if(rolelist[i].id == value){
							return rolelist[i].name;
						}
					}
				}
			
			}, {
				title : '职位',
				field : 'title',
				editor : 'text',
				align : 'center',
				width : 50
		}, 
			] ],
			toolbar : [ {
				id : 'btnAdd',
				text : '添加',
				iconCls : 'icon-add',
				handler : function() {
					addEmployee('add');
				}
			}, '-', {
				id : 'btnEdit',
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					editEmployee('edit');
				}
			}, '-', {
				id : 'btnDel',
				text : '删除',
				iconCls : 'icon-cancel',
				handler : function() {
					deleteEmployee();
				}
			}, '-' ],
		});
		 $('#RoleType').combobox({   

		      url:'<%=basePath%>getRoleTypeList',

		      valueField:'id',

		      textField:'name',
		      
		      editable : false,
		      
		      method : 'get',
		  });
		 $('#RoleType1').combobox({   

		      url:'<%=basePath%>getRoleTypeList',

		      valueField:'id',

		      textField:'name',
		      
		      editable : false,
		      
		      method : 'get',
		  });
		 
		 $('#title').combobox({   

		      url:'<%=basePath%>gettitleList',

		      valueField:'empId',

		      textField:'title',
		      
		      editable : false,
		      
		      method : 'get',
		      
		  });
		 $('#title1').combobox({   

		      url:'<%=basePath%>gettitleList',

		      valueField:'empId',

		      textField:'title',
		      
		      editable : false,
		      
		      method : 'get',
		      
		  });
			$("#dg").datagrid('hideColumn','RoleId');//隐藏属性

			$("#dg").datagrid('hideColumn','empId');
	});
	
    function getroleList(url) {
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
	
	
	function searchEmployee() {
		var data1 = sy.serializeObject($('#employeeTable').form());
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
		$('#employeeTable').form("clear");
	}
	
    var url;
    var type;
    function addEmployee() {
        $('#dlg').dialog("open").dialog('setTitle', '添加员工信息'); ;
        $('#fm').form("clear");    
    }
    function editEmployee() {
        var row = $('#dg').datagrid("getSelected");
        if (row) {
            $('#dlg').dialog("open").dialog('setTitle', '修改员工信息');
            $('#fm').form("load", row);
        }
    }
    function saveEmployee() {	
    	 var data1 = sy.serializeObject($('#fm').form());
    	 var data = encodeURI(JSON.stringify(data1),"UTF-8");  	 
    	 var title = $('#dlg').panel('options').title;
    	 if (title.indexOf('添加') >=0) {
    		 url = '<%=basePath%>addEmployee';
    	 } else {
    		 var row = $('#dg').datagrid("getSelected");
    		 url = '<%=basePath%>editEmployee?empId=' + row.empId;
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
    function deleteEmployee() {
        var row = $('#dg').datagrid('getSelected');
      
                if (row) {
                	$.ajax({
                		url:'<%=basePath%>deleteEmployee?empId=' + row.empId,
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
			<div title="员工信息查询" >
			<form id="employeeTable">
				<table id="employeeTable" class="employeeTable datagrid-toobar"
					style="width: 100%; height: 100%">	
					<tr>
						<th>角色类型:</th>
						<td><input id="RoleType" type="text" class="easyui-combobox"
							name="RoleType" editable="false" /></td>
							<th>职位属性:</th>
						<td><input id="title" type="text" class="easyui-combobox"
							name="title" editable="false" /></td>
					</tr>
					<tr>
						<td colspan="2"><a class="easyui-linkbutton"
							icon="icon-search" href="javascript:void(0);"
							onclick="searchEmployee();">查找</a> <a id="clearBtn"
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
				<label> 员工名称 </label> <input name="empName"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label> email</label> <input name="email"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label> 联系电话</label> <input name="contact"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label> 登录名</label> <input name="loginName" class="easyui-validatebox"
					required="true" />
			</div>
			<div class="fitem">
				<label> 角色</label> <input id="RoleType1" type="text"
					class="easyui-combobox" name="roleId" editable="false" />
			</div>
			<div class="fitem">
				<label> 职位</label> <input id="title1" type="text"
					class="easyui-combobox" name="title" editable="false" />
			</div>
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="saveEmployee();" iconcls="icon-save">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="javascript:$('#dlg').dialog('close')" iconcls="icon-cancel">取消</a>
	</div>

</body>
</html>