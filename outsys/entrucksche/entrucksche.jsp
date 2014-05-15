<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>配车调度</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="配车调度">
		<script type="text/javascript" src="entrucksche.js"></script>
		<link href="<%=request.getContextPath()%>/gwall/all.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/gwall/all.js"></script>
	</head>

	<body id='mmain_body' onload="initFrame();">
		<div id='mmain_nav'>
			<font color="#000000">出库处理&gt;&gt;</font>
			<font color="#000000">装车处理&gt;&gt;</font>
			<b>备货调度</b>
			<br>
		</div>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id="tabDiv">
						<div id="tabsHead">
							<a class="curtab" id="tabs1"
								href="javascript:showTab('tabs1','tabContent1')" title="出库订单调度">出库订单调度</a>
							<a class="tabs" id="tabs2"
								href="javascript:showTab('tabs2','tabContent2');" title="调拨计划调度">调拨计划调度</a>
							<%--
							<a class="tabs" id="tabs3"
								href="javascript:showTab('tabs3','tabContent3');" title="采购退货调度">采购退货调度</a>	
							--%>
						</div>
						<div id="tabsBody">
							<div id="tabContent1" class="curtab_body">
								<iframe id="iframe_outorder" name="iframe_finOrder" align="top"
									width="100%" scrolling="auto" frameborder="0" height="100%"
									src="outorders.jsf?isAll=0"></iframe>
							</div>
							<div id="tabContent2">
								<iframe id="iframe_tranplan" name="iframe_unfinOrder"
									width="100%" align="top" scrolling="auto" frameborder="0" height="100%"
									src="tranplan.jsf?isAll=0"></iframe>
							</div>
							<%--
							<div id="tabContent3">
								<iframe id="iframe_poreturnplan" name="iframe_unfinOrder"
									width="100%" align="top" scrolling="auto" frameborder="0" height="100%"
									onload="this.height=iframe_poreturnplan.document.body.scrollHeight+100;
									this.width=iframe_poreturnplan.document.body.scrollWidth;"
									src="<%=request.getContextPath()%>/outsys/entrucksche/poreturnplan.jsf?isAll=0"></iframe>
							</div>
							--%>
						</div>
					</div>
				</h:form>

			</f:view>
		</div>
	</body>
</html>