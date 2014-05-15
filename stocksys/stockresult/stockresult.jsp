<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.StockAdjustMB"%>
<%@ include file="../../include/include_imp.jsp" %>
<%
	StockAdjustMB ai = (StockAdjustMB) MBUtil
			.getManageBean("#{stockadjustMB}");
	if (null != request.getParameter("isAll")) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>盘盈盘亏信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="盘盈盘亏信息">
		<meta http-equiv="description" content="盘盈盘亏信息">
		<script type="text/javascript" src="stockresult.js"></script>
	</head>
	<body id="mmain_body" onload="initload();">
		<div id="mmain_nav">
			<FONT color="#000000">库内处理</FONT>&gt;&gt;
			<FONT color="#000000">盘点</FONT>&gt;&gt;
			<B>盘盈盘亏记录</B>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain_opt">
					<a4j:outputPanel id="queryButs">
						<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
							onclick="Gwallwin.winShowmask('TRUE');"
							oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
							action="#{stockadjustMB.search}" rendered="#{stockadjustMB.LST}" />
						<gw:GAjaxButton value="重置" theme="a_theme"
							onclick="clearSearchKey();" rendered="#{stockadjustMB.LST}"/>
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							onclick="reportExcel('gtable')" type="button" />
					</a4j:outputPanel>
				</div>
				<a4j:outputPanel id="queryForm">
					<div id="mmain_cnd">
						单据日期从:
						<h:inputText id="start_date" styleClass="datetime" size="10"
							onfocus="#{gmanage.datePicker};"
							value="#{stockadjustMB.sk_start_date}" />
						至:
						<h:inputText id="end_date" styleClass="datetime" size="10"
							onfocus="#{gmanage.datePicker};"
							value="#{stockadjustMB.sk_end_date}" />
						盘点操作单号:
						<h:inputText id="biid" styleClass="inputtext" size="17"
							onkeypress="formsubmit(event);"
							value="#{stockadjustMB.sk_obj.pbid}" />
						盘盈盘亏单号:
						<h:inputText id="nvfromvoucherid" styleClass="inputtext" size="17"
							onkeypress="formsubmit(event);"
							value="#{stockadjustMB.sk_obj.biid}" />
						组织架构:
						<h:selectOneMenu id="orid" value="#{stockadjustMB.orid}" onchange="doSearch();">
							<f:selectItem itemLabel="" itemValue="" />
							<f:selectItems value="#{OrgaMB.subList}" />
						</h:selectOneMenu>
					</div>
				</a4j:outputPanel>
				<a4j:outputPanel id="output">
					<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
						gselectsql="SELECT distinct a.id,a.biid,a.pbid,a.buty,a.infl,a.flag,a.Stat,a.crna,a.crdt,a.whid,a.orid,a.rema,a.chna,a.chdt,b.orna 
										FROM mtma a LEFT JOIN orga b ON a.orid=b.orid WHERE a.#{stockadjustMB.gorgaSql} #{stockadjustMB.searchSQL}"
						gpage="(pagesize = 18)"
						gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 盘盈盘亏单号,name = biids,width = 100,headtype = hidden,align = left,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = biid(headtext = 盘盈盘亏单号,name = biid,width = 110,headtype = sort,align = left,type = link,linktype=script,typevalue=stockresult_edit.jsf?pid=gcolumn[biid], datatype=string);
											gcid = buty(headtext = 来源类型,name = buty,width = 80,headtype = sort,align = left,type = mask,datatype=string,typevalue=stockplan:盘点计划/STOCKOPT:盘点操作);
											gcid = pbid(headtext = 来源单号,name = pbid,width = 110,headtype = sort,align = left,type = text,datatype=string);
											gcid = crna(headtext = 创建人,name = crna,width = 82,headtype = sort,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 创建时间,name = crdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = chna(headtext = 审核人,name = chna,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = flag(headtext = 状态,name = flag,width = 80,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:出库中/31:已完成,headtype = sort,datatype = string);
											gcid = rema(headtext = 备注,name = rema,width = 130,headtype = sort,align = left,type = text,datatype=string);
									" />
				</a4j:outputPanel>
			</h:form>
		</f:view>
	</body>
</html>