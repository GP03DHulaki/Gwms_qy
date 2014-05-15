<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.scm.ColoSizeMB"%>
<%
//需要有来源单号和物料编号来保存信息
			String soid = request.getParameter("soid");
			ColoSizeMB ai = (ColoSizeMB) MBUtil.getManageBean("#{coloSizeMB}");
			if(request.getParameter("time") != null) {
			if(soid==null||soid.equals("")) {
				out.print("参数错误");
				return;
			}
			if(request.getParameter("soid")!=null) {
				ai.setSoid(request.getParameter("soid"));
			}
			}
			
	%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="search" />
		<title>规格规格码表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
		<style type="text/css">
#select{border:1px solid ##009933; }
#select td{width:30px;height:30px;display:block;background-color:#C7DCED;cursor:pointer}
</style>
<script>
is_IE = (navigator.appName == "Microsoft Internet Explorer");
function init(){clearAll();
 var table = document.getElementById('select');
 //得到所有表格
 var tds =  table.getElementsByTagName("td");
 //注册点击事件
 for(var i=0;i<tds.length;i++){
	 addEvent(tds[i],"click",tdclick);
	 }
 
 //初始化选中
 var data = $("edit:data").value;
 ids = data.split(",");
 for(var i=0;i<ids.length;i++){
	var select = document.getElementById(ids[i]);
	tdclick(select);
 }
}
var tdclick = function (obj){
	if(is_IE) {
		//选中的规格
		var bgColor = "#fed0c3";
		var nowColor = obj.style.backgroundColor;
		if(nowColor.toLowerCase()==bgColor) {
			obj.setAttribute("selected",false);
			obj.style.backgroundColor="#C7DCED";
		}
		else {
			//选中
			obj.setAttribute("selected",true);
			obj.style.backgroundColor=bgColor;
		}
	}
	else {
		var bgColor = "rgb(254, 208, 195)";
		var nowColor = obj.style.backgroundColor;
		if(nowColor==bgColor) {obj.setAttribute("selected",false);
			obj.style.backgroundColor="#C7DCED";
		}
		else {obj.setAttribute("selected",true);
			obj.style.backgroundColor=bgColor;
		}
	}
}

function addEvent(obj,event,func){
	var hand = function(obj){
		return function(){
			func(obj)
		}
	}
	if(is_IE){
		obj.attachEvent('on'+event,hand(obj));
	}
	else {
		obj.addEventListener(event,hand(obj),false);
	}
}
function save(){
	var table = document.getElementById('select');
 //得到所有表格
 	var tds =  table.getElementsByTagName("td");
 	var data='';
 	for(var i=0;i<tds.length;i++) {
 		if(tds[i].getAttribute('selected')==true){
 			data = data+tds[i].id+",";
 		}
 	}
 	$("edit:data").value=data;
 	return true;
}
function endSave() {
	clearAll();
	var data = $("edit:data").value;
 	ids = data.split(",");
 	for(var i=0;i<ids.length;i++){
		var select = document.getElementById(ids[i]);
		tdclick(select);
 	}
	var msg = $("edit:msg").value;
	alert(msg);
}
function clearAll(){
	var table = document.getElementById('select');
 //得到所有表格
 	var tds =  table.getElementsByTagName("td");
 	for(var i=0;i<tds.length;i++) {
 		tds[i].setAttribute("selected",false);
 		tds[i].style.backgroundColor="#C7DCED";
 	}
}
function resetTable() {clearAll();
	var data = $("edit:data").value;
	var table = document.getElementById('select');
 	var tds =  table.getElementsByTagName("td");
 	ids = data.split(",");
 	for(var i=0;i<ids.length;i++){
	var select = document.getElementById(ids[i]);
	tdclick(select);
 }
}
</script>
	</head>
	<body id=mmain_body onLoad="init()">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" onclick="save()" oncomplete="endSave()"
							id="sid" value="保存" type="button" action="#{coloSizeMB.save}"
							reRender="renderArea" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="reset" value="重置" type="button" onclick="resetTable()"
							reRender="output" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="clear" value="清空" type="button" onclick="clearAll()"
							reRender="output" requestDelay="50" />
					</div>
					<div id=mmain_free>
<table id="select" align="center">
<tr>
	<td id="0_0">空</td>
	<t:dataList var="color" value="#{coloSizeMB.allColor}">
		<td id="<h:outputText value="#{color.id}"/>_0"><h:outputText value="#{color.cona}" /></td>
	</t:dataList>
</tr>
<t:dataList var="size" value="#{coloSizeMB.allSize}">
<tr>
	<td id="0_<h:outputText value="#{size.id}" />"><h:outputText value="#{size.szna}" /></td>
	<t:dataList var="color" value="#{coloSizeMB.allColor}">
		<td id="<h:outputText value="#{color.id}"/>_<h:outputText value="#{size.id}" />"></td>
	</t:dataList>
</tr>
</t:dataList>
</table>
</div>
<div style="display: none;">
<a4j:outputPanel id="renderArea">
<h:inputHidden id="msg" value="#{coloSizeMB.msg}"></h:inputHidden>
<h:inputHidden id="data" value="#{coloSizeMB.data}"></h:inputHidden>
</a4j:outputPanel>
</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>