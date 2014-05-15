<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>生成箱条码</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="gwall">
		<link href="<%=request.getContextPath()%>/gwall/all_gtab.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="printpackbox.js"></script>
	</head>

	<body id="mmain_body" onload="listPageLoad();">
		<f:view>
			<div id="mmain">
				<h:form id="list">
					<a4j:outputPanel id="queryButs" rendered="#{printPackboxMB.LST}">
						<a4j:commandButton value="查询"
							onclick="Gwallwin.winShowmask('TRUE');"
							oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
							action="#{printPackboxMB.search}" styleClass="a4j_but"
							rendered="#{printPackboxMB.LST}"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" />
						<a4j:commandButton value="重置" size="5"
							rendered="#{printPackboxMB.LST}" onclick="clearData()"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<a4j:commandButton id="printBut" value="打印"
							onclick="if(print(gtable)){}else{return false};"
							action="#{printPackboxMB.printPackBox}"
							reRender="renderArea,output" requestDelay="50"
							oncomplete="lookPrint();" onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
						生成箱码个数:
						<h:inputText id="qty" styleClass="datetime"
							value="#{printPackboxMB.mbean.qty}" size="8"
							onkeyup="this.value=this.value.replace(/\D|^0/g,'')" />
						<a4j:commandButton id="createBarcodeBut" value="生成箱码"
							onclick="if(!checkList()){return false;}"
							action="#{printPackboxMB.generatePackBox}"
							reRender="renderArea,output" oncomplete="endcheckList();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
					</a4j:outputPanel>
					<div id="mmain">
						<a4j:outputPanel id="queryForm" rendered="true">
							<h:outputText value="创建日期从:" />
							<h:inputText id="start_date" styleClass="datetime" size="12"
								value="#{printPackboxMB.sk_start_date}"
								onfocus="#{gmanage.datePicker};" />
							<h:outputText value="至:" />
							<h:inputText id="end_date" styleClass="datetime" size="12"
								value="#{printPackboxMB.sk_end_date}"
								onfocus="#{gmanage.datePicker};" />
						箱子码:
						<h:inputText id="query_inco" value="#{printPackboxMB.sk_obj.inco}"
								size="25" styleClass="datetime" />
						生成人:
						<h:inputText id="query_crna" value="#{printPackboxMB.sk_obj.crna}"
								size="10" styleClass="datetime" />
						打印状态:
						<h:selectOneMenu id="sk_flag"
								value="#{printPackboxMB.sk_obj.flag}">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="未打印" itemValue="0" />
								<f:selectItem itemLabel="已打印" itemValue="1" />
								<a4j:support event="onchange"
									onsubmit="Gwallwin.winShowmask('TRUE');"
									action="#{printPackboxMB.search}"
									oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"></a4j:support>
							</h:selectOneMenu>
						</a4j:outputPanel>

						<!--
						箱子码:
						<h:inputText id="sk_inco" value="#{printPackboxMB.mbean.inco}"
							size="25" styleClass="inputtextedit" />
						<img id="whid_img" style="cursor: hand"
							src="../../images/find.gif" onclick="selectInve();" />-->



					</div>
					<%--and a.moid='printPackbox' --%>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gversion="2" gtype="grid"
							gselectsql=" select a.boco,case when a.prnu>0 then '已打印' else '未打印' end as prnu,b.usna,a.crdt from bxin a left join usin b on a.crus=b.usid where 1=1 and a.biid='init' #{printPackboxMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="
								gcid = boco(headtext = selcheckbox,name = selcheckbox,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
								gcid = 0(headtext = 行号,name = rowid,width = 40,headtype = text,align = center,type = text,datatype=string);
								gcid = boco(headtext = 箱码,name = boco,width = 200,headtype = sort,align = left,type = text,datatype=string);
								gcid = usna(headtext = 生成人,name = usna,width = 100,headtype = sort,align = left,type = text,datatype=string);
								gcid = crdt(headtext = 生成时间,name = crdt,width = 120,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = prnu(headtext = 是否打印,name = prnu,width = 100,headtype = sort,align = center,type = text,datatype=string);
								" />
						<!-- 
							gselectsql=" select a.baco,case when a.pnum>0 then '已打印' else '未打印' end as pnum,b.usna,a.crdt from nwba a left join usin b on a.crus=b.usid where 1=1  "
 -->
					</a4j:outputPanel>

					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="outPutFileName"
							value="#{printPackboxMB.outPutFileName}"></h:inputHidden>
						<h:inputHidden id="msg" value="#{printPackboxMB.msg}" />
					</a4j:outputPanel>
					<h:inputHidden id="item" value="#{printPackboxMB.item}"></h:inputHidden>
				</h:form>
			</div>
		</f:view>
	</body>
</html>
