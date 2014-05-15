<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.report.OrderCheckMB"%>
<%
	OrderCheckMB ai = (OrderCheckMB) MBUtil
	            .getManageBean("#{orderCheckMB}");
	  ai.initSK();
	%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>检查订单重复报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="检查订单重复报表">
		<script type='text/javascript' src='orderflow.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>检查订单重复报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{orderCheckMB.LST}">
							<gw:GAjaxButton id="sid" value="查询" type="button" theme="b_theme"
								oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
								action="#{orderCheckMB.search}" />
							<gw:GAjaxButton value="重置" theme="b_theme"
								onclick="textClear('bdate','edate');" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" reRender="output" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{orderCheckMB.LST}">
						<div id="mmain_cnd">
							开始日期从:
							<h:inputText id="sk_bdate" styleClass="datetime" size="16"
								value="#{orderCheckMB.sk_bdate}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" />
							到:
							<h:inputText id="sk_edate" styleClass="datetime" size="16"
								value="#{orderCheckMB.sk_edate}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" />
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gsortmethod="ASC"
										gselectsql="
										SELECT cs,padt,plat,biid,g1,g2,g3,g4,g5,expressName,username,receiver,mobile,expressNo,soco,state,address,remark FROM P_OSA_CHECK_FUN('#{orderCheckMB.sk_bdate}','#{orderCheckMB.sk_edate}')										
										"
										gpage="(pagesize = -1)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = padt(headtext = 创建时间,name = padt,width = 120,align = left,type = text,headtype = sort,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = plat(headtext = 来源平台,name = plat,width = 100,align = left,type = text,headtype = sort,datatype= string);
											gcid = biid(headtext = 销售单号,name = biid,width = 100,align = left,type = text,headtype = sort,datatype= string);
											gcid = soco(headtext = 来源单号,name = soco,width = 100,align = left,type = text,headtype = sort,datatype= string);
											gcid = g1(headtext = SKU1,name = g1,width = 100,align = left,type = text,headtype = sort,datatype= string);
											gcid = g2(headtext = SKU2,name = g2,width = 100,align = left,type = text,headtype = sort,datatype= string);
											gcid = g3(headtext = SKU3,name = g3,width = 100,align = left,type = text,headtype = sort,datatype= string);
											gcid = g4(headtext = SKU4,name = g4,width = 100,align = left,type = text,headtype = sort,datatype= string);
											gcid = g5(headtext = SKU5,name = g5,width = 100,align = left,type = text,headtype = sort,datatype= string);
											gcid = expressName(headtext = 快递公司,name = expressName,width = 100,align = left,type = text,headtype = sort,datatype= string);
											gcid = expressNo(headtext = 快递单号,name = expressNo,width = 100,align = left,type = text,headtype = sort,datatype= string);
											gcid = username(headtext = 创建人,name = username,width = 60,align = left,type = text,headtype = sort,datatype= string);
											gcid = receiver(headtext = 收件人,name = receiver,width = 60,align = left,type = text,headtype = sort,datatype= string);
											gcid = mobile(headtext = 电话,name = mobile,width = 80,align = left,type = text,headtype = sort,datatype= string);											
											gcid = state(headtext = 状态,name = state,width = 60,align = left,type = text,headtype = sort,datatype= string);
											gcid = address(headtext = 地址,name = address,width = 120,align = left,type = text,headtype = sort,datatype= string);											
											gcid = remark(headtext = 备注,name = remark,width = 120,align = left,type = text,headtype = sort,datatype = string);
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
