<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.common.InvclassCOM"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%
InvclassCOM ai = (InvclassCOM) MBUtil.getManageBean("#{invclassCOM}");
if (request.getParameter("time") != null) {
	ai.initSK();
}
if (request.getParameter("retid") != null) {
	ai.setRetid(request.getParameter("retid"));
}
if (request.getParameter("retname") != null) {
	ai.setRetname(request.getParameter("retname"));
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>款类选择</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<link rel="stylesheet" type="text/css" href="GwallJS/Gtree/style.css"></link>
  		<script type="text/javascript" src="GwallJS/Gtree/GtreeCode.js"></script>
 <script type="text/javascript">
function select1(){
	retid = $('edit:retid').value;
    retname = $('edit:retname').value;
    try{
	var  id=Gtree.treeList['tree'].selectedID;
	var name=document.getElementById("lb_"+id).innerText;}
    catch(err){alert('未选中节点！');return}
    var nodevalue=$('edit:nodevalue');
	if(!nodevalue||nodevalue.value==''){
		alert('未选中节点！');return;
	}
	var isGwin = Gwin && document.GwinID;//是否Gwin方式弹出.
		if(isGwin === false){
			is_IE = (navigator.appName == "Microsoft Internet Explorer");
			var callBack = null;  
			if(is_IE) {
				callBack = window.dialogArguments;
			}
			else {
				if (window.opener.callBack == undefined) {   
					window.opener.callBack = window.dialogArguments;   
				}   
				callBack = window.opener.callBack;   
			}
		}
		if ( retid != "" && retid != null){
    		isGwin ? parent.document.getElementById(retid).value = id : callBack.document.getElementById(retid).value=id;
		}
		if ( retname != "" && retname != null){
			isGwin ? parent.document.getElementById(retname).value = name : callBack.document.getElementById(retname).value=name;
		}
		//将nodevalue返回给被调用的页面，父页面必须包含edit:perfix元素
		try{isGwin ? parent.document.getElementById("edit:prefix").value = nodevalue.value : callBack.document.getElementById("edit:prefix").value=nodevalue.value;}catch(err){}
		
		isGwin ? Gwin.close(document.GwinID) : window.close();	
}

Gtree.fninitend = function(){
	Gtree.treeList["tree"].fnclicknode = function( id, isfiles, obj ){
		$('edit:nodevalue').value=obj.value;
		select1();
	}
}
function openbase(){
	top.window.autoOpenTree("BASE","invclass");
}
 </script>
	</head>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="确定" type="button" onclick="select1()"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="刷新" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but" />
						<a4j:commandButton type="button" value="添加" onclick="openbase()"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<div id=mmain_free>
						<div id="tree" class="Gtree" type="Gtree" edit=true autoclose=false data="treeJson.jsp"></div>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{invclassCOM.retid}" />
						<h:inputHidden id="retname" value="#{invclassCOM.retname}" />
						<h:inputHidden id="nodevalue" value="" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>