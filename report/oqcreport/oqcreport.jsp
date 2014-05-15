<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.report.OqcReportMB"%>

<%
	OqcReportMB ai = (OqcReportMB) MBUtil
			.getManageBean("#{oqcreportMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<html>
	<head>
		<title>出库复核统计报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="员工绩效">
		<script type='text/javascript' src='oqcreport.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>出库复核统计报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{oqcreportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{oqcreportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','usid,usna,start_date,end_date,sk_orderFopls');" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{oqcreportMB.export}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
						</a4j:outputPanel>
						
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{oqcreportMB.LST}">
						<div id="mmain_cnd">
							开始时间:
							<h:inputText id="start_date" styleClass="datetime" size="12"
								onfocus="#{gmanage.datePicker}"
								value="#{oqcreportMB.sk_start_datetime}" />
							到:
							<h:inputText id="end_date" styleClass="datetime" size="12"
								onfocus="#{gmanage.datePicker}"
								value="#{oqcreportMB.sk_end_datetime}" />
							用户编码:
							<h:inputText id="usid" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{oqcreportMB.usid}" />
							用户名称:
							<h:inputText id="usna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{oqcreportMB.usna}" />
							状态:
							<h:selectOneMenu id="sk_orderFopls" value="#{oqcreportMB.orderFopls}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="平台" itemValue="01" />
								<f:selectItem itemLabel="非平台" itemValue="11" />
							</h:selectOneMenu>	
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="										
											select a.crus,a.crna,
											CASE WHEN '#{oqcreportMB.orderFopls}'='' THEN '全部' ELSE '#{oqcreportMB.orderFopls}' END AS foplsType,
											count( distinct a.soco) as orderNum,sum(b.qty)as orderQty,
											(select isnull(count(distinct pa.soco),0) from rema pa join rede pe on pa.biid = pe.biid join obma oa on pa.soco=oa.biid where a.crus=pa.crus and oa.inty = 'S' and pa.chdt >= CONVERT(datetime, '#{oqcreportMB.sk_start_datetime}') and pa.chdt <= CONVERT(datetime, '#{oqcreportMB.sk_end_datetime}') #{oqcreportMB.foplsValue}) as soqty,
											(select isnull(sum(pe.qty),0) from rema pa join rede pe on pa.biid = pe.biid join obma oa on pa.soco=oa.biid where a.crus=pa.crus and oa.inty = 'S' and pa.chdt >= CONVERT(datetime, '#{oqcreportMB.sk_start_datetime}') and pa.chdt <= CONVERT(datetime, '#{oqcreportMB.sk_end_datetime}') #{oqcreportMB.foplsValue}) as sqty,
											(select isnull(count(distinct pa.soco),0) from rema pa join rede pe on pa.biid = pe.biid join obma oa on pa.soco=oa.biid where a.crus=pa.crus and oa.inty = 'M' and pa.chdt >= CONVERT(datetime, '#{oqcreportMB.sk_start_datetime}') and pa.chdt <= CONVERT(datetime, '#{oqcreportMB.sk_end_datetime}') #{oqcreportMB.foplsValue}) as moqty,
											(select isnull(sum(pe.qty),0) from rema pa join rede pe on pa.biid = pe.biid join obma oa on pa.soco=oa.biid where a.crus=pa.crus and oa.inty = 'M' and pa.chdt >= CONVERT(datetime, '#{oqcreportMB.sk_start_datetime}') and pa.chdt <= CONVERT(datetime, '#{oqcreportMB.sk_end_datetime}') #{oqcreportMB.foplsValue}) as mqty
											from rema a join rede b on a.biid=b.biid join obma c on a.soco=c.biid
											where 1=1  #{oqcreportMB.searchSQL}
											group by a.crus,a.crna
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = chus,width = 30,headtype = text,align = center,type = text,datatype=string);											   
										    gcid = crus(headtext = 用户编码,name = crus,width =100,align = left,type = text,datatype=string);
										    gcid = crna(headtext = 用户名称,name = crna,width =100,align = left,type = text,datatype=string);										   
										    gcid = foplsType(headtext = 平台,name = foplsType,width = 65,align = center,type = mask,typevalue=01:平台/11:非平台,headtype = text,datatype = string);
										    gcid = orderNum(headtext = 订单数,name = orderNum,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = orderQty(headtext = 总数量,name = orderQty,width = 80,headtype = sort,align = right,type = link,datatype=number,dataformat={0},summary=this,linktype = script,typevalue = oqcreport_edit.jsf?type=&crus=gcolumn[crus]&orderFopls=#{oqcreportMB.orderFopls});
										    gcid = soqty(headtext = 一单一货订单数,name = soqty,width = 120,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = sqty(headtext = 一单一货商品数,name = sqty,width = 120,headtype = sort,align = right,type = link,datatype=number,dataformat={0},summary=this,linktype = script,typevalue = oqcreport_edit.jsf?type=s&crus=gcolumn[crus]&orderFopls=#{oqcreportMB.orderFopls});
										    gcid = moqty(headtext = 一单多货订单数,name = moqty,width = 120,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,);
										    gcid = mqty(headtext = 一单多货商品数,name = mqty,width = 120,headtype = sort,align = right,type = link,datatype=number,dataformat={0},summary=this,linktype = script,typevalue = oqcreport_edit.jsf?type=m&crus=gcolumn[crus]&orderFopls=#{oqcreportMB.orderFopls});
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{oqcreportMB.msg}" />
							<h:inputHidden id="gsql" value="#{oqcreportMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{oqcreportMB.outPutFileName}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
