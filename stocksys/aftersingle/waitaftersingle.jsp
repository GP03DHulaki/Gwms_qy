<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ include file="../../include/include_imp.jsp"%>

<html>
	<head>
		<title>盘点计划单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="盘点计划单">
		<script type="text/javascript" src="aftersingle.js"></script>
	</head>

	<body id="mmain_body">
		<div id="mydiv"
			style="width: 190px; height: 30px; bgcolor: #efefef; display: none;">
			<img src="../../images/indicator.gif" width="16" height="16" />
			<b><font color="white">正在处理，请稍等...</font> </b>
		</div>
		<div id=mmain_nav>
			<font color="#000000">库内处理</font>&gt;&gt;
			<b>追单处理</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain_opt">
					<a4j:commandButton onmouseover="this.className='a4j_over'"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
						id="sid" value="查询" type="button" action="#{stockPlanMB.search}"
						oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
						requestDelay="50" onclick="Gwallwin.winShowmask('TRUE');;"
						rendered="#{stockPlanMB.LST}" />
					<a4j:commandButton value="重置" rendered="#{stockPlanMB.LST}"
						onmouseover="this.className='a4j_over'"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
						onclick="textClear('edit','biid,crna,ch_flag,start_date,end_date,orid');" />
					<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
						onclick="reportExcel('gtable')" type="button" />
				</div>
				<a4j:outputPanel id="queryForm" rendered="true">
					<div id=mmain_cnd>
						创建时间从:
						<h:inputText id="start_date" styleClass="datetime" size="12"
							value="#{stockPlanMB.sk_start_date}"
							onfocus="#{gmanage.datePicker};" />
						至:
						<h:inputText id="end_date" styleClass="datetime" size="12"
							value="#{stockPlanMB.sk_end_date}"
							onfocus="#{gmanage.datePicker};" />
						单号:
						<h:inputText id="biid" styleClass="datetime" size="15"
							value="#{stockPlanMB.sk_obj.biid}"
							onkeypress="formsubmit(event);" />
						类型:
						<h:inputText id="sk_dety" styleClass="datetime" size="15"
							value="#{stockPlanMB.sk_obj.dety}"
							onkeypress="formsubmit(event);" />
						状态:
						<h:selectOneMenu id="ch_flag" value="#{stockPlanMB.sk_obj.flag}"
							onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItem itemLabel="待处理" itemValue="01"/>
							<f:selectItem itemLabel="处理中" itemValue="21"/>
							<f:selectItem itemLabel="已完成" itemValue="31"/>
						</h:selectOneMenu>
					</div>
				</a4j:outputPanel>
				<div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2" gsort="flag" gsortmethod="desc"
							gpage="(pagesize = 20)" gdebug="false"
							gselectsql="select a.biid,a.crdt,a.lpco,a.stat,a.flag,a.rema from aslt a WHERE (stat=1 OR stat=2) #{stockPlanMB.searchSQL}"
							gcolumn="gcid = 0(headtext = 行号,name = rowid,width = 40,headtype = text,align = center,type = text,datatype=string);
										gcid = biid(headtext = 订单号,name = biid,width = 110,headtype = sort,align = left,type = text,datatype=string);
										gcid = crdt(headtext = 创建时间,name = crdt,width =130,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
										gcid = lpco(headtext = 物流公司,name = lpco,width = 100,headtype = sort,align = left,datatype=string);
										gcid = stat(headtext = 处理类型,name = stat,width = 100,headtype = sort,align = left,type=mask,datatype=string,typevalue=1:退件/2:修改快递公司);
										gcid = flag(headtext = 状态,name = flag,width = 75,align = center,type = mask,typevalue=01:待处理/21:处理中/31:已完成/51:已回写,headtype = sort,datatype = string);
										gcid = rema(headtext = 备注,name = rema,width = 150,headtype = sort,align = left,type = text,datatype=string);
										" />
					</a4j:outputPanel>
				</div>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{stockPlanMB.msg}" />
						<h:inputHidden id="sellist" value="#{stockPlanMB.sellist}" />
					</a4j:outputPanel>
				</div>
			</h:form>
		</f:view>
	</body>
</html>
