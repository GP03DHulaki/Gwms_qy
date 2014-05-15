<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.ReturnCheckMB"%>
<%
	ReturnCheckMB ai = (ReturnCheckMB) MBUtil.getManageBean("#{returncheckMB}");
	ai.setSk_biid(null);
	ai.setSearchSQL("");
%>
<html>
	<head>
		<title>质检返修单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="质检返修单">
		<script type="text/javascript" src="returncheck.js"></script>
	</head>

	<body id="mmain_body" onload="textClear('list','start_date,end_date,sk_biid,socoid');">
		<div id=mmain_nav>
			<font color="#000000">入库处理&gt;&gt;</font>
			<b>质检返修单</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							rendered="#{returncheckMB.ADD}" onclick="addNew();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" action="#{returncheckMB.deleteHead}"
							onclick="if(!doDeleteHeadAll()){return false};"
							rendered="#{returncheckMB.DEL}"
							oncomplete="endDoList();" requestDelay="50" />
						<a4j:commandButton id="sid" value="查询"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							action="#{returncheckMB.search}" type="button" reRender="output"
							rendered="#{returncheckMB.LST}" requestDelay="50" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearSearchKey();" rendered="#{returncheckMB.LST}" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							onclick="reportExcel('gtable')" type="button" />
					</div>
					<div id=mmain_cnd>
						<div>
							创建日期从:
							<h:inputText id="start_date" styleClass="datetime" size="16"
								value="#{returncheckMB.sk_start_date}" onfocus="#{gmanage.datePicker}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="16"
								value="#{returncheckMB.sk_end_date}" onfocus="#{gmanage.datePicker}" />
							单据单号:
							<h:inputText id="sk_biid" styleClass="inputtext" size="12"
								value="#{returncheckMB.mbean.biid}" onkeypress="formsubmit(event);" />
							来源单号:
							<h:inputText id="socoid" styleClass="inputtext" size="12"
								value="#{returncheckMB.mbean.soco}" onkeypress="formsubmit(event);" />							
						</div>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gversion="2" gtype="grid" gdebug="false" gselectsql="
							 select a.biid,a.soco,b.suna,a.crdt,a.crna,a.eddt,a.chna,a.flag,a.rema, 
							 (select top 1 c.inna from rcde b left join inve c on b.inco=c.inco where b.biid=a.biid) as inna
							 from rcma a left join suin b on a.suid=b.suid where 1=1
							 #{returncheckMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="
							gcid = biid(headtext = selcheckbox,name = selcheckbox,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = biid(headtext = 单据编号 ,name = biid,width = 100,headtype = hidden , align = left ,datatype = string);
							gcid = biid(headtext = 单据单号,name = biids,width = 100,headtype = sort,align = left,type = link,linktype = script,datatype=string,typevalue = returncheck_edit.jsf?biid=gcolumn[biid]);
							gcid = suna(headtext = 供应商名称,name = suna,width = 140,align = left,type = text,headtype = sort,datatype = string);
							gcid = inna(headtext = 商品名称,name = inna,width = 100,align = left,type = text,headtype = sort,datatype=string);
							gcid = crdt(headtext = 创建时间,name = crdt,width = 120,align = left,type = text,headtype = sort,datatype=string);
							gcid = crna(headtext = 创建人,name = crna,width = 80,align = left,type = text,headtype = sort,datatype=string);
							gcid = eddt(headtext = 审核时间,name = eddt,width = 120,align = left,type = text,headtype = sort,datatype=string);
							gcid = chna(headtext = 审核人,name = chna,width = 80,align = left,type = text,headtype = sort,datatype=string);
							gcid = flag(headtext = 单据状态,name = flag,width = 60,headtype = sort,align = center,type = mask,datatype=string,typevalue=01:制作之中/11:己审核);
							gcid = rema(headtext = 备注,name = rema,width = 150,headtype = sort,align = left,type = text,datatype=string);
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderCheck">
						<h:inputHidden id="msg" value="#{returncheckMB.msg}" />
						<h:inputHidden id="item" value="#{returncheckMB.item}" />
					</a4j:outputPanel>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
