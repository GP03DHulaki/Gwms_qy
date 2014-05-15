<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.report.OqcReportMB"%>

<%
	OqcReportMB ai = (OqcReportMB) MBUtil
			.getManageBean("#{oqcreportMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
	if (request.getParameter("type") != null) {
		ai.setType(request.getParameter("type"));
	}
	if (request.getParameter("crus") != null) {
		ai.setUsid(request.getParameter("crus"));
	}
	if (request.getParameter("orderFopls") != null) {
		ai.setOrderFopls(request.getParameter("orderFopls"));
	}
	ai.searchEx(); 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>员工绩效</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="员工绩效">
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;
			<a href="oqcreport.jsf?isAll=true"
				title="返回" class="return">出库复核统计报表</a>&gt;&gt;
			</font>
			<b>明细报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{oqcreportMB.LST}">
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" reRender="output" />
						</a4j:outputPanel>						
					</div>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT c.inty,
												a.soco,
												b.inco,
												SUM(b.qty) AS qty,
												a.crus,
												a.crna,
												a.chdt
												FROM rema a JOIN rede b ON a.biid=b.biid 
												JOIN obma c ON a.soco=c.biid
												WHERE 1=1 #{oqcreportMB.searchSQL}
												GROUP BY c.inty,a.soco,a.crus,a.crna,a.chdt,b.inco
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = chus,width = 30,headtype = text,align = center,type = text,datatype=string);	
										    gcid = inty(headtext = 单据类型,name = inty,width = 120,align = center,type = mask,headtype = sort,datatype = string,typevalue=S:一单一货/M:一单多货);
										    gcid = inco(headtext = 物料编码,name = inco,width =100,align = left,type = text,datatype=string);
										    gcid = crdt(headtext = 日期,name = crdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
										    gcid = soco(headtext = 单号,name = soco,width =150,align = left,type = text,datatype=string);
										    gcid = crus(headtext = 用户编码,name = crus,width =100,align = left,type = text,datatype=string);
										    gcid = crna(headtext = 用户名称,name = crna,width =100,align = left,type = text,datatype=string);
										    gcid = qty(headtext = 数量,name = qty,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{oqcreportMB.msg}" />
							<h:inputHidden id="gsql" value="#{oqcreportMB.gsql}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
