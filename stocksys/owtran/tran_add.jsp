<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>货主转换计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="添加货主转换计划">
		<script type="text/javascript" src="tran.js"></script>
	</head>
	<body id='mmain_body'>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id='mmain_nav'>
						<div id="mmain_nav">
							<font color="#000000"> 库内处理 &gt;&gt;<a id="linkid" href="owtran.jsf"
								class="return" title="返回">货主转换计划</a>&gt;&gt;</font><b>添加货主转换计划</b>
							<br>
						</div>
					</div>
					<div id='mmain_opt'>
						<gw:GAjaxButton rendered="#{owTranMB.ADD}" theme="a_theme"
							id="addId" value="保存" type="button"
							action="#{owTranMB.addHead}" reRender="msg,main"
							onclick="if(!addHead()){return false};" oncomplete="endDo();"
							requestDelay="50" />
					</div>
					<div id='mmain_cnd'>
						<a4j:outputPanel id="main">
							<table cellpadding="0" cellspacing="3" border="0">
								<tr>
									<td>
										调拨计划单:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext" size="20"
											value="#{owTranMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
									</td>
									<td>
										调入仓库:
									</td>
									<td>
										<h:inputText id="inwhna" styleClass="inputtext" size="20"
											value="#{owTranMB.mbean.inwhna}"
											 />
										<h:inputHidden id="powh" value="#{owTranMB.mbean.powh}" />
										<img id="twh_img" style="cursor: pointer"
											src="../../images/find.gif"
											onclick="return selectWaho1('edit:powh','edit:inwhna','edit:ifib');" />
									</td>
									<td>
										调拨类型:
									</td>
									<td>
											<h:selectOneMenu id="ifib" value="#{owTranMB.mbean.ifib}" 
												style="width:130px;" disabled="true">
													<h:inputHidden id="ifibs" value="#{owTranMB.mbean.ifib}"></h:inputHidden>
													<f:selectItems value="#{owTranMB.ifibs}" />
											</h:selectOneMenu>
									</td>
								<tr>
									<td>
										组织架构:
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{owTranMB.mbean.orid}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
									<td>
										调出仓库:
									</td>
									<td>
										<h:inputText id="outwhna" styleClass="inputtext" size="20"
											value="#{owTranMB.mbean.outwhna}"
											 />
										<h:inputHidden id="pfwh" value="#{owTranMB.mbean.pfwh}" />
										<img id="fwh_img" style="cursor: pointer"
											src="../../images/find.gif"
											onclick="return selectWaho('edit:pfwh','edit:outwhna','1');"
											/>
									</td>
									<!-- 
									<td>
										路&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;线:
									</td>
									<td>
										<h:selectOneMenu id="lico" style="width:130px;"
											value="#{tranPlanMB.mbean.lico}">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{lineMB.itemlist}" />
										</h:selectOneMenu>
									</td>
									 -->
								</tr>
								<tr>
									<td>
										经手人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											value="#{owTranMB.mbean.opna}" />
									</td>
									<td>
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="inputtext" size="70"
											value="#{owTranMB.mbean.rema}" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<h:inputHidden id="msg" value="#{owTranMB.msg}" />
				</h:form>
			</f:view>
		</div>
	</body>
</html>