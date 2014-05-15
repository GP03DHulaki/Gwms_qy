<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.PackBoxMB"%>

<%
    PackBoxMB ai = (PackBoxMB) MBUtil.getManageBean("#{packBoxMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSK();
    }
%>

<html>
	<head>
		<title>装箱</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="装箱">
		<script src="packbox.js"></script>
	</head>
	<body id="mmain_body">
		<div id="mydiv"
			style="width: 190px; height: 30px; bgcolor: #efefef; display: none;">
			<img src="../../images/indicator.gif" width="16" height="16" />
			<b><font color="white">正在处理，请稍等...</font> </b>
		</div>
		<div id=mmain_nav>
			<font color="#000000">库内处理&gt;&gt;</font><b>装箱</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain_opt">
					<gw:GAjaxButton value="添加单据" theme="b_theme"
						rendered="#{packBoxMB.ADD}" oncomplete="addNew();" id="addHead" />
					<gw:GAjaxButton value="删除单据" theme="b_theme"
						action="#{packBoxMB.deleteHead}" id="deleteId"
						onclick="if(!deleteHeadAll(gtable)){return false};"
						reRender="output,renderArea" oncomplete="endDeleteHeadAll();"
						requestDelay="50" rendered="#{packBoxMB.DEL}" />
					<a4j:outputPanel id="queryButs">
						<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
							onclick="Gwallwin.winShowmask('TRUE');"
							oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
							action="#{packBoxMB.search}" />
						<gw:GAjaxButton value="重置" theme="a_theme"
							onclick="clearSearchKey();" rendered="#{packBoxMB.LST}" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							onclick="reportExcel('gtable')" type="button" />
					</a4j:outputPanel>
				</div>
				<a4j:outputPanel id="queryForm" rendered="true">
					<div id="mmain_cnd">
						<h:outputText value="创建日期从:" />
						<h:inputText id="start_date" styleClass="datetime" size="12"
							value="#{packBoxMB.sk_start_date}"
							onfocus="#{gmanage.datePicker};" />
						<h:outputText value="至:" />
						<h:inputText id="end_date" styleClass="datetime" size="12"
							value="#{packBoxMB.sk_end_date}" onfocus="#{gmanage.datePicker};" />
						<h:outputText value="装箱单:" />
						<h:inputText id="sk_voucherid" styleClass="datetime" size="15"
							value="#{packBoxMB.sk_obj.biid}" onkeypress="formsubmit(event);" />
						<h:outputText value="审核人:" />
						<h:inputText id="sk_crna" styleClass="datetime" size="15"
							value="#{packBoxMB.sk_obj.chna}" onkeypress="formsubmit(event);" />
						<h:outputText value="状态:" />
						<h:selectOneMenu id="ch_flag" value="#{packBoxMB.sk_obj.flag}"
							onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItem itemLabel="制作之中" itemValue="01" />
							<f:selectItem itemLabel="正式单据" itemValue="11" />
						</h:selectOneMenu>
					</div>
				</a4j:outputPanel>
				<div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2"
							gpage="(pagesize = 20)" gdebug="true"
							gselectsql="SELECT a.biid,a.crna,a.crdt,a.chna,a.chdt,a.flag,a.rema,a.boco,a.dety,a.soco
										FROM pvma a where  1=1 #{packBoxMB.searchSQL } "
							gcolumn="gcid = 1(headtext = selall,name = did,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
								gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
								gcid = biid(headtext = 隐藏单号,name = biids,width = 60,headtype = hidden,align = left,type = link,datatype=string);
								gcid = biid(headtext = 装箱单号,name = biid,width = 110,headtype = sort,align = left,type = link,datatype=string,linktype = script,typevalue = packbox_edit.jsf?pid=gcolumn[biid]);
								gcid = boco(headtext = 箱条码,name = boco,width = 130,headtype = sort,align = left,type = text,datatype=string);
								gcid = dety(headtext = 装箱类型,name = dety,width = 100,headtype = sort,align = left,type = mask,datatype=string,typevalue=01:质检装箱/02:库内装箱/03:库外装箱);
								gcid = soco(headtext = 来源单号,name = soco,width = 130,headtype = sort,align = left,type = text,datatype=string);
								gcid = crna(headtext = 创建人,name = crna,width = 80,headtype = sort,align = left,type = text,datatype=string);
								gcid = crdt(headtext = 创建时间,name = crdt,width =110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:ss);
								gcid = chna(headtext = 审核人,name = chna,width = 80,headtype = sort,align = left,type = text,datatype=string);
								gcid = chdt(headtext = 审核时间,name = chdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:ss);
								gcid = flag(headtext = 状态,name = flag,width = 100,headtype = sort,align = left,type = mask,typevalue=01:制作之中/11:正式单据,headtype = sort,datatype = string);
								gcid = rema(headtext = 备注,name = rema,width = 170,headtype = sort,align = left,type = text,datatype=string);
								" />
					</a4j:outputPanel>
				</div>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{packBoxMB.msg}" />
						<h:inputHidden id="sellist" value="#{packBoxMB.sellist}" />
						<h:inputHidden id="biid" value="#{packBoxMB.mbean.biid}" />
					</a4j:outputPanel>
				</div>
			</h:form>
		</f:view>
	</body>
</html>