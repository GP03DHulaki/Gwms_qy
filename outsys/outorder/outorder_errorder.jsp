<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.OutOrderMB"%>
<%@	page import="com.gwall.pojo.stockout.OutOrderMBean"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
    OutOrderMB ai = (OutOrderMB) MBUtil.getManageBean("#{outOrderMB}");
    if (request.getParameter("isAll") != null) {
        ai.setSearchSQL("");
        ai.setSk_inco("");
        ((OutOrderMBean) ai.sk_obj).setFlag("");
        ai.initSearchKey(new OutOrderMBean());
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
	</head>

	<body id='mmain_body'>
		<div id='mmain_nav'>
			<font color="#000000">出库处理&gt;&gt;</font><b>出库订单</b>
			<br>
		</div>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id='mmain_opt'>
						<a4j:outputPanel id="queryButs" rendered="#{outOrderMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{outOrderMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="clearSearchKey();" />
						</a4j:outputPanel>
						<a4j:outputPanel id="headButton">
							<gw:GAjaxButton theme="b_theme"
								rendered="#{outOrderMB.SPE}"
								id="errorso2task" value="重新生成任务" type="button"
								action="#{outOrderMB.errorso2task}"
								onclick="if(!errorso2task()){return false};"
								reRender="renderArea,headButton,detailButton,headmain,outdetail,output"
								oncomplete="endErrorso2task();" requestDelay="50" />
						</a4j:outputPanel>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a name="errorder" class="default_a" id="errorder"
							href="javascript:goToErr(0)"><font size="3">返回</font> </a>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{outOrderMB.LST}">
						<div id="mmain_cnd">
							下单日期从:
							<h:inputText id="start_date" styleClass="datetime" size="13"
								onfocus="#{gmanage.datePicker}"
								value="#{outOrderMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="13"
								onfocus="#{gmanage.datePicker}"
								value="#{outOrderMB.sk_end_date}" />
							付款日期从:
							<h:inputText id="start_date_padt" styleClass="datetime" size="13"
								onfocus="#{gmanage.datePicker}"
								value="#{outOrderMB.start_date_padt}" />
							至:
							<h:inputText id="end_date_padt" styleClass="datetime" size="13"
								onfocus="#{gmanage.datePicker}"
								value="#{outOrderMB.end_date_padt}" />
							审核日期从:
							<h:inputText id="sk_chdt_start" styleClass="datetime" size="13"
								value="#{outOrderMB.sk_chdt_start}"
								onfocus="#{gmanage.datePicker}" />
							至:
							<h:inputText id="sk_chdt_end" styleClass="datetime" size="13"
								value="#{outOrderMB.sk_chdt_end}"
								onfocus="#{gmanage.datePicker}" />
							出库单号:
							<h:inputText id="sk_biid" styleClass="inputtext" size="22"
								onkeypress="formsubmit(event);"
								value="#{outOrderMB.sk_obj.biid}" />
							来源订单号:
							<h:inputText id="sk_soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{outOrderMB.sk_obj.soco}" />
							客户名称:
							<h:inputText id="sk_cuid" styleClass="inputtext" size="12"
								onkeypress="formsubmit(event);"
								value="#{outOrderMB.sk_obj.cuna}" />
							商品编码:
							<h:inputText id="sk_inco" styleClass="inputtext" size="16"
								onkeypress="formsubmit(event);"
								value="#{outOrderMB.sk_inco}" />
							制单人:
							<h:inputText id="crna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{outOrderMB.sk_obj.crna}" />
							收件人:
							<h:inputText id="rena" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{outOrderMB.rena}" />
							快递单号:
							<h:inputText id="loco" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{outOrderMB.sk_obj.loco}" />
							组织架构:
							<h:selectOneMenu id="orid" value="#{outOrderMB.sk_obj.orid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
							承运商:
							<h:selectOneMenu id="lpco" value="#{outOrderMB.sk_obj.lpco}"
								onchange="doSearch();">
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
							是否复核:
							<h:selectOneMenu id="stat" value="#{outOrderMB.sk_obj.stat}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="未复核" itemValue="0" />
								<f:selectItem itemLabel="己复核" itemValue="20" />
							</h:selectOneMenu>
							是否需要发票:
							<h:selectOneMenu id="invo" value="#{outOrderMB.sk_obj.invo}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="不需要" itemValue="flase" />
								<f:selectItem itemLabel="需要" itemValue="true" />
							</h:selectOneMenu>
							是否货到付款:
							<h:selectOneMenu id="paty" value="#{outOrderMB.sk_obj.paty}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="否" itemValue="0" />
								<f:selectItem itemLabel="是" itemValue="1" />
							</h:selectOneMenu>
							到货地区:
							<h:selectOneMenu id="lico" style="width:130px;"
								value="#{outOrderMB.sk_obj.lico}" onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{lineMB.itemlist}" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>

					<a4j:outputPanel id="output">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT DISTINCT a.id,a.lpco,d.orna,a.biid,a.soco,c.lina,isnull(j.whna,'') as wwhna,
											a.cuna,a.cbid,a.tavo,a.tawe,a.tanu,a.crna,a.crdt,a.chna,a.chdt,a.flag,a.orad,n.prov,n.city,n.area,
											a.rema,n.rena,a.endt,a.stat,a.padt,a.fsna,
											a.invo,a.loco,a.tale,a.paty,a.eddt
											FROM obma a LEFT JOIN cuin b ON a.cuid=b.cuid 
											left join noin n on n.biid = a.biid
											LEFT JOIN liin c on a.lico=c.lico left join waho j on a.waid=j.whid 
											left join (select biid,CASE WHEN isnull(sum(qty),1)=0 THEN 1 ELSE isnull(sum(qty),1) END as qty,
											isnull(sum(gqty),0) as gqty from oubd group by biid) as t on t.biid = a.biid
											left join orga d on a.orid=d.orid 
											LEFT JOIN v_so_cancel e ON a.biid=e.biid 
											WHERE a.#{outOrderMB.gorgaSql} AND a.erro<>0 AND (a.flag='13' OR a.flag='16') AND e.biid IS NULL 
											AND NOT EXISTS (SELECT 1 FROM pkln WHERE oubi=a.biid AND qty<>fqty AND stat=0) #{outOrderMB.searchSQL}
											"
										gpage="(pagesize = 20)"
										gcolumn="gcid = id(headtext = selall,name = id,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type =text ,datatype=string);
											gcid = tale(headtext = 是否紧急,name = tale,width = 65,align = center,type = mask,typevalue=0:/1:紧急,headtype = sort,datatype = string);								
											gcid = biid(headtext = 出库订单,name = hid_biid,width = 0,headtype = hidden,align = left,type = text,datatype=string);
											gcid = biid(headtext = 出库订单,name = biid,width = 150,headtype = sort,align = left,type = link,datatype=string,linktype = script,typevalue = javascript:Edit('gcolumn[biid]'));
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
											gcid = cbid(headtext = 客户订单号,name = cbid,width = 70,headtype = hidden,align = left,type = text,datatype=string);
											gcid = stat(headtext = 是否复核,name = stat,width = 65,align = center,type = mask,typevalue=0:未复核/20:己复核,headtype = sort,datatype = string);
											gcid = loco(headtext = 快递单号,name = loco,width = 120,headtype = sort,align = center,type = text,datatype=string);
											gcid = tanu(headtext = 总数量,name = tanu,width = 65,headtype = hidden,align = right,type = text,datatype=number,dataformat={0.##});
											gcid = tavo(headtext = 总体积(m³),name = tavo,width = 65,headtype = hidden,align = right,type = text,datatype=number,dataformat={0.##});
											gcid = tawe(headtext = 总重量(㎏),name = tawe,width = 65,headtype = hidden,align = right,type = text,datatype=number,dataformat={0.##});
											gcid = crna(headtext = 制单人,name = crna,width = 60,headtype = hidden,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 下单时间,name = crdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = padt(headtext = 同步时间,name = padt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = eddt(headtext = 付款时间,name = eddt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = chna(headtext = 审核人,name = chna,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核时间,name = chdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = soco(headtext = 来源单据,name = soco,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = orad(headtext = 目的地,name = orad,width = 100,headtype = hidden,align = left,type = text,datatype=string);
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
							<h:inputHidden id="outPutFileName"
								value="#{outOrderMB.outPutFileName}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='outorder_edit.jsf'"
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

			</f:view>
		</div>
	</body>
</html>