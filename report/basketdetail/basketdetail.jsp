<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.BasketDetailMB"%>

<%
	BasketDetailMB ai = (BasketDetailMB) MBUtil
			.getManageBean("#{basketDetailMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>备货框明细报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="备货框明细报表">
		<script type='text/javascript' src='basketdetail.js'></script>
	</head>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>备货框明细报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{basketDetailMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{basketDetailMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme" onclick="cleartext();" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" reRender="output" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{basketDetailMB.LST}">
						<div id="mmain_cnd">
							日期从:
							<h:inputText id="sk_chdt_start" styleClass="datetime" size="10"
								value="#{basketDetailMB.sk_chdt_start}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至" />
							<h:inputText id="sk_chdt_end" styleClass="datetime" size="10"
								value="#{basketDetailMB.sk_chdt_end}"
								onfocus="#{gmanage.datePicker}" />

							出库订单:
							<h:inputText id="obid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{basketDetailMB.obid}" />
							物料编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{basketDetailMB.inco}" />
							商品名称:
							<h:inputText id="inna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{basketDetailMB.inna}" />
							客户名称:
							<h:inputText id="cuna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{basketDetailMB.cuna}" />
							<h:outputText value="备货框:">
							</h:outputText>
							<h:inputText id="whid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{basketDetailMB.whid}" />
							<img id="owid_img" style="cursor: hand;"
								src="../../images/find.gif" onclick="return selectWaho();" />
							<h:inputHidden id='whna' value="#{basketDetailMB.whna}"></h:inputHidden>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gsort="whid" gsortmethod="desc"
										gselectsql="
										select p.biid,p.whid,p.obid,p.obty,p.inco,v.inna,v.colo,v.inse,w.whna,s.crdt,p.qty,m.cuid,u.cuna from spde p
										join (select biid,crdt from spma) s on s.biid = p.biid 
										left join obma m on m.biid = p.obid
										left join cuin u on m.cuid = u.cuid 
										left join waho w on w.whid = p.whid
										left join inve v on p.inco = v.inco
										 where 1=1 and m.flag>=16 and m.flag<=19 #{basketDetailMB.initCondition} #{basketDetailMB.searchSQL}
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 二次分拣单,name = whid,width = 110,headtype = sort,align = left,type = string,datatype=string);
											gcid = whid(headtext = 备货框编码,name = whid,width = 85,headtype = sort,align = left,type = string,datatype=string);
											gcid = whna(headtext = 备货框名称,name = whna,width = 110,headtype = sort,align = left,type = string,datatype=string);
											gcid = obid(headtext = 出库订单,name = obid,width =100,headtype = sort,align = left,type = text,datatype=string);
											gcid = cuid(headtext = 客户编码,name = cuid,width =70,headtype = sort,align = left,type = text,datatype=string);
											gcid = cuna(headtext = 客户名称,name = cuna,width = 140,headtype = sort,align = left,type = string,datatype=string);
											gcid = inco(headtext = 商品编码,name = inco,width = 100,headtype = sort,align = left,type = string,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 130,headtype = sort,align = left,type = string,datatype=string);
											gcid = colo(headtext = 规格,name = colo,width = 80,headtype = sort,align = left,type = string,datatype=string);
											gcid = inse(headtext = 规格码,name = inse,width = 80,headtype = sort,align = left,type = string,datatype=string);
										    gcid = qty(headtext = 数量,name = rqty,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
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
