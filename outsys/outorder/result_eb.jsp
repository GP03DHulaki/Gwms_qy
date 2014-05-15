<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>导入结果</title>
		<base target="_parent" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="导入结果">
	</head>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<div align="center">
					<h:outputText id="msg" style="color:red;font-size: 18;"
						value="#{outOrderMB.msg}" />
				</div>
				<p></p>
				<div align="center">
					<button onclick="window.location.href='outorder.jsf'" id="backBut"
						onmouseover="this.className='a4j_over'"
						onmouseout="this.className='a4j_buton'" class="a4j_but">
						返回
					</button>
				</div>
			</f:view>
		</div>
	</body>
</html>