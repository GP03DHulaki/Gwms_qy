<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
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
    ai.searchBqty();
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
			<a href="initreplenishOrder.jsf" title="返回" class="return">主动补货订单列表</a>&gt;&gt;
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
										SELECT top 100 a.baco,b.inco,b.qty,a.whid FROM stnu a JOIN pain b ON a.baco=b.boco JOIN waho c ON a.whid=c.whid
											WHERE c.whty='5' AND c.orid='#{InitreplenishOrderMB.gorid}' AND a.aqty>0  #{InitreplenishOrderMB.searchSQL}
											ORDER BY a.baco
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = inco,width = 30,headtype = text,align = center,type = text,datatype=string);											   
										    gcid = baco(headtext = 箱条码,name = baco,width =120,align = left,type = text,datatype=string);
										    gcid = inco(headtext = 商品编码,name = inco,width =120,align = left,type = text,datatype=string);
										    gcid = qty(headtext = 可用数量,name = qty,width =100,align = right,type = text,,datatype=number,dataformat={0});
										    gcid = whid(headtext = 库位,name = whid,width = 120,headtype = sort,align = right,type = string,datatype=string);
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