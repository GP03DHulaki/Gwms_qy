<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.OtherinMB"%>
<html>
	<head>
		<title>其它入库</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="gwall">
		<meta http-equiv="description" content="其它入库">
		<script src="otherin.js"></script>

	</head>
	<%
		OtherinMB ai = (OtherinMB) MBUtil.getManageBean("#{otherinMB}");
		if (request.getParameter("isAll") != null) {
			ai.initSK();
		}
	%>
	<body id='mmain_body' >
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;入库&gt;&gt;</font><b>其它入库</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'"
							rendered="#{otherinMB.ADD}"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll()){return false};"
							rendered="#{otherinMB.DEL}" reRender="output,renderArea"
							action="#{otherinMB.deleteHead}" oncomplete="endDeleteHeadAll();"
							requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="同步" type="button" reRender="output,renderArea" action=""
							requestDelay="50" onclick="syn();" rendered="false"
							oncomplete="endSyn();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							action="#{otherinMB.search}" requestDelay="50"
							onclick="if(!search()){return false};"
							oncomplete="Gwallwin.winShowmask('FALSE');"
							rendered="#{otherinMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearData();" rendered="#{otherinMB.LST}" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="创建日期从:">
						</h:outputText>
						<h:inputText id="sk_start_date" styleClass="datetime" size="12"
							value="#{otherinMB.sk_start_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="12"
							value="#{otherinMB.sk_end_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="其它入库单:">
						</h:outputText>
						<h:inputText id="sk_biid" styleClass="datetime" size="15"
							value="#{otherinMB.sk_obj.biid}" onkeypress="formsubmit(event);" />
						<h:outputText value="物料编码:">
						</h:outputText>
						<h:inputText id="sk_inco" styleClass="datetime" size="15"
							value="#{otherinMB.sk_inco}" onkeypress="formsubmit(event);" />
						<h:outputText value="制单人:">
						</h:outputText>
						<h:inputText id="crna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{otherinMB.sk_obj.crna}" />
						<br>
						<h:outputText value="组织架构:" >
						</h:outputText>
						<h:selectOneMenu id="orid" value="#{otherinMB.sk_obj.orid}" onchange="doSearch();">
							<f:selectItem itemLabel="" itemValue="" />
							<f:selectItems value="#{OrgaMB.subList}" />
						</h:selectOneMenu>	
						<h:outputText value="仓库:" ></h:outputText>
						<h:selectOneMenu id="sk_whid" value="#{otherinMB.sk_obj.whid}"
							style="width:130px;">
							<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
						</h:selectOneMenu>
						<h:outputText value="单据标志:">
						</h:outputText>
						<h:selectOneMenu id="sk_flag" value="#{otherinMB.sk_obj.flag}" onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItems value="#{otherinMB.flags}" />
						</h:selectOneMenu>
						<h:outputText value="入库类型:">
						</h:outputText>
						<h:selectOneMenu id="buty" value="#{otherinMB.buty}" onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItems value="#{otherinMB.butys}" />
						</h:selectOneMenu>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="Select a.id,a.biid,a.buty,a.owid,a.soty,a.soco,a.infl,a.flag,a.stus,a.stna,a.stdt,a.stat,a.dety,
										a.crus,a.crna,a.crdt,a.edus,a.edna,a.eddt,a.chus,a.chna,a.chdt,a.opna,a.whid,c.whna,a.orid,a.rema,t.orna,
										(select top 1 inco from oide where biid=a.biid) as inco
										From oima a LEFT JOIN waho c ON a.whid = c.whid 
										left join orga t on t.orid=a.orid
										WHERE a.#{otherinMB.gorgaSql} #{otherinMB.searchSQL}"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
								gcid = orna(headtext = 组织架构,name = orna,width = 100,align = left,type = text,headtype = sort,datatype = string);
								gcid = biid(headtext = 其它入库单,name = biids,width = 0,align = left,type = text,headtype = hidden,datatype = string);
								gcid = biid(headtext = 其它入库单,name = biid,width = 110,align = left,type = link,headtype = sort,datatype = string,linktype = script,typevalue = otherin_edit.jsf?pid=gcolumn[biid]);
								gcid = inco(headtext = 物料编码,name = inco,width = 110,align = left,type = text,headtype = sortheadtype = sort,datatype = string);
								gcid = dety(headtext = 业务类型,name = dety,width = 80,align = center,type = mask,typevalue=01:还回入库/02:赠品入库/03:其他入库,headtype = sort,datatype = string);
								gcid = owid(headtext = 货主,name = owid,width = 120,align = left,type = text,headtype = sort,datatype = string);
								gcid = crna(headtext = 创建人,name = crna,width = 50,align = left,type = text,headtype = sort,datatype = string);
								gcid = crdt(headtext = 创建时间,name = crdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = whna(headtext = 入库仓库,name = whna,width = 120,align = left,type = text,headtype = sort,datatype = string);
								gcid = flag(headtext = 单据标志,name = flag,width = 60,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:关闭单据,headtype = sort,datatype = string);
								gcid = chna(headtext = 审核人,name = chna,width = 50,align = left,type = text,headtype = sort,datatype = string);
								gcid = chdt(headtext = 审核时间,name = chdt,width = 100,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = rema(headtext = 备注,name = rema,width = 160,align = left,type = text,headtype = sort,datatype = string);
							" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{otherinMB.msg}" />
							<h:inputHidden id="sellist" value="#{otherinMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
