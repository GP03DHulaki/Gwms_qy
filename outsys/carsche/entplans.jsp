<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.CarScheMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
	CarScheMB ai = (CarScheMB) MBUtil.getManageBean("#{carScheMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK_plan();
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
								reRender="output" action="#{carScheMB.search_enplan}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="clearSearchKey('2');" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{carScheMB.LST}">
						<div id="mmain_cnd">
							计划日期从:
							<h:inputText id="start_date" styleClass="datetime" size="10"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{carScheMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="10"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{carScheMB.sk_end_date}" />
							备货计划单号:
							<h:inputText id="biid" styleClass="datetime" size="20"
								value="#{carScheMB.biid}" />
							来源类型:
							<h:selectOneMenu id="sk_soty" value="#{carScheMB.sk_soty}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="出库订单" itemValue="OUTORDER" />
								<f:selectItem itemLabel="调拨计划" itemValue="TRANPLAN" />
								<f:selectItem itemLabel="采购退货" itemValue="PURCHASERETURNPLAN" />
							</h:selectOneMenu>
							来源单号:
							<h:inputText id="sk_soco" styleClass="datetime" size="22"
								value="#{carScheMB.sk_soco}" />
						</div>
					</a4j:outputPanel>

					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gsort="prorate" gsortmethod="DESC"
										gselectsql="
											SELECT a.biid,c.soty,SUM(a.fqty*ISNULL(b.volu,0)) AS fvolu,SUM(a.fqty) AS fqty,
											SUM(a.qty*ISNULL(b.volu,0)) AS tavo,SUM(a.qty) AS qty,
											COUNT(DISTINCT a.oubi) AS bnum,
											CONVERT(INT,(ISNULL(SUM(a.fqty),0)/SUM(a.qty))*100) AS prorate
											FROM ltde a JOIN inve b ON a.inco=b.inco 
											JOIN ltma c ON a.biid=c.biid
											JOIN obma d ON a.oubi=d.biid
											WHERE d.#{carScheMB.gorgaSql} AND c.flag >= '11' AND d.flag in ('16','17') 
											AND (d.aity = 'ENTRUCKPLAN' OR d.aity IS NULL OR d.aity='')
											AND c.soty='OUTORDER' #{carScheMB.searchSQL_plan}
											GROUP BY a.biid,c.soty
											UNION ALL
											SELECT a.biid,c.soty,SUM(a.fqty*ISNULL(b.volu,0)) AS fvolu,SUM(a.fqty) AS fqty,
											SUM(a.qty*ISNULL(b.volu,0)) AS tavo,SUM(a.qty) AS qty,
											COUNT(DISTINCT a.oubi) AS bnum,
											CONVERT(INT,(ISNULL(SUM(a.fqty),0)/SUM(a.qty))*100) AS prorate
											FROM ltde a JOIN inve b ON a.inco=b.inco 
											JOIN ltma c ON a.biid=c.biid
											JOIN ppma d ON a.oubi=d.biid
											WHERE d.#{carScheMB.gorgaSql} AND c.flag >= '11' AND d.flag in ('16','17') 
											AND (d.aity = 'ENTRUCKPLAN' OR d.aity IS NULL OR d.aity='')
											AND c.soty='TRANPLAN' #{carScheMB.searchSQL_plan}
											GROUP BY a.biid,c.soty
											UNION ALL
											SELECT a.biid,c.soty,SUM(a.fqty*ISNULL(b.volu,0)) AS fvolu,SUM(a.fqty) AS fqty,
											SUM(a.qty*ISNULL(b.volu,0)) AS tavo,SUM(a.qty) AS qty,
											COUNT(DISTINCT a.oubi) AS bnum,
											CONVERT(INT,(ISNULL(SUM(a.fqty),0)/SUM(a.qty))*100) AS prorate
											FROM ltde a JOIN inve b ON a.inco=b.inco 
											JOIN ltma c ON a.biid=c.biid
											JOIN prbm d ON a.oubi=d.biid
											WHERE d.#{carScheMB.gorgaSql} AND c.flag >= '11' AND d.flag in ('16','17') 
											AND (d.aity = 'ENTRUCKPLAN' OR d.aity IS NULL OR d.aity='')
											AND c.soty='PURCHASERETURNPLAN' #{carScheMB.searchSQL_plan}
											GROUP BY a.biid,c.soty
											"
										gpage="(pagesize = 20)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 40,headtype = text,align = center,type = text,datatype=string);
											gcid = prorate(headtext = 分拣完成进度,name = prorate,width = 120,headtype = sort,align = left,type = gprogress);
											gcid = biid(headtext = 备货计划单号,name = biid,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = soty(headtext = 来源类型,name = soty,width = 60,align = center,type = mask,typevalue=OUTORDER:出库订单/PURCHASERETURNPLAN:采购退货/TRANPLAN:调拨计划,headtype = sort,datatype = string);
											gcid = tavo(headtext = 总体积(m³),name = tavo,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##});
											gcid = fvolu(headtext = 完成体积(m³),name = fvolu,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##});
											gcid = qty(headtext = 总数量,name = qty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
											gcid = fqty(headtext = 拣货数量,name = fqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
											gcid = bnum(headtext = 总单据数,name = bnum,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
											gcid = -1(headtext = 操作,value= 查看明细,name = opt,width = 60,headtype = text,align = center,type = script,typevalue = showBil_bid('gcolumn[biid]','gcolumn[soty]'));
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="sellist" value="#{carScheMB.sellist}" />
							<h:inputHidden id="msg" value="#{carScheMB.msg}" />
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