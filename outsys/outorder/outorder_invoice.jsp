<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.stockout.OutOrderInvoiceMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
	OutOrderInvoiceMB ai = (OutOrderInvoiceMB) MBUtil.getManageBean("#{outOrderInvoiceMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSK();
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>销售订单开票</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="销售订单开票">
		<script type="text/javascript" src="outorder.js"></script>
		<script type="text/javascript" src="checkboxsel.js"></script>
		<style type="text/css">
			.gcolstyle {
				cursor: pointer;
				color: #0000FF;
			}
		</style>
	</head>

	<body id='mmain_body'>
		<div id='mmain_nav'>
			<font color="#000000">出库处理&gt;&gt;</font><b>销售订单开票</b>
			<br>
		</div>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id='mmain_opt'>
						<a4j:outputPanel id="queryButs" rendered="#{outOrderInvoiceMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{outOrderInvoiceMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="clearSearchKey();" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{outOrderInvoiceMB.LST}">
						<div id="mmain_cnd">
							下单日期从:
							<h:inputText id="start_date" styleClass="datetime" size="15"
								onfocus="#{gmanage.datePicker}"
								value="#{outOrderInvoiceMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="15"
								onfocus="#{gmanage.datePicker}"
								value="#{outOrderInvoiceMB.sk_end_date}" />
							付款日期从:
							<h:inputText id="start_date_padt" styleClass="datetime" size="15"
								onfocus="#{gmanage.datePicker}"
								value="#{outOrderInvoiceMB.start_date_padt}" />
							至:
							<h:inputText id="end_date_padt" styleClass="datetime" size="15"
								onfocus="#{gmanage.datePicker}"
								value="#{outOrderInvoiceMB.end_date_padt}" />
							审核日期从:
							<h:inputText id="sk_chdt_start" styleClass="datetime" size="15"
								value="#{outOrderInvoiceMB.sk_chdt_start}"
								onfocus="#{gmanage.datePicker}" />
							至:
							<h:inputText id="sk_chdt_end" styleClass="datetime" size="15"
								value="#{outOrderInvoiceMB.sk_chdt_end}"
								onfocus="#{gmanage.datePicker}" />
							<br>
							是否开票:
							<h:selectOneMenu id="isiv" value="#{outOrderInvoiceMB.isiv}">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="否" itemValue="0" />
								<f:selectItem itemLabel="是" itemValue="1" />
								<f:selectItem itemLabel="已补票" itemValue="2" />
							</h:selectOneMenu>
							出库订单:
							<h:inputText id="sk_biid" styleClass="inputtext" size="22"
								onkeypress="formsubmit(event);"
								value="#{outOrderInvoiceMB.sk_obj.biid}" />
							来源交易号:
							<h:inputText id="sk_soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{outOrderInvoiceMB.sk_obj.soco}" />
							快递单号:
							<h:inputText id="loco" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{outOrderInvoiceMB.sk_obj.loco}" />
							收件人:
							<h:inputText id="rena" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{outOrderInvoiceMB.rena}" />
							商品编码:
							<h:inputText id="sk_inco" styleClass="inputtext" size="16"
								onkeypress="formsubmit(event);" value="#{outOrderInvoiceMB.sk_inco}" />
							<br>
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="output">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false" gsort="isiv"
										gselectsql="
											SELECT a.biid,a.flag,a.fsna,a.lpna,a.cuna,n.rena,n.prov,n.city,a.area,a.soco,a.paty,a.fpay,a.loco,a.crdt,a.padt,n.rsad,a.rema
											,n.rem1,n.rem2,n.rem3,a.isiv,a.ivco,a.tanu,a.ivun,a.ivdt
											FROM obma a LEFT JOIN cuin b ON a.cuid=b.cuid
											left join noin n on n.biid = a.biid
											left join obbm e on a.biid=e.biid
											WHERE e.biid is null AND a.#{outOrderInvoiceMB.gorgaSql} #{outOrderInvoiceMB.searchSQL}"
										gpage="(pagesize = 20)"
										gcolumn="gcid = biid(headtext = selall,name = id,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = -1(headtext = 操作,value=<font color=blue>开票,name = doinv,width = 50,headtype = text,align = center,type = text,datatype=string,gscript={onclick=startDo()&soInvoice('gcolumn[biid]')},gstyle=gcolstyle);
											gcid = isiv(headtext = 是否开票,name = isiv,width = 65,align = center,type = mask,typevalue=0:未开票/1:已开票/2:已补票,headtype = sort,datatype = string,,bgcolor={gcolumn[isiv]=1:#66FF00/gcolumn[isiv]=0:red/gcolumn[isiv]=2:#bbffaa});
											gcid = biid(headtext = 出库订单,name = biid,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = ivun(headtext = 开票人,name = ivun,width = 120,headtype = sort,align = left,type = text,datetype=string);
											gcid = ivdt(headtext = 开票时间,name = ivdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = tanu(headtext = 商品数量,name = tanu,width = 60,headtype = sort,align = left,type = text,datatype=number,dataformat=0);
											gcid = ivco(headtext = 发票内容,name = ivco,width = 350,headtype = sort,align = left,type = text,datatype=string);
											gcid = rema(headtext = 备注,name = rema,width = 130,headtype = sort,align = left,type = text,datatype=string);
											gcid = fsna(headtext = 来源店铺,name = lpna,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = lpna(headtext = 承运商,name = lpco,width = 50,headtype = sort,align = left,type = text,datatype=string);
											gcid = cuna(headtext = 客户昵称,name = cuna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = rena(headtext = 收件人,name = crna,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = prov(headtext = 省,name = prov,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = city(headtext = 市,name = city,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = area(headtext = 区,name = area,width = 60,headtype = hidden,align = left,type = text,datatype=string);
											gcid = soco(headtext = 来源交易,name = soco,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = paty(headtext = 是否到付,name = paty,width = 65,align = center,type = mask,typevalue=0:/1:货到付款,headtype = sort,datatype = string);
											gcid = fpay(headtext = 运费到付,name = fpay,width = 65,align = center,type = mask,typevalue=false:/true:运费到付,headtype = sort,datatype = string);
											gcid = loco(headtext = 快递单号,name = loco,width = 120,headtype = sort,align = center,type = text,datatype=string);
											gcid = flag(headtext = 状态,name = flag,width = 65,align = center,type = mask,typevalue=01:制作之中/08:文员审核/11:正式单据/21:出库中/13:已分配任务/15:计划装车/16:分拣中/17:分拣完成/31:已完成/19:装车中/100:已关闭,headtype = sort,datatype = string);
											gcid = crdt(headtext = 下单时间,name = crdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = rsad(headtext = 目的地,name = orad,width = 100,headtype = hidden,align = left,type = text,datatype=string);
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
							<h:inputHidden id="msg" value="#{outOrderInvoiceMB.msg}" />
							<h:inputHidden id="sellist" value="#{outOrderInvoiceMB.sellist}" />
							<h:inputHidden id="biid" value="#{outOrderInvoiceMB.mbean.biid}" />
							<h:inputHidden id="gsql" value="#{outOrderInvoiceMB.gsql}" />
							<h:inputHidden id="outPutFileName" value="#{outOrderInvoiceMB.outPutFileName}" />
						</a4j:outputPanel>
						<a4j:jsFunction name="soInvoice"  oncomplete="endSoInv();" reRender="renderArea,output" action="#{outOrderInvoiceMB.soInvoice}" >
							<a4j:actionparam name="sellist" assignTo="#{outOrderInvoiceMB.sellist}" />
						</a4j:jsFunction>
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