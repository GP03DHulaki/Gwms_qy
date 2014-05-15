<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@	page import="com.gwall.view.PoinReportMB"%>

<%
    PoinReportMB ai = (PoinReportMB) MBUtil
            .getManageBean("#{poinReportMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSK();
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>采购入库报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="采购入库报表">
		<script type='text/javascript' src='poinreport.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">入库单统计&gt;&gt;</font>
			<b>采购入库报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
				<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{poinReportMB.msg}" />
							<h:inputHidden id="gsql" value="#{poinReportMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{poinReportMB.outPutFileName}" />
						</a4j:outputPanel>
				   </div>
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{poinReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{poinReportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','biid,inna,sk_inse,inco,soco,chus,sk_start_date,sk_end_date,sk_outo,suna');" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{poinReportMB.export}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{poinReportMB.LST}">
						<div id="mmain_cnd">
							审核日期从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="12"
								value="#{poinReportMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							至:
							<h:inputText id="sk_end_date" styleClass="datetime" size="12"
								value="#{poinReportMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							采购入库单:
							<h:inputText id="biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{poinReportMB.biid}" />
							采购订单:
							<h:inputText id="soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{poinReportMB.soco}" />
							制单号:
							<h:inputText id="sk_outo" styleClass="datetime" size="15"
								value="#{poinReportMB.sk_outo}" onkeypress="formsubmit(event);"/>
							商品名称:
							<h:inputText id="inna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{poinReportMB.inna}" />
								<br/>
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{poinReportMB.inco}" />
							规格码:
							<h:inputText id="sk_inse" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{poinReportMB.inse}" />
							审核人编码:
							<h:inputText id="chus" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{poinReportMB.chus}" />
							供应商:
							<h:inputText id="suna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{poinReportMB.suna}" />
							<h:outputText value="仓库:" ></h:outputText>
							<h:selectOneMenu id="sk_whid" value="#{poinReportMB.sk_whid}"
								style="width:130px;">
								<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT c.biid,c.crus,g.orna,c.crdt,t.inco,sum(t.qty) as jqty,
											v.inna,v.inse,v.colo,c.soco,c.chna,p.buty,c.chdt,c.chus,s.suna,p.soco as psoco,p.outo as outo
											from psma c JOIN (
												SELECT a.biid,b.inco,SUM(b.qty) AS qty FROM psde a JOIN pain b ON a.baco=b.boco WHERE a.chfl='02' GROUP BY a.biid,b.inco
												UNION ALL
												SELECT a.biid,a.inco,a.qty FROM psde a WHERE (a.chfl='04' OR a.chfl='03')
											) t on c.biid=t.biid
											JOIN inve v ON v.inco = t.inco
											JOIN orga g ON g.orid = c.orid	
											LEFT JOIN pubm p ON c.soco = p.biid
											LEFT JOIN suin s ON p.suid = s.suid	
											where 1 = 1 #{poinReportMB.initCondition} #{poinReportMB.searchSQL}																	
											GROUP BY c.biid,t.inco,v.inna,v.inst,v.colo,c.crus,c.crdt,
											g.orna,v.inse,c.soco,c.chna,p.buty,c.chdt,s.suna,c.chus,p.soco,p.outo;
										"
										gpage="(pagesize = 60)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 采购入库单,name = biid,width =110,headtype = sort,align = left,type = text,datatype=string);
											gcid = soco(headtext = 采购订单,name = soco,width =110,headtype = sort,align = left,type = text,datatype=string);
											gcid = psoco(headtext = 来源订单,name = psoco,width =110,headtype = sort,align = left,type = text,datatype=string);
											gcid = outo(headtext = 制单号,name = outo,width = 120,align = left,type = text,headtype = sort,datatype = string);
											gcid = buty(headtext = 采购类型,name = buty,width = 60,align = center,type = mask,headtype = sort,datatype = string,typevalue=01:ODM/02:FOB/03:代卖/04:外调/05:整件外发);
											gcid = suna(headtext = 供应商,name = suna,width =110,headtype = sort,align = left,type = text,datatype=string);
											gcid = chus(headtext = 审核人编码,name = chus,width =80,headtype = sort,align = left,type = text,datatype=string);
											gcid = chna(headtext = 审核人名称,name = chna,width =80,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核日期,name = chdt,width =110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = inco(headtext = 商品编码,name = mpinco,width = 110,headtype = sort,align = left,type = string,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 140,headtype = sort,align = left,type = string,datatype=string);
											gcid = colo(headtext = 规格,name = colo,width = 70,headtype = sort,align = left,type = string,datatype=string);
											gcid = inse(headtext = 规格码,name = inse,width = 70,headtype = sort,align = left,type = string,datatype=string);
										    gcid = jqty(headtext = 入库数量,name = jpty,width = 60,headtype = sort,align = right,type = text, datatype =number,dataformat=0.##,summary=this);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
				</h:form>
			</f:view>
			<%-- 
				gcid = rqty(headtext = 入库数量,name = rqty,width = 90,headtype = hidden,align = right, datatype =number,dataformat=0.##);
			--%>
		</div>
	</body>
</html>
