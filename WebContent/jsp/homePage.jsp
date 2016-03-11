<%@page import="com.util.HmitUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<base href="<%=basePath%>">
<head>
<title></title>
<link href="css/default.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="themes/icon.css" />

<script type="text/javascript" src="jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src='jquery/outlook2.js'> </script>
<script type="text/javascript" src="jquery/jquery.easyui.min.js"></script>



<script type="text/javascript">
	 var _menus = {"menus":[
						{"menuid":"1","icon":"icon-sys","menuname":"项目管理",
							"menus":[
									{"menuname":"新建项目","icon":"icon-role","url":"project/newproject.jsp"},
									{"menuname":"项目跟踪","icon":"icon-edit","url":"project/traceproject.jsp"},
									{"menuname":"新建招标项目","icon":"icon-edit","url":"project/tenderproject.jsp"},
									{"menuname":"项目付款记录","icon":"icon-edit","url":"project/payproject.jsp"},
								]
						},{"menuid":"2","icon":"icon-sys","menuname":"采购管理",
							"menus":[{"menuname":"采购管理","icon":"icon-nav","url":"project/order.jsp"},
							         {"menuname":"项目信息管理","icon":"icon-nav","url":"project/project.jsp"},
									{"menuname":"供应商管理","icon":"icon-nav","url":"project/supplier.jsp"}
								]
						},{"menuid":"3","icon":"icon-sys","menuname":"客户管理",
							"menus":[{"menuname":"客户管理","icon":"icon-nav","url":"customer/customer.jsp"},
								]
						},{"menuid":"4","icon":"icon-sys","menuname":"员工管理",
							"menus":[{"menuname":"员工管理","icon":"icon-nav","url":"employee/employee.jsp"},
								]
						},{"menuid":"5","icon":"icon-sys","menuname":"发票管理",
							"menus":[{"menuname":"发票管理","icon":"icon-nav","url":"invoice/invoice.jsp"},
								]
						},{"menuid":"6","icon":"icon-sys","menuname":"合同管理",
							"menus":[{"menuname":"合同管理","icon":"icon-nav","url":"contract/contract.jsp"},
								]
						},{"menuid":"7","icon":"icon-sys","menuname":"报表",
							"menus":[{"menuname":"项目报表","icon":"icon-nav","url":"#"},
									{"menuname":"营业额报表","icon":"icon-nav","url":"#"},
									{"menuname":"采购报表","icon":"icon-nav","url":"#"}	
								]
						},{"menuid":"8","icon":"icon-sys","menuname":"设置",
							"menus":[{"menuname":"权限设置","icon":"icon-nav","url":"#"},
									{"menuname":"个人信息设置","icon":"icon-nav","url":"#"}
								]
						}]};
	 
        //设置登录窗口
        function openPwd() {
            $('#w').window({
                title: '修改密码',
                width: 300,
                modal: true,
                shadow: true,
                closed: true,
                height: 160,
                resizable:false,
            });
        }
        //关闭登录窗口
        function close() {
            $('#w').window('close');
        }

        function closeLogin() {
        	close();
        }
    	function ProInfo(index) {
	        $('#inv').dialog("open").dialog('setTitle', '到期项目详情');
	        $("#p11").datagrid('selectRow',index);
	        var row = $('#p11').datagrid("getSelected");
	   	    $('#dg1').datagrid('load', row);   
		 
	}
        //修改密码
        function serverLogin() {
            var $newpass = $('#txtNewPass');
            var $rePass = $('#txtRePass');

            if ($newpass.val() == '') {
                msgShow('系统提示', '请输入密码！', 'warning');
                return false;
            }
            if ($rePass.val() == '') {
                msgShow('系统提示', '请在一次输入密码！', 'warning');
                return false;
            }

            if ($newpass.val() != $rePass.val()) {
                msgShow('系统提示', '两次密码不一至！请重新输入', 'warning');
                return false;
            }
             url='<%=basePath%>editpassword?newpass=' + $newpass.val();
        
             $.post(url,null, function(result) {
            	 var name=result.msg;
            	 var name1=result.Result;
            	 
               if(name != name1){
            	msgShow('系统提示', '恭喜，密码修改成功！<br>您的新密码为：' + result.msg, 'info');                
               }else{
            	   msgShow('系统提示', '修改失败！！', 'info');     	   
               }
               $newpass.val('');
               $rePass.val('');
               close();
            },'json');
           
            
        }
        
		function detail() {
			//$("#p11").panel('refresh','<%=basePath%>jsp/loginPage.jsp');
		    var currTab =  self.parent.$('#tabs').tabs('getSelected'); //获得当前tab
		    //var url = $(currTab.panel('options').content).attr('src');
		    self.parent.$('#tabs').tabs('update', {
		      tab : currTab,
		      options : {
		       content : createFrame('<%=basePath%>jsp/loginPage.jsp')
		      }
		     });
		}
        $(function() {
            openPwd();
            //
            $('#editpass').click(function() {
                $('#w').window('open');
            });

            $('#btnEp').click(function() {
                serverLogin();
            });

           

            $('#loginOut').click(function() {
                $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {

                    if (r) {
                    	<%session.removeAttribute("current_user");%>
                        location.href = 'jsp/loginPage.jsp';
                    }
                });

            });
			
//             $('#p11').panel({
//                 title: '到期账款',
//                 width: 400,
//                 modal: false,
//                 iconCls : 'icon-ok',
//                 shadow: true,
//                 height: 250,
//                 draggable:false,
//                 resizable:false,
//             });
			
<%--             var options = {
            	    title: "到期账款",
            	    iconCls: 'icon-ok',
            	    href : '<%=basePath%>getMaturityMoneyList',
			tools : [ [ {
				iconCls : 'icon-add',
				handler : function() {
					alert('add');
				}
			}, {
				iconCls : 'icon-edit',
				handler : function() {
					alert('edit');
				}
			} ] ]

		}; --%>
	//	$("#p11").panel(options);

		//init datagrid

	});
