<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.ReturnPutawayMB"%>
<html>
	<head>
		<title>销售退货上架</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="gwall">
		<meta http-equiv="description" content="销售退货上架">
		<script src="returnputaway.js"></script>

	</head>
	<%
		ReturnPutawayMB ai = (ReturnPutawayMB) MBUtil.getManageBean("#{returnPutawayMB}");
		if (request.getParameter("isAll") != null) {
			ai.initSK();
		}
	%>
	<body id='mmain_body' >
		<div id="mmain_nav">
			销售退货上架
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll()){return false};"
							reRender="output,renderArea"
							action="#{returnPutawayMB.deleteHead}" oncomplete="endAlertMsg();"
							requestDelay="50" />						
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							action="#{returnPutawayMB.search}" requestDelay="50"
							onclick="if(!search()){return false};"
							oncomplete="Gwallwin.winShowmask('FALSE');"
							rendered="#{returnPutawayMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearData();" rendered="#{returnPutawayMB.LST}" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="创建日期从:">
						</h:outputText>
						<h:inputText id="sk_start_date" styleClass="datetime" size="12"
							value="#{returnPutawayMB.sk_start_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="12"
							value="#{returnPutawayMB.sk_end_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="其它入库单:">
						</h:outputText>
						<h:inputText id="sk_biid" styleClass="datetime" size="15"
							value="#{returnPutawayMB.sk_obj.biid}" onkeypress="formsubmit(event);" />
						<h:outputText value="制单人:">
						</h:outputText>
						<h:inputText id="crna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{returnPutawayMB.sk_obj.crna}" />
						<!-- 
						<h:outputText value="组织架构:" >
						</h:outputText>
						<h:selectOneMenu id="orid" value="#{returnPutawayMB.sk_obj.orid}" onchange="doSearch();">
							<f:selectItem itemLabel="" itemValue="" />
							<f:selectItems value="#{OrgaMB.subList}" />
						</h:selectOneMenu>
						-->
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="Select a.id,a.biid,a.buty,a.soty,a.soco,a.infl,a.flag,a.stus,a.stna,a.stdt,a.stat,a.dety,
										a.crus,a.crna,a.crdt,a.edus,a.eddt,a.chus,a.chna,a.chdt,a.opna,a.whid,a.orid,a.rema  
										From ruma a
										WHERE 1=1 #{returnPutawayMB.searchSQL}"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
								gcid = biid(headtext = 销售退货上架单,name = biids,width = 110,align = left,type = text,headtype = hidden,datatype = string);
								gcid = biid(headtext = 销售退货上架单,name = biid,width = 110,align = left,type = link,headtype = sort,datatype = string,linktype = script,typevalue = returnputaway_edit.jsf?pid=gcolumn[biid]);
								gcid = soco(headtext = 来源单据,name = soco,width = 100,align = left,type = text,headtype = sort,datatype = string);
								gcid = crna(headtext = 创建人,name = crna,width = 50,align = left,type = text,headtype = sort,datatype = string);
								gcid = crdt(headtext = 创建时间,name = crdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = flag(headtext = 单据标志,name = flag,width = 60,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:关闭单据,headtype = sort,datatype = string);
								gcid = chna(headtext = 审核人,name = chna,width = 50,align = left,type = text,headtype = sort,datatype = string);
								gcid = chdt(headtext = 审核时间,name = chdt,width = 100,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = rema(headtext = 备注,name = rema,width = 160,align = left,type = text,headtype = sort,datatype = string);
							" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{returnPutawayMB.msg}" />
							<h:inputHidden id="sellist" value="#{returnPutawayMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
