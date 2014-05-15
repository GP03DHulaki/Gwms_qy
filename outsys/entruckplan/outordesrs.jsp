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
		<script type="text/javascript" src="entruckplan.js"></script>
		<script type="text/javascript">
			function setSkin(){
				parent.parent.Gskin.setSkinCss(document);
			}
		</script>
	</head>
	<body onload="setSkin();">
		<f:view>
			<h:form id="edit">
				<div id=mmain_opt>
					<a4j:outputPanel id="mainBut" rendered="true">
						<a4j:commandButton value="添加订单"
							onclick="selOutOrder('#{entruckPlanMB.mbean.orid}','#{entruckPlanMB.mbean.soty}');"
							oncomplete="parent.document.getElementById('edit:refBut').onclick();"
							reRender="outorder" styleClass="a4j_but1"
							rendered="#{entruckPlanMB.MOD && entruckPlanMB.commitStatus}"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" />

						<a4j:commandButton value="删除订单"
							onclick="if(!selectFromId1(TRANPLAN)){return false};"
							action="#{entruckPlanMB.deleteDetail}"
							reRender="renderArea,outorder,tranplan,pobackplan"
							rendered="#{entruckPlanMB.DEL && entruckPlanMB.commitStatus}"
							onmouseover="this.className='a4j_over1'"
							oncomplete="endDelOrder();"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</a4j:outputPanel>
				</div>
				<a4j:outputPanel id="outorder"
					rendered="#{entruckPlanMB.mbean.soty=='OUTORDER' ? true : false }">
					<g:GTable gid="outorder" gtype="grid" gversion="2" gdebug="false"
						gselectsql="
							SELECT DISTINCT a.id,a.biid AS oubi,a.cuid,a.flag,a.crus,a.crna,a.chus,a.chna,a.crdt,a.chdt,a.tavo,a.orid,a.tanu,
							a.tawe,a.orad,a.rema,a.cuna FROM obma a LEFT JOIN cuin b ON a.cuid=b.cuid 
							Join ltde c on a.biid=c.oubi WHERE c.biid= '#{entruckPlanMB.mbean.biid}' "
						gpage="(pagesize = -1)"
						gcolumn="gcid = oubi(headtext = selall,name = selall,width = 20,headtype = #{entruckPlanMB.commitStatus ? 'checkbox' : 'hidden'},align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = oubi(headtext = 出库订单,name = oubi,width = 150,headtype = sort,align = left,type = text,datatype=string);
							gcid = cuna(headtext = 客户名称,name = cuna,width = 120,headtype = sort,align = left,type = text,datatype=string);
							gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = tavo(headtext = 总体积,name = tavo,width = 60,headtype = hidden,align = left,type = text,datatype=number,dataformat={0.######});
							gcid = tawe(headtext = 总重量,name = tawe,width = 60,headtype = hidden,align = left,type = text,datatype=number,dataformat={0.######});
							gcid = tanu(headtext = 总数量,name = tanu,width = 60,headtype = sort,align = left,type = text,datatype=number,dataformat={0.######});
							gcid = orad(headtext = 详细地址,name = orad,width = 260,headtype = sort,align = left,type = text,datatype=string);
							gcid = rema(headtext = 备注,name = rema,width = 120,headtype = sort,align = left,type = text,datatype=string);
					" />
				</a4j:outputPanel>

				<a4j:outputPanel id="tranplan"
					rendered="#{entruckPlanMB.mbean.soty=='TRANPLAN' ? true : false }">
					<g:GTable gid="TRANPLAN" gtype="grid" gversion="2" gdebug="false"
						gselectsql="
							SELECT a.oubi,c.chdt,d.whna AS iwh,c.rema,
							SUM(a.qty) AS tanu,SUM(ISNULL(b.volu,0)*a.qty) AS tavo,SUM(ISNULL(b.newe,0)*a.qty) AS tawe
							FROM ltde a 
							LEFT JOIN inve b ON a.inco=b.inco
							LEFT JOIN ppma c ON a.oubi=c.biid
							LEFT JOIN waho d ON c.powh=d.whid
							WHERE a.biid='#{entruckPlanMB.mbean.biid}'
							GROUP BY a.oubi,c.chdt,d.whna,c.rema 
						"
						gpage="(pagesize = -1)"
						gcolumn="gcid = oubi(headtext = selall,name = selall,width = 20,headtype = #{entruckPlanMB.commitStatus ? 'checkbox' : 'hidden'},align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = oubi(headtext = 调拨计划,name = oubi,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = iwh(headtext = 调入仓库,name = iwh,width = 120,headtype = sort,align = left,type = text,datatype=string);
							gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = tavo(headtext = 总体积,name = tavo,width = 60,headtype = sort,align = left,type = text,datatype=number,dataformat={0.######});
							gcid = tawe(headtext = 总重量,name = tawe,width = 60,headtype = sort,align = left,type = text,datatype=number,dataformat={0.######});
							gcid = tanu(headtext = 总数量,name = tanu,width = 60,headtype = sort,align = left,type = text,datatype=number,dataformat={0.######});
							gcid = rema(headtext = 备注,name = rema,width = 150,headtype = sort,align = left,type = text,datatype=string);
					" />
				</a4j:outputPanel>

				<a4j:outputPanel id="pobackplan"
					rendered="#{entruckPlanMB.mbean.soty=='PURCHASERETURNPLAN' ? true : false }">
					<g:GTable gid="PURCHASERETURNPLAN" gtype="grid" gversion="2"
						gdebug="false"
						gselectsql="
							SELECT a.oubi,c.chdt,c.stus,c.stna,c.rema,
							SUM(a.qty) AS tanu,SUM(ISNULL(b.volu,0)*a.qty) AS tavo,SUM(ISNULL(b.newe,0)*a.qty) AS tawe
							FROM ltde a 
							LEFT JOIN inve b ON a.inco=b.inco
							LEFT JOIN prbm c ON a.oubi=c.biid
							WHERE a.biid='#{entruckPlanMB.mbean.biid}'
							GROUP BY a.oubi,c.chdt,c.stus,c.stna,c.rema
						"
						gpage="(pagesize = -1)"
						gcolumn="gcid = oubi(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = oubi(headtext = 采购退货计划,name = oubi,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = stna(headtext = 供应商名称,name = stna,width = 150,headtype = sort,align = left,type = text,datatype=string);
							gcid = chdt(headtext = 审核日期,name = chdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = tavo(headtext = 总体积(m³),name = tavo,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##});
							gcid = tawe(headtext = 总重量(㎏),name = tawe,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##});
							gcid = tanu(headtext = 总数量,name = tanu,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
							gcid = rema(headtext = 备注,name = rema,width = 150,headtype = sort,align = left,type = text,datatype=string);
							
					" />
				</a4j:outputPanel>

				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{entruckPlanMB.msg}" />
						<h:inputHidden id="sellist" value="#{entruckPlanMB.sellist}" />
						<h:inputHidden id="soty" value="#{entruckPlanMB.mbean.soty}" />
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
		</f:view>
	</body>
</html>