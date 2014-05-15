<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<html>
	<head>
		<title>出库订单列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="出库订单列表">
		<script type="text/javascript" src="packaging.js"></script>
		<script type="text/javascript">
			function setSkin(){
				parent.parent.Gskin.setSkinCss(document);
			}
		</script>
	</head>
	<body onload="setSkin();">
		<f:view>
			<h:form id="edit">
				<a4j:outputPanel id="result">
					<g:GTable gid="gtable" gtype="grid" gdebug="false"
						gselectsql="
									SELECT a.inco,a.qty as aqty,a.gqty,isnull(b.qty,0) as qty,((a.gqty-isNull(b.qty,0))%i.inpa) AS lqty, 
									i.inna,i.colo,i.inst,i.iftl FROM oubd a LEFT JOIN 
									(SELECT inco,sum(qty) AS qty FROM gpad WHERE biid IN 
									(SELECT biid FROM gpam WHERE soco = '#{packagingMB.mbean.soco}') GROUP BY inco) 
									b ON a.inco = b.inco  join inve i on a.inco = i.inco 
									WHERE a.biid = '#{packagingMB.mbean.soco}'  
									AND isnull(a.gqty,0)-isNull(b.qty,0)>0 "
						gpage="(pagesize = -1)" gversion="2"
						gcolumn="gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = inco(headtext = 物料编码,name = inco,width = 150,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 物料名称,name = inna,width = 200,align = left,type = text,headtype = sort ,datatype = string);
									gcid = iftl(headtext = 主料/辅料,name = colo,width = 110,align = left,type = mask,headtype = sort ,datatype = string,typevalue=1:主料/0:辅料);
									gcid = inst(headtext = 规格,name = inst,width = 100,align = left,type = text,headtype = sort ,datatype = string);
									gcid = aqty(headtext = 订单数量,name = aqty,width = 100,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##);
									gcid = gqty(headtext = 已分拣数量,name = gqty,width = 100,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##);
									gcid = qty(headtext = 已打包数量,name = qty,width = 100,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##);
									gcid = lqty(headtext = 未打包数量,name = lqty,width = 100,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,bgcolor={gcolumn[lqty]!=0:#ff7474});
									" />
				</a4j:outputPanel>


				<div id="errmsg" style="display: none">
					<div id=mmain_cnd align="left">
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