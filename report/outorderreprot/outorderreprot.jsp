<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@ page import="com.gwall.view.report.OutOrderReportMB"%>
<%@	page import="com.gwall.view.OutOrderMB"%>
<%
	OutOrderReportMB ai = (OutOrderReportMB) MBUtil
			.getManageBean("#{outOrderReportMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}

	OutOrderMB ais = (OutOrderMB) MBUtil.getManageBean("#{outOrderMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>订单发货统计</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="订单发货统计报表">
		<script type="text/javascript" src="outorderreport.js"></script>
	</head>
	<body id=mmain_body onload="clearData();">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>订单发货统计报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{outOrderReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="outorderreprot" action="#{outOrderReportMB.search}" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" rendered="#{outOrderReportMB.LST}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="excel" value="导出EXCEL" type="button"
								action="#{outOrderReportMB.exportProcedureProduct}"
								reRender="msg,outPutFileName"
								onclick="excelios_begin('gtable');" oncomplete="excelios_end();"
								requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{outOrderReportMB.LST}">
						<div id="mmain_cnd">
							<h:outputText value="发货日期从:"></h:outputText>
							<h:inputText id="sk_start_date" styleClass="datetime" size="15"
								value="#{outOrderReportMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="15"
								value="#{outOrderReportMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							订单编号:
							<h:inputText id="orderNo" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{outOrderReportMB.orderNo}" />
							快递单号:
							<h:inputText id="expressNo" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{outOrderReportMB.expressNo}" />
							来源单据号:
							<h:inputText id="socoNo" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{outOrderReportMB.soco}" />
							货到付款:
							<h:selectOneMenu id="fpay" value="#{outOrderReportMB.paty}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="否" itemValue="0" />
								<f:selectItem itemLabel="是" itemValue="1" />
							</h:selectOneMenu>
							收件人:
							<h:inputText id="receiver" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{outOrderReportMB.receiver}" />
							承运商:
							<h:selectOneMenu id="lpco" value="#{outOrderReportMB.lpco}">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{carrierMB.list}" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="outorderreprot">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gsort="biid" gsortmethod="ASC"
										gselectsql="select * from (SELECT a.biid,case when a.isup = 0 then a.loco 
 										else e.loco end as loco , CONVERT(DECIMAL(15, 2), a.orde) AS orde,a.paty,a.soco, n.rena, n.reca,n.reph,a.lpco,ol.chdt,a.fsna,h.inse,
 										 h.vole,h.vowi,h.vohe,case when a.isup = 0 then isnull(a.czwe,0) else isnull(e.weig,0) end as tawe,n.city,a.orad
										FROM dbo.obma AS a 
										LEFT OUTER JOIN dbo.waho AS c ON a.whid = c.whid
										LEFT OUTER JOIN dbo.noin AS n ON n.biid = a.biid 
										left join dbo.coma as f on f.loco=a.loco
										left join dbo.inve as h on h.inco=f.inco 
										INNER JOIN dbo.olma AS ol ON ol.soco = a.biid LEFT JOIN(select biid,loco,weig,lpco from pode group by biid,loco,weig,lpco) e on a.biid = e.biid
										WHERE 1=1  #{outOrderReportMB.searchSQL}) x "
										gpage="(pagesize = 20)"
										gcolumn="
													gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
													gcid = biid(headtext = 订单编号,name = biid,width = 130,align = left,type = text,headtype = sort ,datatype = string);
													gcid = loco(headtext = 快递单号,name = loco,width = 100,align = left,type = text,headtype = sort ,datatype = string);
													gcid = orde(headtext = 货款金额,name = orde,width = 55,align = left,type = text,headtype = sort ,datatype = string);
													gcid = paty(headtext = 是否到付,name = paty,width = 65,align = center,type = mask,typevalue=0:否/1:货到付款,headtype = sort,datatype = string);
													gcid = soco(headtext = 来源单据号,name = soco,width = 150,align = left,type = text,headtype = sort,datetype = string);
													gcid = rena(headtext = 收件人,name = rena,width = 100,align = left,type = text,headtype = sort ,datatype = string);
													gcid = reca(headtext = 手机,name = reca,width = 100,align = left,type = text,headtype = sort ,datatype = string);
													gcid = reph(headtext = 固话,name = reca,width = 100,align = left,type = text,headtype = sort ,datatype = string);
													gcid = lpco(headtext = 快递公司,name = lpco,width = 70,align = center,type = text,headtype = sort ,datatype = string);
													gcid = chdt(headtext = 发货时间,name = chdt,width = 140,align = center,type = text,headtype = sort ,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
													gcid = fsna(headtext = 店铺,name = fsna,width = 70,align = left,type = text,headtype = sort ,datatype = string);
													gcid = inse(headtext = 包装耗材规格码,name = tawe,width = 90,align = center,type = text,headtype = sort ,datatype=string);
													gcid = vole(headtext = 包装耗材长(cm),name = tawe,width = 90,align = center,type = text,headtype = sort ,datatype=number,dataformat={0.##});
													gcid = vowi(headtext = 包装耗材宽(cm),name = tawe,width = 90,align = center,type = text,headtype = sort ,datatype=number,dataformat={0.##});
													gcid = vohe(headtext = 包装耗材高(cm),name = tawe,width = 90,align = center,type = text,headtype = sort ,datatype=number,dataformat={0.##});
													gcid = tawe(headtext = 重量(g),name = tawe,width = 70,align = center,type = text,headtype = sort ,datatype=number,dataformat={0.##});
													gcid = city(headtext = 城市,name = city,width = 70,align = left,type = text,headtype = sort ,datatype = string);
													gcid = orad(headtext = 地址,name = orad,width = 400,align = left,type = text,headtype = sort ,datatype = string);
												" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>

					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{outOrderReportMB.msg}" />
							<h:inputHidden id="gsql" value="#{outOrderReportMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{outOrderReportMB.outPutFileName}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='picksche_edit.jsf'"
							style="display:none;" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
