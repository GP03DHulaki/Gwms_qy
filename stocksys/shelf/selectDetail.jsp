<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>上架车明细</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">     
	<meta http-equiv="keywords" content="上架车明细">
	<meta http-equiv="description" content="上架车明细">
</head>
<script type="text/javascript">

	function showMes(){

	}
	function cleartext(){

	}

</script>
<body id="mmain_body" onload="showMes()">
	<f:view>
		<div id="mmain">
			<h:form id="edit">
				<div id=mmain_opt>
					<a4j:commandButton onmouseover="this.className='a4j_over1'"
						onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
						id="sid" value="查询" type="button" action=""
						reRender="output" requestDelay="50" />
					<a4j:commandButton type="button" value="重置" onclick="cleartext();"
						onmouseover="this.className='a4j_over1'"
						onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
				</div>
				<div id=mmain_cnd>
					<h:outputText value="商品编号:"></h:outputText>
					<h:inputText id="id" styleClass="inputtextedit" size="15"
						value="" onkeypress="formsubmit(event);" />
					<!--<h:outputText value="简称:"></h:outputText>
					<h:inputText id="name" styleClass="inputtextedit" size="15"
						value="#{CustomerCOM.name}" onkeypress="formsubmit(event);" />-->
				</div>
				<a4j:outputPanel id="output">
					<g:GTable gid="gtable" gtype="grid" gversion="2"
						gselectsql="select vc_barcode,nv_invname,nv_specification,nv_units,dc_newqty from gt_purindetail 
									where vc_carid = '01' and vc_voucherid = 'R20110330001'"
						gwidth="550" gpage="(pagesize = 20)"
						growclick=""
						gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
								gcid = vc_barcode(headtext = 商品条码,name = vc_barcode,width = 120,headtype = sort,align = left,type = text,datatype=string);
								gcid = nv_invname(headtext = 商品名称,name = nv_invname,width = 120,headtype = sort,align = left,type = text,datatype=string);
								gcid = nv_specification(headtext = 规格,name = nv_specification,width = 100,headtype = sort,align = left,type = text,datatype=string);
								gcid = nv_units(headtext = 单位,name = nv_units,width = 100,headtype = sort,align = left,type = text,datatype=string);
								gcid = dc_newqty(headtext = 数量,name = dc_newqty,width = 80,align = right,type = text ,headtype=sort, datatype =number,dataformat=0.##);
								" />
				</a4j:outputPanel>
			</h:form>
		</div>
	</f:view>
</body>
</html>