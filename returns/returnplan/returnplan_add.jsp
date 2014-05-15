<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.ReturnPlanMB"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>销售退货计划单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="销售退货计划单">
		<meta http-equiv="description" content="销售退货计划单">
		<script type="text/javascript" src="returnplan.js"></script>
	</head>

	<%
		ReturnPlanMB ai = (ReturnPlanMB) MBUtil
				.getManageBean("#{returnPlanMB}");
	
	%>

	<body id="mmain_body" onload="initAdd();">
		<div id="mmain_nav">
			<font color="#000000">退货处理&gt;&gt;<a id="linkid"
				href="returnplan.jsf" title="返回" class="return">销售退货计划</a>&gt;&gt;</font><b>添加销售退货计划</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain_opt">
					<a4j:commandButton onmouseover="this.className='a4j_over'"
						rendered="#{returnPlanMB.ADD}"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
						id="addId" value="保存" type="button"
						action="#{returnPlanMB.addHead}"
						reRender="msg,vc_voucherid"
						onclick="if(!addHead()){return false};" oncomplete="endAddHead();"
						requestDelay="50"></a4j:commandButton>
				</div>
				<div id="mmain_cnd">
					<a4j:outputPanel id="showHead">
						<table border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td>
									<h:outputText value="单据单号:"></h:outputText>
								</td>
								<td>
									<h:inputText id="biid" styleClass="datetime" value="自动生成"
										disabled="true" />
								</td>
								<td>
									<h:outputText value="单据类型:"></h:outputText>
								</td>
								<td colspan="3">
									<h:selectOneMenu id="buty" style="width:130px;"
									value="#{returnPlanMB.mbean.buty}">
										<f:selectItems value="#{returnPlanMB.butys}" />
									</h:selectOneMenu>
								</td>
							</tr>
							<tr>
							<td>
								<h:outputText value="组织架构:"></h:outputText>
							</td>
							<td>
								<h:inputText id="orna" styleClass="datetime"
									value="#{returnPlanMB.mbean.orna}" disabled="true" />
								<h:inputHidden id="orid" value="#{returnPlanMB.mbean.orid}" />
									<img id="orid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectOrga();" />
							</td>
							<td>
								<h:outputText value="入库仓库:"></h:outputText>
							</td>
							<td>
								<h:inputText id="whna" styleClass="datetime"
											value="#{returnPlanMB.mbean.whna}" disabled="true" />
										<h:inputHidden id="whid" value="#{returnPlanMB.mbean.whid}" />
										<img id="orid_img" style="cursor:pointer"
											src="../../images/find.gif" onclick="selectWaho()" />
							</td>
							<td>
								<h:outputText value="退货时间:"></h:outputText>
							</td>
							<td>
								<h:inputText id="stdt" styleClass="datetime" onfocus="#{gmanage.datePicker};"
									value="#{returnPlanMB.mbean.stdt}" />
							</td>						
							</tr>
							<tr>
								<td>
									备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
								</td>
								<td colspan="5">
									<h:inputText id="rema" styleClass="datetime"
										value="#{returnPlanMB.mbean.rema}" size="97" />
								</td>
							</tr>
						</table>
					</a4j:outputPanel>
				</div>
				<div style="display: none;">
						<h:inputHidden id="msg" value="#{returnPlanMB.msg}" />
						
						<h:inputHidden id="sellist" value="#{returnPlanMB.sellist}" />
						<a4j:commandButton id="showMe" value="刷新列表" style="display:none;"
							reRender="showHead" />
				</div>
			</h:form>
		</f:view>
	</body>
</html>