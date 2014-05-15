<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.report.WaitLoadingMB"%>

<%
	WaitLoadingMB ai = (WaitLoadingMB) MBUtil
			.getManageBean("#{waitLoadingMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>装车调度报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="装车调度报表">
		<script type='text/javascript' src='waitloading.js'></script>
	</head>
	<body id="mmain_body">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>装车调度报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
				<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{waitLoadingMB.msg}" />
							<h:inputHidden id="gsql" value="#{waitLoadingMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{waitLoadingMB.outPutFileName}" />
						</a4j:outputPanel>
				   </div>
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{waitLoadingMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{waitLoadingMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','cuna,sk_start_date,sk_end_date,biid,inna,inco,colo,chna,orna,orid,soco,flag,cbid,sk_chdt_start,sk_chdt_end,rema');" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{waitLoadingMB.export}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{waitLoadingMB.LST}">
						<div id="mmain_cnd">
							打单日期从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="10"
								value="#{orderCountMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="10"
								value="#{orderCountMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							出库复核日期从:
							<h:inputText id="sk_chdt_start" styleClass="datetime" size="10"
								value="#{waitLoadingMB.sk_chdt_start}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_chdt_end" styleClass="datetime" size="10"
								value="#{waitLoadingMB.sk_chdt_end}"
								onfocus="#{gmanage.datePicker}" />
							<br/>
							仓库:
							<h:selectOneMenu id="whid" value="#{waitLoadingMB.whid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{warehouseMB.wareList}" />
							</h:selectOneMenu>
							快递公司:
							<h:selectOneMenu id="lpco" value="#{waitLoadingMB.lpco}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{carrierMB.list}" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gselectsql="select d.whna,c.lpna,COUNT(*) as dqty,SUM(isnull(b.qty,0)) as sqty, 
												 sum(isnull(e.grwe,0)) stawe,sum(isnull(e.volu,0)) svolu from obma a 
												left join oubd b on a.biid=b.biid 
												left join lpin c on a.lpco=c.lpco
												left join waho d on a.whid=d.whid
												left join inve e on b.inco=e.inco
												left join rema f on a.biid=f.soco
												where a.flag='17' and a.stat='20'  #{waitLoadingMB.searchSQL}
												group by d.whna,c.lpna "
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);							
											gcid = whna(headtext = 仓库,name = whna,width = 150,headtype = sort,align = left,type = text,datatype=string);
											gcid = lpna(headtext = 快递公司,name = lpna,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = dqty(headtext = 订单数量,name = dqty,width = 80,align = left,type = text,headtype = sort,datatype =number,dataformat=0.#,summary=this);
											gcid = sqty(headtext = 商品数量,name = sqty,width = 80,align = left,type = text,headtype = sort,datatype =number,dataformat=0.#,summary=this);
											gcid = stawe(headtext = 重量(g),name = stawe,width = 100,align = left,type = text,headtype = sort,datatype =number,dataformat=0.##,summary=this);	
											gcid = svolu(headtext = 体积(m3),name = svolu,width = 130,headtype = sort,align = left,type = text,datatype =number,dataformat=0.##,summary=this);
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
