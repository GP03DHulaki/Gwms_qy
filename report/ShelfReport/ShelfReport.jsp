<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@	page import="com.gwall.view.report.ShelfReportMB"%>

<%
ShelfReportMB ai = (ShelfReportMB) MBUtil
            .getManageBean("#{shelfReportMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSK();
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>上架统计统计报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="上架统计统计报表">
		<script type='text/javascript' src='summarytotal.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>库存查询汇总报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{shelfReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{shelfReportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','usid,usna,start_date');" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" reRender="output" />
						</a4j:outputPanel>						
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{shelfReportMB.LST}">
						<div id="mmain_cnd">
							开始时间:
							<h:inputText id="start_date" styleClass="datetime" size="12"
								onfocus="#{gmanage.datePicker}"
								value="#{shelfReportMB.sk_start_datetime}" />
							到:
							<h:inputText id="end_date" styleClass="datetime" size="12"
								onfocus="#{gmanage.datePicker}"
								value="#{shelfReportMB.sk_end_datetime}" />
							用户编码:
							<h:inputText id="usid" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{shelfReportMB.usid}" />
							用户名称:
							<h:inputText id="usna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{shelfReportMB.usna}" />
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT b.chna,b.chus,CONVERT(INT,SUM(a.qty)) as qty FROM slde a 
												JOIN slma b ON a.biid=b.biid WHERE b.flag='11'
												AND convert(varchar(20),b.chdt,120) >='#{shelfReportMB.sk_start_datetime}'
												AND convert(varchar(20),b.chdt,120) <='#{shelfReportMB.sk_end_datetime}'
												GROUP BY chna,chus
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = chna(headtext = 用户名,name = chna,width =150,headtype = sort,align = left,type = text,datatype=string);
											gcid = chus(headtext = 用户编码,name = chus,width = 150,headtype = sort,align = left,type = text,datatype=string);
											gcid = qty(headtext = 总数量,name = qty,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
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
