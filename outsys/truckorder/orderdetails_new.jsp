<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<html>
	<head>
		<title>订单明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="订单明细">
		<script type="text/javascript" src="truckorder.js"></script>
		<script type="text/javascript">
			function load(){
				window.endLoad();
			}
			function setSkin(){
				parent.parent.Gskin.setSkinCss(document);
			}
		</script>
	</head>
	<body onload="startDo();setSkin();load();">
		<f:view>
			<h:form id="edit">
				<div id=mmain_cnd>
					<a4j:outputPanel id="detail">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											Select a.inco,b.inna,b.inty,b.inse,b.inpr,b.colo,SUM(ISNULL(c.uqty,0)) AS uqty,
											SUM(a.qty) AS qty From lode a left join inve b On a.inco = b.inco  
											LEFT JOIN f_getstocknumbers_sum('#{outOrderMB.mbean.orid}') c on a.inco=c.inco
											Where a.biid = '#{truckOrderMB.mbean.biid}'
											and a.obid like '#{truckOrderMB.dbiid}'
											GROUP BY a.inco,b.inna,b.inty,b.inse,b.inpr,b.colo
										"
										gpage="(pagesize = -1)"
										gcolumn="
										gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
										gcid = inco(headtext = 商品编码,name = inco,width = 140,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inna(headtext = 商品名称,name = inna,width = 215,align = left,type = text,headtype = sort ,datatype = string);
										gcid = colo(headtext = 规格,name = colo,width = 90,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inse(headtext = 规格码,name = inse,width = 90,align = left,type = text,headtype = sort ,datatype = string);
										gcid = qty(headtext =  数量,name = qty,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0.######,summary=this);
										gcid = uqty(headtext =  可用库存,name = uqty,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0.######,summary=this);
								" />
								</td>
							</tr>
						</table>
					</a4j:outputPanel>
				</div>
			</h:form>
		</f:view>
	</body>
</html>