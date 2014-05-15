<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.OrderCountMB"%>

<%
	OrderCountMB ai = (OrderCountMB) MBUtil
		.getManageBean("#{orderCountMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
	if (request.getParameter("type") != null) {
		ai.setType(request.getParameter("type"));
	}
	
	if (request.getParameter("crus") != null) {
		ai.setCrus(request.getParameter("crus"));		
	}
	
	if (request.getParameter("lpco") != null) {
		ai.setLpco(request.getParameter("lpco"));		
	}
	ai.searchReportEx(); 
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
			<a href="personnelstockreport.jsf?isAll=true"
				title="返回" class="return">员工出库明细报表</a>&gt;&gt;
			</font>
			<b>员工出库明细报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{orderCountMB.LST}">
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
											SELECT c.inty,a.inco,c.biid,SUM(a.qty) AS qty,b.chus,b.chna,b.crdt
												FROM lode a JOIN loma b ON a.biid=b.biid 
												JOIN obma c ON a.obid=c.biid
												WHERE b.flag='11' #{orderCountMB.searchSQL}
												GROUP BY c.inty,b.chus,b.chna,b.crdt,a.inco,c.biid												
										"
										gpage="(pagesize = 30)"
										gcolumn="											
											gcid = 0(headtext = 行号,name = chus,width = 30,headtype = text,align = center,type = text,datatype=string);	
										    gcid = inty(headtext = 单据类型,name = inty,width = 120,align = center,type = mask,headtype = sort,datatype = string,typevalue=S:一单一货/M:一单多货);
										     gcid = biid(headtext = 单号,name = pbid,width =150,align = left,type = text,datatype=string);
										    gcid = inco(headtext = 商品编码,name = inco,width =100,align = left,type = text,datatype=string);
										    gcid = crdt(headtext = 日期,name = cpri,width = 120,align = left,type = text,datatype=datetime,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);										   
										    gcid = chus(headtext = 用户编码,name = chus,width =100,align = left,type = text,datatype=string);
										    gcid = chna(headtext = 用户名称,name = chna,width =100,align = left,type = text,datatype=string);
										    gcid = qty(headtext = 数量,name = qty,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{orderCountMB.msg}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
