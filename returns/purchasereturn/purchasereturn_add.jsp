<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>采购退货出库单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="采购退货出库单">
		<meta http-equiv="description" content="采购退货出库单">
		<script type="text/javascript"	src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="purchasereturn.js"></script>
	</head>

	<body id="mmain_body" onload="initAdd();">
		<div id="mmain_nav">
			<font color="#000000">退货处理&gt;&gt;<a id="linkid"
				href="purchasereturn.jsf" title="返回" class="return">采购退货出库单</a>&gt;&gt;</font><b>添加采购退货出库单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain_opt">
					<a4j:commandButton onmouseover="this.className='a4j_over'"
						rendered="#{purchaseReturnMB.ADD}"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
						id="addId" value="保存" type="button"
						action="#{purchaseReturnMB.addHead}"
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
								<td>
									<h:selectOneMenu id="buty"
										value="#{purchaseReturnMB.mbean.buty}">
										<f:selectItems value="#{purchaseReturnMB.butys}" />
									</h:selectOneMenu>
								</td>
							</tr>
							<tr>
								<td>
									<h:outputText value="来源单据业务类型:"></h:outputText>
								</td>
								<td>
									<h:selectOneMenu id="soty"
										value="#{purchaseReturnMB.mbean.soty}">
										<f:selectItems value="#{purchaseReturnMB.sotys}" />
									</h:selectOneMenu>
								</td>
								<td>
									<h:outputText value="退货计划单号:"></h:outputText>
								</td>
								<td>
									<h:inputText id="soco" styleClass="datetime"
										value="#{purchaseReturnMB.mbean.soco}"
										style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									<img id="whid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectformvoucherid();" />&nbsp;
									<h:outputText value="出库仓库: "></h:outputText>
									<h:inputText id="whna" styleClass="datetime"
										value="#{purchaseReturnMB.mbean.whna}"
										disabled="true"/>
									<h:inputHidden id="whid"
										value="#{purchaseReturnMB.mbean.whid}" />
								</td>
							</tr>
							<tr>
								<td>
									<h:outputText value="经手人:"></h:outputText>
								</td>
								<td>
									<h:inputText id="opna" styleClass="datetime"
										value="#{purchaseReturnMB.mbean.opna}"/>
									<img id="emp_img" style="cursor: pointer;" src="../../images/find.gif" onclick="selectuser();" />
								</td>
								<td>
									<h:outputText value="备注:"></h:outputText>
								</td>
								<td>
									<h:inputText id="rema" styleClass="datetime"
										value="#{purchaseReturnMB.mbean.rema}" size="80" />
								</td>
							</tr>
						</table>
					</a4j:outputPanel>
				</div>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{purchaseReturnMB.msg}" />
						<h:inputHidden id="orid" value="#{purchaseReturnMB.orid}"></h:inputHidden>
					</a4j:outputPanel>
				</div>
			</h:form>
		</f:view>
	</body>
</html>