<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.TraninMB"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>调拨入库</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="调拨入库">
		<meta http-equiv="description" content="调拨入库">
		<script type="text/javascript" src="tranin.js"></script>

	</head>
	<%
		TraninMB ai = (TraninMB) MBUtil.getManageBean("#{traninMB}");
		if (request.getParameter("isAll") != null) {
			ai.initSK();
		}
	%>
	<body id="mmain_body">
		<div id="mmain_nav">
			<font color="#000000">库内处理&gt;&gt;调拨&gt;&gt;</font><b>调拨入库</b>
			<br>
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'"
							rendered="#{traninMB.ADD}"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll()){return false};"
							rendered="#{traninMB.DEL}" reRender="output,renderArea"
							action="#{traninMB.deleteHead}" oncomplete="endDeleteHeadAll();"
							requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="同步" type="button" reRender="output,renderArea" action=""
							requestDelay="50" onclick="syn();" rendered="false"
							oncomplete="endSyn();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							action="#{traninMB.search}" requestDelay="50"
							onclick="if(!search()){return false};" rendered="#{traninMB.LST}"
							oncomplete="Gwallwin.winShowmask('FALSE');"
							 />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearData();" rendered="#{traninMB.LST}" />
						<!--  
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="导出Excel" type="button" action="" id="excelMBut"
							onclick="Gwallwin.winShowmask('TRUE');"
							reRender="outPutFileName,msg" oncomplete="endDot();"
							requestDelay="50" rendered="false" />
						-->
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						<!--<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					value="导出Excel1" type="button" action=""
					id="excelMButTest" onclick="openExcel();"
					reRender="outPutFileName,msg" oncomplete=""
					requestDelay="50" rendered="true" />
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					value="导出Excel2" type="button" action=""
					id="excelMButTest1" onclick="openExcel2();"
					reRender="outPutFileName,msg" oncomplete=""
					requestDelay="50" rendered="true" />
			-->
					</div>
					<div id=mmain_cnd>
						<h:outputText value="创建日期从:">
						</h:outputText>
						<h:inputText id="sk_start_date" styleClass="datetime" size="12"
							value="#{traninMB.sk_start_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="12"
							value="#{traninMB.sk_end_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="调拨入库单:">
						</h:outputText>
						<h:inputText id="sk_biid" styleClass="datetime" size="15"
							value="#{traninMB.sk_obj.biid}" onkeypress="formsubmit(event);" />
						<h:outputText value="来源单号:">
						</h:outputText>
						<h:inputText id="sk_soco" styleClass="datetime" size="15"
							value="#{traninMB.sk_obj.soco}" onkeypress="formsubmit(event);" />
						<h:outputText value="单据标志:">
						</h:outputText>
						<h:selectOneMenu id="sk_flag" value="#{traninMB.sk_obj.flag}" onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="00" />
							<f:selectItems value="#{traninMB.flags}" />
						</h:selectOneMenu>
						<br/>
						<h:outputText value="调出仓库">
						</h:outputText>
							<h:inputText id="pfna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{traninMB.sk_obj.owna}" />
						<h:outputText value="调入仓库:"> 
						</h:outputText>
							<h:inputText id="pona" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{traninMB.sk_obj.pona}" />
						<h:outputText value="制单人:"> 
						</h:outputText>
							<h:inputText id="crna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{traninMB.sk_obj.crna}" />
						组织架构:
							<h:selectOneMenu id="orid" value="#{traninMB.orid}" onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
						<h:outputText value="备注:"> 
						</h:outputText>
							<h:inputText id="rema" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{traninMB.sk_obj.rema}" />
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="Select a.id,a.biid,a.buty,a.soty,a.soco,a.infl,a.flag,a.pfwh,a.powh,
								a.stus,a.stna,a.stdt,a.stat,a.crus,a.crna,a.crdt,a.edus,a.edna,a.eddt,a.chus,a.chna,a.chdt,a.gddt,
								a.opna,a.whid,b.whna,d.whna as iwhna,a.orid,a.rema,a.aity,a.aico,c.orna
								FROM pama a 
								Left Join waho b on a.pfwh=b.whid Left Join waho d on a.powh=d.whid 
								join orga c on c.orid=a.orid
								WHERE a.#{traninMB.gorgaSql} #{traninMB.searchSQL}"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = id(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = biid(headtext = 调拨出库单号,name = hid_biid,width = 0,headtype = hidden,align = left,type = text,datatype=string);
							gcid = orna(headtext = 组织架构,name = orna,width = 80,headtype = sort,align = left,type = text,datatype=string);
							gcid = biid(headtext = 调拨入库单,name = biids,width = 60,headtype = sort,align = left,type = hidden,datatype=string);
							gcid = biid(headtext = 调拨入库单,name = biid,width = 90,headtype = sort,align = left,type = link,datatype=string,linktype = script,typevalue = tranin_edit.jsf?pid=gcolumn[biid]);
							gcid = soty(headtext = 来源类型,name = soty,width = 65,align = center,type = mask,typevalue=TRANPLAN:调拨计划/TRANOUT:调拨出库,headtype = sort,datatype = string);
							gcid = soco(headtext = 来源单号,name = soco,width = 110,headtype = sort,align = left,type = text,datatype=string);
							gcid = whna(headtext = 调出仓库,name = whna,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = iwhna(headtext =调入仓库,name = iwhna,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = flag(headtext = 状态,name = flag,width = 65,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:关闭单据,headtype = sort,datatype = string);
							gcid = crna(headtext = 创建人,name = crna,width = 80,headtype = sort,align = left,type = text,datatype=string);
							gcid = gddt(headtext = 过账时间,name = gddt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = crdt(headtext = 创建时间,name = crdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = chna(headtext = 审核人,name = chna,width = 80,headtype = sort,align = left,type = text,datatype=string);
							gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = rema(headtext = 备注,name = rema,width = 150,headtype = sort,align = left,type = text,datatype=string);
						" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{traninMB.msg}" />
							<h:inputHidden id="sellist" value="#{traninMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>