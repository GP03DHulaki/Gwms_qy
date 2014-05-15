<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.report.WeighMB"%>

<%
	WeighMB ai = (WeighMB) MBUtil
			.getManageBean("#{weighMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>包装耗材使用查询报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="出库订单报表">
		<script type='text/javascript' src='weighreport.js'></script>
	</head>
	<body id="mmain_body">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>包装耗材使用查询报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
				<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{weighMB.msg}" />
							<h:inputHidden id="gsql" value="#{weighMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{weighMB.outPutFileName}" />
						</a4j:outputPanel>
				   </div>
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{weighMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{weighMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','cuna,sk_start_date,sk_end_date,biid,inna,inco,colo,chna,orna,orid,soco,flag,cbid,sk_chdt_start,sk_chdt_end,rema');" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{weighMB.export}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{weighMB.LST}">
						<div id="mmain_cnd">
							称重日期从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="10"
								value="#{weighMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="10"
								value="#{weighMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							快递单号:
							<h:inputText id="biid" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{weighMB.loco}" />
							包装箱编码:
							<h:inputText id="inco" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{weighMB.inco}" />
							称重操作人:
							<h:inputText id="chna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{weighMB.usna}" />
							
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gselectsql="
											select b.biid,a.loco,a.inco,c.inna,a.crna,a.crdt,g.usna,
												'1' as qty
												from coma a 
												left join obma b on a.loco=b.loco
												left join inve c on a.inco=c.inco
												left join usin g on g.usid=a.crna
												where 1 = 1 #{weighMB.searchSQL}
											;
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 销售订单号,name = biid,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = loco(headtext = 快递单号,name = loco,width = 120,align = center,type = mask,typevalue=01:制作之中/08:文员审核/11:正式单据/21:出库中/13:已分配任务/15:计划装车/16:分拣中/17:分拣完成/31:已完成/19:装车中/100:已关闭,headtype = sort,datatype = string);
											gcid = inco(headtext = 包装箱编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = inna(headtext = 包装箱名称,name = inna,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = qty(headtext = 包装箱数量,name = qty,width = 120,align = center,type = text,headtype = sort,datatype = string);
											gcid = usna(headtext = 操作人,name = qty,width = 70,align = center,type = text,headtype = sort,datatype = string);
											gcid = crdt(headtext = 称重日期,name = crdt,width = 120,align = center,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
											
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
