<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.MoinReportMB"%>

<%
	MoinReportMB ai = (MoinReportMB) MBUtil.getManageBean("#{moinReportMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>生产入库报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="生产入库报表">
		<script type='text/javascript' src='moinsearch.js'></script>
	</head>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain_nav>
			<font color="#000000">入库单统计&gt;&gt;</font>
			<b>生产入库报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{moinReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{moinReportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','sk_start_date,soco,sk_end_date,biid,soco,inna,inco,colo,crna,whid,whna');" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="excel" value="导出EXCEL" type="button"
								action="#{moinReportMB.exportProcedureProduct}" reRender="msg,outPutFileName"
								onclick="excelios_begin('gtable');" oncomplete="excelios_end();" requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{moinReportMB.LST}">
						<div id="mmain_cnd">
							创建日期从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="10"
								value="#{moinReportMB.sk_start_date}" onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="10"
							value="#{moinReportMB.sk_end_date}" onfocus="#{gmanage.datePicker}" />
							入库单号:
							<h:inputText id="biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{moinReportMB.biid}" />
							计划单号:
							<h:inputText id="soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{moinReportMB.soco}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{moinReportMB.inco}" />
							<br>
							商品名称:
							<h:inputText id="inna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{moinReportMB.inna}" />
							规格:
							<h:inputText id="colo" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{moinReportMB.colo}" />
							入库人:
							<h:inputText id="crna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{moinReportMB.crna}" />
							<h:outputText value="入库仓库:">
							</h:outputText>
							<h:inputText id="whna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{moinReportMB.whna}" />
							<img id="owid_img" style="cursor: hand;"
											src="../../images/find.gif" 
								onclick="return selectWaho();" />
								<h:inputHidden id='whid' value="#{moinReportMB.whid}"></h:inputHidden>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false" gsort="crdt" gsortmethod="desc"
										gselectsql="
										SELECT c.biid,s.biid as soco,t.inco,v.inna,v.colo,v.inse,c.crdt,c.crna,w.whna,sum(s.qty) as jqty,sum(t.qty) AS rqty  from csma c JOIN csde t ON
											 	c.biid = t.biid 
										 	  join ctde s on s.biid = c.soco AND s.inco = t.inco
										 	LEFT JOIN inve v ON v.inco = t.inco
										 	left join waho w on w.whid = c.whid
										 where 1 = 1 #{moinReportMB.initCondition} #{moinReportMB.searchSQL}
											GROUP BY c.biid,t.inco,v.inna,v.inst,v.colo,c.crna,c.crdt,s.biid,w.whna,v.inse;
										"gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 入库单号,name = mpbiid,width =100,headtype = sort,align = left,type = text,datatype=string);
											gcid = soco(headtext = 计划单号,name = mpbiid,width =100,headtype = sort,align = left,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = mpinco,width = 110,headtype = sort,align = left,type = string,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 130,headtype = sort,align = left,type = string,datatype=string);
											gcid = colo(headtext = 规格,name = colo,width = 100,headtype = sort,align = left,type = string,datatype=string);
											gcid = inse(headtext = 规格码,name = inse,width = 80,headtype = sort,align = left,type = string,datatype=string);
										   	gcid = crdt(headtext = 创建时间,name = crdt,width = 70,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
										   	gcid = crna(headtext =入库人,name = mpinco,width = 50,headtype = sort,align = left,type = string,datatype=string);
										   	gcid = whna(headtext =入库仓库,name = mpinco,width = 100,headtype = sort,align = left,type = string,datatype=string);
										   	gcid = jqty(headtext = 计划数量,name = jqty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = rqty(headtext = 入库数量,name = rqty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{moinReportMB.msg}" />
							<h:inputHidden id="gsql" value="#{moinReportMB.gsql}" />
							<h:inputHidden id="outPutFileName" value="#{moinReportMB.outPutFileName}" />
						</a4j:outputPanel>
						<%-- 
						Select  INVE.inco , INVE.inna , INVE.colo ,INVE.inst , a.whid ,a.whna as awhna ,STNU.aqty ,STNU.qty,
                        STNU.uqty ,STNU.lqty, GRAND.pwid ,b.whna as bwhna from INVE,WAHO as a,STNU,f_stockSearch_selectGrandpa() as GRAND,WAHO as b
                        where INVE.inco=STNU.baco and a.whid=STNU.whid and CONVERT(VARCHAR(50),GRAND.whid)=a.whid 
                        and CONVERT(VARCHAR(50),GRAND.pwid)=b.whid  #{receptSummary.searchSQL}
						--%>

					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
