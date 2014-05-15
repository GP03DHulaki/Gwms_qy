<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>生产包装计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="生产包装计划">
		<meta http-equiv="description" content="生产包装计划">
		<script type="text/javascript" src="moplan.js"></script>
	</head>
	<body id="mmain_body">
		<div id="mmain_nav">
			<a id="linkid" href="moplan.jsf" class="return" title="返回">入库处理</a>&gt;&gt;
			<b>添加生产包装计划</b>
			<br>
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							rendered="#{moPlanMB.ADD}" onmouseout="this.className='a4j_buton'"
							styleClass="a4j_but" id="addId" value="保存" type="button"
							action="#{moPlanMB.addHead}" reRender="msg,showHead"
							onclick="if(!addHead()){return false};"
							oncomplete="endHeadAdd();" requestDelay="50" />
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="showHead">
							<table border="0" cellspacing="0" cellpadding="1">
								<tr>
									<td>
										<h:outputText value="单据单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime" size="15"
											value="#{moPlanMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="业务类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="dety" value="#{moPlanMB.mbean.dety}">
											<f:selectItems value="#{moPlanMB.butys}" />
										</h:selectOneMenu>
									</td>
									<td>
										组织架构:
									</td>
									<td>
										<h:selectOneMenu id="orna" value="#{moPlanMB.mbean.orid}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										经手人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="15"
											value="#{moPlanMB.mbean.opna}" />
									</td>
									<td>
										<h:outputText value="入库仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whna" styleClass="datetime"
											value="#{moPlanMB.mbean.whna}" disabled="true"/>
										<h:inputHidden id="whid" value="#{moPlanMB.mbean.whid}"/>	
										<img id="whid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectWaho();" />		
									</td>
									<td>
										部&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门:
									</td>
									<td>
										<h:inputText id="dpna" styleClass="datetime"
											value="#{moPlanMB.mbean.dpna}" disabled="true"/>
										<h:inputHidden id="dpid" value="#{moPlanMB.mbean.dpid}"/>	
										<img id="whid_img" style="cursor: hand"
												src="../../images/find.gif" onclick="selectDept();" />		
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											value="#{moPlanMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{moPlanMB.msg}" />
						</a4j:outputPanel>
					</div>
				</h:form>
		</f:view>
	</body>
</html>