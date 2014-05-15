<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@ page import="com.gwall.view.StockSearchMB"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>查看锁定库存</title>

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
					SELECT buty,biid,isnull(soty,'') AS soty,isnull(soco,'') AS soco,inco,sum(qty) AS qty,whid,stat FROM slst 
					WHERE inco = '#{stockSearchMB.show_baco}' AND whid = '#{stockSearchMB.show_whid}' 
					AND stat IN (0,4,5) GROUP BY buty,biid,soty,soco,inco,stat,whid having sum(qty)>0
				"
						gpage="(pagesize = -1)"
						gcolumn="
					gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
					gcid = buty(headtext = 单据类型,name = buty,width =80,headtype = sort,align = left,type = mask,typevalue=SHEFT:理货上架/TRANOUT:调拨出库/otherout:其它出库/OUTORDER:出库订单/move:移库/CHANGEBACO:花色转换/TRANPLAN:调拨计划/PackBox:库内装箱,datatype=string);
					gcid = biid(headtext = 单据单号,name = biid,width =110,headtype = sort,align = left,type = text,datatype=string);
					gcid = soco(headtext = 任务单号,name = soco,width =110,headtype = sort,align = left,type = text,datatype=string);
					gcid = whid(headtext = 锁定货位,name =whid,width = 110,align = left,type = mask,typevalue=0:新花/1:保留/2:非保留,headtype = sort,datatype = string);
					gcid = inco(headtext = 商品编码,name = inco,width =110,headtype = sort,align = left,type = text,datatype=string);
				    gcid = qty(headtext = 锁定数量,name = qty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
				    gcid = stat(headtext = 锁定状态,name =stat,width = 80,align = center,type = mask,typevalue=0:拣货锁定/2:上架锁定/4:跳过异常锁定/5:复核异常锁定,headtype = sort,datatype = string);
			" />
				</a4j:outputPanel>
			</h:form>
		</f:view>
	</body>
</html>