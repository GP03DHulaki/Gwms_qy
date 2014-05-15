<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="javax.faces.el.ValueBinding"%>
<%@page import="com.gwall.view.AsnMB"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<title>采购订单明细</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="gwall">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/Gwalltag.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="asn.js"></script>

</head>
<body>
	<f:view>
	<h:form id="edit">
		<div id="mmain_opt">
			<a4j:commandButton id="addDBut" value="添加明細"
				onclick="if(!addDetail(gtable)){return false};"
				onmouseover="this.className='a4j_over1'"
				onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
				type="button" action="#{asnMB.addDetail}" 
				oncomplete="endAddDetail();"
				reRender="renderArea,output" rendered="#{asnMB.MOD && asnMB.commitStatus}"
				 requestDelay="50" />
		</div>
		<div id=mmain_free>
			<a4j:outputPanel id="output">
				<g:GTable gid="gtable" gtype="grid" gversion="2"
					gselectsql="select a.did,a.biid,a.roid,a.inco,c.inna,a.qty from pubd a join pubm b on a.biid = b.biid join inve c on a.inco = c.inco 
								where b.suid = '#{asnMB.mbean.suid }' AND a.did NOT IN (SELECT a.did FROM pubd a JOIN asbd b ON (a.biid=b.poid and a.roid=b.frid) WHERE b.biid = '#{asnMB.mbean.biid }') "
					gwidth="550" gpage="(pagesize = -1)" gdebug="false"
					gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = checkbox);
						gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
						gcid = biid(headtext = 采购订单编号,name = biid,width = 120,headtype = sort,align = left,type = text,datatype=string);
						gcid = roid(headtext = 行序号,name = roid,width = 70,headtype = sort,align = left,type = text,datatype=string);
						gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
						gcid = inna(headtext = 商品名称,name = inna,width = 150,headtype = sort,align = left,type = text,datatype=string);
						gcid = qty(headtext = 数量,name = qty,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat=0);
				" />
			</a4j:outputPanel>
		</div>
		<div style="display: none;">
			<a4j:outputPanel id="renderArea">
				<h:inputHidden id="msg" value="#{asnMB.msg}" />
				<h:inputHidden id="sellist" value="#{asnMB.sellist}" />
				
			</a4j:outputPanel>
		</div>
	</h:form>
	</f:view>
</body>
</html>