<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.InitreplenishOrderMB"%>

<%
InitreplenishOrderMB ai = (InitreplenishOrderMB) MBUtil
		.getManageBean("#{InitreplenishOrderMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
	if (request.getParameter("inco") != null) {
		ai.setSk_inco(request.getParameter("inco"));
	}
	ai.searchJqty();
	String num=(String)MBUtil.getManageBean("#{InitreplenishOrderMB.searchSQL}");
	String num1=(String)MBUtil.getManageBean("#{InitreplenishOrderMB.gorid}");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>在架数量列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="在架数量">
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<a href="initreplenishOrder.jsf?"
				title="返回" class="return">主动补货订单列表</a>&gt;&gt;
			<b>在架数量列表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
										SELECT b.inco,d.inna,d.inse,b.qty,b.whid,d.colo FROM stnu b JOIN waho c ON b.whid=c.whid join inve d ON b.inco=d.inco
										WHERE c.whty='6' AND c.orid='#{InitreplenishOrderMB.gorid}' #{InitreplenishOrderMB.searchSQL}
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = inco,width = 30,headtype = text,align = center,type = text,datatype=string);										    
										    gcid = inco(headtext = 商品编码,name = inco,width =120,align = left,type = text,datatype=string);
										    gcid = inna(headtext = 商品名,name = inna,width = 120,align = right,type = string,datatype=string);
										    gcid = colo(headtext = 规格,name = colo,width = 120,align = right,type = string,datatype=string);
										    gcid = inse(headtext = 规格码,name = inse,width = 120,align = right,type = string,datatype=string);
										    gcid = qty(headtext = 数量,name = qty,width =100,align = right,type = text,,datatype=number,dataformat={0});
										    gcid = whid(headtext = 移动库位编码,name = whid,width = 120,headtype = sort,align = right,type = string,datatype=string);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{InitreplenishOrderMB.msg}" />						
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>