<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>退货计划单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="退货计划单">
		<meta http-equiv="description" content="退货计划单">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="purchasereturnplan.js"></script>
	</head>

	<body id="mmain_body" onload="initAdd();">
		<div id="mmain_nav">
			<font color="#000000">退货处理&gt;&gt;<a id="linkid"
				href="purchasereturnplan.jsf" title="返回" class="return">采购退货计划</a>&gt;&gt;</font><b>添加采购退货计划</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain_opt">
					<a4j:commandButton onmouseover="this.className='a4j_over'"
						rendered="#{purchaseReturnPlanMB.ADD}"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
						id="addId" value="保存" type="button"
						action="#{purchaseReturnPlanMB.addHead}"
						reRender="msg,showHead,vc_voucherid"
						onclick="if(!addHead()){return false};" oncomplete="endAddHead();"
						requestDelay="50"></a4j:commandButton>
				</div>
				<div id="mmain_cnd">
					<a4j:outputPanel id="showHead">
						<table border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td>
									<h:outputText value="采购退货计划:"></h:outputText>
								</td>
								<td>
									<h:inputText id="biid" styleClass="datetime" value="自动生成"
										disabled="true" />
								</td>
								<td>
									<h:outputText value="业务类型:"></h:outputText>
								</td>
								<td>
									<h:selectOneMenu id="buty" style="width:130px;"
										value="#{purchaseReturnPlanMB.mbean.buty}">
										<f:selectItems value="#{purchaseReturnPlanMB.butys}" />
									</h:selectOneMenu>
								</td>
							</tr>
							<tr>
								<td>
									<h:outputText value="退货出库仓库:"></h:outputText>
								</td>
								<td>
									<h:inputText id="whna" styleClass="datetime"
										value="#{purchaseReturnPlanMB.mbean.whna}" disabled="true" />
									<h:inputHidden id="whid"
										value="#{purchaseReturnPlanMB.mbean.whid}" />
									<img id="whid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectWaho();" />
								</td>
								<!-- <td>
									路&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;线:
								</td>
								<td>
									<h:selectOneMenu id="lico" style="width:130px;"
										value="#{purchaseReturnPlanMB.mbean.lico}">
										<f:selectItem itemLabel="" itemValue="" />
										<f:selectItems value="#{lineMB.itemlist}" />
									</h:selectOneMenu>
								</td> -->
								<td>
									<h:outputText value="退货时间:"></h:outputText>
								</td>
								<td>
									<h:inputText id="stdt" styleClass="datetime"
										onfocus="#{gmanage.datePicker};"
										value="#{purchaseReturnPlanMB.mbean.stdt}" />
								</td>
							</tr>
							<tr>
								<td>
									<h:outputText value="供货商编号:"></h:outputText>
								</td>
								<td>
									<h:inputText id="stus" styleClass="datetime"
										value="#{purchaseReturnPlanMB.mbean.stus}"
										style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									<img id="whid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectstus();" />
								</td>
								<td>
									<h:outputText value="供货商名称:"></h:outputText>
								</td>
								<td colspan="3">
									<h:inputText id="stna" styleClass="datetime" size="50"
										value="#{purchaseReturnPlanMB.mbean.stna}"
										style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />

								</td>
							</tr>
							<tr>
								<td>
									<h:outputText value="经手人"></h:outputText>
								</td>
								<td>
									<h:inputText id="opna" styleClass="datetime"
										value="#{purchaseReturnPlanMB.mbean.opna}" />
								</td>
								<td>
									<h:outputText value="备注:"></h:outputText>
								</td>
								<td colspan="5">
									<h:inputText id="rema" styleClass="datetime"
										value="#{purchaseReturnPlanMB.mbean.rema}" size="70" />
								</td>
							</tr>
						</table>
					</a4j:outputPanel>
				</div>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{purchaseReturnPlanMB.msg}" />
						<h:inputHidden id="orid" value="#{purchaseReturnPlanMB.orid}"></h:inputHidden>
					</a4j:outputPanel>
				</div>
			</h:form>
		</f:view>
	</body>
</html>