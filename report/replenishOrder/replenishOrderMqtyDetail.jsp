<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@	page import="com.gwall.view.ReplenishOrderMB"%>

<%
    ReplenishOrderMB ai = (ReplenishOrderMB) MBUtil
            .getManageBean("#{replenishOrderMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSK();
    }
    if (request.getParameter("inco") != null) {
        ai.setSk_inco(request.getParameter("inco"));
    }
    ai.searchMqty();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>在移动库位数量列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="在移动库位数量">
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<a href="replenishOrder.jsf?isAll=0" title="返回" class="return">待补货订单列表</a>&gt;&gt;
			<b>在移动库位数量列表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gselectsql="
										SELECT a.baco,a.inco,a.qty,a.whid,c.inse,c.inna,c.colo
											FROM stnu a 
											JOIN waho b ON a.whid=b.whid 
											join inve c ON a.inco=c.inco
											WHERE b.whty='9' AND a.bxfl='04' AND b.orid='#{replenishOrderMB.gorid}' #{replenishOrderMB.searchSQL}											
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
							<h:inputHidden id="msg" value="#{replenishOrderMB.msg}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>