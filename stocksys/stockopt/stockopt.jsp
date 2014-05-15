<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.StockOptMB"%>

<%
	StockOptMB ai =(StockOptMB) MBUtil.getManageBean("#{stockOptMB}");
	if(request.getParameter("isAll")!=null){
		ai.initSK();
	}
%>

<html>
	<head>
		<title>盘点操作单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="盘点操作单">
		<script src="stockopt.js"></script>
	</head>
	<body id="mmain_body">
		<div id="mydiv"
			style="width: 190px; height: 30px; bgcolor: #efefef; display: none;">
			<img src="../../images/indicator.gif" width="16" height="16" />
			<b><font color="white">正在处理，请稍等...</font> </b>
		</div>
		<div id=mmain_nav>
			<font color="#000000">库内处理&gt;&gt;</font><font color="#000000">盘点&gt;&gt;</font><b>盘点操作单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain_opt">
					<gw:GAjaxButton value="添加单据" theme="b_theme"
						rendered="#{stockOptMB.ADD}" oncomplete="addNew();" id="addHead" />
					<gw:GAjaxButton value="删除单据" theme="b_theme"
						action="#{stockOptMB.deleteHead}" id="deleteId"
						onclick="if(!deleteHeadAll(gtable)){return false};"
						reRender="output,renderArea" oncomplete="endDeleteHeadAll();"
						requestDelay="50" rendered="#{stockOptMB.DEL}" />
					<a4j:outputPanel id="queryButs">
						<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
							onclick="Gwallwin.winShowmask('TRUE');" oncomplete="Gwallwin.winShowmask('FALSE');"
							reRender="output" action="#{stockOptMB.search}" rendered="#{stockOptMB.LST}"/>
						<gw:GAjaxButton value="重置" theme="a_theme"
							onclick="clearSearchKey();" rendered="#{stockOptMB.LST}" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							onclick="reportExcel('gtable')" type="button" />
					</a4j:outputPanel>
				</div>
				<a4j:outputPanel id="queryForm" rendered="true">
					<div id="mmain_cnd">
						<h:outputText value="创建日期从:" />
						<h:inputText id="start_date" styleClass="datetime" size="12"
							value="#{stockOptMB.sk_start_date}"
							onfocus="#{gmanage.datePicker};" />
						<h:outputText value="至:" />
						<h:inputText id="end_date" styleClass="datetime" size="12"
							value="#{stockOptMB.sk_end_date}"
							onfocus="#{gmanage.datePicker};" />
						<h:outputText value="盘点操作单:" />
						<h:inputText id="sk_voucherid" styleClass="datetime" size="15"
							value="#{stockOptMB.sk_obj.biid}" onkeypress="formsubmit(event);" />
						<h:outputText value="盘点计划单:" />
						<h:inputText id="sk_fromvoucherid" styleClass="datetime" size="15"
							value="#{stockOptMB.sk_obj.pbid}" onkeypress="formsubmit(event);" />
						<br>
						<h:outputText value="制单人:">
						</h:outputText>
						<h:inputText id="crna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{stockOptMB.sk_obj.crna}" />
						<h:outputText value="组织架构:" >
						</h:outputText>
						<h:selectOneMenu id="orid" value="#{stockOptMB.sk_obj.orid}" onchange="doSearch();">
							<f:selectItem itemLabel="" itemValue="" />
							<f:selectItems value="#{OrgaMB.subList}" />
						</h:selectOneMenu>	
						<h:outputText value="状态:" />
						<h:selectOneMenu id="ch_flag" value="#{stockOptMB.sk_obj.flag}"
							onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItem itemLabel="制作之中" itemValue="01" />
							<f:selectItem itemLabel="正式单据" itemValue="11" />
							<f:selectItem itemLabel="关闭单据" itemValue="21" />
						</h:selectOneMenu>
						盘点库位:
							<h:inputText id="whid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{stockOptMB.whid}" />
							<img id="owid_img" style="cursor: hand;"
											src="../../images/find.gif" 
								onclick="return selectWaho('edit:whid','edit:fwna');" />
							<h:inputHidden id="fwna" value="#{stockOptMB.whna}"></h:inputHidden>
					</div>
				</a4j:outputPanel>
				<div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2"
							gpage="(pagesize = 100)" gdebug="false"
							gselectsql="SELECT a.id,a.biid,a.pbid,a.orid,a.crna,a.crdt,a.chna,a.chdt,a.flag,a.rema,b.whna,c.orna
										FROM pema a 
										LEFT JOIN waho b ON a.whid=b.whid
										LEFT JOIN orga c ON a.orid=c.orid where a.#{stockOptMB.gorgaSql} #{stockOptMB.searchSQL}"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
										gcid = 0(headtext = 行号,name = rowid,width = 40,headtype = text,align = center,type = text,datatype=string);
										gcid = biid(headtext = 隐藏单号,name = biids,width = 60,headtype = hidden,align = left,type = text,datatype=string);
										gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
										gcid = biid(headtext = 盘点操作单,name = biid,width = 110,headtype = sort,align = left,type = link,linktype = script,typevalue = stockopt_edit.jsf?pid=gcolumn[biid],datatype=string);
										gcid = pbid(headtext = 盘点计划单,name = pbid,width = 110,headtype = sort,align = left,type = text,datatype=string);
										gcid = whna(headtext = 盘点货位,name = whna,width = 100,headtype = sort,align = left,type = text,datatype=string);
										gcid = crna(headtext = 创建人,name = crna,width = 80,headtype = sort,align = left,type = text,datatype=string);
										gcid = crdt(headtext = 创建时间,name = crdt,width =110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
										gcid = chna(headtext = 审核人,name = chna,width = 80,headtype = sort,align = left,type = text,datatype=string);
										gcid = chdt(headtext = 审核时间,name = chdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
										gcid = flag(headtext = 状态,name = flag,width = 75,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:关闭单据,headtype = sort,datatype = string);
										gcid = rema(headtext = 备注,name = rema,width = 120,headtype = sort,align = left,type = text,datatype=string);
										" />
					</a4j:outputPanel>
				</div>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{stockOptMB.msg}" />
						<h:inputHidden id="sellist" value="#{stockOptMB.sellist}" />
						<h:inputHidden id="biid" value="#{stockOptMB.mbean.biid}" />
					</a4j:outputPanel>
					<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
						onclick="startDo();"
						oncomplete="javascript:window.location.href='stockopt_edit.jsf'"
						style="display:none;" />
				</div>
			</h:form>
		</f:view>
	</body>
</html>