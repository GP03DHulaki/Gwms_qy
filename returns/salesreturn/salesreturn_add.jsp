<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>销售退货单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="销售退货单">
		<meta http-equiv="description" content="销售退货单">
		<script type="text/javascript" src="salesreturn.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
	</head>
	<body id="mmain_body" onload="initAdd();">
		<div id="mmain_nav">
			<font color="#000000">退货处理&gt;&gt;<a id="linkid"
				href="salesreturn.jsf" title="返回" class="return">销售退货入库</a>&gt;&gt;</font><b>添加销售退货入库单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain_opt">
					<a4j:commandButton onmouseover="this.className='a4j_over'"
						rendered="#{saleReturnMB.ADD}"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
						id="addId" value="保存" type="button"
						action="#{saleReturnMB.addHead}"
						reRender="renderArea"
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
									组织架构:
								</td>
								<td>
									<h:selectOneMenu id="orid1" value="#{saleReturnMB.mbean.orid}">
										<f:selectItems value="#{OrgaMB.subList}" />
									</h:selectOneMenu>
								</td>
								<td>
									<h:outputText value="退货入库仓库:"></h:outputText>
								</td>
								<td>
									<h:inputText id="whna" styleClass="datetime"
										value="#{saleReturnMB.mbean.whna}" disabled="true" />
									<h:inputHidden id="whid" value="#{saleReturnMB.mbean.whid}" />
									<img id="whid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectWaho();" />
								</td>
							</tr>
							<tr>
								<td>
									<h:outputText value="单据业务类型:"></h:outputText>
								</td>
								<td>
									<h:selectOneMenu id="buty" value="#{saleReturnMB.mbean.buty}">
										<f:selectItems value="#{saleReturnMB.butys}" />
									</h:selectOneMenu>
								</td>
								<td>
									<h:outputText value="来源单据业务类型:"></h:outputText>
								</td>
								<td>
									<h:selectOneMenu id="soty" value="#{saleReturnMB.mbean.soty}"
										onchange="change()">
										<f:selectItem itemLabel="无" itemValue="" />
										<f:selectItems value="#{saleReturnMB.sotys}" />
									</h:selectOneMenu>
								</td>
								
							</tr>
							 
							<tr id="st1" >
								<td>
									<h:outputText value="销售退货计划单号:"></h:outputText>
								</td>
								<td>
									<h:inputText id="soco" styleClass="datetime"
										value="#{saleReturnMB.mbean.soco}"
										style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									<img id="whid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectformvoucherid();" />
								</td>
							</tr>
							
							<tr id="st2" style="display: none;">
								<td>
									<h:outputText value="销售退货收货单号:"></h:outputText>
								</td>
								<td>
									<h:inputText id="socos" styleClass="datetime"
										value="#{saleReturnMB.mbean.socos}"
										style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									<img id="whid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectformvoucherid();" />
								</td>
							</tr>
							<tr>
								<td>
									<h:outputText value="经手人:"></h:outputText>
								</td>
								<td>
									<h:inputText id="opna" styleClass="datetime"
										value="#{saleReturnMB.mbean.opna}" size="20" />
									<img id="emp_img" style="cursor: hand"
										src="../../images/find.gif" onclick="selectCheckuserid();" />
								</td>
								<td>
									<h:outputText value="备注:"></h:outputText>
								</td>
								<td colspan="5">
									<h:inputText id="rema" styleClass="datetime"
										value="#{saleReturnMB.mbean.rema}" size="80" />
								</td>
							</tr>
						</table>
					</a4j:outputPanel>
				</div>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{saleReturnMB.msg}" />
					</a4j:outputPanel>
				</div>
			</h:form>
		</f:view>
	</body>
</html>