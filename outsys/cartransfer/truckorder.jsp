<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.CarTransferMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	CarTransferMB ai = (CarTransferMB) MBUtil
			.getManageBean("#{carTransferMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>装车单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="装车单">
		<script type="text/javascript" src="truckorder.js"></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">出库处理</font>&gt;&gt;配车处理&gt;&gt;
			<b>装车单</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();" rendered="#{carTransferMB.ADD}" />
						
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据"
							onclick="if(!doDeleteAll(gtable)){return false};"
							action="#{carTransferMB.deleteHead}"
							reRender="output,renderArea,msg" oncomplete="endDeleteHeadAll();"
							requestDelay="50" rendered="#{carTransferMB.DEL}" />
							
						<a4j:outputPanel id="queryButs" rendered="#{carTransferMB.LST}">
						
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{carTransferMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','cbid,rema,cuna,sk_biid,soco,soty,sk_flag,start_date,end_date,orid');" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
								
						</a4j:outputPanel>
						
					
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{carTransferMB.LST}">
						<div id="mmain_cnd">
							创建日期从:
							<h:inputText id="start_date" styleClass="datetime" size="10"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{carTransferMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="10"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{carTransferMB.sk_end_date}" />
							装车单号:
							<h:inputText id="sk_biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{carTransferMB.sk_obj.biid}" />
							出库订单:
							<h:inputText id="soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{carTransferMB.soco}" />
							客户订单号:
							<h:inputText id="cbid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{carTransferMB.cbid}" />
							客户名称:
							<h:inputText id="cuna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{carTransferMB.cuna}" />
							<br>
							<h:outputText value="组织架构:">
							</h:outputText>
							<h:selectOneMenu id="orid" value="#{carTransferMB.orid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
							<h:outputText value="来源类型:">
							</h:outputText>
							<h:selectOneMenu id="soty" value="#{carTransferMB.soty}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{carTransferMB.sotys}" />
							</h:selectOneMenu>
							备注:
							<h:inputText id="rema" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{carTransferMB.rema}" />
							<h:outputText value="状态:" rendered="true" />
							<h:selectOneMenu id="sk_flag" value="#{carTransferMB.sk_obj.flag}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{carTransferMB.flags}" />
							</h:selectOneMenu>

						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT a.id,a.biid,a.flag,a.crus,a.crna,a.chus,a.chna,a.crdt,
											a.chdt,a.orid,a.soty,a.stat,a.rema,a.soco,0 AS tavo,0 AS tawe,
											(SELECT COUNT(DISTINCT obid) FROM lode WHERE biid=a.biid) AS vcount,
											a.lico,b.lina,c.orna,a.prnm,a.lpco 
											FROM loma a left join liin b on a.lico = b.lico
											join orga c on c.orid=a.orid
											WHERE a.#{carTransferMB.gorgaSql} #{carTransferMB.searchSQL}
											"
										gpage="(pagesize = 20)"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 装车单,name = hid_biid,width = 0,headtype = hidden,align = left,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = biid(headtext = 装车单,name = biid,width = 110,headtype = sort,align = left,type = link,datatype=string,linktype = script,typevalue = javascript:Edit('gcolumn[biid]'));
											gcid = lpco(headtext = 承运商,name = lpco,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = soty(headtext = 来源类型,name = soty,width = 60,align = center,type = mask,typevalue=OUTORDER:出库订单/PURCHASERETURNPLAN:采购退货/TRANPLAN:调拨计划,headtype = sort,datatype = string);
											gcid = tavo(headtext = 总体积,name = tavo,width = 60,headtype = hidden,align = left,type = text,datatype=number,dataformat={0.##});
											gcid = tawe(headtext = 总重量,name = tawe,width = 60,headtype = hidden,align = left,type = text,datatype=number,dataformat={0.##});
											gcid = vcount(headtext = 单据数量,name = vcount,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
											gcid = flag(headtext = 状态,name = flag,width = 55,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:出库中,headtype = sort,datatype = string);
											gcid = crna(headtext = 创建人,name = crna,width = 65,headtype = sort,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 创建时间,name = crdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = chna(headtext = 审核人,name = chna,width = 65,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = rema(headtext = 备注,name = rema,width = 170,headtype = sort,align = left,type = text,datatype=string);
											gcid = prnm(headtext = 打印次数,name = prnm,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0},bgcolor={gcolumn[prnm]>0:#ffff00});
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{carTransferMB.msg}" />
							<h:inputHidden id="sellist" value="#{carTransferMB.sellist}" />
							<h:inputHidden id="biid" value="#{carTransferMB.mbean.biid}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='truckorder_edit.jsf'"
							style="display:none;" />
					</div>
				</h:form>

			</f:view>
		</div>
	</body>
</html>