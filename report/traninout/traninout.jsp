<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.TraninoutReportMB"%>

<%
	TraninoutReportMB ai = (TraninoutReportMB) MBUtil
			.getManageBean("#{traninoutReportMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>调拨出入库单报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="调拨出入库单报表">
		<script type='text/javascript' src='traninout.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>调拨出入库单报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
				<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{traninoutReportMB.msg}" />
							<h:inputHidden id="gsql" value="#{traninoutReportMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{traninoutReportMB.outPutFileName}" />
						</a4j:outputPanel>
				   </div>
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs"
							rendered="#{traninoutReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{traninoutReportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','biid,inna,inco,sk_inse,pfwh,powh,colo,sk_chdt_end,sk_chdt_start');" />
						   <a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{traninoutReportMB.export}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{traninoutReportMB.LST}">
						<div id="mmain_cnd">
							创建日期从:
							<h:inputText id="sk_chdt_start" styleClass="datetime" size="10"
								value="#{traninoutReportMB.sk_chdt_start}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_chdt_end" styleClass="datetime" size="10"
								value="#{traninoutReportMB.sk_chdt_end}"
								onfocus="#{gmanage.datePicker}" />
							单据编号:
							<h:inputText id="biid" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{traninoutReportMB.biid}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{traninoutReportMB.inco}" />
							商品名称:
							<h:inputText id="inna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{traninoutReportMB.inna}" />
							<br>
							调入仓库:
							<h:inputText id="powh" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{traninoutReportMB.powh}" />
							调出仓库:
							<h:inputText id="pfwh" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{traninoutReportMB.pfwh}" />
							规格:
							<h:inputText id="colo" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{traninoutReportMB.colo}" />
								规格码:
							<h:inputText id="sk_inse" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{traninoutReportMB.inse}" />
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
										SELECT a.biid,a.buty,a.soty,a.inco,a.soco,a.crdt,a.pric,w.whna as pfwh,h.whna as powh,v.inna,v.inst,v.colo,v.inse,
											  sum(a.jqty) AS jqty,
											  sum(a.iqty) AS iqty,
											  sum(a.oqty) AS oqty 
											FROM
											 (
												 SELECT p.biid,p.buty,p.soty,p.soco,p.crdt,e.inco,p.pfwh,p.powh, s.pric,s.qty AS jqty ,0 AS iqty,e.qty AS oqty 
												 FROM pbma p 
												   JOIN pbde e ON p.biid = e.biid 
												   JOIN (SELECT inco,sum(qty) AS qty ,biid,pric FROM ppde  GROUP BY inco,biid,pric ) s
												   ON s.biid = p.soco AND s.inco = e.inco
												UNION ALL 
												SELECT p.biid,p.buty,p.soty,p.soco,p.chdt,e.inco,p.pfwh,p.powh, 0 as pric,s.qty AS jqty ,e.qty AS iqty,0 AS oqty 
												 FROM pama p 
												   JOIN pade e ON p.biid = e.biid 
												   
												   JOIN (SELECT inco,sum(qty) AS qty ,biid FROM pbde   GROUP BY inco,biid) s
												   ON s.biid = p.soco AND s.inco = e.inco
												   
												UNION ALL 
												SELECT p.biid,p.buty,p.soty,p.soco,p.crdt,e.inco,p.pfwh,p.powh,s.pric, s.qty AS jqty ,e.qty AS iqty,0 AS oqty 
												 FROM pama p 
												   JOIN pade e ON p.biid = e.biid 
												   JOIN (SELECT inco,sum(qty) AS qty ,biid,pric FROM ppde  GROUP BY inco,biid,pric) s
												   ON s.biid = p.soco AND s.inco = e.inco
											 )a
											 JOIN inve v ON v.inco = a.inco 
											 join waho w on w.whid = a.pfwh
											 join waho h on h.whid = a.powh
											 where 1 = 1 #{traninoutReportMB.initCondition} #{traninoutReportMB.searchSQL}
											GROUP BY a.biid,a.buty,a.inco,a.crdt,w.whna,h.whna,v.inna,v.inst,v.colo,a.soco,a.soty,a.pric,v.inse;
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = buty(headtext = 单据类型,name = buty,width = 70,headtype = sort,align = left,type = mask,datatype=string,typevalue=TRANPLAN:调拨计划单/TRANOUT:调拨出库单/tranin:调拨入库单/tranout:调拨出库单/TRANIN:调拨入库单);
											gcid = biid(headtext = 单据编号,name = biid,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 创建日期,name = crdt,width = 70,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
											gcid = soty(headtext = 来源类型,name = buty,width = 70,headtype = sort,align = left,type = mask,datatype=string,typevalue=TRANPLAN:调拨计划/TRANOUT:调拨出库/tranplan:调拨计划/tranout:调拨出库);
											gcid = soco(headtext = 来源单号,name = soco,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = inst(headtext = 商品规格,name = inst,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = colo(headtext = 规格,name = colo,width = 100,headtype = sort,align = left,type = text,datatype=string);
										    gcid = inse(headtext = 规格码,name = inse,width = 100,headtype = sort,align = left,type = text,datatype=string);
										    gcid = pfwh(headtext = 出库仓库,name = pfwh,width = 80,headtype = sort,align = left,datatype=string,type = text);
										    gcid = powh(headtext = 入库仓库,name = powh,width = 80,headtype = sort,align = left,datatype=string,type = text);
										   	gcid = jqty(headtext = 计划数量,name = jqty,width= 60,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
										   	gcid = iqty(headtext = 入库数量,name = iqty,width = 60,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
										   	gcid = oqty(headtext = 出库数量,name = oqty,width = 60,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
										   	gcid = pric(headtext = 价格,name = pric,width = 60,headtype = sort,align = right, datatype =number,dataformat=0.##);
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
