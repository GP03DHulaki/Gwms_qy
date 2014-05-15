<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.PurchaseMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>采购预约列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="keywords" content="采购预约">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/Gwalldate.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="purchase.js"></script>
  </head>
<%
		PurchaseMB ai = (PurchaseMB) MBUtil.getManageBean("#{purchaseMB}");
		if (request.getParameter("isAll") != null) {
			ai.initSK();
		}
%>
  <body id="mmain_body">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;采购预约&gt;&gt;</font><b>预约列表</b>
			<br>
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加预约" type="button"
							onmouseover="this.className='a4j_over1'" rendered="#{purchaseMB.ADD}"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除预约" type="button"
							onclick="if(!deleteHeadAll()){return false};"
							rendered="#{purchaseMB.DEL}" reRender="output,renderArea"
							action="#{purchaseMB.deleteHead}" oncomplete="endDeleteHeadAll();"
							requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							action="#{purchaseMB.search}" requestDelay="50"
							onclick="if(!search()){return false};" 
							 oncomplete="Gwallwin.winShowmask('FALSE');"
							rendered="#{purchaseMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearData();" rendered="#{purchaseMB.LST}" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="创建日期从:">
						</h:outputText>
						<h:inputText id="sk_start_date" styleClass="datetime" size="12"
							value="#{purchaseMB.sk_start_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="12"
							value="#{purchaseMB.sk_end_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="预约日期从:">
						</h:outputText>
						<h:inputText id="sk_start_pcdt" styleClass="datetime" size="12"
							value="#{purchaseMB.sk_start_pcdt}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_pcdt" styleClass="datetime" size="12"
							value="#{purchaseMB.sk_end_pcdt}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="预约单号:">
						</h:outputText>
						<h:inputText id="sk_biid" styleClass="datetime" size="15"
							value="#{purchaseMB.sk_obj.biid}" onkeypress="formsubmit(event);" />
						<h:outputText value="供应商名称:">
						</h:outputText>
						<h:inputText id="sk_suna" styleClass="datetime" size="15"
							value="#{purchaseMB.sk_obj.suna}" onkeypress="formsubmit(event);" />
						<h:outputText value="物料编码:">
						</h:outputText>
						<h:inputText id="sk_inco" styleClass="datetime" size="15"
							value="#{purchaseMB.sk_inco}" onkeypress="formsubmit(event);" />
						<h:outputText value="单据状态:"></h:outputText>
						<h:selectOneMenu id="sk_flag" value="#{purchaseMB.sk_obj.flag}" onchange="doSearch()">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItems value="#{purchaseMB.flags}" />
						</h:selectOneMenu>
						<h:outputText value="是否紧急:"></h:outputText>
						<h:selectOneMenu id="tales" value="#{purchaseMB.mbean.tale}">
							<f:selectItems value="#{purchaseMB.tales}" />
						</h:selectOneMenu>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="select distinct a.id,a.biid,a.tale,a.soco,c.ceve,d.usna,a.crdt,a.pcdt,a.stat,a.flag,a.rema,c.suna,(select top 1 bb.inco from cpbd bb where bb.biid=a.biid) as inco
										from cpbm a 
										left join suin c on a.suid = c.suid left join usin d on d.usid=a.crus
								WHERE a.#{purchaseMB.gorgaSql} #{purchaseMB.searchSQL }"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
								gcid = biid(headtext = 预约单号,name = biids,width = 0,align = left,type = text,headtype = hidden,datatype = string);
								gcid = biid(headtext = 预约单号,name = biid,width = 110,align = left,type = link,headtype = sort,datatype = string,linktype = script,typevalue = javascript:Edit('gcolumn[biid]'));
								gcid = suna(headtext = 供应商名称,name = suna,width = 140,align = left,type = text,headtype = sort,datatype = string);
								gcid = inco(headtext = 物料编码,name = inco,width = 140,align = left,type = text,headtype = sort,datatype = string);
								gcid = usna(headtext = 创建者,name = crus,width = 95,align = left,type = text,headtype = sort);
								gcid = pcdt(headtext = 预约到货日期,name = pcdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = crdt(headtext = 创建日期,name = crdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = flag(headtext = 状态,name = flag,width = 80,align = center,type = mask,typevalue=01:制作中/11:已审核/12:已质检/21:拒收中/22:已拒收/31:部分到货完成/32:全部到货完成/41:部分到货完成,headtype = sort,datatype = string,bgcolor={gcolumn[flag]=32:#00FF00});
								gcid = tale(headtext = 是否紧急,name = tale,width = 80,align = center,type = mask,typevalue=20:普通/10:紧急,headtype = sort,datatype = string,bgcolor={gcolumn[tale]=10:#FF0000});
								gcid = rema(headtext = 备注,name = rema,width = 120,align = left,type = text,headtype = sort,datatype = string);
							" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{purchaseMB.msg}" />
							<h:inputHidden id="sellist" value="#{purchaseMB.sellist}" />
							<h:inputHidden id="biid" value="#{purchaseMB.mbean.biid}" />
							<a4j:commandButton id="editbut" value="隐藏"
					onclick="startDo();" oncomplete="javascript:window.location.href='edit.jsf'"
					style="display:none;" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>
