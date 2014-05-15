<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>添加单据</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="添加单据">
		<script type="text/javascript" src="cancelback.js"></script>
	</head>
	<body id='mmain_body' >
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id='mmain_nav'>
						<a id="linkid" href="cancelback.jsf" class="return" title="返回">库内处理</a>&gt;&gt;
						<b>添加单据</b>
						<br>
					</div>
					<div id='mmain_opt'>
						<gw:GAjaxButton rendered="#{cancelBackMB.ADD}" theme="a_theme"
							id="addId" value="保存" type="button"
							action="#{cancelBackMB.addHead}" reRender="msg,main"
							onclick="if(!addHead()){return false};" oncomplete="endDo();"
							requestDelay="50" />
					</div>
					<div id='mmain_cnd'>
						<a4j:outputPanel id="main">
							<table cellpadding="3" cellspacing="0" border="0">
								<tr>
									<td>
										单据单号:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext" size="20"
											value="#{cancelBackMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
									</td>
									<td>
										移动库位:
									</td>
									<td>
										<h:inputText id="owid" styleClass="inputtext" size="20"
											value="#{cancelBackMB.mbean.owid}" />
										<img id="emp_img" style="cursor: pointer;"
											src="../../images/find.gif"
											onclick="selectWhid('9','ALL','edit:owid','')" />
									</td>
									<td>
										经手人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											value="#{cancelBackMB.mbean.opna}" />
										<img id="emp_img" style="cursor: pointer;"
											src="../../images/find.gif" onclick="selectuser();" />
									</td>
								</tr>
								<tr>
									<td>
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="inputtext" size="95"
											value="#{cancelBackMB.mbean.rema}" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<h:inputHidden id="msg" value="#{cancelBackMB.msg}" />
					<h:inputHidden id="orid" value="#{cancelBackMB.mbean.orid}" />
				</h:form>
			</f:view>
		</div>
	</body>
</html>