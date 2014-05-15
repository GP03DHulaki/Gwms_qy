<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title></title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="gwall">
		<script type="text/javascript" src="aftersingle.js"></script>
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/gwall/all_gtab.js'></script>
		<link href="<%=request.getContextPath()%>/gwall/all_gtab.css"
			rel="stylesheet" type="text/css" />
	</head>
	<body id='mmain_body' onload="initFrame();endWinShow();">
		<div id='mmain_nav'>
			<font color="#000000">库内处理&gt;&gt;</font>
			<font color="#000000"><b>追单处理</b> </font>
			<br>
		</div>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id="tabDiv">
						<div id="tabsHead">
							<a class="curtab" id="tabs1"
								href="javascript:showTab('tabs1','tabContent1')" title="追单操作">追单操作</a>
							<a class="curtab" id="tabs2"
								href="javascript:showTab('tabs2','tabContent2');" title="待处理列表">待处理列表</a>
						</div>
						<div id="tabsBody">
							<div id="tabContent1" class="curtab_body">
								<iframe id="iframe_outorder" name="iframe_finOrder" align="top"
									width="100%" height="90%" scrolling="auto" frameborder="0"
									onload="parent.Gskin.setSkinCss(null,this);"
									src="<%=request.getContextPath()%>/stocksys/aftersingle/aftersingle.jsf?isAll=0"></iframe>
							</div>
							<div id="tabContent2">
								<iframe id="iframe_tranplan" name="iframe_unfinOrder"
									width="100%" height="90%" align="top" scrolling="auto"
									frameborder="0" onload="parent.Gskin.setSkinCss(null,this);"
									src="<%=request.getContextPath()%>/stocksys/aftersingle/waitaftersingle.jsf?isAll=0"></iframe>
							</div>

						</div>
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
		</div>
	</body>
</html>