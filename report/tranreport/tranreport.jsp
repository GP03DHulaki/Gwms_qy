<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.TranReportMB"%>

<%
	TranReportMB ai = (TranReportMB) MBUtil
			.getManageBean("#{tranReportMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>调拨计划明细报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="调拨计划明细报表">
		<script type='text/javascript' src='tranreport.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>调拨计划明细报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{tranReportMB.msg}" />
							<h:inputHidden id="gsql" value="#{tranReportMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{tranReportMB.outPutFileName}" />
						</a4j:outputPanel>
				   </div>
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{tranReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{tranReportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','sk_start_date,sk_inse,sk_end_date,biid,inco,inna,orid,whid,whna,whid1,whna1');" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{tranReportMB.export}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{tranReportMB.LST}">
						<div id="mmain_cnd">
							创建日期从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="10"
								value="#{tranReportMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="10"
								value="#{tranReportMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							调拨计划单号:
							<h:inputText id="biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{tranReportMB.biid}" />
							调出仓库:
							<h:inputText id="whna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{tranReportMB.whna}" />
							<img id="owid_img" style="cursor: hand;"
								src="../../images/find.gif"
								onclick="return selectWaho('edit:whid','edit:whna');" />
							<h:inputHidden id='whid' value="#{tranReportMB.whid}"></h:inputHidden>
							调入仓库:
							<h:inputText id="whna1" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{tranReportMB.whna1}" />
							<img id="owid_img" style="cursor: hand;"
								src="../../images/find.gif"
								onclick="return selectWaho('edit:whid1','edit:whna1');" />
							<h:inputHidden id='whid1' value="#{tranReportMB.whid1}"></h:inputHidden>
							<br>
							商品名称:
							<h:inputText id="inna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{tranReportMB.inna}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{tranReportMB.inco}" />
							规格码:
							<h:inputText id="sk_inse" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{tranReportMB.inse}" />
							组织架构:
							<h:selectOneMenu id="orid" value="#{tranReportMB.orid}"
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
										  select r.orna,a.biid,a.crdt,a.chdt,g.whna as pfwh,h.whna as powh,b.inco,v.inna,v.colo,v.inse,b.qty,b.iqty,b.oqty from ppma a 
											  left join ppde b on a.biid = b.biid
											  left join inve  v on v.inco = b.inco
											  left join waho g on g.whid = a.pfwh
											  left join waho h on h.whid = a.powh
											  left join orga r on r.orid = a.orid
									  where 1 = 1 #{tranReportMB.initCondition} #{tranReportMB.searchSQL}
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = soco,width =90,headtype = sort,align = left,type = text,datatype=string);
											gcid = biid(headtext = 单据编号,name = biid,width =90,headtype = sort,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 创建日期,name = crdt,width = 70,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
											gcid = chdt(headtext = 审核日期,name = crdt,width = 70,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
											gcid = pfwh(headtext = 调出仓库,name = whna,width =80,headtype = sort,align = left,type = text,datatype=string);
											gcid = powh(headtext = 调入仓库,name = whna,width =80,headtype = sort,align = left,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = mpinco,width = 110,headtype = sort,align = left,type = string,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 100,headtype = sort,align = left,type = string,datatype=string);
											gcid = colo(headtext = 规格,name = colo,width = 90,headtype = sort,align = left,type = string,datatype=string);
											gcid = inse(headtext = 规格码,name = inse,width = 60,headtype = sort,align = left,type = string,datatype=string);
										    gcid = qty(headtext = 计划数量,name = pty,width =60,headtype = sort,align = right,type = text, datatype =number,dataformat=0.##,summary=this);
										    gcid = iqty(headtext = 入库数量,name = ipty,width =60,headtype = sort,align = right,type = text, datatype =number,dataformat=0.##,summary=this);
										    gcid = oqty(headtext = 出库数量,name = opty,width =60,headtype = sort,align = right,type = text, datatype =number,dataformat=0.##,summary=this);
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
