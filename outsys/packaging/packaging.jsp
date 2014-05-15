<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.PackagingMB"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>打包</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="打包">
	<meta http-equiv="description" content="打包">
	<link href="../../css/style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/gwall/all.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="packaging.js"></script>
	
</head>
	<%
		PackagingMB ai = (PackagingMB) MBUtil.getManageBean("#{packagingMB}");
		if (request.getParameter("isAll") != null) {
			ai.initSK();
		}
	%>
<body id="mmain_body">
	<div id="mmain_nav"><font color="#000000">出库处理&gt;&gt;</font><b>打包</b><br></div>
	<f:view>
	<div id="mmain">
		<h:form id="edit">
			<div id="mmain_opt">
				<a4j:commandButton value="添加单据" onmouseover="this.className='a4j_over1'" 
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					action="#{packagingMB.clearMBean}" oncomplete="addNew();"
					id="addHead" rendered="#{packagingMB.ADD}" />
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					id="deleteId" value="删除单据" type="button"
					onclick="if(!deleteHeadAll()){return false};"
					rendered="#{packagingMB.DEL}" reRender="output,renderArea"
					action="#{packagingMB.deleteHead}"
					oncomplete="endDeleteHeadAll();" requestDelay="50" />
				<a4j:commandButton onmouseover="this.className='a4j_over'"
					onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
					value="查询" type="button" reRender="output" id="sid" oncomplete="Gwallwin.winShowmask('FALSE');"
					action="#{packagingMB.search}" requestDelay="50" onclick="startDo();"
					rendered="#{packagingMB.LST}" />
				<a4j:commandButton value="重置"
					onmouseover="this.className='a4j_over'"
					onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
					onclick="clearSearchKey('0');" rendered="#{packagingMB.LST}" />
			</div>
			<div id=mmain_cnd>
				创建日期从:
				<h:inputText id="sk_start_date" styleClass="datetime" size="10"
					value="#{packagingMB.sk_start_date}" onclick="#{gmanage.datePicker};" 
					 onkeypress="formsubmit(event);"	/>
				<h:outputText value="至:">
				</h:outputText>
				<h:inputText id="sk_end_date" styleClass="datetime" size="10"
					value="#{packagingMB.sk_end_date}" onclick="#{gmanage.datePicker};" 
					 onkeypress="formsubmit(event);"	/>
				打包单编号:
				<h:inputText id="sk_biid" styleClass="datetime" 
					size="12" value="#{packagingMB.sk_obj.biid}"
					 onkeypress="formsubmit(event);"	/>
				创建人:
				<h:inputText id="sk_crna" styleClass="datetime" 
					size="12" value="#{packagingMB.sk_obj.crna}"
					 onkeypress="formsubmit(event);"	/>
				单据状态:
				<h:selectOneMenu id="sk_flag" value="#{packagingMB.sk_obj.flag}" 
				rendered="true" onchange="doSearch();">
					<f:selectItem itemLabel="全部" itemValue="" />
					<f:selectItems value="#{packagingMB.flags}" />
				</h:selectOneMenu>
			</div>
			<a4j:outputPanel id="output">
				<g:GTable gid="gtable" gtype="grid"
					gselectsql="SELECT a.id,a.biid,a.soty,b.orna,a.soco,a.crus,a.crna,a.opna,a.crdt,a.chus,a.chna,a.chdt,a.flag,a.rema
	 					 FROM gpam a join orga b on a.orid=b.orid WHERE 1 = 1 #{packagingMB.searchSQL }"
					gpage="(pagesize = 20)" gversion="2" gdebug = "false"
					gcolumn="gcid = biid(headtext = selall,name = pk,width = 20,align = center,type = checkbox,headtype = checkbox);
						gcid = 0(headtext = 行号,name = rowid,width = 35,align = center,type = text,headtype = text,datatype = string);
						gcid = biid(headtext = 打包单编号,name = hid_biid,width = 0,align = left,type = text,headtype = hidden,datatype = string);
						gcid = biid(headtext = 打包单编号,name = biid,width = 110,headtype = sort,align = center,type = link,datatype=string,linktype = script,typevalue = javascript:Edit('gcolumn[biid]'));
						gcid = orna(headtext = 组织架构,name = orna,width = 90,headtype = sort,align = left,type = text,datatype=string);
						gcid = soty(headtext = 业务来源,name = orna,width = 80,align = center,type = mask,headtype = sort,datatype = string typevalue=OUTORDER:出库订单/OTHEROUTPLAN:其它出库计划/otheroutplan:其它出库计划);
						gcid = soco(headtext = 来源单号,name = whna,width = 120,align = center,type = text,headtype = sort,datatype = string);
						gcid = crna(headtext = 创建人,name = crna,width = 90,align = center,type = text,headtype = sort,datatype = string);
						gcid = crdt(headtext = 创建时间,name = crdt,width = 120,align = center,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
						gcid = opna(headtext = 经手人,name = opna,width = 90,align = center,type = text,headtype = sort,datatype = string);
						gcid = chna(headtext = 审核人,name = chna,width = 90,align = center,type = text,headtype = sort,datatype = string);
						gcid = chdt(headtext = 审核时间,name = chdt,width = 120,align = center,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
						gcid = flag(headtext = 状态,name = flag,width = 70,align = center,type = mask,typevalue=01:制作之中/11:正式单据,headtype = sort,datatype = string);
						gcid = rema(headtext = 备注,name = rema,width = 150,align = left,type = text,headtype = sort,datatype = string);
					" />
			</a4j:outputPanel>
			<div style="display: none;">
			<a4j:outputPanel id="renderArea">
				<h:inputHidden id="msg" value="#{packagingMB.msg}" />
				<h:inputHidden id="sellist" value="#{packagingMB.sellist}" />
				<h:inputHidden id="biid" value="#{packagingMB.mbean.biid}" />
				<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
					onclick="startDo();" oncomplete="javascript:window.location.href='packaging_edit.jsf'"
					style="display:none;" />
			</a4j:outputPanel>
			</div>
		</h:form>
	</div>
	</f:view>
</body>
</html>