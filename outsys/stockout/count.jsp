<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

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
				gselectsql="select id_id,'IN8BE81' AS a,'TEST01' as b,'IVISKJVISF' AS c,'5*4' AS d,'件' as e,95 as f,  mtxt from temp 
						union select id_id,'BRETDV' AS a,'TEST02' as b,'KKUJNCHND' AS c,'2*7' AS d,'件' as e,81 as f,  mtxt from temp "
				gwidth="550" gpage="(pagesize = -1)"
				growclick="" gdebug ="false"
				gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
						gcid = 2(headtext = 商品编码,name = vc_invcode,width = 120,headtype = sort,align = left,type = text,datatype=string);
						gcid = 3(headtext = 商品名称,name = nv_invname,width = 120,headtype = sort,align = left,type = text,datatype=string);
						gcid = 4(headtext = 商品条码,name = vc_barcode,width = 120,headtype = sort,align = left,type = text,datatype=string);
						gcid = 5(headtext = 规格,name = vc_invstandard,width = 100,headtype = sort,align = left,type = text,datatype=string);
						gcid = 7(headtext = 数量,name = dc_qty,width = 80,align = right,type = text ,headtype=sort, datatype =number,dataformat=0.##);
						" />
	</h:form>
	</f:view>
</body>
</html>