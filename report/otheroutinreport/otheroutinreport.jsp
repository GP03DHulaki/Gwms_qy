<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.report.OtherOutInReportMB"%>
<%
	OtherOutInReportMB ai = (OtherOutInReportMB) MBUtil
			.getManageBean("#{otherOutInReportMB}");
	if (request.getParameter("isAll") != null) { 
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>借出还回报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="借出还回报表">
		<script type='text/javascript' src='otheroutinreport.js'></script>
	</head>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>借出还回报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{otherOutInReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{otherOutInReportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','sk_start_date,sk_end_date,biid,inna,inco,crna,dety,orid,dpid,dpna');" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" reRender="output" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{otherOutInReportMB.LST}">
						<div id="mmain_cnd">
							借出出库单:
							<h:inputText id="outbiid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{otherOutInReportMB.outbiid}" />
							还回入库单:
							<h:inputText id="inbiid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{otherOutInReportMB.inbiid}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{otherOutInReportMB.inco}" />
							<br>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											select DISTINCT a.biid as outbiid,b.biid as inbiid,ad.inco,sum(ad.qty) as oqty,sum(bd.qty)as iqty,e.inna,e.colo,e.inse
											,a.crdt as outcrdt,b.crdt as incrdt
											from ooma a left join oima b on a.biid=b.soco right join oode ad on a.biid=ad.biid left join oide bd on bd.biid = b.biid join inve e on e.inco= ad.inco
											where a.dety='01' #{otherOutInReportMB.searchSQL} group by a.biid,b.biid,ad.inco,bd.inco,e.inna,e.colo,e.inse,a.crdt,b.crdt
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = outbiid(headtext = 借出出库单号,name = outbiid,width = 100,headtype = sort,align = left,type = string,datatype=string);
											gcid = inbiid(headtext = 还回入库单号,name = inbiid,width = 100,headtype = sort,align = left,type = string,datatype=string);
											gcid = inco(headtext = 商品编码,name = mpinco,width = 120,headtype = sort,align = left,type = string,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 100,headtype = sort,align = left,type = string,datatype=string);
											gcid = colo(headtext = 规格,name = inst,width = 60,headtype = sort,align = left,type = string,datatype=string);
											gcid = inse(headtext = 规格码,name = inse,width = 50,headtype = sort,align = left,type = string,datatype=string);
											gcid = outcrdt(headtext = 借出时间,name = outcrdt,width = 120,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = incrdt(headtext = 还回时间,name = incrdt,width = 120,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
										    gcid = oqty(headtext = 借出数量,name = qty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = iqty(headtext = 还回数量,name = qty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);											
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
