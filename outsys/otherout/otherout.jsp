<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.gwall.view.OtherOutMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	OtherOutMB ai = (OtherOutMB) MBUtil.getManageBean("#{otherOutMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<html>
	<head>
		<title>其它出库</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="其它出库">
		<script type="text/javascript" src="otherout.js"></script>
	</head>

	<body id='mmain_body'>
		<div id="mmain_nav">
			<font color="#000000">出库处理&gt;&gt;</font><b>其它出库</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'"
							rendered="#{otherOutMB.ADD}"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll()){return false};"
							rendered="#{otherOutMB.DEL}" reRender="output,renderArea"
							action="#{otherOutMB.deleteHead}"
							oncomplete="endDeleteHeadAll();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="同步" type="button" reRender="output,renderArea" action=""
							requestDelay="50" onclick="syn();" rendered="false"
							oncomplete="endSyn();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							action="#{otherOutMB.search}" requestDelay="50"
							onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
							rendered="#{otherOutMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearData();" rendered="#{otherOutMB.LST}" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="制单日期从:">
						</h:outputText>
						<h:inputText id="sk_start_date" styleClass="datetime" size="12"
							value="#{otherOutMB.sk_start_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="12"
							value="#{otherOutMB.sk_end_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="其它出库单:">
						</h:outputText>
						<h:inputText id="sk_biid" styleClass="datetime" size="15"
							value="#{otherOutMB.sk_obj.biid}" onkeypress="formsubmit(event);" />
						<h:outputText value="物料编码:">
						</h:outputText>
						<h:inputText id="sk_inco" styleClass="datetime" size="15"
							value="#{otherOutMB.sk_inco}" onkeypress="formsubmit(event);" />
						<h:outputText value="制单人:">
						</h:outputText>
						<h:inputText id="crna" styleClass="inputtext" size="15"
							onkeypress="formsubmit(event);" value="#{otherOutMB.sk_obj.crna}" />
						<h:outputText value="组织架构:">
						</h:outputText>
						<h:selectOneMenu id="orid" value="#{otherOutMB.sk_obj.orid}"
							onchange="doSearch();">
							<f:selectItem itemLabel="" itemValue="" />
							<f:selectItems value="#{OrgaMB.subList}" />
						</h:selectOneMenu>
						<h:outputText value="仓库:" ></h:outputText>
						<h:selectOneMenu id="sk_whid" value="#{otherOutMB.sk_obj.whid}"
							style="width:130px;">
							<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
						</h:selectOneMenu>
						<h:outputText value="单据标志:">
						</h:outputText>
						<h:selectOneMenu id="sk_flag" value="#{otherOutMB.sk_obj.flag}"
							onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItems value="#{otherOutMB.flags}" />
						</h:selectOneMenu>
						<h:outputText value="出库业务类型:">
						</h:outputText>
						<h:selectOneMenu id="buty" value="#{otherOutMB.buty}"
							onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItems value="#{otherOutMB.butys}" />
						</h:selectOneMenu>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="Select a.biid,a.buty,a.soty,a.soco,a.flag,
										a.crus,a.crna,a.crdt,a.edus,a.edna,
										a.eddt,a.chus,a.chna,a.chdt,a.whid,
										b.whna,a.orid,a.rema ,c.orna,dety,
										(select top 1 inco from oode where biid=a.biid) as inco
										From ooma a 
										LEFT JOIN waho b ON a.whid = b.whid 
										LEFT JOIN orga c ON a.orid = c.orid 
										WHERE a.#{otherOutMB.gorgaSql} #{otherOutMB.searchSQL }"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
								gcid = biid(headtext = 其它出库单,name = biids,width = 110,align = left,type = text,headtype = hidden,datatype = string);
								gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
								gcid = biid(headtext = 其它出库单,name = biid,width = 110,align = left,type = link,headtype = sort,datatype = string,linktype = script,typevalue = otherout_edit.jsf?pid=gcolumn[biid]);
								gcid = soco(headtext = 来源单号,name = soco,width = 110,align = left,type = text,headtype = sort,datatype = string);
								gcid = inco(headtext = 物料编码,name = inco,width = 110,align = left,type = text,headtype = sort,datatype = string);
								gcid = dety(headtext = 业务类型,name = dety,width = 80,align = center,type = mask,typevalue=01:借出出库/02:赠品出库/03:其他出库,headtype = sort,datatype = string);
								gcid = whna(headtext = 出库仓库,name = whna,width = 110,align = left,type = text,headtype = sort,datatype = string);
								gcid = crna(headtext = 制单人,name = crna,width = 90,align = left,type = text,headtype = sort,datatype = string);
								gcid = crdt(headtext = 制单时间,name = crdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = chna(headtext = 审核人,name = chna,width = 90,align = left,type = text,headtype = sort,datatype = string);
								gcid = chdt(headtext = 审核时间,name = chdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = flag(headtext = 单据标志,name = flag,width = 80,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:关闭单据,headtype = sort,datatype = string);
								gcid = rema(headtext = 备注,name = rema,width = 115,align = left,type = text,headtype = sort,datatype = string);
							" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{otherOutMB.msg}" />
							<h:inputHidden id="sellist" value="#{otherOutMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
