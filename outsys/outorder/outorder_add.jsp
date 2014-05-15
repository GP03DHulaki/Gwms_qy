<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>添加出库订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="添加出库订单">
		<script type="text/javascript" src="outorder.js"></script>
	</head>
	<body id='mmain_body'>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id='mmain_nav'>
						<a id="linkid" href="outorder.jsf" class="return" title="返回">出库处理</a>&gt;&gt;
						<b>添加出库订单</b>
						<br>
					</div>
					<div id='mmain_opt'>
						<gw:GAjaxButton rendered="#{outOrderMB.ADD}" theme="a_theme"
							id="addId" value="保存" type="button"
							action="#{outOrderMB.addHead}" reRender="msg,main"
							onclick="if(!addHead()){return false};" oncomplete="endDo();"
							requestDelay="50" />
					</div>
					<div id='mmain_cnd'>
						<a4j:outputPanel id="main">
							<table cellpadding="1" cellspacing="1" border="0">
								<tr>
									<td>
										出库订单:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext" size="20"
											value="#{outOrderMB.mbean.biid}"
											readonly="true" style="color:#A0A0A0;" />
									</td>
									<td>
										订单类型:
									</td>
									<td>
										<h:selectOneMenu id="buty" value="#{outOrderMB.mbean.buty}"
											style="width:130px;">
											<f:selectItems value="#{outOrderMB.butys}" />
										</h:selectOneMenu>
									</td>
									<td>
										组织架构:
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{outOrderMB.mbean.orid}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										客户名称:
									</td>
									<td>
										<t:inputText id="cuna" size="20" styleClass="inputtext"
											value="#{outOrderMB.mbean.cuna}" style="readonly:expression(this.readOnly=true);color:#A0A0A0;"
											 />
										<h:inputHidden id="cuid" value="#{outOrderMB.mbean.cuid}" />
										<img id="suid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectCuin();" />
									</td>
									<td>
										路&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;线:
									</td>
									<td>
										<h:selectOneMenu id="lico" style="width:130px;"
											value="#{outOrderMB.mbean.lico}">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{lineMB.itemlist}" />
										</h:selectOneMenu>
									</td>
									<td>
										发货级别:
									</td>
									<td>
										<h:selectOneMenu id="tale" value="#{outOrderMB.mbean.tale}"
											style="width:130px;">
											<f:selectItem itemLabel="普通" itemValue="30" />
											<f:selectItem itemLabel="中级" itemValue="20" />
											<f:selectItem itemLabel="高级" itemValue="10" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										装车要求:
									</td>
									<td>
										<h:selectOneMenu id="dety" value="#{outOrderMB.mbean.dety}"
											style="width:130px;">
											<f:selectItem itemLabel="允许部分装车" itemValue="1" />
											<f:selectItem itemLabel="不允许部分装车" itemValue="0" />
										</h:selectOneMenu>
									</td>
									<td>
										经&nbsp;&nbsp;手&nbsp;人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											value="#{outOrderMB.mbean.opna}" />
										<img id="emp_img" style="cursor: pointer;"
										src="../../images/find.gif" onclick="selectuser();" />
									</td>
								</tr>
								<tr>
									<td>
										目&nbsp;的&nbsp;&nbsp;地:
									</td>
									<td colspan="5">
										<h:inputText id="orad" value="#{outOrderMB.mbean.orad}"
											styleClass="inputtext" size="102" />
									</td>
								</tr>
								<tr>
									<td>
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="inputtext" size="102"
											value="#{outOrderMB.mbean.rema}" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<h:inputHidden id="msg" value="#{outOrderMB.msg}" />
				</h:form>
			</f:view>
		</div>
	</body>
</html>