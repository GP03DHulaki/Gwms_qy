<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.SfCountMB"%>

<%
	SfCountMB ai = (SfCountMB) MBUtil.getManageBean("#{sfcountMB}");
	if (request.getParameter("isAll") != null) {
		//ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>备货装车人员报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="备货装车人员报表">
		<script type='text/javascript' src='sfcount.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>备货装车人员报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<a4j:outputPanel id="queryForm" rendered="#{sfcountMB.LST}">
						<div id=mmain_opt>
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{sfcountMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','biid,soco,puna,bhna,crna,usna,sk_start_date,sk_end_date');" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" reRender="output" />
						</div>
						<div id="mmain_cnd">
							出库日期从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="12"
								value="#{sfcountMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							至:
							<h:inputText id="sk_end_date" styleClass="datetime" size="12"
								value="#{sfcountMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							出库单号:
							<h:inputText id="biid" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{sfcountMB.biid}" />
							计划单号:
							<h:inputText id="soco" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{sfcountMB.soco}" />
							<br>
							备货员:
							<h:inputText id="bhna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{sfcountMB.bhna}" />
							拉货员:
							<h:inputText id="puna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{sfcountMB.puna}" />
							点货员:
							<h:inputText id="crna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{sfcountMB.crna}" />
							送货员:
							<h:inputText id="usna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{sfcountMB.usna}" />
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
							gselectsql="SELECT a.biid,a.soco,sum(b.qty) AS qtys,sum(b.qty*d.pric) AS prics,e.biid as remaid,
										e.puus,f.usna AS puna,e.crus,e.crna,e.opna,g.usna,a.chdt   
										FROM olma a 
										JOIN olde b ON a.biid = b.biid 
										LEFT JOIN obma c ON a.soco = c.biid 
										LEFT JOIN oubd d ON c.biid = d.biid AND d.inco = b.inco 
										LEFT JOIN 
										(SELECT crus,crna,opna,puus,soco,biid FROM rema WHERE flag = '11' AND stat >= 20) e ON a.soco = e.soco 
										LEFT JOIN usin f ON e.puus = f.usid 
										LEFT JOIN usin g ON e.opna = g.usid 
										WHERE a.flag = '11' #{sfcountMB.initCondition} #{sfcountMB.sql}
										GROUP BY a.biid,a.soco,e.biid,e.puus,f.usna,e.crus,e.crna,e.opna,g.usna,a.chdt  
							"
							gpage="(pagesize = 30)"
							gcolumn="
								gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
								gcid = biid(headtext = 出库单号,name = biid,width = 130,headtype = sort,align = left,type = text,datatype=string);
								gcid = soco(headtext = 计划单号,name = soco,width = 130,headtype = sort,align = left,type = text,datatype=string);
								gcid = chdt(headtext = 出库时间,name = chdt,width = 120,align = left,type = text,headtype = sort,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = -1(headtext = 备货员 ,name = view_h,width = 68,headtype = sort , align = center , type = link ,linktype = script,typevalue = javascript:look_bh('gcolumn[soco]'),value = 查 看, datatype = string);
								gcid = puus(headtext = 拉货员编码,name = puus,width = 70,headtype = sort,align = left,type = text,datatype=string);
								gcid = puna(headtext = 拉货员,name = puna,width = 60,headtype = sort,align = left,type = text,datatype=string);
								gcid = crus(headtext = 点货员编码,name = crus,width = 70,headtype = sort,align = left,type = text,datatype=string);
								gcid = crna(headtext = 点货员,name = crna,width = 60,headtype = sort,align = left,type = text,datatype=string);
								gcid = opna(headtext = 送货员编码,name = usna,width = 70,headtype = sort,align = left,type = text,datatype=string);
								gcid = usna(headtext = 送货员,name = usna,width = 60,headtype = sort,align = left,type = text,datatype=string);
							   	gcid = qtys(headtext = 总数量,name = qtys,width= 60,headtype = sort,align = right, datatype =number,dataformat=0.##);

								gcid = prics(headtext = 总金额,name = prics,width= 110,headtype = sort,align = right, datatype =number,dataformat=0.000000);
						" />
					</a4j:outputPanel>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
