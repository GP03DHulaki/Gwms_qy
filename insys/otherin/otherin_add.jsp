<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>其它入库单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="其它入库单">
		<meta http-equiv="description" content="其它入库单">
		<script type="text/javascript" src="otherin.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
	</head>

	<body id="mmain_body" onload="initAdd();">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;<a href="otherin.jsf"
				title="返回" class="return">入库</a>&gt;&gt;</font><b>添加其它入库单</b>
			<br>
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							rendered="#{otherinMB.ADD}"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="addId" value="保存" type="button" action="#{otherinMB.addHead}"
							reRender="msg,showHead,vc_voucherid"
							onclick="if(!addHead()){return false};"
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
											value="#{otherinMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="业务类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="dety" value="#{otherinMB.mbean.dety}"
											style="width:130px;" onchange="initDisplay()">
											<f:selectItems value="#{otherinMB.butys}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="组织架构:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{otherinMB.mbean.orid}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>

								</tr>
								<tr>
									<td>
										<h:outputText value="入库仓库:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="whid" value="#{otherinMB.mbean.whid}"
											style="width:130px;">
											<f:selectItems value="#{warehouseMB.wareList}" />
										</h:selectOneMenu>
									</td>
									<td>
										经&nbsp;&nbsp;手&nbsp;人:
									</td>
									<td>
										<h:inputText id="opna" value="#{otherinMB.mbean.opna}" styleClass="datetime" size="20"/>
										<img id="emp_img" style="cursor: hand"
											src="../../images/find.gif" onclick="selectCheckuserid();" />
									</td>
									<td id="initdisplay" colspan="3" style="display: none;">
										其他出库单号:
										<h:inputText id="srid" value="#{otherinMB.mbean.soco}"
											styleClass="datetime" size="16" />
										<img id="invsrid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectSrid();" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											value="#{otherinMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{otherinMB.msg}" />
						</a4j:outputPanel>
					</div>
				</h:form>
		</f:view>
	</body>
</html>