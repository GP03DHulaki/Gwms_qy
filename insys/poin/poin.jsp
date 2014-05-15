<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="javax.faces.el.ValueBinding"%>
<%@page import="com.gwall.view.PoinMB"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<title>采购入库</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="采购入库">
	<meta http-equiv="description" content="采购入库">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/Gwalldate.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="poin.js"></script>

</head>
<%
		PoinMB ai = (PoinMB) MBUtil.getManageBean("#{poinMB}");
		if (request.getParameter("isAll") != null) {
			ai.initSK();
		}

	%>
<body id="mmain_body">
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;入库&gt;&gt;</font><b>采购入库</b><br></div>
	<f:view>
	<div id="mmain">
		<h:form id="edit">
			<div id="mmain_opt">
				<a4j:commandButton value="添加单据" type="button"
					onmouseover="this.className='a4j_over1'" rendered="#{poinMB.ADD}"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					oncomplete="addNew();"/>
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					id="deleteId" value="删除单据" type="button"
					onclick="if(!deleteHeadAll()){return false};"
					rendered="#{poinMB.DEL}" reRender="output,renderArea"
					action="#{poinMB.deleteHead}"
					oncomplete="endDeleteHeadAll();" requestDelay="50" />
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					value="同步" type="button" reRender="output,renderArea"
					action="" requestDelay="50" 
					onclick="syn();" rendered="false"
					oncomplete="endSyn();" />
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					value="查询" type="button" reRender="output" id="sid"
					action="#{poinMB.search}" requestDelay="50" onclick="if(!search()){return false};"
					oncomplete="Gwallwin.winShowmask('FALSE');"
					rendered="#{poinMB.LST}" />
				<a4j:commandButton value="重置"
					onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					onclick="clearData();" rendered="#{poinMB.LST}" />
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					value="导出Excel" type="button" action=""
					id="excelMBut" onclick="Gwallwin.winShowmask('TRUE');"
					reRender="outPutFileName,msg" oncomplete="endDot();"
					requestDelay="50" rendered="false" />
				<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
					onclick="reportExcel('gtable')" type="button" />
				<!--  
				<a4j:commandButton value="导入EXCEL"
					onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					onclick="showImport();" rendered="#{poinMB.LST}" />-->
			</div>
			<div id=mmain_cnd>
				<h:outputText value="创建日期从:">
				</h:outputText>
				<h:inputText id="sk_start_date" styleClass="datetime" size="12"
					value="#{poinMB.sk_start_date}" onfocus="#{gmanage.datePicker}" />
				<h:outputText value="至:">
				</h:outputText>
				<h:inputText id="sk_end_date" styleClass="datetime" size="12"
					value="#{poinMB.sk_end_date}" onfocus="#{gmanage.datePicker}" />
				<h:outputText value="采购入库单:">
				</h:outputText>
				<h:inputText id="sk_biid" styleClass="datetime" size="15"
					value="#{poinMB.sk_obj.biid}" onkeypress="formsubmit(event);" />	
				<h:outputText value="采购订单号:">
				</h:outputText>
				<h:inputText id="sk_soco" styleClass="datetime" size="15"
					value="#{poinMB.sk_obj.soco}" onkeypress="formsubmit(event);" />
				<h:outputText value="物料编码:">
				</h:outputText>
				<h:inputText id="sk_inco" styleClass="datetime" size="15"
					value="#{poinMB.sk_inco}" onkeypress="formsubmit(event);" />
				<h:outputText value="制单人:">
				</h:outputText>
				<h:inputText id="crna" styleClass="inputtext" size="15"
						onkeypress="formsubmit(event);" value="#{poinMB.sk_obj.crna}" />
				<br>
				<h:outputText value="组织架构:" >
				</h:outputText>
				<h:selectOneMenu id="orid" value="#{poinMB.orid}" onchange="doSearch();">
					<f:selectItem itemLabel="" itemValue="" />
					<f:selectItems value="#{OrgaMB.subList}" />
				</h:selectOneMenu>
				<h:outputText value="仓库:" ></h:outputText>
				<h:selectOneMenu id="sk_whid" value="#{poinMB.sk_obj.whid}"
					style="width:130px;">
					<f:selectItem itemValue="" itemLabel="全部"/>
					<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
				</h:selectOneMenu>
				<h:outputText value="单据标志:">
				</h:outputText>
				<h:selectOneMenu id="sk_flag" value="#{poinMB.sk_obj.flag}"  onchange="doSearch();">
					<f:selectItem itemLabel="全部" itemValue="00" />
					<f:selectItems value="#{poinMB.flags}"/>
				</h:selectOneMenu>
			</div>
			<a4j:outputPanel id="output">
				<g:GTable gid="gtable" gtype="grid"
					gselectsql="SELECT a.id,a.orid,a.biid,a.owid,a.crna,CASE a.soco WHEN '_U8_poin_' THEN '无采购订单' ELSE a.soco END AS soco,b.tale,a.crdt,a.gddt,
								b.suid,ISNULL(c.ceve,e.ceve) as ceve,b.opna,b.buty,b.pudt,a.stus,a.stna,a.stdt,a.flag,a.chna,a.chdt,a.rema ,d.orna
								FROM psma a LEFT JOIN pubm b ON a.soco = b.biid LEFT JOIN suin c ON b.suid = c.suid 
								left join orga d on a.orid=d.orid LEFT JOIN suin e ON a.stus = e.suid 							
								 WHERE a.#{poinMB.gorgaSql} #{poinMB.searchSQL}"
					gpage="(pagesize = 20)" gversion="2" gdebug = "true"
					gcolumn="gcid = id(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
						gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
						gcid = orna(headtext = 组织架构,name = orna,width = 110,align = left,type = text,headtype = sort,datatype = string);
						gcid = biid(headtext = 采购入库单,name = biids,width = 90,align = left,type = text,headtype = hidden,datatype = string);
						gcid = biid(headtext = 采购入库单,name = biid,width = 110,align = left,type = link,headtype = sort,datatype = string,linktype = script,typevalue = poin_edit.jsf?pid=gcolumn[biid]);
						gcid = soco(headtext = 采购订单号,name = soco,width = 110,align = left,type = text,headtype = sort,datatype = string);
						gcid = tale(headtext = 是否紧急,name = tale,width = 60,align = center,type = mask,typevalue=20:普通/10:紧急,headtype = hidden,datatype = string,bgcolor={gcolumn[tale]=10:#FF0000});
						gcid = ceve(headtext = 供应商,name = ceve,width = 100,align = left,type = text,headtype = sort,datatype = string);
						gcid = owid(headtext = 货主,name = owid,width = 120,align = left,type = text,headtype = sort,datatype = string);
						gcid = crna(headtext = 制单人,name = crna,width = 60,align = left,type = text,headtype = sort,datatype = string);
						gcid = buty(headtext = 采购类型,name = buty,width = 70,align = center,type = mask,headtype = sort,datatype = string,typevalue=01:工厂采购/02:市场采购/03:耗材采购);
						gcid = gddt(headtext = 过账时间,name = gddt,width = 100,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
						gcid = pudt(headtext = 采购时间,name = pudt,width = 100,align = left,type = text,headtype = hidden,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
						gcid = stna(headtext = 制单人,name = stna,width = 60,align = left,type = text,headtype = sort,datatype = string);
						gcid = crdt(headtext = 制单时间,name = crdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
						gcid = flag(headtext = 单据标志,name = flag,width = 70,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:关闭单据,headtype = sort,datatype = string);
						gcid = chna(headtext = 审核人,name = chna,width = 90,align = left,type = text,headtype = sort,datatype = string);
						gcid = chdt(headtext = 审核时间,name = chdt,width = 100,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
						gcid = rema(headtext = 备注,name = rema,width = 110,align = left,type = text,headtype = hidden,datatype = string);
					" />
			</a4j:outputPanel>
			<div style="display: none;">
			<a4j:outputPanel id="renderArea">
				<h:inputHidden id="msg" value="#{poinMB.msg}" />
				<h:inputHidden id="sellist" value="#{poinMB.sellist}" />
			</a4j:outputPanel>
			</div>
		</h:form>
	</div>
	<div id="import" style="display: none" align="left">
		<h:form id="file" enctype="multipart/form-data">
			<t:inputFileUpload id="upFile" styleClass="upfile"
				storage="file" value="#{poinMB.myFile}" required="true"
				size="75" />
			<div id="mes"></div>
			<div align="center">
				<gw:GAjaxButton value="上传" onclick="return doImport();"
					id="import" theme="a_theme" />
				<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
					onclick="Close();" type="button" />
			</div>
			<div style="display: none;">
				<h:commandButton value="上传" id="importBut"
					action="#{poinMB.uploadFilePoin}" />
			</div>
		</h:form>
	</div>
	</f:view>
</body>
</html>