<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.OrderCountMB"%>

<%
	OrderCountMB ai = (OrderCountMB) MBUtil
			.getManageBean("#{orderCountMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>出库订单报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="出库订单报表">
		<script type='text/javascript' src='ordercount.js'></script>
	</head>
	<body id="mmain_body" onload="selectAllItems('edit:shopList',true);">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>出库订单报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
				<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{orderCountMB.msg}" />
							<h:inputHidden id="gsql" value="#{orderCountMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{orderCountMB.outPutFileName}" />
						</a4j:outputPanel>
				   </div>
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{orderCountMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{orderCountMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','cuna,sk_start_date,sk_inse,sk_end_date,biid,inna,inco,colo,chna,orna,orid,soco,flag,cbid,sk_chdt_start,sk_chdt_end,rema,iscancle,stat,whid,start_date_padt,end_date_padt,whfl');selectAllItems('edit:shopList',true);" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{orderCountMB.export}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{orderCountMB.LST}">
						<div id="mmain_cnd">
							创建日期从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="10"
								value="#{orderCountMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="10"
								value="#{orderCountMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							审核日期从:
							<h:inputText id="sk_chdt_start" styleClass="datetime" size="10"
								value="#{orderCountMB.sk_chdt_start}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_chdt_end" styleClass="datetime" size="10"
								value="#{orderCountMB.sk_chdt_end}"
								onfocus="#{gmanage.datePicker}" />
							付款日期从:
							<h:inputText id="start_date_padt" styleClass="datetime" size="15"
								onfocus="#{gmanage.datePicker}"
								value="#{orderCountMB.start_date_padt}" />
							至:
							<h:inputText id="end_date_padt" styleClass="datetime" size="15"
								onfocus="#{gmanage.datePicker}"
								value="#{orderCountMB.end_date_padt}" />
							单据编号:
							<h:inputText id="biid" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{orderCountMB.biid}" />
							来源单号:
							<h:inputText id="soco" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{orderCountMB.soco}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{orderCountMB.inco}" />
							<br>
							商品名称:
							<h:inputText id="inna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{orderCountMB.inna}" />
							规格:
							<h:inputText id="colo" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{orderCountMB.colo}" />
							审核人:
							<h:inputText id="chna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{orderCountMB.chna}" />
							客户名称:
							<h:inputText id="cuna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{orderCountMB.cuna}" />
							是否锁定库存:
							<h:selectOneMenu id="whfl" value="#{orderCountMB.whfl}">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="是" itemValue="1" />
								<f:selectItem itemLabel="否" itemValue="0" />
							</h:selectOneMenu>
							是否取消:
							<h:selectOneMenu id="iscancle" style="width:60px;"
								value="#{orderCountMB.iscancle}">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItem itemLabel="是" itemValue="1" />
								<f:selectItem itemLabel="否" itemValue="0" />
							</h:selectOneMenu>
							是否复核:
							<h:selectOneMenu id="stat" value="#{orderCountMB.stat}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="未复核" itemValue="0" />
								<f:selectItem itemLabel="己复核" itemValue="20" />
							</h:selectOneMenu>
							发货仓库：
							<h:selectOneMenu id="whid" value="#{orderCountMB.whid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{warehouseMB.wareList}" />
							</h:selectOneMenu>
							店铺：
							<h:inputText id="selectshops" styleClass="inputtext" size="20"
								value="#{orderCountMB.selectshops}" onclick="showsel(this,'selectshops')" />
							<div id="selectshops" class="checkboxsel" style="display: none;">
								<div id=mmain_opt>
									<a4j:commandButton value="全选"
										onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										onclick="selectAllItems('edit:shopList',true)" />
									<a4j:commandButton value="全清"
										onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										onclick="selectAllItems('edit:shopList',false)" />
								</div>
								<h:selectManyCheckbox id="shopList"
									value="#{orderCountMB.orderFsids}" styleClass="selectItem"
									layout="pageDirection" >
									<f:selectItems value="#{orderCountMB.shops}"/>
								</h:selectManyCheckbox>
								
							</div>
							组织架构:
							<h:selectOneMenu id="orid" value="#{orderCountMB.orid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
							单据状态:
							<h:selectOneMenu id="flag" value="#{orderCountMB.flag}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="制作之中" itemValue="01" />
								<f:selectItem itemLabel="正式单据" itemValue="11" />
								<f:selectItem itemLabel="已分配任务" itemValue="13" />
								<f:selectItem itemLabel="计划备货" itemValue="15" />
								<f:selectItem itemLabel="分拣中" itemValue="16" />
								<f:selectItem itemLabel="分拣完成" itemValue="17" />
								<f:selectItem itemLabel="装车中" itemValue="19" />
								<f:selectItem itemLabel="出库中" itemValue="21" />
								<f:selectItem itemLabel="已完成" itemValue="31" />
								<f:selectItem itemLabel="已关闭" itemValue="100" />
								<f:selectItem itemLabel="已拒回" itemValue="101" />
							</h:selectOneMenu>
							<br />
							规格码:
							<h:inputText id="sk_inse" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{orderCountMB.inse}" />
							客户订单号:
							<h:inputText id="cbid" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{orderCountMB.cbid}" />
							备注:
							<h:inputText id="rema" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{orderCountMB.rema}" />
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gselectsql="
											SELECT o.biid,o.soco,n.cuna,d.inco,v.inna,'gujingbc01' as colo,o.cbid,o.chna,g.orna,o.crdt,o.chdt,o.rema,o.flag,
											  SUM(d.qty) AS qty,
											  SUM(d.fqty) AS fqty,
											  sum(d.gqty) AS gqty,
											  sum(d.pqty) AS pqty,
											  sum(d.qty)-sum(d.fqty) as cqty,case when o.isup = 0 then isnull(o.czwe,0) else isnull(e.weig,0) end as tawe,
											  o.wgdt,f.eddt as eddt1,v.inse as vinse,o.orad,z.prov,z.reph,o.loco,o.lpco,f.eddt as eddt2,h.chdt as fchdt,k.chdt as kchdt,p.whna
											  ,CASE WHEN l.biid IS NOT NULL THEN '已取消' ELSE '' END AS iscancel,o.padt,o.eddt,o.fsna
											  ,CASE WHEN isnull(o.whfl,'')<>'' THEN '已锁库存' ELSE '未锁库存' END AS whfl
											  FROM obma o LEFT JOIN oubd  d ON o.biid = d.biid
											  LEFT JOIN inve v ON v.inco = d.inco
											  LEFT JOIN cuin n ON n.cuid = o.cuid
											  left join orga g on g.orid = o.orid
											  left join ltde m on o.biid=m.oubi and d.inco=m.inco
											  left join ltma f on f.biid=m.biid
											  left join rema h on h.soco=o.biid
											  left join lobd j on j.obid=o.biid
											  left join loma k on j.biid=k.biid
											  left join obbm l on o.biid=l.biid
											  left join waho p on p.whid=o.whid 
											  INNER JOIN dbo.olma AS ol ON ol.soco = o.biid LEFT JOIN(select biid,loco,weig,lpco from pode group by biid,loco,weig,lpco) e on o.biid = e.biid
											  LEFT OUTER JOIN dbo.noin AS z ON z.biid = o.biid 
											  where 1 = 1 #{orderCountMB.initCondition} #{orderCountMB.searchSQL}
											GROUP BY o.biid,p.whna,z.reph,o.loco,o.lpco,o.soco,d.inco,n.cuna,v.inna,v.inst,v.colo,g.orna,o.cbid,o.chna,o.crdt,o.flag,o.rema,o.chdt,v.inse,o.wgdt,f.eddt,h.chdt,k.chdt,l.biid,o.padt,o.fsna,o.whfl,o.eddt,o.isup,o.czwe,e.weig,o.orad,z.prov;
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 50,headtype = sort,align = left,type = text,datatype=string);
											gcid = flag(headtext = 状态,name = flag,width = 60,align = center,type = mask,typevalue=01:制作之中/08:文员审核/11:正式单据/21:出库中/13:已分配任务/15:计划装车/16:分拣中/17:分拣完成/31:已完成/19:装车中/100:已关闭,headtype = sort,datatype = string);
											gcid = biid(headtext = 单据编号,name = biid,width = 90,headtype = sort,align = left,type = text,datatype=string);
											gcid = whfl(headtext = 库存状态,name = whfl,width = 60,headtype = sort,align = center,type = text,datatype=string,bgcolor={gcolumn[whfl]=未锁库存:#66FF00});
											gcid = iscancel(headtext = 是否取消,name = iscancel,width = 60,headtype = sort,align = center,type = text,datatype=string,bgcolor={gcolumn[iscancel]=已取消:red});
											gcid = soco(headtext = 来源单号,name = soco,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = fsna(headtext = 店鋪,name = fsna,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = whna(headtext = 发货仓库,name = whna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = loco(headtext = 快递单号,name = loco,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = lpco(headtext = 快递公司,name = lpco,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = reph(headtext = 固话,name = reph,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = prov(headtext = 省,name = prov,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = orad(headtext = 详细地址,name = orad,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = vinse(headtext = 规格,name = vinse,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = tawe(headtext = 重量,name = tawe,width = 100,align = center,type = text,headtype = sort ,datatype=number,dataformat={0.##});
											gcid = chna(headtext = 审核人,name = crna,width = 50,align = left,type = text,headtype = sort,datatype = string);
											gcid = crdt(headtext = 订单日期,name = crdt,width = 70,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
											gcid = chdt(headtext = 审核日期,name = crdt,width = 70,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
											gcid = inco(headtext = 商品编码,name = inco,width = 90,headtype = sort,align = left,type = text,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = colo(headtext = 包材编码,name = colo,width = 100,headtype = sort,align = left,type = text,datatype=string);
										    gcid = qty(headtext = 计划数量,name = qty,width= 60,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
										    gcid = fqty(headtext = 出库数量,name = fqty,width = 60,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
										   	gcid = cqty(headtext = 未出数量,name = cqty,width = 60,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
										   	gcid = gqty(headtext = 分拣数量,name = gqty,width = 60,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
										   	gcid = eddt1(headtext = 快递单打印日期,name = eddt,width = 100,align = center,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
										   	gcid = eddt2(headtext = 发货单打印日期,name = eddt1,width = 100,align = center,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
										   	gcid = fchdt(headtext = 出库复核日期,name = fchdt,width = 100,align = center,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
										   	gcid = wgdt(headtext = 称重日期,name = wgdt,width = 100,align = center,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
										   	gcid = kchdt(headtext = 快递交接日期,name = kchdt,width = 100,align = center,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
											gcid = eddt(headtext = 同步时间,name = eddt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = padt(headtext = 付款时间,name = padt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = rema(headtext = 备注,name = rema,width = 100,headtype = sort,align = left,type = text,datatype=string);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
