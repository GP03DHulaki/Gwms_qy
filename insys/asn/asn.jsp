<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.AsnMB"%><%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.pojo.stockin.AsnMBean"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title>ASN单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="ASN单">
		<meta http-equiv="description" content="ASN单">
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/Gwalldate.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="asn.js"></script>
		<script type="text/javascript" src="wro/g3.js"></script>
	</head>
	<%
		AsnMB ai = (AsnMB) MBUtil.getManageBean("#{asnMB}");
		if (request.getParameter("isAll") != null) {
			ai.initSK();
			((AsnMBean) ai.sk_obj).setFlag("01");
			ai.setSearchSQL(" and a.flag='01' ");
		}
	%>
	<body id="mmain_body">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;ASN单&gt;&gt;</font><b>ASN单</b>
			<br>
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'" rendered="#{asnMB.ADD}"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll()){return false};"
							rendered="#{asnMB.DEL}" reRender="output,renderArea"
							action="#{asnMB.deleteHead}" oncomplete="endDeleteHeadAll();"
							requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="同步" type="button" reRender="output,renderArea" action=""
							requestDelay="50" onclick="syn();" rendered="false"
							oncomplete="endSyn();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							action="#{asnMB.search}" requestDelay="50"
							onclick="if(!search()){return false};" rendered="#{asnMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearData();" rendered="#{asnMB.LST}" />
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
					</div>
					<div id=mmain_cnd>
						<h:outputText value="创建日期从:">
						</h:outputText>
						<h:inputText id="sk_start_date" styleClass="datetime" size="12"
							value="#{asnMB.sk_start_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="12"
							value="#{asnMB.sk_end_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="ASN单号:">
						</h:outputText>
						<h:inputText id="sk_biid" styleClass="datetime" size="15"
							value="#{asnMB.sk_obj.biid}" onkeypress="formsubmit(event);" />
						<h:outputText value="供应商编码:">
						</h:outputText>
						<h:inputText id="sk_suid" styleClass="datetime" size="12"
							value="#{asnMB.sk_obj.suid}" onkeypress="formsubmit(event);" />
						<!--<h:outputText value="商品条码:">
				</h:outputText>
				<h:inputText id="vc_barcode" styleClass="datetime" size="15"
					value="" onkeypress="formsubmit(event);" />
				-->
						<h:outputText value="供应商名称:">
						</h:outputText>
						<h:inputText id="sk_suna" styleClass="datetime" size="15"
							value="#{asnMB.sk_obj.suna}" onkeypress="formsubmit(event);" />
						<h:outputText value="单据状态:">
						</h:outputText>
						<h:selectOneMenu id="sk_flag" value="#{asnMB.sk_obj.flag}">
							<f:selectItem itemLabel="全部" itemValue="00" />
							<f:selectItems value="#{asnMB.flags}" />
						</h:selectOneMenu>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="SELECT a.id,a.biid,a.suid,b.ceve,a.indt,a.flag,a.stat,a.buty,a.chna,a.chdt,
								a.whid,a.orid,a.rema,c.orna FROM asbm a join suin b ON a.suid = b.suid 
								left join orga c on a.orid=c.orid 
								WHERE 1 = 1 #{asnMB.searchSQL }"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
						gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
						gcid = biid(headtext = ASN单号,name = biids,width = 121,align = left,type = text,headtype = hidden,datatype = string);
						gcid = biid(headtext = ASN单号,name = biid,width = 121,align = left,type = link,headtype = sort,datatype = string,linktype = script,typevalue = asn_edit.jsf?pid=gcolumn[biid]);
						gcid = orna(headtext = 组织架构,name = orna,width = 121,align = left,type = text,headtype = sort,datatype = string);
						gcid = ceve(headtext = 供应商名称,name = ceve,width = 140,align = left,type = text,headtype = sort,datatype = string);
						gcid = indt(headtext = 计划到货时间,name = indt,width = 111,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
						gcid = chna(headtext = 审核人,name = chna,width = 111,align = left,type = text,headtype = sort,datatype = string);
						gcid = flag(headtext = 状态,name = flag,width = 81,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:关闭单据,headtype = sort,datatype = string);
						gcid = chdt(headtext = 审核时间,name = chdt,width = 111,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
						gcid = rema(headtext = 备注,name = rema,width = 131,align = left,type = text,headtype = sort,datatype = string);
					" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{asnMB.msg}" />
							<h:inputHidden id="sellist" value="#{asnMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>