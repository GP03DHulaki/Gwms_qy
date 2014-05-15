<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@	page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.StockPlanMB"%>
<%
	StockPlanMB ai = (StockPlanMB) MBUtil.getManageBean("#{stockPlanMB}");
	if (null != request.getParameter("isAll")) {
		ai.initSK();
	}
%>

<html>
	<head>
		<title>盘点计划单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="盘点计划单">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/css/style.css">
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gwalldate.js'></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/Gbase.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/Gwallwin.js"></script>
		<script type="text/javascript" src="stockplan.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
	</head>

	<body id="mmain_body">
		<div id="mydiv"
			style="width: 190px; height: 30px; bgcolor: #efefef; display: none;">
			<img src="../../images/indicator.gif" width="16" height="16" />
			<b><font color="white">正在处理，请稍等...</font> </b>
		</div>
		<div id=mmain_nav>
			<font color="#000000">库内处理</font>&gt;&gt;盘点&gt;&gt;<b>盘点计划单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td id="mmain_opt">
							<a4j:commandButton value="添加单据" type="button"
								onmouseover="this.className='a4j_over1'"
								rendered="#{stockPlanMB.ADD}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								oncomplete="addNew();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="deleteId" value="删除单据" type="button"
								onclick="if(!deleteHeadAll()){return false};"
								rendered="#{stockPlanMB.DEL}" reRender="output,renderArea"
								action="#{stockPlanMB.deleteHead}"
								oncomplete="endDeleteHeadAll();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								id="sid" value="查询" type="button"
								action="#{stockPlanMB.search}"
								oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
								requestDelay="50" onclick="Gwallwin.winShowmask('TRUE');;" rendered="#{stockPlanMB.LST}" />
							<a4j:commandButton value="重置" rendered="#{stockPlanMB.LST}"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="textClear('edit','biid,crna,ch_flag,start_date,end_date,orid');" />
							<a4j:commandButton id="printButton" value="打印计划单号"
								rendered="false" onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="if(!doPrintAll(gtable)){return false};"
								reRender="renderArea,outPutFileName,msg"
								oncomplete="lookPrint();" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</td>
					</tr>
				</table>
				<a4j:outputPanel id="queryForm" rendered="true">
					<div id=mmain_cnd>
						创建时间从:
						<h:inputText id="start_date" styleClass="datetime" size="12"
							value="#{stockPlanMB.sk_start_date}" onfocus="#{gmanage.datePicker};" />
						至:
						<h:inputText id="end_date" styleClass="datetime" size="12"
							value="#{stockPlanMB.sk_end_date}" onfocus="#{gmanage.datePicker};" />
						盘点计划单:
						<h:inputText id="biid" styleClass="datetime" size="15"
							value="#{stockPlanMB.sk_obj.biid}" onkeypress="formsubmit(event);" />
						制单人:
						<h:inputText id="crna" styleClass="datetime" size="15"
							value="#{stockPlanMB.sk_obj.crna}" onkeypress="formsubmit(event);" />
						状态:
						<h:selectOneMenu id="ch_flag" value="#{stockPlanMB.sk_obj.flag}" onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItems value="#{stockPlanMB.flags}" />
						</h:selectOneMenu>
						组织架构:
						<h:selectOneMenu id="orid" value="#{stockPlanMB.orid}" onchange="doSearch();">
							<f:selectItem itemLabel="" itemValue="" />
							<f:selectItems value="#{OrgaMB.subList}" />
						</h:selectOneMenu>
					</div>
				</a4j:outputPanel>
				<div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2"
							gpage="(pagesize = 20)" gdebug="false"
							gselectsql="SELECT a.id,a.biid,a.orid,a.pmmt,a.crna,a.opna,a.crdt,a.chna,a.chdt,a.flag,a.rema,b.whna,c.orna,a.gddt
										FROM pmma a LEFT JOIN waho b ON a.whid=b.whid
										LEFT JOIN orga c ON a.orid=c.orid where a.#{stockPlanMB.gorgaSql} #{stockPlanMB.searchSQL}"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
										gcid = 0(headtext = 行号,name = rowid,width = 40,headtype = text,align = center,type = text,datatype=string);
										gcid = biid(headtext = 隐藏单号,name = biids,width = 60,headtype = hidden,align = left,type = text,datatype=string);
										gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
										gcid = biid(headtext = 盘点计划单,name = biid,width = 100,headtype = sort,align = left,type = link,linktype = script,typevalue = stockplan_edit.jsf?pid=gcolumn[biid],datatype=string);
										gcid = pmmt(headtext = 盘点方式,name = pmmt,width = 70,headtype = sort,align = center,type = mask,datatype=string,typevalue=01:货位盘点/02:商品盘点);
										gcid = whna(headtext = 盘点仓库,name = whna,width = 80,headtype = text,align = left,type = text,datatype=string);
										gcid = opna(headtext = 操作人,name = opna,width = 70,headtype = sort,align = left,type = text,datatype=string);
										gcid = crna(headtext = 创建人,name = crna,width = 70,headtype = sort,align = left,type = text,datatype=string);
										gcid = gddt(headtext = 过账时间,name = gddt,width =100,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:ss);
										gcid = crdt(headtext = 创建时间,name = crdt,width =100,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:ss);
										gcid = chna(headtext = 审核人,name = chna,width = 80,headtype = sort,align = left,type = text,datatype=string);
										gcid = chdt(headtext = 审核时间,name = chdt,width = 100,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:ss);
										gcid = flag(headtext = 状态,name = flag,width = 75,align = center,type = mask,typevalue=01:制作之中/02:复盘中/11:正式单据/21:关闭单据,headtype = sort,datatype = string);
										gcid = rema(headtext = 备注,name = rema,width = 150,headtype = sort,align = left,type = text,datatype=string);
										" />
					</a4j:outputPanel>
				</div>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{stockPlanMB.msg}" />
						<h:inputHidden id="sellist" value="#{stockPlanMB.sellist}" />
					</a4j:outputPanel>
				</div>
			</h:form>
		</f:view>
	</body>
</html>
