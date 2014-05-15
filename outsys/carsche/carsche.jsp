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

	<body id='mmain_body' onload="initFrame1();endWinShow();">
		<div id='mmain_nav'>
			<font color="#000000">出库处理&gt;&gt;</font>
			<font color="#000000">配车处理&gt;&gt;</font>
			<b>配车调度</b>
			<br>
		</div>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id="tabDiv">
						<div id="tabsHead">
							<a class="curtab" id="tabs2"
								href="javascript:showTab('tabs2','tabContent2');" title="承运商订单完成进度">承运商订单完成进度</a>
							<a class="tabs" id="tabs1"
								href="javascript:showTab('tabs1','tabContent1')" title="备货计划完成进度">备货计划完成进度</a>
							
						</div>
						<div id="tabsBody">
							<div id="tabContent2">
								<div id=mmain>
								<iframe id="iframe_unfinOrder" name="iframe_unfinOrder"
									width="100%" align="top"  frameborder="0" height="100%"
									onload="this.height=iframe_unfinOrder.document.body.scrollHeight+100;
									this.width=iframe_unfinOrder.document.body.scrollWidth;"
									src="<%=request.getContextPath()%>/outsys/carsche/orders.jsf?isAll=0"></iframe>
								</div>	
							</div>
							<div id="tabContent1" class="curtab_body">
								<div id=mmain>
								<iframe id="iframe_finOrder" name="iframe_finOrder" align="top"
									width="100%"  frameborder="0" height="100%" 
									onload="this.height=iframe_finOrder.document.body.scrollHeight+100;
									this.width=iframe_finOrder.document.body.scrollWidth"
									src="<%=request.getContextPath()%>/outsys/carsche/entplans.jsf?isAll=0"></iframe>
								</div>	
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