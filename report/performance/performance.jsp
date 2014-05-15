<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.report.PerformanceMB"%>

<%
	PerformanceMB ai = (PerformanceMB) MBUtil
			.getManageBean("#{performanceMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>员工绩效</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="员工绩效">
		<script type="text/javascript" src="outorderreport.js"></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>员工绩效报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{performanceMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{performanceMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','usid,usna,start_date,end_date,sk_orderFopls');" />
							
								
						</a4j:outputPanel>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="excel" value="导出EXCEL" type="button"
								action="#{performanceMB.exportOrdereCount}"
								reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
								oncomplete="excelios_end();" requestDelay="50" />
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{performanceMB.LST}">
						<div id="mmain_cnd">
							开始时间:
							<h:inputText id="start_date" styleClass="datetime" size="12"
								onfocus="#{gmanage.datePicker}"
								value="#{performanceMB.sk_start_datetime}" />
							到:
							<h:inputText id="end_date" styleClass="datetime" size="12"
								onfocus="#{gmanage.datePicker}"
								value="#{performanceMB.sk_end_datetime}" />
							用户编码:
							<h:inputText id="usid" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{performanceMB.usid}" />
							用户名称:
							<h:inputText id="usna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{performanceMB.usna}" />
							状态:
							<h:selectOneMenu id="sk_orderFopls" value="#{performanceMB.orderFopls}"
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
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gselectsql="
										SELECT 
											count(distinct a.pbid) as orderQty,SUM(a.qty) AS qty,
											CASE WHEN '#{performanceMB.orderFopls}'='' THEN '全部' ELSE '#{performanceMB.orderFopls}' END AS foplsType,
											(select isnull(count(distinct pe.pbid),0) from pkma pa join pkde pe on pa.biid = pe.biid join obma oa on pe.pbid=oa.biid where pa.chus = b.chus and oa.inty = 'S' and pe.cpri >= CONVERT(datetime, '#{performanceMB.sk_start_datetime}') and pe.cpri <= CONVERT(datetime, '#{performanceMB.sk_end_datetime}') #{performanceMB.foplsValue}) as soqty,
											(select isnull(sum(pe.qty),0) from pkma pa join pkde pe on pa.biid = pe.biid join obma oa on pe.pbid=oa.biid where pa.chus = b.chus and oa.inty = 'S' and pe.cpri >= CONVERT(datetime, '#{performanceMB.sk_start_datetime}') and pe.cpri <= CONVERT(datetime, '#{performanceMB.sk_end_datetime}') #{performanceMB.foplsValue}) as sqty,
											(select isnull(count(distinct pe.pbid),0) from pkma pa join pkde pe on pa.biid = pe.biid join obma oa on pe.pbid=oa.biid where pa.chus = b.chus and oa.inty = 'M' and pe.cpri >= CONVERT(datetime, '#{performanceMB.sk_start_datetime}') and pe.cpri <= CONVERT(datetime, '#{performanceMB.sk_end_datetime}') #{performanceMB.foplsValue}) as moqty,
											(select isnull(sum(pe.qty),0) from pkma pa join pkde pe on pa.biid = pe.biid join obma oa on pe.pbid=oa.biid where pa.chus = b.chus and oa.inty = 'M' and pe.cpri >= CONVERT(datetime, '#{performanceMB.sk_start_datetime}') and pe.cpri <= CONVERT(datetime, '#{performanceMB.sk_end_datetime}') #{performanceMB.foplsValue}) as mqty,
											(select sum(p.qty) from pkln p where p.stat=2 and p.crdt>= CONVERT(datetime, '#{performanceMB.sk_start_datetime}') and p.crdt <= CONVERT(datetime, '#{performanceMB.sk_end_datetime}') and p.crus=b.chus and p.crna=b.chna) as bqty,
											b.chus,
											b.chna	
											FROM pkde a JOIN pkma b ON a.biid=b.biid 
											JOIN obma c ON a.pbid=c.biid
											WHERE b.flag='11' #{performanceMB.searchSQL}
											GROUP BY b.chus,b.chna
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = chus,width = 30,headtype = text,align = center,type = text,datatype=string);											   
										    gcid = chus(headtext = 用户编码,name = chus,width =100,align = left,type = text,datatype=string);
										    gcid = chna(headtext = 用户名称,name = chna,width =100,align = left,type = text,datatype=string);
										    gcid = foplsType(headtext = 平台,name = foplsType,width = 65,align = center,type = mask,typevalue=01:平台/11:非平台,headtype = text,datatype = string);
										    gcid = orderQty(headtext = 订单数,name = orderQty,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = bqty(headtext = 跳过数,name = bqty,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = qty(headtext = 总数量,name = qty,width = 80,headtype = sort,align = right,type = link,datatype=number,dataformat={0},summary=this,linktype = script,typevalue = performance_edit.jsf?type=&chus=gcolumn[chus]&orderFopls=#{performanceMB.orderFopls});
										    gcid = soqty(headtext = 一单一货订单数,name = soqty,width = 120,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = sqty(headtext = 一单一货商品数,name = sqty,width = 120,headtype = sort,align = right,type = link,datatype=number,dataformat={0},summary=this,linktype = script,typevalue = performance_edit.jsf?type=s&chus=gcolumn[chus]&orderFopls=#{performanceMB.orderFopls});
										    gcid = moqty(headtext = 一单多货订单数,name = moqty,width = 120,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,);
										    gcid = mqty(headtext = 一单多货商品数,name = mqty,width = 120,headtype = sort,align = right,type = link,datatype=number,dataformat={0},summary=this,linktype = script,typevalue = performance_edit.jsf?type=m&chus=gcolumn[chus]&orderFopls=#{performanceMB.orderFopls});
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{performanceMB.msg}" />
							<h:inputHidden id="gsql" value="#{performanceMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{performanceMB.outPutFileName}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
