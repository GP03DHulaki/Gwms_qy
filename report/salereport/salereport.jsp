<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.SaleReportMB"%>

<%
	SaleReportMB ai = (SaleReportMB) MBUtil
			.getManageBean("#{saleReportMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>销售退货清单明细报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="销售退货清单明细报表">
		<script type='text/javascript' src='salereport.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>销售退货清单明细报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
				<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{saleReportMB.msg}" />
							<h:inputHidden id="gsql" value="#{saleReportMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{saleReportMB.outPutFileName}" />
						</a4j:outputPanel>
						</div>
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{saleReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{saleReportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','sk_start_date,sk_inse,sk_end_date,biid,soco,inco,inna,orid,whid,whna,stna');" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{saleReportMB.export}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{saleReportMB.LST}">
						<div id="mmain_cnd">
							退货日期从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="10"
								value="#{saleReportMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="10"
								value="#{saleReportMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							销售退货入库单号:
							<h:inputText id="biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{saleReportMB.biid}" />
							来源单号:
							<h:inputText id="soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{saleReportMB.soco}" />
							入库仓库:
							<h:inputText id="whna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{saleReportMB.whna}" />
							<img id="owid_img" style="cursor: hand;"
								src="../../images/find.gif" onclick="return selectWaho();" />
							<h:inputHidden id='whid' value="#{saleReportMB.whid}"></h:inputHidden>
							<br>
							<!-- 
							客户名称:
							<h:inputText id="stna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{saleReportMB.stna}" />
							 -->
							商品名称:
							<h:inputText id="inna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{saleReportMB.inna}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{saleReportMB.inco}" />
							规格码:
							<h:inputText id="sk_inse" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{saleReportMB.inse}" />
							组织架构:
							<h:selectOneMenu id="orid" value="#{saleReportMB.orid}"
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
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gselectsql="
											SELECT b.orid,a.biid,b.soty,b.soco,b.whid,a.inco,v.inna,v.colo,v.inse
											,ISNULL(d.qty,0) AS jqty,a.qty AS iqty,g.orna,w.whna,b.chdt FROM rsde a JOIN rsma b ON a.biid=b.biid
											LEFT JOIN inve v ON a.inco=v.inco 
											LEFT JOIN rpde d ON d.biid=b.soco
											LEFT JOIN waho w on w.whid = b.whid
											left join orga g on g.orid = b.orid 
											where 1 = 1 #{saleReportMB.searchSQL}
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width =90,headtype = hidden,align = left,type = text,datatype=string);
											gcid = biid(headtext = 销售退货入库单,name = biid,width =130,headtype = sort,align = left,type = text,datatype=string);
											gcid = soty(headtext = 来源类型,name = soty,width = 80,headtype = sort,align = left,type = mask,datatype=string,typevalue=RETURNRECEIPT:销售退货收货/RETURNPLAN:销售退货计划);
											gcid = soco(headtext = 来源单号,name = soco,width = 130,headtype = sort,align = left,type = text,datatype=string);
											gcid = whna(headtext = 入库仓库,name = whna,width =80,headtype = sort,align = left,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = inco,width = 110,headtype = sort,align = left,type = string,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 100,headtype = sort,align = left,type = string,datatype=string);
											gcid = colo(headtext = 规格,name = colo,width = 90,headtype = sort,align = left,type = string,datatype=string);
											gcid = inse(headtext = 规格码,name = inse,width = 70,headtype = sort,align = left,type = string,datatype=string);
										    gcid = jqty(headtext = 计划数量,name = jpty,width =60,headtype = sort,align = right,type = text, datatype =number,dataformat=0.##,summary=this);
										    gcid = iqty(headtext = 退货数量,name = rqty,width = 60,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
										    gcid = chdt(headtext = 创建日期,name = chdt,width = 130,headtype = sort,align = left,type = text,datatype=string);
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
