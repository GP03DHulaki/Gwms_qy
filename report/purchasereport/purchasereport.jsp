<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.PurchaseReportMB"%>

<%
	PurchaseReportMB ai = (PurchaseReportMB) MBUtil
			.getManageBean("#{purchaseReportMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>采购退货清单明细报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="采购退货清单明细报表">
		<script type='text/javascript' src='purchasereport.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>采购退货清单明细报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{purchaseReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{purchaseReportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','sk_start_date,sk_end_date,biid,soco,inco,inna,orid,whid,whna,stna');" />
							<!-- 
							<gw:GAjaxButton id="otpDBut1" value="导出EXCEL" theme="b_theme"
								onclick="showOutput('gtable')" type="button" reRender="output" />
							 -->
							 <gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{purchaseReportMB.LST}">
						<div id="mmain_cnd">
							退货日期从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="10"
								value="#{purchaseReportMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="10"
								value="#{purchaseReportMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							采购退货计划单号:
							<h:inputText id="biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{purchaseReportMB.biid}" />
							采购退货出库单号:
							<h:inputText id="soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{purchaseReportMB.soco}" />
							退货仓库:
							<h:inputText id="whna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{purchaseReportMB.whna}" />
							<img id="owid_img" style="cursor: hand;"
								src="../../images/find.gif" onclick="return selectWaho();" />
							<h:inputHidden id='whid' value="#{purchaseReportMB.whid}"></h:inputHidden>
							<br>
							退货商名称:
							<h:inputText id="stna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{purchaseReportMB.stna}" />
							商品名称:
							<h:inputText id="inna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{purchaseReportMB.inna}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{purchaseReportMB.inco}" />
							组织架构:
							<h:selectOneMenu id="orid" value="#{purchaseReportMB.orid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
										SELECT a.biid,a.inco,a.soco,a.stdt,w.whna,w.whna as pfwh,v.inna,v.inse,v.colo,g.orna,a.stna,
										  sum(a.jqty) AS jqty,
										  sum(a.tqty) AS tqty
										FROM
										 (
											 SELECT p.biid,p.whid,p.orid,p.soco,p.stna,p.stdt,e.inco,s.qty AS jqty ,e.qty AS tqty
											 FROM prma p 
											   JOIN prde e ON p.biid = e.biid 
											   JOIN (SELECT inco,sum(qty) AS qty ,biid FROM prbd  GROUP BY inco,biid ) s
											   ON s.biid = p.soco AND s.inco = e.inco) a
											 JOIN inve v ON v.inco = a.inco 
											 join waho w on w.whid = a.whid
											 join orga g on g.orid = a.orid
									  where 1 = 1 #{purchaseReportMB.initCondition} #{purchaseReportMB.searchSQL}
									 GROUP BY a.biid,a.inco,a.stdt,w.whna,v.inna,v.inse,v.colo,a.soco,g.orna,a.stna;
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = soco,width =90,headtype = sort,align = left,type = text,datatype=string);
											gcid = biid(headtext = 采购退货出库单,name = biid,width =110,headtype = sort,align = left,type = text,datatype=string);
											gcid = soco(headtext = 采购退货计划单,name = soco,width =110,headtype = sort,align = left,type = text,datatype=string);
											gcid = whna(headtext = 退货仓库,name = whna,width =80,headtype = sort,align = left,type = text,datatype=string);
											gcid = stna(headtext = 退货商名称,name =stna,width =150,headtype = sort,align = left,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = mpinco,width = 110,headtype = sort,align = left,type = string,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 100,headtype = sort,align = left,type = string,datatype=string);
											gcid = colo(headtext = 规格,name = colo,width = 90,headtype = sort,align = left,type = string,datatype=string);
											gcid = inse(headtext = 规格码,name = inse,width = 90,headtype = sort,align = left,type = string,datatype=string);
										    gcid = jqty(headtext = 计划数量,name = jpty,width =80,headtype = sort,align = right,type = text, datatype =number,dataformat=0.##,summary=this);
										    gcid = tqty(headtext = 退货数量,name = rqty,width = 80,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
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
