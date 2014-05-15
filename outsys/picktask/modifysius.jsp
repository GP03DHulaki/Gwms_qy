<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.PickTaskMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
    PickTaskMB ai = (PickTaskMB) MBUtil.getManageBean("#{pickTaskMB}");
    ai.getVouch();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>修改任务执行人</title>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="修改任务执行人" />
		<script type="text/javascript" src="picktask.js"></script>
	</head>
	<body id=mmain_body onload="init();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<h:panelGroup style="font-weight:bold">备货处理>>备货任务>>修改任务执行人</h:panelGroup>
					<div id=mmain_opt>
						<a4j:commandButton id="saveButton" value="保存"
							reRender="renderArea,msg" onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							onclick="if(!checkModifysius()){return false;}"
							action="#{pickTaskMB.modifysius}"
							oncomplete="endcheckModifysius();" />
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="showHead">
							<table border="0" cellspacing="0" cellpadding="1">
								<tr>
									<td>
										<h:outputText value="原有执行人:"></h:outputText>
									</td>
									<td>
										<h:inputText id="sina" styleClass="datetime" size="15"
											value="#{pickTaskMB.mbean.sina}" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="修改后执行人:"></h:outputText>
									</td>
									<td oncontextmenu='return(false);' onpaste='return false'>
										<h:inputText id="sina1" styleClass="datetime" onfocus="this.blur();"
											value="#{pickTaskMB.mbean.nsina}" />
										<h:inputHidden id="sius1" value="#{pickTaskMB.mbean.nsius}" />
										<%--
										<h:inputText id="nsina" value="#{pickTaskMB.mbean.nsina}"/>
										--%>
										<img id="orid_img" style="cursor: hand"
											src="../../images/find.gif" onclick="selectModifyUser();" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{pickTaskMB.msg}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>