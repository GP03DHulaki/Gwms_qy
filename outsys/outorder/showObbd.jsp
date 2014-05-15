<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>KA单据花色调整差异明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="KA单据花色调整差异明细">
		<meta http-equiv="description" content="KA单据花色调整差异明细">
		<script type="text/javascript" src="outorder.js"></script>
	</head>
	<body>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<a4j:outputPanel id="show">
						<g:GTable gid="gtable1" gtype="grid" gdebug="false"
							gselectsql="SELECT case when t.asco IS NULL THEN p.asco ELSE t.asco END AS asco,p.inna,isnull(p.qty,0)-ISNULL(t.qty,0) AS qty
									FROM (SELECT asco,qty,inna FROM obbd WHERE biid = '#{outOrderMB.mbean.biid}') p 
									FULL JOIN (SELECT b.asco,SUM(isnull(qty,0)) AS qty FROM oubd a JOIN inve b 
									ON a.inco = b.inco WHERE a.biid = '#{outOrderMB.mbean.biid}'
									GROUP BY b.asco) t ON p.asco=t.asco
									WHERE isnull(p.qty,0)-ISNULL(t.qty,0)<>0"
							gpage="(pagesize = -1)" gversion="2"
							gcolumn="
								gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
								gcid = asco(headtext = ERP编码,name = asco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inna(headtext = 商品名称,name = inna,width = 200,align = left,type = text,headtype = sort ,datatype = string);
								gcid = qty(headtext = 数量,name = qty,width = 90,align = right,type = text,headtype = sort ,datatype = number,dataformat=0.##);
					" />
					</a4j:outputPanel>
				</div>
			</h:form>
		</f:view>
	</body>
</html>