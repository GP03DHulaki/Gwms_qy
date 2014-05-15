<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@	page import="com.gwall.view.report.StockPlanReportMB"%>

<%
	StockPlanReportMB ai = (StockPlanReportMB) MBUtil
            .getManageBean("#{stockPlanReportMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSK();
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>盘点差异报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="盘点差异报表">
		<script type='text/javascript' src='stockplanreport.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>盘点差异报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{stockPlanReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{stockPlanReportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','sk_start_date,sk_end_date,indf,biid,inna,whna,psta,flag,inco,colo,usna,orna,orid');" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="excel" value="导出全部" type="button"
								action="#{stockPlanReportMB.exportTotal}"
								reRender="msg,outPutFileName"
								onclick="excelios_begin('gtable');" oncomplete="excelios_end();"
								requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{stockPlanReportMB.LST}">
						<div id="mmain_cnd">
							创建日期从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="16"
								value="#{stockPlanReportMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="16"
								value="#{stockPlanReportMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							盘点计划:
							<h:inputText id="biid" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{stockPlanReportMB.biid}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{stockPlanReportMB.inco}" />
							盘点货位:
							<h:inputText id="whid" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{stockPlanReportMB.whid}" />
							<br>
							商品名称:
							<h:inputText id="inna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{stockPlanReportMB.inna}" />
							规格:
							<h:inputText id="colo" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{stockPlanReportMB.colo}" />
							盘点人:
							<h:inputText id="usna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{stockPlanReportMB.usna}" />
							组织架构:
							<h:selectOneMenu id="orid" value="#{stockPlanReportMB.orid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
							盘点状态:
							<h:selectOneMenu id="psta" value="#{stockPlanReportMB.psta}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="已盘" itemValue="已盘" />
								<f:selectItem itemLabel="未盘" itemValue="未盘" />
							</h:selectOneMenu>
							单据状态:
							<h:selectOneMenu id="flag" value="#{stockPlanReportMB.flag}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="已审核" itemValue="已审核" />
								<f:selectItem itemLabel="未审核" itemValue="未审核" />
							</h:selectOneMenu>
							存在商品差异:
							<h:selectOneMenu id="indf" value="#{stockPlanReportMB.indf}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="是" itemValue="1" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT g.orna,a.biid,CONVERT(VARCHAR(16),b.crdt,120) AS crdt,a.whid,a.inco,v.inna,v.colo,v.inse,u.usna
											,a.qty,a.fqty,a.fqty-a.qty AS cqty
											,CASE WHEN i.stat>0 THEN '已盘' ELSE '未盘' END AS psta
											,CASE WHEN b.flag='11' THEN '已审核' ELSE '未审核' END AS flag
											,i.stat
											FROM pmde a 
											LEFT JOIN pmma b ON a.biid=b.biid
											LEFT JOIN inve v ON v.inco = a.inco
											LEFT JOIN orga g on g.orid = b.orid
											LEFT JOIN pwci i ON a.biid=i.biid AND a.whid=i.whid
											LEFT JOIN usin u ON b.opna=u.usid
											WHERE 1 = 1 #{stockPlanReportMB.initCondition} #{stockPlanReportMB.searchSQL}
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = biid(headtext = 盘点计划,name = biid,width = 110,headtype = sort,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 创建时间,name = crdt,width = 110,align = left,type = text,headtype = sort,datatype=string);
											gcid = whid(headtext = 盘点货位,name = whid,width = 90,align = left,type = text,headtype = sort,datatype = string);
											gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = colo(headtext = 规格,name = colo,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = inse(headtext = 规格码,name = inse,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = usna(headtext = 盘点人,name = usna,width = 60,align = left,type = text,headtype = sort,datatype = string);
											gcid = qty(headtext = 账面数量,name = jqty,width= 60,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
										    gcid = fqty(headtext = 实盘数量,name = rqty,width= 60,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
										    gcid = cqty(headtext = 差异数量,name = cqty,width= 60,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
										    gcid = psta(headtext = 盘点状态,name = psta,width = 60,align = center,type = text,headtype = sort,datatype = string);
										    gcid = flag(headtext = 单据状态,name = flag,width = 60,align = center,type = text,headtype = sort,datatype = string);
										    gcid = stat(headtext = 盘点次数,name = stat,width= 60,headtype = sort,align = right, datatype =number,dataformat=0);
										   	
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>

					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{stockPlanReportMB.msg}" />
							<h:inputHidden id="gsql" value="#{stockPlanReportMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{stockPlanReportMB.outPutFileName}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
