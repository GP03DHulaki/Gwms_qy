<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@ page import="com.gwall.view.StockSearchMB"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>查看商品明细</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="查看锁定库存">
		<script type="text/javascript" src="stockSearch.js"></script>
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/css/style.css">

	</head>
	<%
	    StockSearchMB ai = (StockSearchMB) MBUtil
	            .getManageBean("#{stockSearchMB}");
	    if (request.getParameter("time") != null) {
	        if (request.getParameter("baco") != null) {
	            ai.setShow_baco(request.getParameter("baco"));
	        }
	        if (request.getParameter("whid") != null) {
	            ai.setShow_whid(request.getParameter("whid"));
	        }
	    }
	%>
	<body>
		<f:view>
			<h:form>
				<a4j:outputPanel id="output">
					<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
						gselectsql="
							WITH tb_stnu AS (
								SELECT inco,uqty,bxfl,baco FROM stnu WHERE bxfl='04' 
								AND inco = '#{stockSearchMB.show_baco}' AND whid = '#{stockSearchMB.show_whid}'
								UNION ALL
								SELECT b.inco,a.uqty,a.bxfl,a.baco FROM stnu a LEFT JOIN pain b ON a.baco=b.boco WHERE a.bxfl='02'
								AND b.inco = '#{stockSearchMB.show_baco}' AND a.whid = '#{stockSearchMB.show_whid}'
							)
							SELECT a.inco,a.baco,a.bxfl,a.uqty AS qty,b.inna,b.colo,b.inse,'#{stockSearchMB.show_whid}' AS whid FROM tb_stnu a LEFT JOIN inve b ON a.inco=b.inco
						"
						gpage="(pagesize = -1)"
						gcolumn="
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = bxfl(headtext = 条码类型,name = bxfl,width =80,headtype = sort,align = center,type = mask,typevalue=02:箱/04:SKU,datatype=string);
							gcid = inco(headtext = 商品编码,name = inco,width =120,headtype = sort,align = left,type = text,datatype=string);
							gcid = inna(headtext = 商品名称,name = inna,width =80,headtype = sort,align = left,type = text,datatype=string);
							gcid = colo(headtext = 规格,name = colo,width =60,headtype = sort,align = left,type = text,datatype=string);
							gcid = inse(headtext = 规格码,name = inse,width =60,headtype = sort,align = left,type = text,datatype=string);
							gcid = whid(headtext = 库位编码,name = whid,width = 100,headtype = sort,align = left,type = text,datatype=string);
						    gcid = qty(headtext = 可用数量,name = qty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
						    gcid = baco(headtext = 条码,name = baco,width =120,headtype = sort,align = left,type = text,datatype=string);
					" />
				</a4j:outputPanel>
			</h:form>
		</f:view>
	</body>
</html>