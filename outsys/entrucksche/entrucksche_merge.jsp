<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.EntruckScheMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	EntruckScheMB ai = (EntruckScheMB) MBUtil
			.getManageBean("#{entruckScheMB}");
	if (request.getParameter("isAll") != null) {
		ai.searchMerge();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>备货调度</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="备货调度">
		<script type="text/javascript" src="entrucksche.js"></script>
	</head>

	<body id='mmain_body'>
		<div id='mmain_nav'>
			<a id="linkid" href="entrucksche.jsf" class="return" title="返回">出库处理</a>&gt;&gt;
			<font color="#000000">装车处理&gt;&gt;</font>
			<b>订单筛选</b>
			<br>
		</div>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id='mmain_opt'>
						<gw:GAjaxButton theme="a_theme" id="sid" value="查询"
							type="button" onclick="startDo();"
							oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
							action="#{entruckScheMB.searchMerge}" />
						<gw:GAjaxButton value="返回" theme="a_theme"
								onclick="window.location.href='entrucksche.jsf'" />		
					</div>
					<div id="mmain_cnd">
						订单日期从:
						<h:inputText id="start_date" styleClass="datetime" size="10"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
							value="#{entruckScheMB.sk_start_date}" />
						至:
						<h:inputText id="end_date" styleClass="datetime" size="10"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
							value="#{entruckScheMB.sk_end_date}" />
						客户编码:
						<h:inputText id="sk_cuin" styleClass="inputtext" size="12"
							onkeypress="formsubmit(event);" value="#{entruckScheMB.sk_cuin}" />
						承运商编码:
						<h:inputText id="sk_lpin" styleClass="inputtext" size="12"
							onkeypress="formsubmit(event);" value="#{entruckScheMB.sk_lpin}" />
						线路:
						<h:selectOneMenu id="sk_lnco" value="#{entruckScheMB.sk_lnco}"
							rendered="true" onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{entruckScheMB.lineList}" />
						</h:selectOneMenu>
						商品编码:
						<h:inputText id="sk_inco" value="#{entruckScheMB.sk_inco}"
							styleClass="datetime" size="22" />
						<img id="invcode_img" style="cursor: pointer;display:none;"
							src="../../images/find.gif" onclick="selectInve();" />
						<h:selectManyCheckbox id="checkbox" layout="lineDirection"
							value="#{entruckScheMB.boxvalues}">
							<f:selectItems value="#{entruckScheMB.sitem}" />
						</h:selectManyCheckbox>
						
					</div>

					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT SUM(ISNULL(a.tawe,0)) AS tawe,SUM(ISNULL(a.tavo,0)) AS tavo,
											SUM(ISNULL(a.tanu,0)) AS tanu, COUNT(a.biid) AS bnum 
											#{entruckScheMB.columnSql}
											FROM obma a #{entruckScheMB.joinSql} 
											WHERE a.flag in ('11','21') AND (a.aity = 'ENTRUCKPLAN' OR a.aity IS NULL OR aity='')
											#{entruckScheMB.searchKey} #{entruckScheMB.groupSql} 
										"
										gpage="(pagesize = 20)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 40,headtype = text,align = center,type = text,datatype=string);
											gcid = -1(headtext = 操作,value= 查看明细,name = opt,width = 60,headtype = text,align = center,type = script,typevalue = searchBill(#{entruckScheMB.gscript}),datatype=string);
											#{entruckScheMB.gcolumn}
											gcid = bnum(headtext = 单据数,name = bnum,width = 80,headtype = sort,align = right,type = text,datatype=string);
											gcid = tavo(headtext = 总体积,name = tavo,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##});
											gcid = tawe(headtext = 总重量,name = tawe,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##});
											gcid = tanu(headtext = 总数量,name = tanu,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
											
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					
					<div style="display: none;">
						<h:inputHidden id="cuid" value="#{entruckScheMB.cuid}" />
						<h:inputHidden id="lico" value="#{entruckScheMB.lico}" />
						<h:inputHidden id="lpco" value="#{entruckScheMB.lpco}" />
						<a4j:commandButton id="listBut" value="订单列表查询" 
							onclick="startDo();" oncomplete="gotoList();"
							style="display:none;"/>
						<a4j:commandButton id="refBut" reRender="output" />	
					</div>
				</h:form>

			</f:view>
		</div>
	</body>
</html>