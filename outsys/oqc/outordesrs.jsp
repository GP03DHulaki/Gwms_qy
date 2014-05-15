<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<html>
	<head>
		<title>待出库复核数据列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="待出库复核数据列表">
		<script type="text/javascript" src="entruckplan.js"></script>
		<script type="text/javascript">
			function init(){
				if(parent.Gskin){
					parent.Gskin.setSkinCss(document);
				}
			}
		</script>
	</head>
	<body onload="init();">
		<f:view>
			<h:form id="edit">
				<a4j:outputPanel id="outorder">
					<g:GTable gid="gtable2" gtype="grid" gversion="2" gdebug="false"
						gsort="swdt" gsortmethod="DESC"
						gselectsql="
							SELECT a.inco,b.inna,b.colo,b.inse,(a.qty-a.fqty) AS qty,a.swdt FROM rede a  
							LEFT JOIN inve b ON b.inco=a.inco WHERE (fqty-qty)<0 AND biid='#{reviewLibraryMB.mbean.biid }' 
							"
						gpage="(pagesize = 5)"
						gcolumn="
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = inco(headtext = 商品编码,name = inco,width = 150,align = left,type = text,headtype = sort ,datatype = string);
							gcid = inna(headtext = 商品名称,name = inna,width = 180,align = left,type = text,headtype = sort ,datatype = string);
							gcid = colo(headtext = 规格,name = colo,width = 120,align = left,type = text,headtype = sort ,datatype = string);
							gcid = inse(headtext = 规格码,name = inse,width = 120,align = left,type = text,headtype = sort ,datatype = string);
							gcid = qty(headtext = 待复核数量,name = tanu,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0.######},bgcolor={gcolumn[qty]>1:#ffe88e},summary=this);
					" />
				</a4j:outputPanel>
				<a4j:jsFunction name="refTable" reRender="outorder" />
				<div id="errmsg" style="display: none">
					<div id=mmain_cnd align="left">
						<a4j:commandButton reRender="outorder" id="renderBut"
							onclick="Gwallwin.winShowmask('TRUE');"
							oncomplete="Gwallwin.winShowmask('FALSE');" />
						<span id="mes" style="color: red;"></span>
						<div align="center">
							<button type="button" onclick="Gwallwin.winClose();"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" class="a4j_but">
								关闭
							</button>
						</div>
					</div>
				</div>
			</h:form>

		</f:view>
	</body>
</html>