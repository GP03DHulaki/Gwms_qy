<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>选择出库订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content=出库订单>
		<meta http-equiv="description" content="出库订单">
		<script type="text/javascript" src="truckorder.js"></script>
	</head>
	<script type="text/javascript">
		function selectThis(param1){
	    	window.returnValue = param1;
			window.close();	
	    }
		function showMes(){
			$('edit:searchpicktaskkey').value='';
			$('edit:sid').onclick();
		}
	</script>
	<body >
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton id="sid" value="查询" type="button"
							onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							reRender="outorder,tranplan,pobackplan" action="#{carTransferMB.selectBill}" />
						<a4j:commandButton type="button" value="重置" onclick="textClear('edit','billbid,billcus');"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<a4j:commandButton styleClass='a4j_but' value='确定'
							action="#{carTransferMB.addDetail}" reRender="renderArea,outorder,tranplan,pobackplan"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'"
							oncomplete="endAddOrder();"
							onclick="if(!selectFromModal('#{carTransferMB.mbean.soty}')){return false}" />
						<button onclick="Gwin.close();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" class="a4j_but">
							返回
						</button>
					</div>
					<div id=mmain_cnd>
						<h:outputText value="出库订单:"></h:outputText>
						<h:inputText id="billbid" styleClass="inputtext"
							size="15" onkeypress="formsubmit(event);" value="#{carTransferMB.billbid}" />
						<h:outputText value="收货方:"></h:outputText>
						<h:inputText id="billcus" styleClass="inputtext" size="15"
							onkeypress="formsubmit(event);" value="#{carTransferMB.billcus}"/>
					</div>
					
					<a4j:outputPanel id="outorder" rendered="#{carTransferMB.mbean.soty=='OUTORDER' ? true : false }">
						<g:GTable gid="OUTORDER" gtype="grid" gversion="2" gdebug="true" gsortmethod="ASC"
							gselectsql="
								select a.loco,c.biid,c.flag,d.lpna,sum(a.qty) gqty from pode a left join poma b on a.biid=b.biid
									left join obma c on b.soco=c.biid 
									left join lpin d on c.lpco=d.lpco
									WHERE c.#{outOrderMB.gorgaSql} AND (c.flag ='16' OR c.flag='17' OR c.flag='19' OR c.flag='20' ) 
									AND c.lpco='#{carTransferMB.mbean.lpco}'  and c.isup='1' and a.stat='0' and a.flag='0' and a.stat='20'
									#{carTransferMB.billKey}
									GROUP BY a.loco,c.biid,d.lpna,c.flag
								union select a.loco,a.biid,a.flag,d.lpna,sum(b.qty) gqty from obma a left join oubd b on a.biid=b.biid
									left join lpin d on a.lpco=d.lpco
									WHERE a.#{outOrderMB.gorgaSql} AND (a.flag ='17' OR a.flag='16') 
									AND a.lpco='#{carTransferMB.mbean.lpco}'  and a.isup='0' and a.stat='20'
									#{carTransferMB.billKey}
									GROUP BY a.loco,a.biid,d.lpna,a.flag
							"
							gpage="(pagesize = -1)"
							gcolumn="gcid = biid(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = loco(headtext = 快递单号,name = loco,width = 150,headtype = sort,align = left,type = text,datatype=string);
							gcid = biid(headtext = 出库订单,name = biid,width = 150,headtype = sort,align = left,type = text,datatype=string);
							gcid = flag(headtext = 单据状态,name = flag,width = 60,headtype = sort,align = center,type = mask,typevalue=16:分拣中/17:已完成/19:已完成/20:部分出库,datatype=string,bgcolor={gcolumn[flag]=16:#FFB6C1});	
							gcid = lpna(headtext = 承运商,name = lpna,width = 60,headtype = sort,align = left,type = text,datatype=string);
							gcid = gqty(headtext = 商品总数,name = gqty,width = 55,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##});
					" />
					</a4j:outputPanel>
					
					<a4j:outputPanel id="tranplan"  rendered="#{carTransferMB.mbean.soty=='TRANPLAN' ? true : false }">
						<g:GTable gid="TRANPLAN" gtype="grid" gversion="2" gdebug="false"
							gselectsql="
							SELECT c.biid,c.chdt,c.orid,d.lina,e.whna AS rece,c.flag,
							SUM(a.qty) AS qty,SUM(a.gqty) AS gqty,f.orna,
							SUM(ISNULL(b.volu,0)*a.qty) AS tavo,SUM(ISNULL(b.newe,0)*a.qty) AS tawe
							FROM ppma c JOIN ppde a ON c.biid=a.biid
							LEFT JOIN inve b ON b.inco=a.inco
							LEFT JOIN liin d on c.lico=d.lico
							join orga f on f.orid=c.orid
							LEFT JOIN waho e ON c.powh=e.whid  
							WHERE c.#{outOrderMB.gorgaSql} and c.lpco='#{carTransferMB.mbean.lpco}' 
							GROUP BY c.biid,c.chdt,c.orid,d.lina,c.flag,f.orna,e.whna
							"
							gpage="(pagesize = -1)"
							gcolumn="gcid = biid(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = biid(headtext = 调拨计划,name = biid,width = 120,headtype = sort,align = left,type = text,datatype=string);
							gcid = flag(headtext = 单据状态,name = flag,width = 60,headtype = sort,align = center,type = mask,typevalue=16:分拣中/17:已完成,datatype=string,bgcolor={gcolumn[flag]=16:#FFB6C1});
							gcid = rece(headtext = 收货方,name = rece,width = 150,headtype = sort,align = left,type = text,datatype=string);
							gcid = lina(headtext = 路线,name = lina,width = 60,headtype = sort,align = left,type = text,datatype=string);
							gcid = tavo(headtext = 总体积,name = tavo,width = 55,headtype = sort,align = left,type = text,datatype=number,dataformat={0.##});
							gcid = tawe(headtext = 总重量,name = tawe,width = 55,headtype = sort,align = left,type = text,datatype=number,dataformat={0.##});
							gcid = gqty(headtext = 总数量,name = gqty,width = 55,headtype = sort,align = left,type = text,datatype=number,dataformat={0.##});
					" />
					</a4j:outputPanel>
					
					<a4j:outputPanel id="pobackplan"  rendered="#{carTransferMB.mbean.soty=='PURCHASERETURNPLAN' ? true : false }">
						<g:GTable gid="PURCHASERETURNPLAN" gtype="grid" gversion="2" gdebug="false" gsort="biilstate" gsortmethod="ASC"
							gselectsql="
							SELECT c.biid,c.chdt,c.orid,d.lina,c.stna AS rece,c.buty,c.flag,
							SUM(a.qty) AS qty,SUM(a.gqty) AS gqty,f.orna,
							SUM(ISNULL(b.volu,0)*a.qty) AS tavo,SUM(ISNULL(b.newe,0)*a.qty) AS tawe
							FROM prbm c JOIN prbd a ON c.biid=a.biid
							LEFT JOIN inve b ON b.inco=a.inco
							LEFT JOIN liin d on c.lico=d.lico
							join orga f on f.orid=c.orid
							WHERE c.#{outOrderMB.gorgaSql} AND (c.flag ='17' OR c.flag='16') AND c.lico='#{carTransferMB.mbean.lico}'  
							GROUP BY c.biid,c.chdt,c.orid,d.lina,c.buty,c.flag,f.orna,c.stna
							"
							gpage="(pagesize = -1)"
							gcolumn="gcid = biid(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = biid(headtext = 采购退货计划,name = biid,width = 120,headtype = sort,align = left,type = text,datatype=string);
							gcid = flag(headtext = 单据状态,name = flag,width = 60,headtype = sort,align = center,type = mask,typevalue=16:分拣中/17:已完成,datatype=string,bgcolor={gcolumn[flag]=16:#FFB6C1});
							gcid = rece(headtext = 收货方,name = rece,width = 150,headtype = sort,align = left,type = text,datatype=string);
							gcid = lina(headtext = 路线,name = lina,width = 60,headtype = sort,align = left,type = text,datatype=string);
							gcid = tavo(headtext = 总体积,name = tavo,width = 55,headtype = sort,align = left,type = text,datatype=number,dataformat={0.##});
							gcid = tawe(headtext = 总重量,name = tawe,width = 55,headtype = sort,align = left,type = text,datatype=number,dataformat={0.##});
							gcid = gqty(headtext = 总数量,name = gqty,width = 55,headtype = sort,align = left,type = text,datatype=number,dataformat={0.##});
					" />
					</a4j:outputPanel>
					
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{carTransferMB.msg}" />
							<h:inputHidden id="sellist" value="#{carTransferMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>

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

			</div>
		</f:view>
	</body>
</html>