<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.PickerDetailMB"%>

<%
	PickerDetailMB ai = (PickerDetailMB) MBUtil
			.getManageBean("#{pickerDetailMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>备货员拣货明细报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="备货员拣货明细报表">
		<script type='text/javascript' src='pickerdetail.js'></script>
	</head>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>备货员拣货明细报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{pickerDetailMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{pickerDetailMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme" onclick="cleartext();" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" reRender="output" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{pickerDetailMB.LST}">
						<div id="mmain_cnd">
							创建日期从:
							<h:inputText id="sk_start_date" styleClass="datetime" size="10"
								value="#{pickerDetailMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="10"
								value="#{pickerDetailMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							出库订单/调拨计划:
							<h:inputText id="pbid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{pickerDetailMB.pbid}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{pickerDetailMB.inco}" />
							商品名称:
							<h:inputText id="inna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{pickerDetailMB.inna}" />
							<h:outputText value="备货员:">
							</h:outputText>
							<h:inputText id="crus" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{pickerDetailMB.crus}" />
							<img id="owid_img" style="cursor: hand;"
								src="../../images/find.gif" onclick="return selectUser();" />
							<h:inputHidden id='crna' value="#{pickerDetailMB.crna}"></h:inputHidden>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
										select  d.biid,d.pbid,d.pbty,d.inco,d.qty,m.crna,m.crus,m.chdt,u.pric,v.inna,(u.pric)*(d.qty) as summary
											from pkde d join pkma m on d.biid = m.biid
											left join inve v on v.inco = d.inco
											left join oubd u on u.biid = d.pbid and u.inco = d.inco
 											where 1= 1#{pickerDetailMB.initCondition} #{pickerDetailMB.searchSQL}
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = chdt(headtext = 拣货日期,name = chdt,width = 120,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = pbid(headtext = 出库订单/调拨计划,name = whid,width = 120,headtype = sort,align = left,type = string,datatype=string);
											gcid = crus(headtext = 备货员编码,name = whna,width = 110,headtype = sort,align = left,type = string,datatype=string);
											gcid = crna(headtext = 备货员名称,name = obid,width =110,headtype = sort,align = left,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = string,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 130,headtype = sort,align = left,type = string,datatype=string);
										    gcid = qty(headtext = 数量,name = qty,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = pric(headtext = 价格,name = pric,width = 70,align = right,type =text,headtype= sort, datatype =number,dataformat=0.##);
											gcid = summary(headtext = 金额,name = qty,width = 100,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
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
