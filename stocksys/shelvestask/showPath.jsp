<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@ page import="com.gwall.view.stock.ShelvesTaskMB"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%
	String id = "";
	ShelvesTaskMB ai = (ShelvesTaskMB) MBUtil.getManageBean("#{shelvestaskMB}");
	if (request.getParameter("pid") != null) {
		id = request.getParameter("pid");
		ai.getMbean().setBiid(id);
	}
	ai.getVouch();
%>
<head>

	<title>查看拣货路径</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="查看拣货路径">
	<meta http-equiv="description" content="查看拣货路径">
	<script type="text/javascript" src="shelvestask.js"></script>

</head>
  
<body id="mmain_body" onLoad="initAdd();">
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;<a href="picktask_edit.jsf">备货处理</a>&gt;&gt;</font><b>查看拣货路径</b><br></div>
	<f:view>
	<h:form id="edit">
	 <div>
		<a4j:outputPanel id="outputtable">
		<g:GTable gid="gtable2" gtype="grid" gdebug="false"
			gselectsql="
				select a.id,a.inco,a.qty as qty ,a.fqty as fqty,a.whid,b.inna,b.inst,b.colo,c.whna,a.stat      
				from pkln a join  waho c on a.whid = c.whid 
				JOIN inve b ON b.inco = a.inco 
				 Where a.biid ='#{shelvestaskMB.mbean.biid}' "
				gpage="(pagesize = -1)" gversion="2"
				gcolumn="
						gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
						gcid = whna(headtext = 下架货位,name = whna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
						gcid = qty(headtext = 应拣数量,name = qty,width = 50,align = right,type number,headtype= sort, datatype =number,dataformat=0.##);
						gcid = fqty(headtext = 实拣数量,name = qty,width = 50,align = right,type = number,headtype= sort, datatype =number,dataformat=0.##);
						gcid = inco(headtext = 物料编码,name = inco,width = 100,align = left,type = text,headtype = sort ,datatype = string);
						gcid = inna(headtext = 物料名称,name = inna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
						gcid = stat(headtext = 状态,name = flag,width = 50,align = center,type = mask,typevalue=0:/2:跳过/4:关闭/,headtype = sort,datatype = string);
					" />
				</a4j:outputPanel>
	</div>
	</h:form>
	</f:view>
</body>
</html>