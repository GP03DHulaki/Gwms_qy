<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>销售退货上架单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="销售退货上架单">
		<meta http-equiv="description" content="销售退货上架单">
		<script type="text/javascript" src="returnputaway.js"></script>
	</head>

	<body id="mmain_body" onload="initAdd();">
		<div id="mmain_nav">
			<a id="linkid" href="returnputaway.jsf" class="return" title="返回">添加销售退货</a>&gt;&gt;
			添加销售退货上架单
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							rendered="#{returnPutawayMB.ADD}"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="addId" value="保存" type="button" action="#{returnPutawayMB.addHead}"
							reRender="msg"
							oncomplete="endAddHead();" requestDelay="50" />
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="showHead">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="单据单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{returnPutawayMB.mbean.biid}" disabled="true" />
									</td>									
									<td>
										<h:outputText value="组织架构:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{returnPutawayMB.mbean.orid}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="上架类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="dety" value="#{returnPutawayMB.mbean.dety}">
											<f:selectItem itemLabel= "合格品" itemValue= "01"/> 
											<f:selectItem itemLabel= "不合格品" itemValue= "05"/> 
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="入库仓库:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="whid" value="#{returnPutawayMB.mbean.whid}"
											style="width:130px;">
											<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
										</h:selectOneMenu>
									</td>
									<td>
										经&nbsp;&nbsp;手&nbsp;人:
									</td>
									<td>
										<h:inputText id="opna" value="#{returnPutawayMB.mbean.opna}" styleClass="datetime" size="20"/>
									</td>
								</tr>
								<!-- 
								<tr>
									<td>
										销售退货收货单号:
									</td>
									<td id="initdisplay">										
										<h:inputText id="soco" value="#{returnPutawayMB.mbean.soco}"
											styleClass="datetime" size="16" />
										<img id="invsrid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectSoco();" />
									</td>
								</tr>
								 -->
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											value="#{returnPutawayMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{returnPutawayMB.msg}" />
						</a4j:outputPanel>
					</div>
				</h:form>
		</f:view>
	</body>
</html>