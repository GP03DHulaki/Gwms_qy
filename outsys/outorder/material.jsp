<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.OutOrderMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	OutOrderMB ai = (OutOrderMB) MBUtil.getManageBean("#{outOrderMB}");
	//ai.getVouch();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>调整商品编码</title>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="调整商品编码" />
		<script type="text/javascript" src="outorder.js"></script>
	</head>
	<body id=mmain_body onload="clearData();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<h:panelGroup style="font-weight:bold">出库订单>>调整商品编码</h:panelGroup>
					<div id=mmain_opt>
						<a4j:commandButton id="saveButton" value="保存"
							reRender="renderArea,msg" onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							onclick="if(!checkMerger()){return false;}"
							action="#{outOrderMB.adjustInco}"
							oncomplete="finishcheckMerger();" />
					</div>
					<div style="display: none;">
						<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
							reRender="showHead,renderArea" />
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="showHead">
							<table border="0" cellspacing="0" cellpadding="1">
								<tr>
									<td>
										<h:outputText value="现有商品编码:"></h:outputText>
									</td>
									<td>
										<h:inputText id="oinco" styleClass="datetime" size="20"
											value="#{outOrderMB.dbean.oinco}" disabled="true" />
									</td>
									<td>
								</tr>
								<tr>
									<td>
										调整商品编码:
									</td>
									<td>
										<h:inputText id="ninco" value="#{outOrderMB.dbean.ninco}"
											styleClass="inputtextedit" />
										<img id="tyna_img" style="cursor: hand"
											src="../../images/find.gif" onclick="selectInve();" />

									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{outOrderMB.msg}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>