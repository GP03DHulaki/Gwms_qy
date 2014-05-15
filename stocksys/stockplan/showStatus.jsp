<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.StockPlanMB"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ taglib uri="http://www.gwall.cn" prefix="gw"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%
	String id = "";
	StockPlanMB ai = (StockPlanMB) MBUtil.getManageBean("#{stockPlanMB}");
	if (request.getParameter("pid") != null) {
		id = request.getParameter("pid");
		ai.getMbean().setBiid(id);
	}
	ai.getVouch();
%>
<head>

	<title>查看盘点状态</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="查看盘点状态">
	<meta http-equiv="description" content="查看盘点状态">
	<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/gwall/all.css">
	<script type='text/javascript'
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
	<script type="text/javascript" src="stockplan.js"></script>

</head>
  
<body id="mmain_body">
	<div id="mmain_nav">
	<font color="#000000">库内处理&gt;&gt;盘点&gt;&gt;盘点计划&gt;&gt;</font><b>盘点状态</b><br>
	</div>
 <div>
	<f:view>
	 <h:form id="edit">
	 	<div id=mmain_opt>
			<a4j:outputPanel id="queryButs" rendered="#{stockPlanMB.LST}">
				<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
					onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
					reRender="output,queryForm" action="#{stockPlanMB.searchTimes}" />
				<gw:GAjaxButton value="重置" theme="a_theme"
					onclick="textClear('edit','stat');" />
			</a4j:outputPanel>
		</div>
	 <a4j:outputPanel id="queryForm" rendered="#{stockPlanMB.LST}">
		<div id="mmain_cnd">
			盘点次数:
			<h:selectOneMenu id="stat" value="#{stockPlanMB.stat}" onchange="doSearch();">
				<f:selectItem itemLabel="全部" itemValue=""/>
				<f:selectItem itemLabel="未盘" itemValue="0"/>
				<f:selectItem itemLabel="已盘" itemValue="1"/>
				<f:selectItem itemLabel="复盘" itemValue="2"/>
			</h:selectOneMenu>
			&nbsp;&nbsp;&nbsp;
			<gw:GAjaxButton value="复盘"  theme="a_theme" action="#{stockPlanMB.repeatCheck}" reRender="renderArea"
					onclick="if(!repeatCheck('gtable')){return false;}" oncomplete="endRepeatCheck()" rendered="#{stockPlanMB.stat>=1}" />
		</div>
	</a4j:outputPanel>
		<a4j:outputPanel id="output">
		<g:GTable gid="gtable" gtype="grid" gdebug="false"
			gselectsql="
				 select a.id, a.biid,a.whid,a.usid,a.stat,w.whna,u.usna, 
				 CASE WHEN (select sum(aa.fqty)-sum(aa.qty) from pmde aa where aa.biid ='#{stockPlanMB.mbean.biid}') <> 0 THEN '有差异' ELSE '无' END AS pptt				 
				 from pwci a 
				 left join waho w on a.whid = w.whid
				 left join usin u on u.usid = a.usid  
				 Where a.biid ='#{stockPlanMB.mbean.biid}'#{stockPlanMB.selKey}"
				gpage="(pagesize = -1)" gversion="2"
				gcolumn="
						gcid=id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
						gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
						gcid = whid(headtext = 库位编码,name = whid,width = 80,align = center,type = text,datatype = string);
						gcid = whna(headtext = 库位名称,name = whna,width = 100,align = center,type = text,datatype = string);
						gcid = usid(headtext = 盘点人编码,name = usid,width = 90,align = center,type = text,datatype = string);
						gcid = usna(headtext = 盘点人姓名,name = usna,width = 90,align = center,type = text,datatype = string);
						gcid = stat(headtext = 盘点次数,name = usna,width = 90,align = center,type = text,datatype = string);
						gcid = stat(headtext = 盘点次数,name = usna,width = 90,align = center,type = text,datatype = string);
						gcid = pptt(headtext = 盘点差异,name = pptt,width = 90,align = center,type = text,datatype = string);
					" />
		</a4j:outputPanel>
		<div style="display: none;">
			<a4j:outputPanel id="renderArea">
				<h:inputHidden id="msg" value="#{stockPlanMB.msg}" />
				<h:inputHidden id="sellist" value="#{stockPlanMB.sellist}" />
			</a4j:outputPanel>
		</div>
	</h:form>
	</f:view>
	</div>
</body>
</html>