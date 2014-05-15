<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.report.OtherInReportMB"%>

<%
	OtherInReportMB ai = (OtherInReportMB) MBUtil
			.getManageBean("#{otherInReportMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>其他入库报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="入库采集统计">
		<script type='text/javascript' src='otherinreport.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>其他入库报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{otherInReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{otherInReportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','biid,inco,sk_inse,usid,usna,start_date,end_date');" />
						</a4j:outputPanel>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{otherInReportMB.exportXls}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{otherInReportMB.LST}">
						<div id="mmain_cnd">
							入库时间从:
							<h:inputText id="start_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{otherInReportMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{otherInReportMB.sk_end_date}" />
							入库单号:
							<h:inputText id="biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{otherInReportMB.biid}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{otherInReportMB.inco}" />
								规格码:
							<h:inputText id="sk_inse" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{otherInReportMB.inse}" />
							用户编码:
							<h:inputText id="usid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{otherInReportMB.usid}" />
							用户名称:
							<h:inputText id="usna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{otherInReportMB.usna}" />	
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT a.biid,a.dety,a.chus,a.chna,a.chdt,b.inco,SUM(b.qty) AS qty,c.inna,c.colo,c.inse,a.crdt FROM oima a 
											JOIN oide b ON a.biid=b.biid 
											LEFT JOIN inve c ON b.inco=c.inco
											WHERE a.flag='11' #{otherInReportMB.searchSQL}
											GROUP BY a.biid,a.dety,a.chus,a.chna,a.chdt,b.inco,c.inna,c.colo,c.inse,a.crdt
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 入库单号,name = biid,width =120,headtype = sort,align = left,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = inco,width =110,headtype = sort,align = left,type = text,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width =110,headtype = sort,align = left,type = text,datatype=string);
											gcid = colo(headtext = 规格,name = colo,width =60,headtype = sort,align = left,type = text,datatype=string);
											gcid = inse(headtext = 规格码,name = inse,width = 60,headtype = sort,align = left,type = text,datatype=string);
										    gcid = qty(headtext = 数量,name = qty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = dety(headtext = 业务类型,name = dety,width = 80,align = center,type = mask,typevalue=01:还回入库/02:赠品入库/03:其他入库,headtype = sort,datatype = string);
										    gcid = chus(headtext = 用户编码,name = chus,width =80,headtype = sort,align = left,type = text,datatype=string);
										    gcid = chna(headtext = 用户名称,name = chna,width =80,headtype = sort,align = left,type = text,datatype=string);
										    gcid = crdt(headtext = 创建时间,name = crdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
										    gcid = chdt(headtext = 入库时间,name = chdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{otherInReportMB.msg}" />
							<h:inputHidden id="gsql" value="#{otherInReportMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{otherInReportMB.outPutFileName}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='picksche_edit.jsf'"
							style="display:none;" />
						<%-- 
						Select  INVE.inco , INVE.inna , INVE.colo ,INVE.inst , a.whid ,a.whna as awhna ,STNU.aqty ,STNU.qty,
                        STNU.uqty ,STNU.lqty, GRAND.pwid ,b.whna as bwhna from INVE,WAHO as a,STNU,f_stockSearch_selectGrandpa() as GRAND,WAHO as b
                        where INVE.inco=STNU.baco and a.whid=STNU.whid and CONVERT(VARCHAR(50),GRAND.whid)=a.whid 
                        and CONVERT(VARCHAR(50),GRAND.pwid)=b.whid  #{otherInReportMB.searchSQL}
						--%>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
