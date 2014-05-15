<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>添加变更条码单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="添加变更条码单">
		<meta http-equiv="description" content="添加变更条码单">
		<script type="text/javascript" src="changebaco.js"></script>
	</head>
	<body id="mmain_body" onload="clear();">
		<div id="mmain_nav">
			库内处理&gt;&gt;
			<a id="linkid" href="changebaco.jsf" class="return" title="返回">变更条码</a>&gt;&gt;
			<b>添加变更条码单</b>
			<br>
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							rendered="#{changeBacoMB.ADD}"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="addId" value="保存" type="button"
							action="#{changeBacoMB.addHead}" reRender="msg,showHead"
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
										<h:inputText id="biid" styleClass="datetime" size="20"
											value="#{changeBacoMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="业务类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{changeBacoMB.mbean.soty}"
											style="width:130px;">
											<f:selectItem itemValue="01" itemLabel="库内调整" />
											<f:selectItem itemValue="02" itemLabel="质检调整" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="经手人:" />
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											value="#{changeBacoMB.mbean.opna}" />
										<img id="emp_img" style="cursor: pointer;"
											src="../../images/find.gif" onclick="selectuser();" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="创建人编码:"></h:outputText>
									</td>
									<td>
										<h:inputText id="crus" styleClass="datetime" size="20"
											value="#{changeBacoMB.mbean.crus}" disabled="true" />
									</td>
									<td>
										<h:outputText value="创建人姓名:" />
									</td>
									<td>
										<h:inputText id="crna" styleClass="inputtext" size="20"
											value="#{changeBacoMB.mbean.crna}" disabled="true" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="仓库:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="whid" value="#{changeBacoMB.mbean.whid}"
											style="width:130px;">
											<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
										</h:selectOneMenu>
										<%-- 
										<h:inputText id="whna" styleClass="datetime"
											value="#{changeBacoMB.mbean.whid}" disabled="true"/>
										<h:inputHidden id="whid" value="#{changeBacoMB.mbean.whid}"/>	
										<img id="whid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectWaho();" />	
										--%>
									</td>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											value="#{changeBacoMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{changeBacoMB.msg}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>