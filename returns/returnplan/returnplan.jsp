<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.ReturnPlanMB"%>
<%
	ReturnPlanMB ai = (ReturnPlanMB) MBUtil
			.getManageBean("#{returnPlanMB}");
	if (null != request.getParameter("isAll")) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>销售退货计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="销售退货计划">
		<meta http-equiv="description" content="销售退货计划">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="returnplan.js"></script>
	</head>

	<body id="mmain_body">
		<div id="mmain_nav">
			<FONT color="#000000">退货处理</FONT>&gt;&gt;
			<B>销售退货计划</B>
		</div>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<gw:GAjaxButton value="添加单据" theme="b_theme" action=""
							rendered="#{returnPlanMB.ADD}" oncomplete="addNew();"
							id="addHead" />
						<gw:GAjaxButton value="删除单据" theme="b_theme"
							action="#{returnPlanMB.deleteHead}" id="deleteId"
							onclick="if(!deleteHeadAll(gtable)){return false};"
							reRender="output,renderArea" oncomplete="endDeleteHeadAll();"
							requestDelay="50" rendered="#{returnPlanMB.DEL}" />
						<a4j:outputPanel id="queryButs">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="Gwallwin.winShowmask('TRUE');"
								oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
								action="#{returnPlanMB.search}" rendered="#{returnPlanMB.LST}"/>
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="clearSearchKey();" rendered="#{returnPlanMB.LST}" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>


					<a4j:outputPanel id="queryForm">
						<div id="mmain_cnd">
							单据日期从:
							<h:inputText id="start_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{returnPlanMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{returnPlanMB.sk_end_date}" />
							退货计划单号:
							<h:inputText id="sk_biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{returnPlanMB.sk_obj.biid}" />
							<h:outputText value="状态:" rendered="true" />
							<h:selectOneMenu id="sk_flag" value="#{returnPlanMB.sk_obj.flag}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{returnPlanMB.flags}" />
							</h:selectOneMenu>
							组织架构:
							<h:selectOneMenu id="orid" value="#{returnPlanMB.orid}" onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<!-- LEFT JOIN waho b ON a.whid=b.whid  and b.whty=1
					gcid = whna(headtext =销售退货仓库,name = whna,width = 100,headtype = hidden,align = left,type = text,datatype=string);
					  -->
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gselectsql="
											SELECT distinct a.id,a.soco,a.biid,a.buty,a.infl,a.stdt,a.stus,a.stna,a.flag,a.Stat,a.crna,a.crdt,a.whid,a.orid,a.rema,a.chna,a.chdt,c.orna FROM rpma a
											left join orga c on a.orid=c.orid
											WHERE a.#{returnPlanMB.gorgaSql} #{returnPlanMB.searchSQL}"
										gpage="(pagesize = 18)"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 退货计划单号,name = biids,width = 100,headtype = hidden,align = left,type = text,datatype=string);
											gcid = biid(headtext = 退货计划单号,name = biid,width = 110,headtype = sort,align = left,type = link,linktype=script,typevalue=returnplan_edit.jsf?pid=gcolumn[biid], datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 90,headtype = sort,align = left,type = text,datatype=string);
											gcid = stat(headtext = 业务类型,name = stat,width = 80,align = center,type = mask,typevalue=1:退款/2:退货,headtype = sort,datatype = string);
											gcid = stna(headtext = 客户,name = stna,width = 90,headtype = sort,align = left,type = text,datatype=string);
											gcid = stdt(headtext = 退货时间,name = stdt,width = 103,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = crna(headtext = 创建人,name = crna,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 创建时间,name = crdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = chna(headtext = 审核人,name = chna,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核时间,name = chdt,width = 103,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = flag(headtext = 状态,name = flag,width = 80,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:退货中/31:已完成/100:已关闭,headtype = sort,datatype = string);
											gcid = rema(headtext = 备注,name = rema,width = 145,headtype = sort,align = left,type = text,datatype=string);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{returnPlanMB.msg}" />
							<h:inputHidden id="sellist" value="#{returnPlanMB.sellist}" />
							<h:inputHidden id="biid" value="#{returnPlanMB.mbean.biid}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>