</script>

</head>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
	<noscript>
		<div
			style="position: absolute; z-index: 100000; height: 2046px; top: 0px; left: 0px; width: 100%; background: white; text-align: center;">
			<img src="images/noscript.gif" alt='抱歉，请开启脚本支持！' />
		</div>
	</noscript>
	<div region="north" split="true" border="false"
		style="overflow: hidden; height: 30px; background: url(images/layout-browser-hd-bg.gif) #7f99be repeat-x center 50%; line-height: 20px; color: #fff; font-family: Verdana, 微软雅黑, 黑体">
		<span style="float: right; padding-right: 20px;" class="head">你好， <%=HmitUtil.CURRENT_USER%> 
			<a href="javascript:void(0)" id="editpass">修改密码</a> <a
			href="javascript:void(0)" id="loginOut">安全退出</a></span> <span
			style="padding-left: 10px; font-size: 16px;"><img
			src="images/blocks.gif" width="20" height="20" align="absmiddle" />
			宁波汇民CRM</span>
	</div>
	<div region="south" split="true"
		style="height: 30px; background: #D2E0F2;">
		<div class="footer">By 宁波汇民科技有限有限公司 Email:ming.liu@nbhmit.com</div>
	</div>
	<div region="west" split="true" title="导航菜单" style="width: 150px;"
		id="west">
		<div class="easyui-accordion" fit="true" border="false">
			<!--  导航内容 -->

		</div>

	</div>

	<div id="mainPanle" region="center"
		style="background: #eee; overflow-y: hidden">
		<div id="tabs" class="easyui-tabs" fit="true" border="false">
			<div title="欢迎使用" style="padding: 20px; overflow: hidden;" id="home"
				fit="true">

				<div style="margin: 0 auto; width: 100%;">
					<table cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td width="250">

								  <div style="width: 290px; height:520px;margin-right: 5px; margin-left: 2px;">
									<div id="p11" class="easyui-panel" title="" style="height:380px;overflow-x: visible;" data-options="">
									</div>
									<script type="text/javascript">	
								    $('#p11').datagrid({
								    	url:'<%=basePath%>getMaturityMoneyList',
								    	title:"到期账款",
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
											title : '项目名称',
											field : 'proName',
											editor : 'text',
											align : 'center',
											width : 60,
											hidden: 'true'	
										},{
											title : '项目Id',
											field : 'id',
											editor : 'text',
											align : 'center',
											hidden : 'true',
											width : 60
											
										},{
											title:'项目名称',
											field:'id1',
											width:50,
											formatter:  function(value,row,index) {		
												return "<a href='javascript:void(0);' onclick='ProInfo("+index+")'>"+row.proName+"</a> ";
											}
										}
										]]
								    })
									</script>
										<ul id="guoqi" style="margin-top: 10px;">
										</ul>
									</div>
								</div> <!-- 				    <div style="width:250px; margin-top: 5px;margin-right: 5px;margin-left: 10px;"> -->
								<!-- 				       <div id="dbsx" class="easyui-panel" title="待办事项"      -->
								<!-- 						        style="height:190px;"    --> <!-- 						        data-options="">    -->
								<!-- 						        <ul id="dbsx" style="margin-top:10px;"> --> <!-- 						        </ul> -->
								<!-- 					  </div> --> <!-- 				    </div> -->

							</td>
							<td>
								<div style="margin-right: 10px;">
							<div style="margin-right: 12px; width:700px; height:270px; padding: 10px 20px;">
									<div id="qgd" class="easyui-datagrid" title="近期项目"
										style="height: 260px;" data-options="iconCls:'icon-ok'">	
									</div>
									 <script type="text/javascript">
		    window.customerlist = getCustomerList('<%=basePath%>getCustomerList');
			$('#qgd').datagrid({    
				url: '<%=basePath%>getNowProject', 
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
				title : '项目名称',
				field : 'proName',
				editor : 'text',
				align : 'center',
				width : 60
			}, {
				title : '项目金额',
				field : 'proMoney',
				editor : 'text',
				align : 'center',
				width : 60
			}, {
				title : '项目经手人',
				field : 'proBrokerage',
				editor : 'text',
				align : 'center',
				width : 60
			}, {
				title : '项目开始时间',
				field : 'beginDate',
				editor : 'text',
				align : 'center',
				width : 60
			}, {
				title : '客户公司',
				field : 'cusId',
				editor : 'text',
				align : 'center',
				width : 60,
				formatter:  function(value,row,index) {
					for(var i=0; i<customerlist.length; i++){
						if(customerlist[i].cusId == value){
							return customerlist[i].compName;
						}
					}
				}
				
			}
			] ]
});

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
								</div>
								<div style="margin-top: 5px; margin-right: 12px;width: 700px; height:220px;padding: 10px 20px;">
	                                <div id="cygj" class="easyui-datagrid" title="近期招标项目"
										style="height: 2125px;" data-options="iconCls:'icon-ok'">	
									</div>
									 <script type="text/javascript">
			$('#cygj').datagrid({    
				url: '<%=basePath%>getTenderProject', 
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
				title : '招标项目',
				field : 'tdProject',
				editor : 'text',
				align : 'center',
				width : 60
			}, {
				title : '招标负责人',
				field : 'tdEmployee',
				editor : 'text',
				align : 'center',
				width : 60
			}, {
				title : '招标时间',
				field : 'tdDate',
				editor : 'text',
				align : 'center',
				width : 60
			}, {
				title : '招标地点',
				field : 'tdPlace',
				editor : 'text',
				align : 'center',
				width : 60
			}, {
				title : '客户公司',
				field : 'comName',
				editor : 'text',
				align : 'center',
				width : 60,

				
			}
			] ]
});



			</script>
										
										</ul>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

	</div>

	<!--修改密码窗口-->
	<div id="w" class="easyui-window" title="修改密码" collapsible="false"
		minimizable="false" maximizable="false" icon="icon-save"
		style="width: 300px; height: 150px; padding: 5px; background: #fafafa;">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false"
				style="padding: 10px; background: #fff; border: 1px solid #ccc;">
				<table cellpadding=3>
					<tr>
						<td>新密码：</td>
						<td><input id="txtNewPass" type="Password" class="txt01" /></td>
					</tr>
					<tr>
						<td>确认密码：</td>
						<td><input id="txtRePass" type="Password" class="txt01" /></td>
					</tr>
				</table>
			</div>
			<div region="south" border="false"
				style="text-align: right; height: 30px; line-height: 30px;">
				<a id="btnEp" class="easyui-linkbutton" icon="icon-ok"
					href="javascript:void(0);"> 确定</a> <a id="cancel"
					class="easyui-linkbutton" icon="icon-cancel"
					href="javascript:void(0);" onclick="closeLogin()">取消</a>
			</div>
		</div>
	</div>

	<div id="mm" class="easyui-menu" style="width: 150px;">
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseall">全部关闭</div>
		<div id="mm-tabcloseother">除此之外全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-tabcloseright">当前页右侧全部关闭</div>
		<div id="mm-tabcloseleft">当前页左侧全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-exit">退出</div>
	</div>
   <div id="inv" class="easyui-dialog"
		style="width:460px; height:350px;" closed="true"
		buttons="#inv-buttons">
		<div style="width:440px; height:270px; ">
		<table id="dg1" class="easyui-datagrid" style="height:300px;"
			title="">
		</table>
		
	</div>
		<script type="text/javascript">
			$('#dg1').datagrid({    
				url: '<%=basePath%>getProInfo', 
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
				title : '项目名称',
				field : 'proName',
				editor : 'text',
				align : 'center',
				width : 60
			}, {
				title : '项目金额',
				field : 'proMoney',
				editor : 'text',
				align : 'center',
				width :   60
			}, {
				title : '项目经手人',
				field : 'proBrokerage',
				editor : 'text',
				align : 'center',
				width :  60
			}, {
				title : '项目竣工时间',
				field : 'completionDate',
				editor : 'text',
				align : 'center',
				width :   60
			}, {
				title : '客户公司',
				field : 'cusId',
				editor : 'text',
				align : 'center',
				width :   60,
				hidden : 'true',
				
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