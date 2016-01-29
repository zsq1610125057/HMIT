<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<%String path = request.getContextPath(); 
      String basePath = request.getScheme()+"://"+ request.getServerName()+":"+request.getServerPort()+path+"/";%>
<base href="<%=basePath%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<script type="text/javascript">
$(function(){
	$('#changedate').val(getCurrentDate());
	
	  $('#configType').combobox({   

		      url:'<%=basePath%>getConfigType',

		      valueField:'id',   

		      textField:'name',
		      
		      editable : false,
		      
		      method : 'get',
		      
		      onSelect : function(record) {
		    	  if (record.name == '配置文件') {
		    		  $('#configFileRow').show();
		    	  } else {
		    		  $('#configFileRow').hide();
		    	  }
		      }

		  }); 
	
});

function getCurrentDate() {
	var d = new Date();
	var year = d.getFullYear();
	var month = d.getMonth()+1;
	var day = d.getDate();	
	return month + "/" + day + "/" + year;
}


</script>
<form id="form" method="post" enctype="multipart/form-data">
	<div region="center" border="false"
		style="padding: 10px; background: #fff; border: 1px solid #ccc;">
		<table>
			<tr>
				<td>更换类型 :</td>
				<td><input id="configType" class="easyui-combobox"
					style="width: 100px"></td>
			</tr>
			<tr>
				<td>更换时间 ：</td>
				<td><input id="changedate" class="easyui-datebox"
					style="width: 100px" /></td>
			</tr>
			<tr>
				<td>更换原因 :</td>
				<td><textarea id="reason"></textarea></td>
			</tr>
			<tr>
				<td>更换详情：</td>
				<td><textarea id="detail"></textarea></td>
			</tr>
			<tr id="configFileRow" style="display: none">
				<td><input id="file" name="file" type="file"
					style="width: 60px;"
					onchange="document.getElementById('configFile').value=this.value" /></td>
				<td><input id="configFile" name="configFile"
					class="easyui-validatebox" type="text" style="width: 126px;"
					required="true" disabled="disabled" prompt="请选择网络配置文件" /></td>
			</tr>
		</table>


	</div>
	<div region="south" border="false"
		style="text-align: right; height: 30px; line-height: 30px;">

		<a id="btnSave" class="easyui-linkbutton" icon="icon-ok"
			href="javascript:void(0);"> 保存</a> <a id="cancel"
			class="easyui-linkbutton" icon="icon-cancel"
			href="javascript:void(0);" onclick="closeLogin()">取消</a>
	</div>
</form>
</html>