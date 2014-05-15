<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.SystemRunMB"%>

<%
	SystemRunMB ai = (SystemRunMB) MBUtil
			.getManageBean("#{systemRunMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>系统运营报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="系统运营报表">
		<script type='text/javascript' src='systemrun.js'></script>
	</head>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>系统运营报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
				<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{systemRunMB.msg}" />
							<h:inputHidden id="gsql" value="#{systemRunMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{systemRunMB.outPutFileName}" />
						</a4j:outputPanel>
				   </div>
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="true">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="if(!startDo()){return false};"
								oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
								action="#{systemRunMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme" onclick="cleartext();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{systemRunMB.export}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="true">
						<div id="mmain_cnd">
							开始日期从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="15"
								value="#{systemRunMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							组织架构:
							<h:selectOneMenu id="orid" value="#{systemRunMB.orid}">
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="1" cellpadding="1" cellspacing="1">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gsort="id" gsortmethod="asc"
										gselectsql="
										 select id,modu,quantity,total,G1,G1_N,G2,G2_N,G3,G3_N,G4,G4_N,G5,G5_N,G6,G6_N,G7,G7_N,
											  	G8,G8_N,G9,G9_N,G10,G10_N,G11,G11_N,G12,G12_N,G13,G13_N,G14,G14_N,G15,G15_N,G16,G16_N,G17,G17_N,
											  	G18,G18_N,G19,G19_N,G20,G20_N,G21,G21_N,G22,G22_N,G23,G23_N,G24,G24_N 
										  from f_getvouchinfo('#{systemRunMB.sk_start_date}','#{systemRunMB.orid}')
  											where 1=1 #{systemRunMB.initCondition}
										"
										gpage="(pagesize = -1)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = modu(headtext = 作业类型,name = modu,width = 70,headtype = sort,align = left,type = string,datatype=string);
											gcid = quantity(headtext = 单量,name = qty,width= 60,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = total(headtext = 总量,name = qty,width= 60,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G7(headtext = 7点,name = G_7,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G7_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G8(headtext = 8点,name = G_8,width =40,headtype = sort,align = right,type = text,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G8_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G9(headtext = 9点,name = G_9,width =40,headtype = sort,align = right,type = text,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G9_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G10(headtext = 10点,name = G_10,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G10_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G11(headtext = 11点,name = G_11,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G11_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G12(headtext = 12点,name = G_12,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G12_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G13(headtext = 13点,name = G_13,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G13_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G14(headtext = 14点,name = G_14,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G14_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G15(headtext = 15点,name = G_15,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G15_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G16(headtext = 16点,name = G_16,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G16_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G17(headtext = 17点,name = G_17,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G17_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G18(headtext = 18点,name = G_18,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G18_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G19(headtext = 19点,name = G_19,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G19_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G20(headtext = 20点,name = G_20,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G20_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G21(headtext = 21点,name = G_21,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G21_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G22(headtext = 22点,name = G_22,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G22_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G23(headtext = 23点,name = G_23,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G23_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G24(headtext = 24点,name = G_23,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G24_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G1(headtext = 1点,name = G_1,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G1_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);								
											gcid = G2(headtext = 2点,name = G_2,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G2_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G3(headtext = 3点,name = G_3,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G3_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G4(headtext = 4点,name = G_4,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G4_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G5(headtext = 5点,name = G_5,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G5_N(headtext =数量,name = qty,width= 50,headtype = sort,align = right, datatype =number,dataformat=0.##);
											gcid = G6(headtext = 6点,name = G_6,width = 40,headtype = sort,align = right,type = string,datatype=number,dataformat={0},bgcolor={#E0EEEE});
											gcid = G6_N(headtext =数量,name = qty,width= 40,headtype = sort,align = right, datatype =number,dataformat=0.##);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
