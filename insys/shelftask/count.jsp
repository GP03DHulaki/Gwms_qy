<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>当前区域所有商品</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="当前区域所有商品">
	<meta http-equiv="description" content="当前区域所有商品">
	<script type="text/javascript" src="sepcar.js"></script>
</head>
<body id="mmain_body">
	<f:view>
	<h:form id="edit">
		<g:GTable gid="gtable" gtype="grid" gdebug="false"
			gselectsql="select id_id,'IVEIKSK' as a,'TEST10' as b,'DSQQQQVIDEICF' as c,'4*7' as d,'件' as e,800 as f,mtxt from temp 
						union select id_id,'WREGEQ' as a,'TEST11' as b,'IIKRIJOWKC' as c,'6*3' as d,'件' as e,700 as f,mtxt from temp  "
			gpage="(pagesize = -1)" gversion="2"
			gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = hidden,headtype = checkbox);
						gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
						gcid = 2(headtext = 商品编码,name = vc_invcode,width = 120,align = left,type = text,headtype = sort,datatype = string);
						gcid = 3(headtext = 商品名称,name = nv_invname,width = 120,align = left,type = text,headtype = sort,datatype = string);
						gcid = 4(headtext = 商品条码,name = vc_barcode,width = 120,align = left,type = text,headtype = sort,datatype = string);
						gcid = 5(headtext = 规格,name = vc_invstandard,width = 120,align = left,type = text,headtype = sort,datatype = string);
						gcid = 6(headtext = 单位,name = vc_invunit,width = 40,align = center,type = text,headtype = hidden,datatype = string);
						gcid = 7(headtext = 数量,name = qty,width = 80,align = right,type = text ,headtype= sort, datatype =number,dataformat=0.##);
						" />
	</h:form>
	</f:view>
</body>
</html>