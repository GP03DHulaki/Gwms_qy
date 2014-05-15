<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.report.OrderCancelReportMB"%>
<%
	OrderCancelReportMB ai = (OrderCancelReportMB) MBUtil
			.getManageBean("#{orderCancelReportMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>取消待处理订单报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="取消待处理订单报表">
		<script type='text/javascript' src='ordercancelreport.js'></script>
	</head>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>取消待处理订单报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{orderCancelReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{orderCancelReportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','sk_start_date,sk_end_date,biid,inna,inco,crna,dety,orid,dpid,dpna');" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" reRender="output" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{orderCancelReportMB.LST}">
						<div id="mmain_cnd">
							销售单号:
							<h:inputText id="biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{orderCancelReportMB.biid}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{orderCancelReportMB.inco}" />
							<br>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
										select DISTINCT a.biid,b.inco,sum(b.qty) as qty,d.inna,d.inse,d.colo,a.crdt from obma a right join obbm c on a.biid=c.biid join oubd b on a.biid=b.biid join inve d on b.inco=d.inco 
											where a.flag < 31 and a.biid is not null and c.biid is not null and b.biid is not null 
											#{orderCancelReportMB.searchSQL}
											group by a.biid,b.inco,d.inna,d.inse,d.colo,a.crdt 
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 商品编码,name = biid,width = 120,headtype = sort,align = left,type = string,datatype=string);
											gcid = inco(headtext = 商品编码,name = mpinco,width = 120,headtype = sort,align = left,type = string,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 100,headtype = sort,align = left,type = string,datatype=string);
											gcid = colo(headtext = 规格,name = inst,width = 80,headtype = sort,align = left,type = string,datatype=string);
											gcid = inse(headtext = 规格码,name = inse,width = 80,headtype = sort,align = left,type = string,datatype=string);
											gcid = crdt(headtext = 创建时间,name = crdt,width = 120,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
										    gcid = qty(headtext = 数量,name = qty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);											
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
