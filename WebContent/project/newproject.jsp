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
	$(function() {
		$('#dg').datagrid({
			url:'',
			title:'采购单',
			pagination : false,
			pageSize:4,
			pageList:[4,8],
			iconCls:'icon-save',
			rownumbers: true,
			singleSelect:true,
			fitColumns:true,
			idField:'id',
			showFooter: true,
			remoteSort: false,
			columns:[[
				{
					title:'设备名称',
					field:'equName',
					width:25	
					
				},
				{
					title:'设备描述',
					field:'equDescription',
					width:50
				},
				{
					title:'数量',
					field:'equNumber',
					width:15
				},
				{
					title:'销售单价',
					field:'sellPrice',
					width:25
				},
				
				{
					title:'销售总价',
					field:'sellTotalPrice',
					width:25
				},
				{
					title:'备注',
					field : 'remarks',
					width : 20
				},
				{
					title:'批发',
					field:'ifWholeSale',
					width:20,
					formatter : function(value,row,index) {
						if (value) {
							return "<img src='<%=basePath%>/themes/icons/ok.png'>";
						} else {
							return "<img src='<%=basePath%>/themes/icons/cancel.png'>";
						}
						
					}
				},
				{
					title:'操作',
					field:'operate',
					width:20,
					formatter:  function(value,row,index) {
						return "<a href='javascript:void(0);' onclick='deleteOrder("+index+");'>删除</a>";

				}}
			]]
	
		});	
		$('#dg').datagrid('hideColumn','remarks');
		  $('#customerComp').combobox({   

		      url:'<%=basePath%>getCustomerList',

		      valueField:'cusId',

		      textField:'compName',
		      
		      editable : true,
		      
		      method : 'get',
		      
		      required : true,
		      
		      onSelect : function(record) {
					$('#contactPerson').val(record.cusName);
					$('#contact').val(record.contact);
					$('#customerAdd').val(record.address);
					//$('#saler').val();
		      },
		      filter : function(q,row) {
		      		var opts = $(this).combobox('options');
		      		//alert(row[opts.textField].indexOf(q));
		      		return row[opts.textField].indexOf(q) > -1;
		      },
		      onHidePanel : function() {
		    	  var txt_Box = $("#customerComp").combobox('getText');
	              var listdata = $.data(this, "combobox");
	              var rowdata = listdata.data;
	                for (var i = 0; i < rowdata.length; i++) {
	                    var _row = rowdata[i];
	                    var txt_Val = _row["compName"];
	                    if (txt_Val.toLowerCase().indexOf(txt_Box.toLowerCase()) > -1) {
	                        $("#customerComp").combobox('setText', _row["compName"]);
	                        $("#customerComp").val(_row["compName"]);
	                        return;
	                    }
	                }
		      }

		  }); 
		  $('#proType').combobox({   

		      url:'<%=basePath%>getProjectTypeList',

		      valueField:'id',

		      textField:'name',
		      
		      editable : false,
		      
		      method : 'get',
		      

		  });
		  $('#proBrokerage').combobox({   

		      url:'<%=basePath%>getProBrokeragList',

		      valueField:'empName',

		      textField:'empName',
		      
		      editable : false,
		      
		      method : 'get',
		      

		  });
		  //供应商下拉框
		  $('#supId').combobox({   

		      url:'<%=basePath%>getSupplierList',

		      valueField:'supId',

		      textField:'supName',
		      
		      editable : false,
		      
		      method : 'get',
		      

		  });
		  $('#payWay').combobox({   

		      url:'<%=basePath%>getPayWayList',

		      valueField:'name',

		      textField:'name',
		      
		      editable : false,
		      
		      method : 'get',
		      

		  });
		$('#addOrderBtn').click(function(){
			
			if ($('#orderForm').form("validate")) {
// 				var price = $('#costUnitPrice').val();
// 				var number = $('#equNumber').val();
// 				var totalIn = $('#costPrice').val();
// 				var totalOut = $('#sellTotalPrice').val();
// 				if (totalIn != price*number) {
// 					$.messager.alert('操作提示', '进项总价有误', 'error');
// 					return;
// 				}
// 				if ((totalOut - totalIn) <= 0) {
// 					$.messager.alert('操作提示', '销项总价不得低于进项总价', 'error');
// 					return;
// 				}
				var data = sy.serializeObject($("#orderForm").form());
				//data.supName =  $('#supId').combobox('getText');
				
				var row = JSON.stringify(data);	
				$('#dg').datagrid('appendRow',JSON.parse(row));
				$('#orderForm').form("clear");
				$('#dg').datagrid('load');
				//$('#dg').datagrid({loadFilter:pagerFilter}).datagrid();
				
			}
		});
		
		$('#clearBtn').click(function() {
			$('#orderForm').form("clear");
		});
		$('#closePageBtn').click(function(){
			
			window.parent.$('#tabs').tabs('close','新建项目');
			
		});
		$('#saveProjectBtn').click(function() {
			if ($("#projectForm").form('validate') && $("#customerForm").form('validate')) {
				if ($('#ifMigAgent').is(':checked')) {
					$('#ifMigAgent').val("1");
				} else {
					$('#ifMigAgent').val("0");
				}
 				var dgData = $('#dg').datagrid('getData');
				var p = sy.serializeObject($("#projectForm").form());
				p.proType =  $('#proType').combobox('getText');
				var o = dgData.rows;
				var ordData = encodeURI(JSON.stringify(o),"UTF-8");
				var proData = encodeURI(JSON.stringify(p), "UTF-8");
				var cusId = $('#customerComp').combobox('getValue');
				console.info(cusId);
				$.ajax({
					type : "POST",
					dataType : "json",
					data : "data=" + proData+ '=' + ordData,
					url:"<%=basePath%>createNewProject?cusId="+ cusId,
					success:function(jr) {
						$.messager.alert('操作提示', jr.msg, jr.result);
						$("#projectForm").form('clear');  
						$("#customerForm").form('clear');
						$("#orderForm").form('clear');
			            var item = $('#dg').datagrid('getRows');
			            if (item) {
			                for (var i = item.length - 1; i >= 0; i--) {
			                    var index = $('#dg').datagrid('getRowIndex', item[i]);
			                    $('#dg').datagrid('deleteRow', index);
			                }
			            }
			            $('#dg').datagrid('loadData', { total: 0, rows: [] }); 
					},
					error:function() {
						 $.messager.alert('操作提示', '项目创建失败，请重试', 'error');
				}
			});
			}
			//var customer = $('#customerComp').combobox('getValue');

			
		});
		
// 		 var pager = $("#dg").datagrid("getPager"); 
// 	      pager.pagination({ 
// 	          total:$("#dg").datagrid("getData").length , 
// 	          onSelectPage:function (pageNo, pageSize) { 
// 	            var start = (pageNo - 1) * pageSize; 
// 	            var end = start + pageSize; 
// 	            $("#dg").datagrid("loadData", data.slice(start, end)); 
// 	            pager.pagination('refresh', { 
// 	              total:data.length, 
// 	              pageNumber:pageNo 
// 	            }); 
// 	          } 
// 	        }); 
});

