<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.base.ScmInveMB"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>规格码列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="GwallJS/Gtree/style.css"></link>
		<script type="text/javascript" src='<%=request.getContextPath()%>/gwall/all.js'></script>
<style type="text/css">
#mmain_free .element{line-height: 14px;vertical-align: middle;margin: 0 5px 3px}
#mmain_free .element img{height:12px;cursor: pointer;}
</style>
<script type="text/javascript">
function add() {
	showModal('selectsize.jsf?retid=edit:colo&retname=edit:cona',"","450px",parent.document,document.GwinID);
}
function del(id) {
	document.getElementById("mmain_free").removeChild(document.getElementById(id.id));
	var data = hcolodata.innerHTML;
	data = data.split(";");
	var newdata ="";
	for(var i=0;i<data.length;i++) {
		var colo =  data[i].split(":");
		if(colo!=""&&colo[0]!=id.id) {
			newdata+=colo[0]+":"+colo[1]+";";
		}
	}
	hcolodata.innerHTML=newdata;
}
function save(){
	parent.document.getElementById("edit:sizelist").value = hcolodata.innerHTML;
	Gwin.close(document.GwinID);
}
function init(){
	var list = parent.document.getElementById("edit:sizelist").value;
	hcolodata.innerHTML=list;
	list = list.split(";");
	var data="";
	for(var i=0;i<list.length;i++) {
		var colo =  list[i].split(":");
		if(colo!=""){
			data += "<span class='element' id="+colo[0]+">"+colo[1]+"<img src='delete.gif' title='删除' onclick='del("+colo[0]+")'/></span>"
		}
	}
	mmain_free.innerHTML = data;
}
</script>
	</head>
	<body id=mmain_body onload="init()">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="添加" type="button" onclick="add()"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="保存并返回" onclick="save();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_free>
						
					</div>
					<div id="hcolodata" style="display: none;"></div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>