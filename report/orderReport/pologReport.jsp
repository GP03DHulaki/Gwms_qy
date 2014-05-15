<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@ page import="com.gwall.view.report.PologReportMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title>采购订单调整日志报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="采购订单调整日志报表">
		<meta http-equiv="description" content="采购订单调整日志报表">
	</head>
	<%
		PologReportMB ai = (PologReportMB) MBUtil.getManageBean("#{pologReportMB}");
	    if (request.getParameter("isAll") != null) {
	        ai.initSK();
	    }
	%>
	<body id="mmain_body">
		<div id="mmain_nav">
			<b><font color="#000000">采购订单调整日志报表</font></b>
			<br>
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="list">
					<div id="mmain_opt">
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							onclick="search();"
							action="#{pologReportMB.search}" requestDelay="50"
							oncomplete="endSearch()" rendered="#{pologReportMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearData();" rendered="#{pologReportMB.LST}" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							onclick="reportExcel('gtable')" type="button"
							reRender="output,msg" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="单号:">
						</h:outputText>
						<h:inputText id="sk_biid" styleClass="datetime" size="15"
							value="#{pologReportMB.sk_biid}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品编码:">
						</h:outputText>
						<h:inputText id="sk_inco" styleClass="datetime" size="15"
							value="#{pologReportMB.sk_inco}" onkeypress="formsubmit(event);" />		
						<h:outputText value="操作人:">
						</h:outputText>
						<h:inputText id="sk_crna" styleClass="datetime" size="15"
							value="#{pologReportMB.sk_crna}" onkeypress="formsubmit(event);" />
						日期从:
						<h:inputText id="start_date" styleClass="datetime" size="15"
							onfocus="#{gmanage.datePicker}"
							value="#{pologReportMB.sk_bdate}" />
						至:
						<h:inputText id="end_date" styleClass="datetime" size="15"
							onfocus="#{gmanage.datePicker}"
							value="#{pologReportMB.sk_edate}" />
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="select a.id,a.biid,a.inco,a.buty,a.qty,a.uqty,a.crus,a.crna,a.crdt,b.inna,b.inse,b.colo from olog a join inve b on a.inco=b.inco where 1=1 #{pologReportMB.searchSQL}"
							gpage="(pagesize = 20)" gversion="2" gdebug="false" gsort="id" gsortmethod="DESC"
							gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
								gcid = biid(headtext = 单号,name = biid,width = 120,align = left,type = text,headtype = sort,datatype = string);
								gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort,datatype = string);
								gcid = colo(headtext = 规格,name = colo,width = 100,align = left,type = text,headtype = sort,datatype = string);
								gcid = inse(headtext = 规格码,name = inse,width = 60,align = left,type = text,headtype = sort,datatype = string);
								gcid = qty(headtext = 原始数量,name = qty,width = 80,align = right,type = text,headtype=sort, datatype =number,dataformat=0.##,summary=this);
								gcid = uqty(headtext = 更新数量,name = uqty,width = 80,align = right,type = text,headtype=sort, datatype =number,dataformat=0.##,summary=this);
								gcid = crna(headtext = 操作人,name = crna,width = 80,align = left,type = text,headtype = sort,datatype = string);
								gcid = crdt(headtext = 操作时间,name = crdt,width = 160,align = left,type = text,headtype = sort,datatype = string);
								" />
					</a4j:outputPanel>
				</h:form>
			</div>
		</f:view>
	</body>
</html>
<script>
function clearSearchKey(){
	textClear('list','sk_biid,sk_inco,sk_crna,sk_bdate,sk_edate','Y');
}
</script>