<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.ShelvMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>理货上架</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="理货上架">
		<meta http-equiv="description" content="理货上架">
		<script type="text/javascript" src="shelf.js"></script>
	</head>
	<%
	    ShelvMB ai = (ShelvMB) MBUtil.getManageBean("#{shelvMB}");
	    if (request.getParameter("isAll") != null) {
	        ai.initSK();
	    }
	%>
	<body id="mmain_body">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;</font><b>理货上架</b>
			<br>
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加单据"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="addNew();" rendered="true" />

						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!doDeleteAll(gtable)){return false};" rendered="true"
							reRender="output,renderArea" oncomplete="endDoDeleteAll();"
							requestDelay="50" action="#{shelvMB.deleteHead}" />

						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onclick="startDo()" oncomplete="endDo()"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							action="#{shelvMB.search}" requestDelay="50"
							rendered="#{shelvMB.LST}" />

						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearData();" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							onclick="reportExcel('gtable')" type="button" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="创建日期 从:">
						</h:outputText>
						<h:inputText id="startDate" styleClass="datetime" size="12"
							value="#{shelvMB.startDate}" onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="endDate" styleClass="datetime" size="15"
							value="#{shelvMB.endDate}" onfocus="#{gmanage.datePicker}" />
						<h:outputText value="审核日期从:">
						</h:outputText>
						<h:inputText id="sk_start_date" styleClass="datetime" size="12"
							value="#{shelvMB.sk_start_date}" onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="15"
							value="#{shelvMB.sk_end_date}" onfocus="#{gmanage.datePicker}" />
						<h:outputText value="单据单号:">
						</h:outputText>
						<h:inputText id="sk_biid" styleClass="datetime" size="15"
							value="#{shelvMB.sk_obj.biid}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品编码:" />
						<h:inputText id="inco" styleClass="inputtext" size="17"
							onkeypress="formsubmit(event);" value="#{shelvMB.sk_inco}" />
						<h:outputText value="制单人:" />
						<h:inputText id="crna" styleClass="inputtext" size="12"
							onkeypress="formsubmit(event);" value="#{shelvMB.sk_obj.crna}" />
						<h:outputText value="状态:" />
						<h:selectOneMenu id="sk_flag"
							value="#{shelvMB.sk_obj.flag}" rendered="true"
							onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItem itemLabel="上架中" itemValue="01" />							
							<f:selectItem itemLabel="已审核" itemValue="11" />
						</h:selectOneMenu>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="select DISTINCT a.id,a.biid,a.flag,a.chna,a.crna,a.chdt,a.rema,a.crdt,a.fwid from slma a left join slde b on a.biid=b.biid where 1=1 #{shelvMB.searchSQL }"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = id(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
						gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = text,datatype = string);
						gcid = -1(headtext = 操作,name = view_h,width = 50,align = center,headtype = hidden,type = link,linktype = script,typevalue = shelf_edit.jsf?pid=gcolumn[2],value = 查看);
						gcid = biid(headtext = 单据编号,name = biids,width = 0,align = left,type = text,headtype = hidden,datatype = string);
						gcid = biid(headtext = 单据编号,name = biid,width = 120,align = left,type = link,linktype = script,typevalue =javascript:Edit('gcolumn[biid]'),headtype = sort,datatype = string);
						gcid = flag(headtext = 状态,name = ch_flag,width = 60,align = center,type = mask,typevalue=01:上架中/11:已审核/21:已完成,headtype = sort,datatype = string);
						gcid = fwid(headtext = 来源库位,name = fwid,width = 120,align = left,type = text,headtype = sort,datatype = string);
						gcid = crna(headtext = 制单人,name = crna,width = 100,align = left,type = text,headtype = sort,datatype = string);
						gcid = crdt(headtext = 创建日期,name = crdt,width = 120,align = left,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
						gcid = chna(headtext = 审核人,name = chna,width = 100,align = left,type = text,headtype = sort,datatype = string);
						gcid = chdt(headtext = 审核时间,name = chdt,width = 120,align = left,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
						gcid = rema(headtext = 备注,name = rema,width = 180,align = left,type = text,headtype = sort,datatype = string);
					" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{shelvMB.msg}" />
							<h:inputHidden id="sellist" value="#{shelvMB.sellist}" />
							<h:inputHidden id="biid" value="#{shelvMB.mbean.biid}" />
							<a4j:commandButton id="editbut" value="隐藏" onclick="startDo();"
								oncomplete="javascript:window.location.href='shelf_edit.jsf'"
								style="display:none;" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>