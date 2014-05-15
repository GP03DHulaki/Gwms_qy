<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>销售退货收货单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="销售退货收货单">
		<meta http-equiv="description" content="销售退货收货单">
		<script type="text/javascript" src="returnreceipt.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
	</head>

	<body id="mmain_body" onload="initAdd();">
		<div id="mmain_nav">
			<font color="#000000">退货处理&gt;&gt;<a id="linkid"
				href="returnreceipt.jsf" title="返回" class="return">销售退货收货</a>&gt;&gt;</font><b>添加销售退货收货单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain_opt">
					<a4j:commandButton onmouseover="this.className='a4j_over'"
						rendered="#{returnReceiptMB.ADD}"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
						id="addId" value="保存" type="button"
						action="#{returnReceiptMB.addHead}"
						reRender="msg,showHead,vc_voucherid"
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
									<h:outputText value="单据业务类型:"></h:outputText>
								</td>
								<td colspan="3">
									<h:selectOneMenu id="buty"
										value="#{returnReceiptMB.mbean.buty}">
										<f:selectItems value="#{returnReceiptMB.butys}" />
									</h:selectOneMenu>
								</td>
							</tr>
							<tr>
								<td id="td2">
									<h:outputText value="退货计划单号:"></h:outputText>
								</td>
								<td id="td3">
									<h:inputText id="soco" styleClass="datetime"
										value="#{returnReceiptMB.mbean.soco}"
										style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									<img id="whid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectformvoucherid();" />
								</td>
								<td>
									<h:outputText value="入库仓库:"></h:outputText>
								</td>
								<td>
									<h:inputText id="whna" styleClass="datetime"
										value="#{returnReceiptMB.mbean.whna}" disabled="true" />
									<h:inputHidden id="whid" value="#{returnReceiptMB.mbean.whid}" />
								</td>
								<td>
									<h:outputText value="组织架构:"></h:outputText>
								</td>
								<td>
									<h:inputText id="orna" styleClass="datetime"
										value="#{returnReceiptMB.mbean.orna}" disabled="true" />
									<h:inputHidden id="orid" value="#{returnReceiptMB.mbean.orid}" />
										<img id="orid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectOrga();" />
								</td>
								
							</tr>
							<tr>
							<td>
									<h:outputText value="收货时间:"></h:outputText>
								</td>
								<td>
									<h:inputText id="stdt" styleClass="datetime"
										onfocus="#{gmanage.datePicker};"
										value="#{returnReceiptMB.mbean.stdt}" />
							</td>
							<td>
									<h:outputText value="经手人:"></h:outputText>
								</td>
								<td colspan="3">
									<h:inputText id="opna" styleClass="datetime" style="readonly:expression(this.readOnly=true);color:#7f7f7f;" 
										value="#{returnReceiptMB.mbean.opna}" size="10" />
									<img id="emp_img" style="cursor: hand"
										src="../../images/find.gif" onclick="selectuser();" />
								</td>
							</tr>
							<tr>
								
								<td>
									<h:outputText value="备注:"></h:outputText>
								</td>
								<td colspan="6">
									<h:inputText id="rema" styleClass="datetime"
										value="#{returnReceiptMB.mbean.rema}" size="110" />
								</td>
							</tr>
						</table>
					</a4j:outputPanel>
				</div>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{returnReceiptMB.msg}" />
					</a4j:outputPanel>
				</div>
			</h:form>
		</f:view>
	</body>
</html>