<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.SaleReturnMB"%>
<%
	SaleReturnMB ai = (SaleReturnMB) MBUtil
			.getManageBean("#{saleReturnMB}");
	if (null != request.getParameter("isAll")) {
		ai.initSK();
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>销售退货</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="销售退货">
		<meta http-equiv="description" content="销售退货">
		<script type="text/javascript" src="salesreturn.js"></script>
	</head>
	<body id="mmain_body">
		<div id="mmain_nav">
			<FONT color="#000000">退货处理</FONT>&gt;&gt;
			<B>销售退货入库</B>
		</div>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<gw:GAjaxButton value="添加单据" theme="b_theme" action=""
							rendered="#{saleReturnMB.ADD}" oncomplete="addNew();"
							id="addHead" />
						<gw:GAjaxButton value="删除单据" theme="b_theme"
							action="#{saleReturnMB.deleteHead}" id="deleteId"
							onclick="if(!deleteHeadAll(gtable)){return false};"
							reRender="output,renderArea" oncomplete="endDeleteHeadAll();"
							requestDelay="50" rendered="#{saleReturnMB.DEL}" />
						<a4j:outputPanel id="queryButs">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="Gwallwin.winShowmask('TRUE');"
								oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
								action="#{saleReturnMB.search}" rendered="#{saleReturnMB.LST}"/>
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="clearSearchKey();" rendered="#{saleReturnMB.LST}" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>


					<a4j:outputPanel id="queryForm">
						<div id="mmain_cnd">
							创建日期从:
							<h:inputText id="start_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{saleReturnMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{saleReturnMB.sk_end_date}" />
							
							审核日期从:
							<h:inputText id="ch_start_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{saleReturnMB.ch_start_date}" />
							至:
							<h:inputText id="ch_end_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{saleReturnMB.ch_end_date}" />
							
							销售退货单号:
							<h:inputText id="sk_biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{saleReturnMB.sk_obj.biid}" />
							来源单号:
							<h:inputText id="sk_soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{saleReturnMB.sk_obj.soco}" />
							<h:outputText value="状态:" rendered="true" />
							<h:selectOneMenu id="sk_flag" value="#{saleReturnMB.sk_obj.flag}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{saleReturnMB.flags}" />
							</h:selectOneMenu>
							<br/>
							创建人:
							<h:inputText id="crna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{saleReturnMB.crna}" />
								
							审核人:
							<h:inputText id="chna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{saleReturnMB.chna}" />
							
								组织架构:
							<h:selectOneMenu id="orid" value="#{saleReturnMB.orid}" onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gselectsql="
											SELECT distinct a.id,a.soty,a.soco,a.biid,a.buty,a.infl,a.flag,a.Stat,a.crna,a.crdt,a.whid,a.orid,a.rema,a.chna,a.chdt,b.whna,c.orna FROM rsma a
											LEFT JOIN waho b ON a.whid=b.whid 
											left join orga c on a.orid=c.orid
											WHERE a.#{saleReturnMB.gorgaSql} #{saleReturnMB.searchSQL}"
										gpage="(pagesize = 18)"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 销售退货单号,name = biids,width = 100,headtype = hidden,align = left,type = text,datatype=string);
											gcid = biid(headtext = 销售退货单号,name = biid,width = 100,headtype = sort,align = left,type = link,linktype=script,typevalue=salesreturn_edit.jsf?pid=gcolumn[biid], datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = soty(headtext = 来源类型,name = soty,width = 80,headtype = sort,align = left,type = mask,datatype=string,typevalue=RETURNPLAN:销售退货计划/RETURNRECEIPT:销售退货收货);
											gcid = soco(headtext = 来源单号,name = soco,width = 100,headtype = sort,align = left,type = text);
											gcid = whna(headtext =销售退货仓库,name = whna,width = 90,headtype = sort,align = left,type = text,datatype=string);
											gcid = crna(headtext = 创建人,name = crna,width = 75,headtype = sort,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 创建时间,name = crdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = chna(headtext = 审核人,name = chna,width = 75,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = flag(headtext = 状态,name = flag,width = 60,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:出库中/31:已完成,headtype = sort,datatype = string);
											gcid = rema(headtext = 备注,name = rema,width = 80,headtype = sort,align = left,type = text,datatype=string);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{saleReturnMB.msg}" />
							<h:inputHidden id="sellist" value="#{saleReturnMB.sellist}" />
							<h:inputHidden id="biid" value="#{saleReturnMB.mbean.biid}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>