<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>上架任务中商品</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="上架任务中商品">
	<meta http-equiv="description" content="上架任务中商品">
	<script type="text/javascript" src="shelf.js"></script>

</head>
<body id="mmain_body">
	<f:view>
	<h:form id="edit">
		<g:GTable gid="gtable" gtype="grid" gversion="2"
				gselectsql="select a.inco, b.inna,b.inst,b.inun,b.colo,b.inse ,sum(a.qty) as qty,ISNULL(c.qty,0) as yqty
							from stnu a left join inve b on a.inco=b.inco
							left join (
								select a.biid,a.fwid,b.inco,sum(b.qty) as qty from slma a left join slde b on a.biid=b.biid  where a.biid='#{shelvMB.mbean.biid}'
								group by a.biid,a.fwid,b.inco) c on a.whid=c.fwid and a.inco=c.inco
								where a.whid='#{shelvMB.mbean.fwid}'
							group by  a.inco,b.inna,b.inst,b.inun,b.colo,b.inse,c.qty
							"
				gwidth="550" gpage="(pagesize = -1)" gdebug ="false"
				gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
						gcid = inco(headtext = 商品编码,name = vc_invcode,width = 120,headtype = sort,align = left,type = text,datatype=string);
						gcid = inna(headtext = 商品名称,name = nv_invname,width = 140,headtype = sort,align = left,type = text,datatype=string);
						gcid = colo(headtext = 规格,name = colo,width = 60,headtype = sort,align = left,type = text,datatype=string);
						gcid = inse(headtext = 规格码,name = inse,width = 80,headtype = sort,align = left,type = text,datatype=string);			
						gcid = qty(headtext = 数量,name = dc_qty,width = 80,align = right,type = text ,headtype=sort, datatype =number,dataformat=0.##);
						gcid = yqty(headtext = 已上架数量,name = dc_yqty,width = 80,align = right,type = text ,headtype=sort, datatype =number,dataformat=0.##);
						" />
	</h:form>
	</f:view>
</body>
</html>