function ifOrder() {
	//var i = $('#order').is(':checked');
	//var i = $("input:checkbox[name='order']:checked").val();
	if($('#order').is(':checked')) {
		$('#orderDiv').attr("disabled",true);
	} else {
	
	}
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

function clear(){
	$('#orderForm').form("clear");
	
}

function deleteOrder(index) {
	$('#dg').datagrid('deleteRow',index);
	$('#dg').datagrid('unselectAll');
	
}
// function pagerFilter(data){
// 	alert(data);
// 	  if (typeof data.length == 'number' && typeof data.splice == 'function'){
// 	      data = {
// 	          total: data.length,
// 	          rows: data,
// 	          originalTotal: data.length
// 	      }
// 	  }
// 	var dg = ('#dg').datagrid();
// 	var opts = dg.datagrid('options');
// 	var pager = dg.datagrid('getPager');
// 	pager.pagination({
// 		onSelectPage:function(pageNum, pageSize){
// 			opts.pageNumber = pageNum;
// 			opts.pageSize = pageSize;
// 			pager.pagination('refresh',{
// 				pageNumber:pageNum,
// 				pageSize:pageSize
// 			});
// 			dg.datagrid('loadData',data);
// 		}
// 	});
// 	if (!data.originalRows){
// 		data.originalRows = (data.rows);
// 	}
// 	var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
// 	var end = start + parseInt(opts.pageSize);
// 	data.rows = (data.originalRows.slice(start, end));
// 	return data;
// }
</script>
<body id="main" class="easyui-layout" style="width: 1000px; height: 570px;margin-top:-20px; overflow:visible" >
	
	<div region="north"  style="height: 90px; background: #F4F4F4;"  class="easyui-tabs"  border="false">
			<div title="客户">
			<form id="customerForm" >
				<table id="customerForm" class="customerTable datagrid-toobar"
					style="width: 100%; height: 100%">
					<tr>
						<th>客户公司:</th>
						<td><input id="customerComp" type="text"
							class="easyui-combobox" name="customerComp" style="width: 205px;"></td>
						<th>客户联系人:</th>
						<td><input id="contactPerson" class="easyui-validatebox"
							type="text" name="contactPerson" readonly="readonly"></td>
						<th>联系方式:</th>
						<td><input id="contact" type="text"
							class="easyui-validatebox" name="contact" readonly="readonly"></td>

					</tr>
					<tr>
						<th>客户地址：</th>
						<td><input id="customerAdd" type="text"
							class="easyui-validatebox" name="customerAdd"
							style="width: 200px;" readonly="readonly" /></td>
						<th>业务代表：</th>
						<td><input id="saler" type="text" name="saler"
							class="easyui-validatebox" readonly="readonly" /></td>
						<!-- 					<td><a class="easyui-linkbutton" href="javascript:void(0);" onclick="searchFunc();">查找</a></td> -->
						<!--                    	<td><a class="easyui-linkbutton" href="javascript:void(0);" onclick="clearSearch();">清空</a></td> 
						
						<td colspan="3"><a class="easyui-linkbutton" icon="icon-add"
							href="customer/customer.jsp" style="margin-left: 250px;">新增客户</a></td>
						<td><a class="easyui-linkbutton" icon="icon-cancel"
							href="javascript:void(0);">清除</a></td>
							-->
					</tr>

			</table>
</form>

			</div>
		</div>
		
    <div region="center"  style="height: 120px; background: #F4F4F4;"  class="easyui-tabs"  border="false">
         <div title="项目">
			<form id="projectForm">
				<table id="projectForm" class="customerTable datagrid-toobar">
					<tr>
						<th>项目名称:</th>
						<td><input id="proName" type="text"
							class="easyui-validatebox" maxlength="50" name="proName"
							required="true" style="width: 200px;"> <span
							style="color: red; margin-left: 2px;">*</span></td>
						<th>项目类型:</th>
						<td><input id="proType" class="easyui-combobox" type="text"
							name="proType" required="true" style="width: 100px;"><span
							style="color: red; margin-left: 5px;">*</span></td>
						<th>合同编号:</th>
						<td><input id="conId" type="text" class="easyui-validatebox"
							maxlength="20" name="conId" required="true" style="width: 100px;">
							<span style="color: red; margin-left: 2px;">*</span></td>
						<!-- 					<th>备注:</th> -->
						<!-- 					<td rowspan="2"><textarea id="remarks" name="remarks"></textarea></td> -->
						<th>执行时间:</th>
						<td><input id="beginDate" type="text" class="easyui-datebox"
							editable="false" required="true" name="beginDate"
							style="width: 105px;"><span
							style="color: red; margin-left: 2px;">*</span></td>
						<th>备注</th>
						<td rowspan="2"><textarea id="remarks" name="remarks"
								style="height: 48px;"></textarea></td>
					</tr>
					<tr>
						<th>项目金额:</th>
						<td><input id="proMoney" type="text" class="easyui-numberbox"
							min="1" max="10000000" precision="2" required="true"
							missingMessage="非法金额" name="proMoney" style="width: 200px;"><span
							style="color: red; margin-left: 5px;">*</span></td>

						<th>预收日期:</th>
						<td><input id="recevablesDate" type="text"
							class="easyui-datebox" name="recevablesDate"
							style="width: 100px;" required="true" editable="false" /><span
							style="color: red; margin-left: 5px;">*</span></td>
						<th>签订日期:</th>
						<td><input id="signDate" type="text" class="easyui-datebox"
							name="signDate" editable="false" required="true"
							style="width: 105px;"> <span
							style="color: red; margin-left: 2px;">*</span></td>
						<th>经手人:</th>
						<td><input id="proBrokerage" type="text"
							class="easyui-combobox" name="proBrokerage" required="true"
							style="width: 100px;"> <span
							style="color: red; margin-left: 2px;">*</span></td>

					</tr>
					<!--  
					<tr>

						<td colspan="2"><input type="checkbox" value="0"
							id="ifMigAgent" name="ifMigAgent" /><b>过单</b></td>
					</tr>
					-->
				</table>
			</form>
			</div>
         
			
			
			<!-- 		<div title="合同"> -->
			<!-- 			<table> -->


			<!-- 			</table> -->
			<!-- 		</div> -->
			<!-- 		<div title="发票"> -->
			<!-- 			<table> -->


			<!-- 			</table> -->
			<!-- 		</div> -->
		<!--  
			<div title="过单">
				<table>


				</table>
			</div>
			-->
</div>
	
	<div  region="south"  style=" height: 360px; background: #F4F4F4;"  class="easyui-tabs"  border="false">
	
			<div title="设备信息" border='false'>
			<form id="orderForm">
				<table id="orderTable" class="customerTable datagrid-toobar"
					>
					<tr>
						<th>设备名称:</th>
						<td><input id="equName" type="text"
							class="easyui-validatebox textbox" required="true" name="equName">
							<span style="color: red; margin-left: 2px;">*</span></td>
						<!-- 					<th>成本: </th> -->
						<!-- 					<td><input id="costUnitPrice" class="easyui-numberbox" type="text" min="1" max="10000000" precision="2" required="true" name="costUnitPrice"><span style="color: red;margin-left: 2px;">*</span></td>	 -->
						<th>数量:</th>
						<td><input id="equNumber" class="easyui-numberbox"
							type="text" required="true" name="equNumber" maxlength="3"><span
							style="color: red; margin-left: 2px;">*</span></td>
						<th>备注:</th>
						<td rowspan="2"><textarea id="remarks"
								class="easyui-validatebox" name="remarks" style="height: 48px;"
								placeholder="预计进货单位，价格描述"></textarea></td>
					</tr>
					<tr>
						<th>设备描述:</th>
						<td rowspan="2"><textarea id="equDescription"
								name="equDescription" style="height: 48px;"></textarea></td>

						<!-- 					<th>供应商: </th> -->
						<!-- 					<td><input id=supId type="text" class="easyui-combobox" required="true" style="width:138px;" name="supId" ><span style="color: red;margin-left: 5px;">*</span></td>	 -->

						<!-- 					<th>付款方式:</th> -->
						<!-- 					<td><input id="payWay" type="text" class="easyui-combobox" required="true" style="width:138px;" name="payWay"/><span style="color: red;margin-left: 5px;">*</span></td> -->
						<!-- 					<th>付款时间:</th> -->
						<!-- 					<td><input id="payDate" type="text" class="easyui-datebox" required="true" name="payDate" editable="false"/><span style="color: red;margin-left: 5px;">*</span></td> -->

						<!-- 					<td><a class="easyui-linkbutton" href="javascript:void(0);" onclick="searchFunc();">查找</a></td> -->
						<!--                    	<td><a class="easyui-linkbutton" href="javascript:void(0);" onclick="clearSearch();">清空</a></td> -->
						<th>销售单价:</th>
						<td><input id="sellPrice" type="text" min="1" max="10000000"
							precision="2" required="true" missingMessage="非法金额"
							class="easyui-numberbox" name="sellPrice"><span
							style="color: red; margin-left: 5px;">*</span></td>



					</tr>
					<tr>
						<td><input id="ifWholeSale" type="checkbox" value="1"
							name="ifWholeSale" /><b>批发</b></td>
						<th>销售总价:</th>
						<td><input id="sellTotalPrice" type="text" min="1"
							max="10000000" precision="2" required="true"
							missingMessage="非法金额" class="easyui-numberbox"
							name="sellTotalPrice"><span
							style="color: red; margin-left: 5px;">*</span></td>

					</tr>
					<tr>
						<td colspan="2"><a id="addOrderBtn" class="easyui-linkbutton"
							icon="icon-add" href="javascript:void(0);">新增采购单</a> <a
							id="clearBtn" class="easyui-linkbutton" icon="icon-cancel"
							href="javascript:void(0);" onclick="clear();">重置</a></td>
					</tr>
				</table>
				


		<div id="g" style="margin-top: 3px;" >
		<table id="dg" class="easyui-datagrid" style="height: 170px;" title="Customer">
		</table>
	</div>
		<div id="saveDive" align="center" style="margin-top: 10px;">

			<a id="saveProjectBtn" class="easyui-linkbutton" icon="icon-save"
				href="javascript:void(0);">保存</a>
			 <a id="closePageBtn" class="easyui-linkbutton" icon="icon-cancel"
				href="javascript:void(0);">关闭</a>
			

		</div>
	</form>
			</div>
	</div>
		

		
</body>
</html>