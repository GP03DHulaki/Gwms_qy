<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.BoxInMB"%>
<html>
	<head>
		<title>入库装箱</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="gwall">
		<meta http-equiv="description" content="其它入库">
		<script src="boxin.js"></script>

	</head>
	<%
		BoxInMB ai = (BoxInMB) MBUtil.getManageBean("#{boxInMB}");
		if (request.getParameter("isAll") != null) {
			ai.initSK();
		}
	%>
	<body id='mmain_body' onload="clearData()">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;&gt;</font><b>装箱入库</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'"
							rendered="#{boxInMB.ADD}"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll()){return false};"
							rendered="#{boxInMB.DEL}" reRender="output,renderArea"
							action="#{boxInMB.deleteHead}" oncomplete="endDeleteHeadAll();"
							requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="同步" type="button" reRender="output,renderArea" action=""
							requestDelay="50" onclick="syn();" rendered="false"
							oncomplete="endSyn();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							action="#{boxInMB.search}" requestDelay="50"
							onclick="if(!search()){return false};"
							oncomplete="Gwallwin.winShowmask('FALSE');"
							rendered="#{boxInMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearData();" rendered="#{boxInMB.LST}" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="创建日期从:">
						</h:outputText>
						<h:inputText id="sk_start_date" styleClass="datetime" size="12"
							value="#{boxInMB.sk_start_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="12"
							value="#{boxInMB.sk_end_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="单号:">
						</h:outputText>	
						<h:inputText id="sk_biid" styleClass="datetime" size="20"
							value="#{boxInMB.sk_obj.biid}" />
						<h:outputText value="来源单号:">
						</h:outputText>
						<h:inputText id="sk_soco" styleClass="datetime" size="20"
							value="#{boxInMB.sk_obj.soco}" />
						<br>	
						<h:outputText value="创建人:">
						</h:outputText>	
						<h:inputText id="sk_crna" styleClass="datetime" size="12"
							value="#{boxInMB.sk_obj.crna}" />
						<h:outputText value="装箱物料:">
						</h:outputText>	
						<h:inputText id="sk_inco" styleClass="datetime" size="20"
							value="#{boxInMB.sk_obj.inco}" />
						<h:outputText value="装箱数量:">
						</h:outputText>
						<h:inputText id="sk_qty" styleClass="datetime" size="12"
							value="#{boxInMB.sk_obj.qty}" />	
							
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql=" select a.biid,a.soco,a.crna,a.crdt,a.flag,b.inna,a.qty,a.rema from bima a
										left join inve b on a.inco = b.inco
										WHERE 1=1 #{boxInMB.searchSQL}"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
								gcid = biid(headtext = 其它入库单,name = biids,width = 0,align = left,type = text,headtype = hidden,datatype = string);
								gcid = biid(headtext = 单号,name = biid,width = 100,align = left,type = link,headtype = sort,datatype = string,linktype=script,typevalue=boxin_edit.jsf?pid=gcolumn[biid]);
								gcid = soco(headtext = 来源单号,name = soco,width = 100,align = left,type = text,headtype = sort,datatype = string);
								gcid = crna(headtext = 创建人,name = crna,width = 100,align = left,type = text,headtype = sort,datatype = string);
								gcid = crdt(headtext = 创建时间,name = crdt,width = 100,align = left,type = text,headtype = sort,datatype = string);
								gcid = flag(headtext = 单据状态,name = flag,width = 100,align = center,type = mask,typevalue = 01:制作之中/11:正式单据/21:关闭单据,headtype = sort,datatype = string);
								gcid = inna(headtext = 物料名称,name = inna,width = 100,align = left,type = text,headtype = sort,datatype = string);
								gcid = qty(headtext = 装箱数量,name = qty,width = 100,align = left,type = text,dataformat=0.##,headtype = sort,datatype = number);
								gcid = rema(headtext = 备注,name = rema,width = 100,align = left,type = text,headtype = sort,datatype = string);
							" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{boxInMB.msg}" />
							<h:inputHidden id="sellist" value="#{boxInMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
