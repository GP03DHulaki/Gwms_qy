<%@ page language="java" pageEncoding="utf-8"%><%@ include file="../../include/include_imp.jsp" %>
<html>
	<head>
		<title>采购订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="采购订单">
		<meta http-equiv="description" content="采购订单">
	</head>
	<body>
		<f:view>
			<h:form id="edit">
				<g:GTable gid="gtable" gversion="2" gtype="grid" gdebug="false" 
					gselectsql="SELECT a.biid,a.ceve,a.crna,a.pudt,a.rema FROM pubm a "
					gpage="(pagesize = 6)"
					gcolumn="
						gcid = 0(headtext = 行项目,name = vc_row,width = 100,headtype = sort,align = center,type = text,datatype=string);
						gcid = biid(headtext = 采购订单号,name = biid,width = 100,headtype = sort,align = left,type = text,datatype=string);
						gcid = ceve(headtext = 供应商名称,name = ceve,width = 200,headtype = sort,align = left,type = text,datatype=string);
						gcid = crna(headtext = 制单人,name = crna,width = 110,headtype = sort,align = left,type = text,datatype=string);
						gcid = pudt(headtext = 采购日期,name = pudt,width = 120,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
						gcid = rema(headtext = 备注,name = rema,width = 140,headtype = sort,align = right,type = text,datatype=string);
					" />
			</h:form>
		</f:view>
	</body>
</html>
