<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@	page import="com.gwall.view.PurchaseReportMB"%>

<%
    PurchaseReportMB ai = (PurchaseReportMB) MBUtil
            .getManageBean("#{purchaseReportMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSK();
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>采购返厂清单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="采购返厂清单">
		<script type='text/javascript' src='poretrunreport.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">入库处理&gt;&gt;</font>
			<b>返厂清单</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{purchaseReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{purchaseReportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','sk_start_date,sk_end_date,biid,soco,inco,inna,orid,whid,whna,stna');" />
							<!-- 
							<gw:GAjaxButton id="otpDBut1" value="导出EXCEL" theme="b_theme"
								onclick="showOutput('gtable')" type="button" reRender="output" />
							 -->
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{purchaseReportMB.LST}">
						<div id="mmain_cnd">
							返厂日期从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="10"
								value="#{purchaseReportMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="10"
								value="#{purchaseReportMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							采购通知单号:
							<h:inputText id="biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{purchaseReportMB.biid}" />
							供应商名称:
							<h:inputText id="stna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{purchaseReportMB.stna}" />
							商品名称:
							<h:inputText id="inna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{purchaseReportMB.inna}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{purchaseReportMB.inco}" />
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT a.soco,a.stus,a.crdt,b.inco,b.qty,c.suna,d.colo,d.inse,d.inna FROM prma a 
											JOIN prde b ON a.biid=b.biid LEFT JOIN suin c ON a.stus=c.suid
											LEFT JOIN inve d ON b.inco=d.inco
										 	WHERE 1 = 1 #{purchaseReportMB.searchSQL}
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = soco(headtext = 采购通知单,name = soco,width =110,headtype = sort,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 返厂日期,name = crdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = stus(headtext = 供应商编码,name = stus,width =120,headtype = hidden,align = left,type = text,datatype=string);
											gcid = suna(headtext = 供应商名称,name = suna, width =150,headtype = sort,align = left,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = mpinco,width = 100,headtype = sort,align = left,type = string,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 150,headtype = sort,align = left,type = string,datatype=string);
											gcid = colo(headtext = 规格,name = colo,width = 90,headtype = sort,align = left,type = string,datatype=string);
											gcid = inse(headtext = 规格码,name = inse,width = 60,headtype = sort,align = left,type = string,datatype=string);
										    gcid = qty(headtext = 退货数量,name = qty,width = 80,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
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
