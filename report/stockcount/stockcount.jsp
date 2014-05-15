<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@	page import="com.gwall.view.StockCountMB"%>

<%
    StockCountMB ai = (StockCountMB) MBUtil
            .getManageBean("#{stockCountMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSK();
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>盘点操作报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="盘点操作报表">
		<script type='text/javascript' src='stockcount.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>盘点操作报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{StockCountMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{stockCountMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','sk_start_date,sk_inse,sk_end_date,biid,inna,whna,soco,flag,inco,colo,crna,orna,orid');" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{stockCountMB.export}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{stockCountMB.LST}">
						<div id="mmain_cnd">
							创建日期从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="10"
								value="#{stockCountMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="10"
								value="#{stockCountMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							盘点单号:
							<h:inputText id="biid" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{stockCountMB.biid}" />
							计划单号:
							<h:inputText id="soco" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{stockCountMB.soco}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{stockCountMB.inco}" />
							盘点货位:
							<h:inputText id="whna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{stockCountMB.whna}" />
							<br>
							商品名称:
							<h:inputText id="inna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{stockCountMB.inna}" />
							规格:
							<h:inputText id="colo" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{stockCountMB.colo}" />
							规格码:
							<h:inputText id="sk_inse" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{stockCountMB.inse}" />
							制单人:
							<h:inputText id="crna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{stockCountMB.crna}" />
							组织架构:
							<h:selectOneMenu id="orid" value="#{stockCountMB.orid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
							单据状态:
							<h:selectOneMenu id="flag" value="#{stockCountMB.flag}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="制作之中" itemValue="01" />
								<f:selectItem itemLabel="正式单据" itemValue="11" />
								<f:selectItem itemLabel="出库中" itemValue="21" />
								<f:selectItem itemLabel="已完成" itemValue="31" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
										SELECT g.orna,m.biid as mbiid,d.pbid as pbiid,w.whna as cwhna,m.crna,m.chdt,d.inco,v.inna,v.colo,v.inse,m.flag,
												isnull(SUM(d.qty),0) AS rqty,sum(p.qty) as jqty,isnull(SUM(d.qty),0)-sum(p.qty) AS cqty from 
												pema m  JOIN pede d
												ON m.biid = d.biid 
												 join pmde p on p.biid = m.pbid AND p.inco = d.inco AND d.whid = p.whid
												 JOIN inve v ON v.inco = d.inco
												 JOIN waho w  ON w.whid = m.whid
												 join orga g on g.orid = m.orid
											where 1 = 1 #{stockCountMB.initCondition} #{stockCountMB.searchSQL}
											GROUP BY m.biid,d.pbid,m.chdt,m.crna,m.orid,d.inco,v.inna,v.inse,v.colo,w.whna ,m.flag,g.orna	
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 70,headtype = sort,align = left,type = text,datatype=string);
											gcid = mbiid(headtext = 盘点单号,name = biid,width = 90,headtype = sort,align = left,type = text,datatype=string);
											gcid = pbiid(headtext = 计划单号,name = soco,width = 90,headtype = sort,align = left,type = text,datatype=string);
											gcid = cwhna(headtext = 盘点货位,name = whna,width = 90,align = left,type = text,headtype = sort,datatype = string);
											gcid = crna(headtext = 制单人,name = crna,width = 50,align = left,type = text,headtype = sort,datatype = string);
											gcid = chdt(headtext = 创建时间,name = crdt,width = 70,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
											gcid = inco(headtext = 商品编码,name = inco,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = colo(headtext = 规格,name = colo,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = inse(headtext = 规格码,name = inse,width = 100,headtype = sort,align = left,type = text,datatype=string);
										    gcid = flag(headtext = 状态,name = flag,width = 80,align = center,type = mask,typevalue=01:制作之中/11:正式单据,headtype = sort,datatype = string);
										   	gcid = jqty(headtext = 账面数量,name = jqty,width= 60,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
										    gcid = rqty(headtext = 实盘数量,name = rqty,width= 60,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
										    gcid = cqty(headtext = 差异数量,name = cqty,width= 60,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>

					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{stockCountMB.msg}" />
							<h:inputHidden id="gsql" value="#{stockCountMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{stockCountMB.outPutFileName}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
