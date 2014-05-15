<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.MoplanReportMB"%>
<%
	MoplanReportMB ai = (MoplanReportMB) MBUtil
			.getManageBean("#{moplanReportMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>生产计划完成情况报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="生产计划完成情况报表">
		<script type='text/javascript' src='moplansearch.js'></script>
	</head>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>生产计划完成情况报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{moplanReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{moplanReportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','sk_start_date,sk_end_date,biid,inna,inco,crna,dety,orid,dpid,dpna');" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" reRender="output" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{moplanReportMB.LST}">
						<div id="mmain_cnd">
							创建日期从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="10"
								value="#{moplanReportMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="10"
								value="#{moplanReportMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							计划单号:
							<h:inputText id="biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{moplanReportMB.biid}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{moplanReportMB.inco}" />
							商品名称:
							<h:inputText id="inna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{moplanReportMB.inna}" />
							<br>
							<h:outputText value="组织架构:">
							</h:outputText>
							<h:selectOneMenu id="orid" value="#{moplanReportMB.orid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
							&nbsp;&nbsp;
							<h:outputText value="子业务类型:" rendered="true">
							</h:outputText>
							<h:selectOneMenu id="dety" value="#{moplanReportMB.dety}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{moplanReportMB.detys}" />
							</h:selectOneMenu>
							&nbsp;&nbsp;&nbsp;&nbsp;制单人:
							<h:inputText id="crna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{moplanReportMB.crna}" />
							部门:
							<h:inputText id="dpna" styleClass="datetime"
								value="#{moplanReportMB.dpna}" />
							<h:inputHidden id="dpid" value="#{moplanReportMB.dpid}" />
							<img id="whid_img" style="cursor: hand"
								src="../../images/find.gif" onclick="selectDept();" />
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
										SELECT c.biid,c.orid,p.dpna,c.dety,g.orna,c.crna,c.crdt,t.inco,sum(t.qty) AS jqty,sum(t.fqty) as wqty,v.inna,v.inse,v.colo,CONVERT(INT,(ISNULL(SUM(t.fqty),0)/SUM(t.qty))*100) AS progress
										from ctma c JOIN ctde t ON c.biid = t.biid 
										join orga g on g.orid = c.orid
										LEFT JOIN inve v ON v.inco = t.inco
										left join dept p on p.dpid = c.dpid
										 where 1 = 1 and t.qty!=0 #{moplanReportMB.initCondition} #{moplanReportMB.searchSQL}
											GROUP BY c.biid,t.inco,v.inna,v.inst,v.colo,c.crna,c.crdt,c.biid,c.orid,c.dety,g.orna,p.dpna;
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = progress(headtext =计划完成进度,name = percent,width = 120,headtype = sort,align = left,type = gprogress);
											gcid = orna(headtext = 组织架构,name = biid,width =100,headtype = sort,align = left,type = text,datatype=string);
											gcid = biid(headtext = 计划单号,name = biid,width =100,headtype = sort,align = left,type = text,datatype=string);
											gcid = dpna(headtext = 部门,name = biid,width =100,headtype = sort,align = left,type = text,datatype=string);
											gcid = dety(headtext = 子业务类型,name = dety,width = 61,align = center,type = mask,typevalue=103:产成品入库/102:半成品入库/105:委外入库/109:返工入库,headtype = sort,datatype = string);
											gcid = inco(headtext = 商品编码,name = mpinco,width = 110,headtype = sort,align = left,type = string,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 170,headtype = sort,align = left,type = string,datatype=string);
											gcid = colo(headtext = 规格,name = inst,width = 80,headtype = sort,align = left,type = string,datatype=string);
											gcid = inse(headtext = 规格码,name = inse,width = 80,headtype = sort,align = left,type = string,datatype=string);
										   	gcid = crna(headtext =制单人,name = mpinco,width = 50,headtype = sort,align = left,type = string,datatype=string);
										    gcid = jqty(headtext = 计划数量,name = jqty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = wqty(headtext = 完成数量,name = wqty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
											gcid = crdt(headtext = 创建时间,name = crdt,width = 70,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
