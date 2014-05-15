<%@ page language="java" pageEncoding="UTF-8"%>

<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>打包</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="打包">
		<meta http-equiv="description" content="打包">
		<link href="../../css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/gwall/all.js"></script>
		<script type="text/javascript" src="packaging.js"></script>
	</head>
	<body id="mmain_body" onload="clear();">
		<div id="mmain_nav">
			<a id="linkid" href="packaging.jsf" class="return" title="返回">出库处理</a>&gt;&gt;
			<b>添加打包单</b>
			<br>
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							rendered="#{packagingMB.ADD}"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="addId" value="保存" type="button"
							action="#{packagingMB.addHead}" reRender="msg,showHead,biid"
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
											value="#{packagingMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="业务类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{packagingMB.mbean.soty}">
											<f:selectItem itemLabel="出库订单" itemValue="OUTORDER" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="来源单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="soco" styleClass="inputtext" size="15"
											value="#{packagingMB.mbean.soco}" />
										<img id="whid_img" style="cursor: hand"
											src="../../images/find.gif" onclick="selectOrders();" />
									</td>
								</tr>
								<tr>
								<td>
								<h:outputText value="组织架构:"></h:outputText>
							</td>
							<td>
								<h:inputText id="orna" styleClass="datetime"
									value="#{packagingMB.mbean.orna}" disabled="true" />
								<h:inputHidden id="orid" value="#{packagingMB.mbean.orid}" />
									<img id="orid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectOrga();" />
							</td>
									<td>
										<h:outputText value="仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whid" styleClass="datetime"
											value="#{packagingMB.mbean.whid}" />
										<h:inputHidden id="whna" value="" />
										<img id="suidimg" style="cursor: hand"
											src="../../images/find.gif" onclick="selectWaho();" />
									</td>
									<td>
										<h:outputText value="经手人:"></h:outputText>
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="15"
											value="#{packagingMB.mbean.opna}" />
									</td>
								</tr>

								<tr>
									<td>
										<h:outputText value="创建人编码:"></h:outputText>
									</td>
									<td>
										<h:inputText id="crus" styleClass="inputtext" size="15"
											value="#{packagingMB.mbean.crus}" disabled="true" />
									</td>
									<td>
										<h:outputText value="创建人姓名"></h:outputText>
									</td>
									<td>
										<h:inputText id="crna" styleClass="inputtext" size="15"
											value="#{packagingMB.mbean.crna}" disabled="true" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											value="#{packagingMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{packagingMB.msg}" />
						</a4j:outputPanel>
					</div>
				</h:form>
		</f:view>
	</body>
</html>