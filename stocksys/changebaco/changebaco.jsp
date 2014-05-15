<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.ChangeBacoMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title>变更条码</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="变更条码">
		<meta http-equiv="description" content="变更条码">
		<script type="text/javascript" src="changebaco.js"></script>

	</head>
	<%
	    ChangeBacoMB ai = (ChangeBacoMB) MBUtil
	            .getManageBean("#{changeBacoMB}");
	    if (request.getParameter("isAll") != null) {
	        ai.initSK();
	    }
	%>
	<body id="mmain_body">
		<div id="mmain_nav">
			<font color="#000000">库内处理&gt;&gt;</font><b>变更条码</b>
			<br>
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加单据"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();" action="#{changeBacoMB.clearMBean}"
							id="addHead" rendered="#{changeBacoMB.ADD}" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll()){return false};"
							rendered="#{changeBacoMB.DEL}" reRender="output,renderArea"
							action="#{changeBacoMB.deleteHead}"
							oncomplete="endDeleteHeadAll();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							value="查询" type="button" reRender="output" id="sid"
							oncomplete="Gwallwin.winShowmask('FALSE');"
							action="#{changeBacoMB.search}" requestDelay="50"
							onclick="startDo();" rendered="#{changeBacoMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							onclick="clearSearchKey('0');" rendered="#{changeBacoMB.LST}" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							onclick="reportExcel('gtable')" type="button" />
					</div>
					<div id=mmain_cnd>
						创建日期从:
						<h:inputText id="sk_start_date" styleClass="datetime" size="10"
							onkeypress="formsubmit(event);"
							value="#{changeBacoMB.sk_start_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="10"
							onkeypress="formsubmit(event);"
							value="#{changeBacoMB.sk_end_date}"
							onfocus="#{gmanage.datePicker}" />
						条码变更单号:
						<h:inputText id="sk_biid" styleClass="datetime"
							onkeypress="formsubmit(event);" size="12"
							value="#{changeBacoMB.sk_obj.biid}" />
						制单人:
						<h:inputText id="sk_crna" styleClass="datetime"
							onkeypress="formsubmit(event);" size="12"
							value="#{changeBacoMB.sk_obj.crna}" />
						单据状态:
						<h:selectOneMenu id="sk_flag" value="#{changeBacoMB.sk_obj.flag}"
							rendered="true" onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItems value="#{changeBacoMB.flags}" />
						</h:selectOneMenu>
						组织架构:
						<h:selectOneMenu id="orid" value="#{changeBacoMB.orid}"
							onchange="doSearch();">
							<f:selectItem itemLabel="" itemValue="" />
							<f:selectItems value="#{OrgaMB.subList}" />
						</h:selectOneMenu>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="select b.whna,a.id,a.orid,g.orna,a.biid,a.crus,a.crna,a.crdt,a.edna,a.eddt,a.opna,a.chna,a.chdt,a.whid,a.flag,a.rema
								from ecma a left join waho b on a.whid = b.whid 
								left join orga g on g.orid = a.orid
								where 1=1 #{changeBacoMB.searchSQL}
							"
							gpage="(pagesize = 20)" gversion="2" gdebug="false" gsort="crdt"
							gsortmethod="desc"
							gcolumn="gcid = biid(headtext = selall,name = pk,width = 20,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 35,align = center,type = text,headtype = text,datatype = string);
								gcid = orna(headtext = 组织架构,name = orna,width = 80,align = left,type = text,headtype = sort,datatype = string);
								gcid = biid(headtext = 条码变更单号,name = hid_biid,width = 0,align = left,type = text,headtype = hidden,datatype = string);
								gcid = biid(headtext = 条码变更单号,name = biid,width = 100,headtype = sort,align = left,type = link,datatype=string,type = link,linktype=script,typevalue=changebaco_edit.jsf?pid=gcolumn[biid]);
								gcid = whna(headtext = 仓库,name = whna,width = 85,align = left,type = text,headtype = sort,datatype = string);
								gcid = crus(headtext = 创建人编码,name = crus,width = 60,align = left,type = text,headtype = sort,datatype = string);
								gcid = crna(headtext = 创建人,name = crna,width = 60,align = left,type = text,headtype = sort,datatype = string);
								gcid = crdt(headtext = 创建时间,name = crdt,width = 120,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = edna(headtext = 修改人,name = crna,width = 60,align = left,type = text,headtype = sort,datatype = string);
								gcid = eddt(headtext = 修改时间,name = crdt,width = 120,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = chna(headtext = 审核人,name = chna,width = 60,align = left,type = text,headtype = sort,datatype = string);
								gcid = chdt(headtext = 审核时间,name = chdt,width = 120,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = opna(headtext = 经办人,name = opna,width = 60,align = left,type = text,headtype = sort,datatype = string);
								gcid = flag(headtext = 状态,name = flag,width = 65,align = center,type = mask,typevalue=01:制作之中/11:正式单据,headtype = sort,datatype = string);
								gcid = rema(headtext = 备注,name = rema,width = 150,align = left,type = text,headtype = sort,datatype = string);
							" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{changeBacoMB.msg}" />
							<h:inputHidden id="sellist" value="#{changeBacoMB.sellist}" />
							<h:inputHidden id="biid" value="#{changeBacoMB.mbean.biid}" />
							<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
								onclick="startDo();"
								oncomplete="javascript:window.location.href='changebaco_edit.jsf'"
								style="display:none;" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>