<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import=" com.gwall.sys.UnwriteBackMB"%>

<%
	UnwriteBackMB ai = (UnwriteBackMB) MBUtil.getManageBean("#{unwriteBackMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>未回写单据汇总</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="未回写单据汇总">
		<link href="<%=request.getContextPath()%>/gwall/all.css" rel="stylesheet" type="text/css" />
		<script src="<%=request.getContextPath()%>/gwall/all.js"></script>
		<script src="unwriteback.js"></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">系统管理&gt;&gt;</font>
			<b>待同步单据列表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<h:panelGroup id="sp" rendered="#{unwriteBackMB.LST}">
							<a4j:commandButton id="searchButton" value="查询" type="button"
								action="#{unwriteBackMB.search}"
								onclick="if(search()==false){return false;}" reRender="output"
								oncomplete="endDo();" requestDelay="50"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
							<a4j:commandButton id="resetButton" value="重置" type="button"
								onclick="if(doClearData()==false){return false;}"
								requestDelay="50" onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						</h:panelGroup>
					</div>
					<a4j:outputPanel id="sps" rendered="#{unwriteBackMB.LST}">
						<div id=mmain_cnd>
							异常时间从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{unwriteBackMB.sk_start_date}" />
							至:
							<h:inputText id="sk_end_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{unwriteBackMB.sk_end_date}" />
							模块名称:
							<h:selectOneMenu id="moid" value="#{unwriteBackMB.moid}" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="生产入库" itemValue="moin" />
								<f:selectItem itemLabel="采购入库" itemValue="poin" />
								<f:selectItem itemLabel="其它入库" itemValue="otherin" />
								<f:selectItem itemLabel="销售退货入库" itemValue="SALERETURN" />
								<f:selectItem itemLabel="采购退货出库" itemValue="PURCHASRETURN" />
								<f:selectItem itemLabel="调拨入库" itemValue="TRANIN" />
								<f:selectItem itemLabel="调拨出库" itemValue="TRANOUT" />
								<f:selectItem itemLabel="出库单" itemValue="stockout" />
								<f:selectItem itemLabel="其它出库" itemValue="otherout" />
							</h:selectOneMenu>
							单据编号:
							<h:inputText id="biid" value="#{unwriteBackMB.biid}"
								styleClass="inputtextedit" />
							<h:outputText value="组织架构:" >
							</h:outputText>
							<h:selectOneMenu id="orid" value="#{unwriteBackMB.orid}" onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue=""/>	
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>	
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gsort="lati"
							gsortmethod="Desc" gversion="2"
							gselectsql="
								SELECT a.biid,a.moid,m.mona,a.lati,a.orid,g.orna,a.ryti FROM erbi a
									 left JOIN modu m ON m.moid = a.moid
									 left JOIN orga g ON g.orid = a.orid
									where a.stat=0 AND a.moid='STOCKOUT' AND a.#{unwriteBackMB.gorgaSql} #{unwriteBackMB.searchSQL}"
							gpage="(pagesize = 30)" gdebug = "false"
							gcolumn="gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
								gcid = orna(headtext = 组织架构,name = mona,width = 140,headtype = sort,align = left,type = text,datatype=string);
								gcid = mona(headtext = 模块名称,name = mona,width = 140,headtype = sort,align = left,type = text,datatype=string);
								gcid = biid(headtext = 单据编号,name = biid,width = 140,headtype = sort,align = left,type = text,datatype=string);
								gcid = lati(headtext = 时间,name = lati,width = 140,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm:ss);
								gcid = ryti(headtext = 失败次数,name = ryti,width = 60,align = right,type = text,headtype = sort ,datatype = number,dataformat=0,bgcolor={gcolumn[ryti]>5:#FF0000/gcolumn[ryti]>0:#FFFF00/gcolumn[ryti]=0:#FFFFFF});
								" />
					</a4j:outputPanel>
				</h:form>
			</f:view>
		</div>
	</body>
</html>