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
<body>
<script type="text/javascript">
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

 function saveTender() {	
    	 var data1 = sy.serializeObject($('#fm').form());
    	 var data = encodeURI(JSON.stringify(data1),"UTF-8");  	 
    		 url = '<%=basePath%>addTender';
    	 $.ajax({
    		 url : url,
    		 data : 'data=' + data,
    		 dataType : 'json',
    		 type : 'post',
    		 success : function(result) {
                 if (result) {
                     $.messager.alert("提示信息", result.msg);
                 }
                 else {
                     $.messager.alert("提示信息", "操作失败");
                 }
    		 },
    		 error : function() {
    			 
    		 }
    	 });
    }
 </script>
	<div id="dlg" style="width: 400px; height: 280px; margin-top:100px; margin-left:250px;padding: 10px 20px;text-align:center;" closed="true"
		buttons="#dlg-buttons">
<form id="fm" method="post">
			<div class="fitem" >
				<label> 招标项目 </label> <input name="tdProject"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label> 招标负责人</label> <input name="tdEmployee"
					class="easyui-validatebox" required="true" />
			</div>
			<div class="fitem">
				<label> 招标时间</label> <input name="tdDate" 
					class="easyui-datebox" editable="false" required="true" />
			</div>
			<div class="fitem">
				<label> 招标地点</label> <input name="tdPlace" class="easyui-validatebox"
					required="true" />
			</div>
			<div class="fitem">
				<label> 客户单位</label> <input name="comName" class="easyui-validatebox"
					required="true" />
			</div>
		</form>

</div>

	<div id="dlg-buttons" style="margin-top:-80px;text-align:center">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="saveTender();" iconcls="icon-save">提交</a> 
	</div>


</body>
</html>