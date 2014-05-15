<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.OrderFlowMB"%>

<%
	OrderFlowMB ai = (OrderFlowMB) MBUtil
			.getManageBean("#{orderFlowMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>出库订单流转报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="出库订单流转报表">
		<script type='text/javascript' src='orderflow.js'></script>
	</head>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>出库订单流转报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
				<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{orderFlowMB.msg}" />
							<h:inputHidden id="gsql" value="#{orderFlowMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{orderFlowMB.outPutFileName}" />
						</a4j:outputPanel>
				   </div>
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{orderFlowMB.LST}">
							<gw:GAjaxButton id="sid" value="查询" type="button" theme="b_theme"
								onclick="if(!startDo()){return false;};"
								oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
								action="#{orderFlowMB.search}" />
							<gw:GAjaxButton value="重置" theme="b_theme"
								onclick="textClear('edit','biid');" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{orderFlowMB.export}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
						
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{orderFlowMB.LST}">
						<div id="mmain_cnd">
							请输入
							<span style="color: red;"><B>销售订单号</B>
							</span> 或
							<span style="color: red;"><B>调拨计划单号</B>
							</span> :
							<h:inputText id="biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{orderFlowMB.biid}" />
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										 gsortmethod="ASC"
										gselectsql="
										SELECT buty,biid,soty,soco,crna,crdt,chna,chdt,flag,rema FROM (
										SELECT '1' as sx,buty,biid,soty,soco,crna,crdt,chna,chdt,flag,rema FROM ppma WHERE biid = '#{orderFlowMB.biid}'  
										UNION ALL 
										SELECT '2' as sx,buty,biid,soty,soco,crna,crdt,chna,chdt,flag,rema FROM obma WHERE biid = '#{orderFlowMB.biid}'  
										UNION ALL 
										SELECT '3' as sx,buty,biid,soty,soco,crna,crdt,chna,chdt,flag,rema FROM ltma WHERE biid IN (SELECT DISTINCT biid FROM ltde WHERE oubi = '#{orderFlowMB.biid}')  
										UNION ALL 
										SELECT '4' as sx,buty,biid,soty,soco,crna,crdt,chna,chdt,flag,rema FROM ptma WHERE biid IN (SELECT DISTINCT biid FROM pkln WHERE oubi = '#{orderFlowMB.biid}')  
										UNION ALL  
										SELECT '5' as sx,buty,biid,soty,soco,crna,crdt,chna,chdt,flag,rema FROM pkma WHERE soco IN (SELECT biid FROM ptma WHERE biid IN (SELECT DISTINCT biid FROM pkln WHERE oubi = '#{orderFlowMB.biid}'))  
										UNION ALL  
										SELECT '6' as sx,buty,biid,soty,soco,crna,crdt,chna,chdt,flag,rema FROM spma WHERE soco IN (SELECT biid FROM pkma WHERE soco IN (SELECT biid FROM ptma WHERE biid IN (SELECT DISTINCT biid FROM pkln WHERE oubi = '#{orderFlowMB.biid}')))   
										UNION ALL  
										SELECT '7' as sx,buty,biid,soty,soco,crna,crdt,chna,chdt,flag,rema FROM loma WHERE biid IN (SELECT DISTINCT biid FROM lobd WHERE obid = '#{orderFlowMB.biid}')   
										UNION ALL  
										SELECT '8' as sx,buty,biid,soty,soco,crna,crdt,chna,chdt,flag,rema FROM rema WHERE soco = '#{orderFlowMB.biid}'   
										UNION ALL  
										SELECT '9' as sx,buty,biid,soty,soco,crna,crdt,chna,chdt,flag,rema FROM olma WHERE soco = '#{orderFlowMB.biid}'   
										UNION ALL  
										SELECT '9' as sx,buty,biid,soty,soco,crna,crdt,chna,chdt,flag,rema FROM pbma WHERE soco = '#{orderFlowMB.biid}'  
										) a 
										"
										gpage="(pagesize = -1)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = buty(headtext = 单据类型,name = mpbiid,width =70,headtype = sort,align = left,type = mask,typevalue=OUTORDER:出库订单/ENTRUCKPLAN:备货计划/PICKTASK:备货任务/PICKDOWN:拣货下架/pickdown:拣货下架/SECSORT:二次分拣/TRUCKORDER:装车单/oqc:出库复核/TRANPLAN:调拨计划/TRANOUT:调拨出库/STOCKOUT:出库单,datatype=string);
											gcid = biid(headtext = 单据单号,name = mpbiid,width =110,headtype = sort,align = left,type = text,datatype=string);
											gcid = soty(headtext = 来源类型,name = mpbiid,width =70,headtype = sort,align = left,type = mask,typevalue=OUTORDER:出库订单/ENTRUCKPLAN:备货计划/PICKTASK:备货任务/PICKDOWN:拣货下架/pickdown:拣货下架/SECSORT:二次分拣/TRUCKORDER:装车单/oqc:出库复核/TRANPLAN:调拨计划/TRANOUT:调拨出库/STOCKOUT:出库单,datatype=string);
											gcid = soco(headtext = 来源单号,name = mpbiid,width =110,headtype = sort,align = left,type = text,datatype=string);
											gcid = crna(headtext = 创建人,name = sina,width = 60,align = left,type = text,headtype = sort,datatype= string);
											gcid = crdt(headtext = 创建时间,name = sina,width = 120,align = left,type = text,headtype = sort,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = chna(headtext = 审核人,name = sina,width = 60,align = left,type = text,headtype = sort,datatype= string);
											gcid = chdt(headtext = 审核时间,name = sina,width = 120,align = left,type = text,headtype = sort,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = flag(headtext = 状态,name = flag,width = 70,align = center,type = mask,typevalue=01:制作之中/08:文员审核/11:正式单据/15:计划装车/16:分拣中/17:分拣完成/19:装车中/21:出库中/30:异常完成/31:已完成/100:已关闭,headtype = sort,datatype = string);
											gcid = rema(headtext = 备注,name = rema,width = 290,align = left,type = text,headtype = sort,datatype = string);
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
