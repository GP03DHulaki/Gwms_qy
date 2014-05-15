<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.OutOrderMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
    OutOrderMB ai = (OutOrderMB) MBUtil.getManageBean("#{outOrderMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSK();
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>出库订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="出库订单">
		<script type="text/javascript" src="outorder.js"></script>
		<script type="text/javascript" src="checkboxsel.js"></script>
	</head>

	<body id='mmain_body' onload="selectorder()">
		<div id='mmain_nav'>
			<font color="#000000">出库处理&gt;&gt;</font><b>出库订单</b>
			<br>
		</div>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id='mmain_opt'>
					<table style="margin-top:0px">
						<tr>
						<td>
						<gw:GAjaxButton value="添加单据" theme="b_theme"
							action="#{outOrderMB.clearMBean}" oncomplete="addNew();"
							id="addHead" rendered="#{outOrderMB.ADD}" />
						<gw:GAjaxButton value="删除单据" theme="b_theme"
							action="#{outOrderMB.deleteHead}" id="deleteId"
							onclick="if(!deleteHeadAll(gtable)){return false};"
							reRender="output,renderArea" oncomplete="endDeleteHeadAll();"
							requestDelay="50" rendered="#{outOrderMB.DEL}" />
						<a4j:outputPanel id="queryButs" rendered="#{outOrderMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{outOrderMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="clearSearchKey();" />
						</a4j:outputPanel>
						<!-- 备货计划需要生成有来源平台,则需要用createTaskByBiid方法生成 -->
						<gw:GAjaxButton theme="b_theme" id="createTaskByBiid"
							value="手动生成任务" type="button"
							onclick="if(!createTask()){return false};" reRender="output,msg"
							oncomplete="endCreateTask();" rendered="#{outOrderMB.SCH}"
							action="#{outOrderMB.createTaskByBiid}" />
							
						
						<%-- 
							
						<gw:GAjaxButton theme="b_theme" id="rejectOrder" value="订单拒回"
							type="button" onclick="if(!rejectOrder()){return false};"
							reRender="output,msg" oncomplete="closeOrderEnd();"
							action="#{outOrderMB.refuseBack}" rendered="#{outOrderMB.APP}" />
						--%>
						
						<gw:GAjaxButton theme="b_theme" id="updateCarrier" value="修改承运商"
							type="button" onclick="if(!updateCarrier()){return false};"
							reRender="output,msg" action="#{outOrderMB.updateCarrier}"
							 rendered="#{outOrderMB.MOD}" oncomplete="closeOrderEnd();" />

					 
						<gw:GAjaxButton theme="b_theme" id="closeOrder" value="关闭取消订单"
							type="button" onclick="if(!closeOrder()){return false};"
							reRender="output,msg" oncomplete="closeOrderEnd();"
							action="#{outOrderMB.closeOrder}" rendered="#{outOrderMB.APP}" />
							
						<gw:GAjaxButton id="impDBut" value="导入订单" theme="b_theme" rendered="true" onclick="showImport()" type="button" />	
						
						<gw:GAjaxButton theme="b_theme" id="qxOrder" value="取消订单"
						type="button" onclick="if(!closeOrder()){return false};"
						reRender="output,msg" oncomplete="closeOrderEnd();"
						action="#{outOrderMB.qxOrder}" rendered="#{outOrderMB.APP}"/>
						
					<%--			
						<gw:GAjaxButton theme="b_theme" id="creatTranPlan" value="生成调拨计划"
							type="button" onclick="if(!creatTranPlan()){return false};"
							reRender="output,msg" oncomplete="closeOrderEnd();"
							action="#{outOrderMB.creatTranPlan}" rendered="#{outOrderMB.SPE}" />
						</td>
					--%>
						<td>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a name="errorder" class="default_a" id="errorder"
							href="javascript:goToErr(1)"><font size="3">查看异常跳过订单</font> </a>
						
						</td>
						<td>
							<span id="orderNum" style="display:block;background-color:red;width:140px;height:12px;margin-left:15px"> 
							<font size="3">已选择  <h:inputText id="seleectOrderNums" styleClass="inputtext" size="1"
											value="#{outOrderMB.ordernums}" readonly="true"
											style="color:#990033;backgroundColor:#990033;" />个订单 </font>
						</span>
						</td>
						<tr>
					</table>
					</div>
					
					<a4j:outputPanel id="queryForm" rendered="#{outOrderMB.LST}">
						<div id="mmain_cnd">
							下单日期从:
							<h:inputText id="start_date" styleClass="datetime" size="15"
								onfocus="#{gmanage.datePicker}"
								value="#{outOrderMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="15"
								onfocus="#{gmanage.datePicker}"
								value="#{outOrderMB.sk_end_date}" />
							付款日期从:
							<h:inputText id="start_date_padt" styleClass="datetime" size="15"
								onfocus="#{gmanage.datePicker}"
								value="#{outOrderMB.start_date_padt}" />
							至:
							<h:inputText id="end_date_padt" styleClass="datetime" size="15"
								onfocus="#{gmanage.datePicker}"
								value="#{outOrderMB.end_date_padt}" />
							审核日期从:
							<h:inputText id="sk_chdt_start" styleClass="datetime" size="15"
								value="#{outOrderMB.sk_chdt_start}"
								onfocus="#{gmanage.datePicker}" />
							至:
							<h:inputText id="sk_chdt_end" styleClass="datetime" size="15"
								value="#{outOrderMB.sk_chdt_end}"
								onfocus="#{gmanage.datePicker}" />
							交接日期从:
							<h:inputText id="sk_lodt_start" styleClass="datetime" size="15"
								value="#{outOrderMB.sk_lodt_start}"
								onfocus="#{gmanage.datePicker}" />
							至:
							<h:inputText id="sk_lodt_end" styleClass="datetime" size="15"
								value="#{outOrderMB.sk_lodt_end}"
								onfocus="#{gmanage.datePicker}" />
							<!-- 
							到期日期从:
							<h:inputText id="sk_endt_start" styleClass="datetime" size="10"
								value="#{outOrderMB.sk_endt_start}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_endt_end" styleClass="datetime" size="10"
								value="#{outOrderMB.sk_endt_end}"
								onfocus="#{gmanage.datePicker}" />
							--CONVERT(INT,(t.gqty)/(t.qty)*100) AS progress
							 -->
							出库单号:
							<h:inputText id="sk_biid" styleClass="inputtext" size="22"
								onkeypress="formsubmit(event);"
								value="#{outOrderMB.sk_obj.biid}" />
							来源订单号:
							<h:inputText id="sk_soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{outOrderMB.sk_obj.soco}" />
							快递单号:
							<h:inputText id="loco" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{outOrderMB.sk_obj.loco}" />
							客户名称:
							<h:inputText id="sk_cuid" styleClass="inputtext" size="12"
								onkeypress="formsubmit(event);"
								value="#{outOrderMB.sk_obj.cuna}" />
							制单人:
							<h:inputText id="crna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{outOrderMB.sk_obj.crna}" />
							
							收件人:
							<h:inputText id="rena" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{outOrderMB.rena}" />
							<br>
							来源平台:
							<h:inputText id="orderFopl" styleClass="inputtext" size="20"
								value="#{outOrderMB.orderFopl}"
								onclick="showsel(this,'orderFopls')" />
							<div id="orderFopls" class="checkboxsel" style="display: none;">
								<div id=mmain_opt>
									<a4j:commandButton value="全选"
										onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										onclick="selectAllItems('edit:foplList',true)" />
									<a4j:commandButton value="全清"
										onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										onclick="selectAllItems('edit:foplList',false)" />
								</div>
								<h:selectManyCheckbox id="foplList"
									value="#{outOrderMB.orderFopls}" styleClass="selectItem"
									layout="pageDirection"> 
									<f:selectItem itemLabel="淘宝" itemValue="001" />
									<f:selectItem itemLabel="拍拍 " itemValue="002" />
									<f:selectItem itemLabel="独立商城 " itemValue="003" />
									<f:selectItem itemLabel="电话接单" itemValue="004" />
									<f:selectItem itemLabel="其它 " itemValue="005" />
									<f:selectItem itemLabel="京东" itemValue="006" />
									<f:selectItem itemLabel="亚马逊" itemValue="007" />
									<f:selectItem itemLabel="一号店" itemValue="008" />
									<f:selectItem itemLabel="淘宝分销 " itemValue="009" />
									<f:selectItem itemLabel="QQ网购" itemValue="010" />
									<f:selectItem itemLabel="中粮兑换卡" itemValue="011" />
									<f:selectItem itemLabel="国美" itemValue="012" />
									<f:selectItem itemLabel="中国移动" itemValue="013" />
									<f:selectItem itemLabel="中粮B2C商城" itemValue="014" />
									<f:selectItem itemLabel="中粮B2B商城" itemValue="015" />
								</h:selectManyCheckbox>
								
							</div>
							店铺：
							<h:inputText id="selectshops" styleClass="inputtext" size="20"
								value="#{outOrderMB.selectshops}" onclick="showsel(this,'selectshops')" />
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
									value="#{outOrderMB.orderFsids}" styleClass="selectItem"
									layout="pageDirection" >
									<f:selectItems value="#{outOrderMB.shops}"/>
								</h:selectManyCheckbox>
								
							</div>
							状态:
							<h:selectOneMenu id="sk_flag" value="#{outOrderMB.sk_obj.flag}"
								rendered="true"  onchange="$('edit:sid').click();">
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
							是否复核:
							<h:selectOneMenu id="stat" value="#{outOrderMB.sk_obj.stat}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="未复核" itemValue="0" />
								<f:selectItem itemLabel="己复核" itemValue="20" />
								<f:selectItem itemLabel="拣货中" itemValue="21" />
							</h:selectOneMenu>
							是否需要发票:
							<h:selectOneMenu id="invo" value="#{outOrderMB.sk_obj.invo}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="不需要" itemValue="false" />
								<f:selectItem itemLabel="需要" itemValue="true" />
							</h:selectOneMenu>

							发票号:
							<h:inputText id="inno" styleClass="inputtext" size="22"
								onkeypress="formsubmit(event);"
								value="#{outOrderMB.sk_obj.inno}" />

							是否紧急:
							<h:selectOneMenu id="tale" value="#{outOrderMB.sk_obj.tale}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="否" itemValue="0" />
								<f:selectItem itemLabel="是" itemValue="1" />
							</h:selectOneMenu>
							<br>
							是否货到付款:
							<h:selectOneMenu id="paty" value="#{outOrderMB.sk_obj.paty}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="否" itemValue="0" />
								<f:selectItem itemLabel="是" itemValue="1" />
							</h:selectOneMenu>
							运费到付:
							<h:selectOneMenu id="fpay" value="#{outOrderMB.fpay}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="否" itemValue="false" />
								<f:selectItem itemLabel="是" itemValue="true" />
							</h:selectOneMenu>
							
							到货地区:
							<h:selectOneMenu id="lico" style="width:130px;"
								value="#{outOrderMB.sk_obj.lico}" onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{lineMB.itemlist}" />
							</h:selectOneMenu>
							承运商:
							<h:selectOneMenu id="lpco" value="#{outOrderMB.sk_obj.lpco}"
								>
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{carrierMB.list}" />
							</h:selectOneMenu>
							是否单品:
							<h:selectOneMenu id="inty" value="#{outOrderMB.sk_obj.inty}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItem itemLabel="一单一货" itemValue="S" />
								<f:selectItem itemLabel="一单多货" itemValue="M" />
							</h:selectOneMenu>
							是否锁定库存:
							<h:selectOneMenu id="sk_whfl" value="#{outOrderMB.sk_obj.whfl}"
								rendered="true"  onchange="$('edit:sid').click();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="是" itemValue="1" />
								<f:selectItem itemLabel="否" itemValue="0" />
							</h:selectOneMenu>
							<br>
							是否取消:
							<h:selectOneMenu id="iscancle" style="width:60px;"
								value="#{outOrderMB.iscancle}" onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItem itemLabel="是" itemValue="1" />
								<f:selectItem itemLabel="否" itemValue="0" />
							</h:selectOneMenu>
							商品编码:
							<h:inputText id="sk_sku" styleClass="inputtext" size="16"
								onkeypress="formsubmit(event);" value="#{outOrderMB.sk_sku}" />
							商品条码:
							<h:inputText id="sk_inco" styleClass="inputtext" size="16"
								onkeypress="formsubmit(event);" value="#{outOrderMB.sk_inco}" />
							发货仓库：
							<h:selectOneMenu id="whid" value="#{outOrderMB.sk_obj.whid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{warehouseMB.wareList}" />
							</h:selectOneMenu>
							
							组织架构:
							<h:selectOneMenu id="orid" value="#{outOrderMB.sk_obj.orid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
							预售类型:
							<h:selectOneMenu id="pret" value="#{outOrderMB.sk_obj.pret}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="非预售" itemValue="0" />
								<f:selectItem itemLabel="部分预售" itemValue="1" />
								<f:selectItem itemLabel="全部预售" itemValue="2" />
							</h:selectOneMenu>
							<br/>
							订单锁定库区:
							<h:selectOneMenu id="arealist" value="#{outOrderMB.areaWhid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{outOrderMB.arealist}" />
							</h:selectOneMenu>
							订单通道从:
							<h:selectOneMenu id="fgallery" value="#{outOrderMB.fgallery}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{outOrderMB.galleryList}" />
							</h:selectOneMenu>
							至:
							<h:selectOneMenu id="ogallery" value="#{outOrderMB.ogallery}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{outOrderMB.galleryList}" />
							</h:selectOneMenu>
							锁定库位从:
							<h:inputText id="flockwhid" styleClass="inputtext" size="12"
								onkeypress="formsubmit(event);" value="#{outOrderMB.flwhid}" />
							至:
							<h:inputText id="olockwhid" styleClass="inputtext" size="12"
								onkeypress="formsubmit(event);" value="#{outOrderMB.olwhid}" />
							个性订单:
							<h:selectOneMenu id="issp" value="#{outOrderMB.issp}">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="否" itemValue="0" />
								<f:selectItem itemLabel="是" itemValue="1" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>

					<a4j:outputPanel id="output">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true" gsort="tale" gsortmethod="DESC"
										gselectsql="
											SELECT DISTINCT a.id,isnull(a.tsmg,'') as tsmg,a.isdt,isnull(a.ised,'0') as ised,a.lpco,
											CASE WHEN isnull(a.whfl,'')<>'' THEN '已锁库存' ELSE '未锁库存' END AS whfl,
											d.orna,a.biid,a.soco,c.lina,isnull(j.whna,'') as wwhna,
											a.cuna,g.whna,a.cbid,a.tavo,a.tawe,a.tanu,a.crna,a.crdt,a.chna,a.chdt,a.flag,a.orad,n.prov,n.city,n.area,
											a.rema,n.rena,a.endt,a.stat,CASE WHEN e.biid IS NOT NULL THEN '已取消' ELSE '' END AS iscancel,a.padt,k.chdt as lodt,a.fsna,
											a.invo,a.inno,a.loco,a.tale,a.paty,a.eddt,a.fpay,a.pret,a.issp,a.spmk,f.inco
											FROM obma a LEFT JOIN cuin b ON a.cuid=b.cuid 
											left join noin n on n.biid = a.biid
											left join waho g on g.whid=a.whid
											LEFT JOIN liin c on a.lico=c.lico left join waho j on a.waid=j.whid 
											left join orga d on a.orid=d.orid 
											left join obbm e on a.biid=e.biid
											left join oubd f on a.biid = f.biid and f.roid= '0001'
											left join lode h on h.obid=a.biid
											left join loma k on h.biid=k.biid
											WHERE a.fopl in (#{outOrderMB.foplSql}) and 
											a.#{outOrderMB.gorgaSql} #{outOrderMB.searchSQL}"
										gpage="(pagesize = 100)" growclick="selectorder()"
										gcolumn="gcid = id(headtext = selall,name = id,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type =text ,datatype=string);
											gcid = ised(headtext = 授权状态,name = ised,width = 50,headtype = hidden,align = left,type = mask,typevalue=0:/1:/5:允许发货,datatype=string);
											gcid = whfl(headtext = 库存状态,name = whfl,width = 60,headtype = sort,align = center,type = text,datatype=string,bgcolor={gcolumn[whfl]=未锁库存:#66FF00});
											gcid = iscancel(headtext = 是否取消,name = iscancel,width = 60,headtype = sort,align = center,type = text,datatype=string,bgcolor={gcolumn[iscancel]=已取消:red});
											gcid = tale(headtext = 是否紧急,name = tale,width = 65,align = center,type = mask,typevalue=0:/1:紧急,headtype = sort,datatype = string,bgcolor={gcolumn[tale]=1:{#FFFFCC}});								
											gcid = biid(headtext = 出库订单,name = hid_biid,width = 0,headtype = hidden,align = left,type = text,datatype=string);
											gcid = flag(headtext = 状态,name = flag,width = 65,align = center,type = mask,typevalue=01:制作之中/08:文员审核/11:正式单据/21:出库中/13:已分配任务/15:计划装车/16:分拣中/17:分拣完成/31:已完成/19:装车中/100:已关闭/101:已拒回,headtype = sort,datatype = string);
											gcid = biid(headtext = 出库订单,name = biid,width = 150,headtype = sort,align = left,type = link,datatype=string,linktype = script,typevalue = javascript:Edit('gcolumn[biid]'));
											gcid = whna(headtext = 发货仓库,name = whna,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = inco,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = tanu(headtext = 总数量,name = tanu,width = 65,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
											gcid = fsna(headtext = 来源平台,name = fsna,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = lpco(headtext = 承运商,name = lpco,width = 50,headtype = sort,align = left,type = text,datatype=string);
											gcid = cuna(headtext = 客户名称,name = cuna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = rena(headtext = 收件人,name = crna,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = prov(headtext = 省,name = prov,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = city(headtext = 市,name = city,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = area(headtext = 区,name = area,width = 60,headtype = hidden,align = left,type = text,datatype=string);
											gcid = lina(headtext = 到货地区,name = lina,width = 70,headtype = sort,align = center,type = text,datatype=string);
											gcid = invo(headtext = 发票,name = invo,width = 65,align = center,type = mask,typevalue=false:/true:需要,headtype = sort,datatype = string);
											gcid = paty(headtext = 是否到付,name = paty,width = 65,align = center,type = mask,typevalue=0:/1:货到付款,headtype = sort,datatype = string);
											gcid = fpay(headtext = 运费到付,name = fpay,width = 65,align = center,type = mask,typevalue=false:/true:运费到付,headtype = sort,datatype = string);
											gcid = cbid(headtext = 客户订单号,name = cbid,width = 70,headtype = hidden,align = left,type = text,datatype=string);
											gcid = stat(headtext = 是否复核,name = stat,width = 65,align = center,type = mask,typevalue=0:未复核/20:己复核/21:拣货中,headtype = sort,datatype = string);
											gcid = loco(headtext = 快递单号,name = loco,width = 120,headtype = sort,align = center,type = text,datatype=string);
											gcid = tavo(headtext = 总体积(m³),name = tavo,width = 65,headtype = hidden,align = right,type = text,datatype=number,dataformat={0.##});
											gcid = tawe(headtext = 总重量(㎏),name = tawe,width = 65,headtype = hidden,align = right,type = text,datatype=number,dataformat={0.##});
											gcid = crna(headtext = 制单人,name = crna,width = 60,headtype = hidden,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 下单时间,name = crdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = eddt(headtext = 同步时间,name = eddt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = padt(headtext = 付款时间,name = padt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = lodt(headtext = 交接时间,name = lodt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = chna(headtext = 审核人,name = chna,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核时间,name = chdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = pret(headtext = 预售类型,name = pret,width = 65,align = center,type = mask,typevalue=0:非预售/1:部分预售/2:全部预售,headtype = sort,datatype = string);
											gcid = soco(headtext = 来源单据,name = soco,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = orad(headtext = 目的地,name = orad,width = 100,headtype = hidden,align = left,type = text,datatype=string);
											gcid = issp(headtext = 个性订单,name = issp,width = 130,headtype = sort,align = left,type = mask,typevalue=0:否/1:是:datatype=string);
											gcid = spmk (headtext = 个性内容,name = spmk,width = 130,headtype = sort,align = left,type = text,datatype=string);
											gcid = inno (headtext = 发票号,name = inno,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = rema(headtext = 备注,name = rema,width = 130,headtype = sort,align = left,type = text,datatype=string);
									" />
								</td>
							</tr>
						</table>
					</a4j:outputPanel>
					<%--
					gcid = -1(headtext = 操作,value=查看,name = opt,width = 30,headtype = #{saleOrderMB.colContral1},align = center,type = link,linktype = script,typevalue = javascript:Edit('gcolumn[vc_voucherid]'),datatype=string);
					--%>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{outOrderMB.msg}" />
							<h:inputHidden id="sellist" value="#{outOrderMB.sellist}" />
							<h:inputHidden id="biid" value="#{outOrderMB.mbean.biid}" />
							<h:inputHidden id="gsql" value="#{outOrderMB.gsql}" />
							<h:inputHidden id="ordernums" value="#{outOrderMB.ordernums}" />
							<h:inputHidden id="outPutFileName"
								value="#{outOrderMB.outPutFileName}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='outorder_edit.jsf'"
							style="display:none;" />
						<a4j:commandButton id="orderNumBut" value="隐藏的统计订单个数按钮"
							onclick="getOrderNums();"
							oncomplete="" reRender="seleectOrderNums"
							style="display:none;" />
					</div>
				</h:form>

				<div id="errmsg" style="display: none">
					<div id=mmain_cnd>
						<span id="mes"></span>
						<div align="center">
							<button type="button" onclick="Gwallwin.winClose();"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" class="a4j_but">
								关闭
							</button>
						</div>
					</div>
				</div>
				
			   <div id="import" style="display: none" align="left">
					<h:form id="file" enctype="multipart/form-data">
						<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
							value="#{outOrderMB.upFile}" required="true" size="75" />
						<div id="mes"></div>
						<div align="center">
							<gw:GAjaxButton value="上传" onclick="return doImport();"
								id="import" theme="a_theme" />
							<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
								onclick="hideDiv()" type="button" />
						</div>
						<div style="display: none;">
							<h:commandButton value="上传" id="importBut"
								action="#{outOrderMB.importXlsEB}" />
						</div>
					</h:form>
				</div>

			</f:view>
		</div>
	</body>
</html>