<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.EntruckPlanMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	EntruckPlanMB ai = (EntruckPlanMB) MBUtil
			.getManageBean("#{entruckPlanMB}");
	ai.getVouch();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>调整组织架构</title>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="调整组织架构" />
		<script type="text/javascript" src="entruckplan.js"></script>
	</head>
	<body id=mmain_body >
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<h:panelGroup style="font-weight:bold">备货调度>>备货计划>>调整组织架构</h:panelGroup>
					<div id=mmain_opt>
						<a4j:commandButton id="saveButton" value="保存" 
							reRender="renderArea,msg" 
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							onclick="if(!checkOrga()){return false;}"
							action="#{entruckPlanMB.updateOrga}"
							oncomplete="finishCheckOrga();"
							 />
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="showHead">
							<table border="0" cellspacing="0" cellpadding="1">
								<tr>
									<td>
										<h:outputText value="原有组织架构:"></h:outputText>
									</td>
									<td>
										<h:inputText id="oorid" styleClass="datetime" size="15"
											value="#{entruckPlanMB.mbean.orna}" />
									</td>
									<td>
								</tr>
								<tr>
									<td>
										组织架构:
									</td>
									<td>
										<h:selectOneMenu id="norid" value="#{entruckPlanMB.mbean.norid}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<!--  <tr>
									<td>
										<h:outputText value="调整后组织架构:"></h:outputText>
									</td>
									<td>
										<h:inputText id="orna" styleClass="datetime"
											value="#{entruckPlanMB.mbean.norna}"/>
										<h:inputHidden id="orid" value="#{entruckPlanMB.mbean.norid}"/>	
										<img id="whid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectOrga();" />		
									</td>
								</tr>-->
							</table>
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{entruckPlanMB.msg}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>