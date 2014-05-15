<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.CarScheMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	CarScheMB ai = (CarScheMB) MBUtil.getManageBean("#{carScheMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>已完成订单明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="已完成订单明细">
		<script type="text/javascript" src="carsche.js"></script>
		<script type="text/javascript" src="checkboxsel.js"></script>
		<script type="text/javascript">
			function setSkin(){
				parent.parent.Gskin.setSkinCss(document);
			}
		</script>
	</head>
	<body onload="setSkin();" id=mmain>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id='mmain_opt'>
						<a4j:outputPanel id="queryButs" rendered="#{carScheMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output,test" action="#{carScheMB.search_order}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								rendered="#{carScheMB.LST}" onclick="clearSearchKey('2');" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{carScheMB.LST}">
						<div id="mmain_cnd">
							订单日期从:
							<h:inputText id="start_date" styleClass="datetime" size="10"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{carScheMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="10"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{carScheMB.sk_end_date}" />
							单据状态:
							<h:inputText id="orderFlag" styleClass="inputtext" size="20"
								value="#{carScheMB.orderFlag}"
								onclick="showsel(this,'orderFlags')" />
							<div id="orderFlags" class="checkboxsel" style="display: none;">
								<div id=mmain_opt>
									<a4j:commandButton value="全选"
										onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										onclick="selectAllItems('edit:flagList',true)" />
									<a4j:commandButton value="全清"
										onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										onclick="selectAllItems('edit:flagList',false)" />
								</div>
								<h:selectManyCheckbox id="flagList"
									value="#{carScheMB.orderFlags}" styleClass="selectItem"
									layout="pageDirection">
									<f:selectItem itemLabel="制作之中" itemValue="01" />
									<f:selectItem itemLabel="正式单据" itemValue="11" />
									<f:selectItem itemLabel="计划装车" itemValue="15" />
									<f:selectItem itemLabel="分拣中" itemValue="16" />
									<f:selectItem itemLabel="分拣完成" itemValue="17" />
									<f:selectItem itemLabel="装车中" itemValue="18" />
									<f:selectItem itemLabel="出库中" itemValue="21" />
									<f:selectItem itemLabel="已完成" itemValue="31" />
								</h:selectManyCheckbox>
							</div>
							路线:
							<h:selectOneMenu id="sk_lnco" value="#{carScheMB.sk_lnco}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{carScheMB.lineList}" />
							</h:selectOneMenu>
							单据类型:
							<h:selectOneMenu id="sk_soty_order"
								value="#{carScheMB.sk_soty_order}" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="出库订单" itemValue="OUTORDER" />
								<f:selectItem itemLabel="调拨计划" itemValue="TRANPLAN" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>

					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gsort="prorate" gsortmethod="DESC"
										gselectsql="
											SELECT isnull(c.lpco,'') as lpco,c.buty AS soty,SUM(a.gqty*ISNULL(b.volu,0)) AS fvolu,SUM(a.gqty) AS gqty,
											SUM(a.gqty*ISNULL(b.volu,0)) AS tavo, ISNULL(d.lpna,'') as lina,SUM(a.qty) AS qty,
											COUNT(DISTINCT c.biid) AS bnum,
											CONVERT(INT,(ISNULL(SUM(a.gqty),0)/SUM(a.qty))*100) AS prorate
											FROM oubd a LEFT JOIN inve b ON a.inco=b.inco 
											JOIN obma c ON a.biid=c.biid
											LEFT JOIN lpin d on c.lpco=d.lpco 
											WHERE c.#{carScheMB.gorgaSql} AND c.flag in (#{carScheMB.flagSql}) 
											AND c.biid NOT IN (SELECT obid FROM lobd WHERE buty = 'OUTORDER') 
											#{carScheMB.searchSQL}
											GROUP BY isnull(c.lpco,''),ISNULL(d.lpna,''),c.buty
											UNION ALL
											SELECT isnull(c.lico,'') as lpco,c.buty AS soty,SUM(a.gqty*ISNULL(b.volu,0)) AS fvolu,SUM(a.gqty) AS gqty,
											SUM(a.gqty*ISNULL(b.volu,0)) AS tavo, ISNULL(d.lina,'') as lina,SUM(a.qty) AS qty,
											COUNT(DISTINCT c.biid) AS bnum,
											CONVERT(INT,(ISNULL(SUM(a.gqty),0)/SUM(a.qty))*100) AS prorate
											FROM ppde a LEFT JOIN inve b ON a.inco=b.inco 
											JOIN ppma c ON a.biid=c.biid
											LEFT JOIN liin d on c.lico=d.lico 
											WHERE c.#{carScheMB.gorgaSql} AND c.flag in (#{carScheMB.flagSql})  
											AND c.biid NOT IN (SELECT obid FROM lobd WHERE buty = 'TRANPLAN') 
											#{carScheMB.searchSQL}
											GROUP BY isnull(c.lico,''),ISNULL(d.lina,''),c.buty
											UNION ALL
											SELECT isnull(c.lico,'') as lpco,c.buty AS soty,SUM(a.gqty*ISNULL(b.volu,0)) AS fvolu,SUM(a.gqty) AS gqty,
											SUM(a.gqty*ISNULL(b.volu,0)) AS tavo, ISNULL(d.lina,'') as lina,SUM(a.qty) AS qty,
											COUNT(DISTINCT c.biid) AS bnum,
											CONVERT(INT,(ISNULL(SUM(a.gqty),0)/SUM(a.qty))*100) AS prorate
											FROM prbd a LEFT JOIN inve b ON a.inco=b.inco 
											JOIN prbm c ON a.biid=c.biid
											LEFT JOIN liin d on c.lico=d.lico 
											WHERE c.#{carScheMB.gorgaSql} AND c.flag in (#{carScheMB.flagSql}) 
											AND c.biid NOT IN (SELECT obid FROM lobd WHERE buty = 'PURCHASERETURNPLAN') 
											#{carScheMB.searchSQL}
											GROUP BY isnull(c.lico,''),ISNULL(d.lina,''),c.buty
											"
										gpage="(pagesize = 20)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 40,headtype = text,align = center,type = text,datatype=string);
											gcid = prorate(headtext = 分拣完成进度,name = prorate,width = 120,headtype = sort,align = left,type = gprogress);
											gcid = soty(headtext = 单据类型,name = soty,width = 60,align = center,type = mask,typevalue=OUTORDER:出库订单/PURCHASERETURNPLAN:采购退货/TRANPLAN:调拨计划,headtype = sort,datatype = string);
											gcid = lpco(headtext = 承运商,name = lpco,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = tavo(headtext = 总体积(m³),name = tavo,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##});
											gcid = fvolu(headtext = 完成体积(m³),name = fvolu,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##});
											gcid = qty(headtext = 总数量,name = qty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
											gcid = gqty(headtext = 分拣数量,name = gqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
											gcid = bnum(headtext = 总单据数,name = bnum,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
											gcid = -1(headtext = 操作,value= 查看明细,name = opt,width = 60,headtype = text,align = center,type = script,typevalue = showBill('gcolumn[lpco]','gcolumn[lina]','gcolumn[soty]'));
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{carScheMB.msg}" />
							<h:inputHidden id="carlico" value="#{carScheMB.carlico}" />
							<h:inputHidden id="carlina" value="#{carScheMB.carlina}" />
							<h:inputHidden id="param" value="#{carScheMB.param}" />
							<h:inputHidden id="isoty" value="#{carScheMB.isoty}" />
						</a4j:outputPanel>
						<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
							onclick="parent.startDo();" oncomplete="listBill();"
							action="#{carScheMB.setTableKey}">
						</a4j:commandButton>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>