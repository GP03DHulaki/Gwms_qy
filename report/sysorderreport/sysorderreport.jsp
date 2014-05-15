<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@ page import="com.gwall.view.report.SysOrderMB"%>
<%@	page import="com.gwall.view.OutOrderMB"%>
<%
	SysOrderMB ai = (SysOrderMB) MBUtil
			.getManageBean("#{sysOrderMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>系统订单对应报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="系统订单对应报表">
		<script type="text/javascript" src="sysorderreport.js"></script>
	</head>
	<body id=mmain_body onload="clearData();">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>订单发货统计报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{sysOrderMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="outorderreprot" action="#{sysOrderMB.search}" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" rendered="#{sysOrderMB.LST}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="excel" value="导出EXCEL" type="button"
								action="#{sysOrderMB.exportXls}"
								reRender="msg,outPutFileName"
								onclick="excelios_begin('gtable');" oncomplete="excelios_end();"
								requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{sysOrderMB.LST}">
						<div id="mmain_cnd">
							<h:outputText value="下单日期从:"></h:outputText>
							<h:inputText id="sk_start_date" styleClass="datetime" size="15"
								value="#{sysOrderMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="15"
								value="#{sysOrderMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							订单编号:
							<h:inputText id="biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{sysOrderMB.biid}" />
							备货计划单号:
							<h:inputText id="ltid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{sysOrderMB.ltid}" />
							备货任务单号:
							<h:inputText id="ptid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{sysOrderMB.ptid}" />
								<br/>
							出库复核单号:
							<h:inputText id="reid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{sysOrderMB.reid}" />
							装车交接单号:
							<h:inputText id="loid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{sysOrderMB.loid}" />
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="outorderreprot">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gsort="biid" gsortmethod="ASC"
										gselectsql=" select distinct a.biid,b.biid as ltid,c.biid as ptid,d.biid as reid,e.biid as loid,a.crdt from obma a 
												left join ltde b on a.biid=b.oubi
												left join ptma c on c.soco=b.biid
												left join rema d on d.soco=a.biid
												left join lode e on e.obid=a.biid		
												where a.flag<='31' and a.biid not in (select biid from obbm)
												 #{sysOrderMB.searchSQL}"
										gpage="(pagesize = 20)"
										gcolumn="
													gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
													gcid = biid(headtext = 订单编号,name = biid,width = 130,align = center,type = text,headtype = sort ,datatype = string);
													gcid = ltid(headtext = 备货计划单号,name = ltid,width = 100,align = center,type = text,headtype = sort ,datatype = string);
													gcid = ptid(headtext = 备货任务单号,name = ptid,width = 100,align = center,type = text,headtype = sort ,datatype = string);
													gcid = reid(headtext = 出库复核单号,name = reid,width = 100,align = center,type = text,headtype = sort ,datatype = string);
													gcid = loid(headtext = 装车交接单号,name = loid,width = 100,align = center,type = text,headtype = sort,datetype = string);
													gcid = crdt(headtext = 下单时间,name = crdt,width = 140,align = center,type = text,headtype = sort ,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
													
												" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>

					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{sysOrderMB.msg}" />
							<h:inputHidden id="gsql" value="#{sysOrderMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{sysOrderMB.outPutFileName}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='picksche_edit.jsf'"
							style="display:none;" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
