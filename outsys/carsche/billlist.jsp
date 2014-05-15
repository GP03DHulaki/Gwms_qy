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
		<script type="text/javascript" src="carsche.js"></script>
	</head>

	<body id='mmain_body' onload="initFrame();">
		<f:view>
			<h:form id="edit">
				<div id='mmain_nav'>
					<a id="linkid" href="carsche.jsf" title="返回">出库处理</a>&gt;&gt;
					<font color="#000000">配车处理&gt;&gt;</font>
					<b>订单列表<h:outputText value="#{carScheMB.carlina}" /> </b>
					<br>
				</div>
				<div id='mmain'>
					<div id="tabDiv">
						<!--<div id="tabsHead">
							<a class="curtab" id="tabs1"
								href="javascript:showTab('tabs1','tabContent1')" title="已完成分拣订单">已分拣订单</a>
							<a class="tabs" id="tabs2"
								href="javascript:showTab('tabs2','tabContent2');"
								title="未完成分拣订单">未完成分拣订单</a>
						</div>-->
						<div id="tabsBody">
							<div id="tabContent1" class="curtab_body">
								<iframe id="iframe_finOrder" name="iframe_finOrder" align="top"
									width="100%" scrolling="auto" frameborder="0" height="100%"
									onload="this.height=iframe_finOrder.document.body.scrollHeight;
									this.width=iframe_finOrder.document.body.scrollWidth"
									src="<%=request.getContextPath()%>/outsys/carsche/finorder.jsf"></iframe>
							</div>
							<!--<div id="tabContent2">
								<iframe id="iframe_unfinOrder" name="iframe_unfinOrder"
									width="100%" align="top" scrolling="auto" frameborder="0"
									onload="this.height=iframe_unfinOrder.document.body.scrollHeight;
									this.width=iframe_unfinOrder.document.body.scrollWidth;
									"
									src="<%=request.getContextPath()%>/outsys/carsche/unfinorder.jsf"></iframe>
							</div>
						-->
						</div>
					</div>
				</div>

				<div style="display: none;">
					<h:inputHidden id="msg" value="#{carScheMB.msg}" />
					<a4j:commandButton id="gotoBut" reRender="toMBean"
						action="#{carScheMB.doNext}" oncomplete="gotoEdit();" />
				</div>
			</h:form>

			<div id="errmsg" style="display: none">
				<div id=mmain_cnd align="left">
					<span id="mes" style="color: red;"></span>
					<div align="center">
						<button type="button" onclick="Gwallwin.winClose();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" class="a4j_but">
							关闭
						</button>
					</div>
				</div>
			</div>

		</f:view>
	</body>
</html>