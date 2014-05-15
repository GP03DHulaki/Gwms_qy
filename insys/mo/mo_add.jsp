<%@ page language="java" pageEncoding="utf-8"%><%@ include file="../../include/include_imp.jsp" %>
<html>
	<head>
		<title>生产订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="生产订单">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script src="mo.js"></script>
	</head>
	<body onLoad="initAdd();" id="mmain_body">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;订单&gt;&gt;</font>
			<b>添加生产订单</b>
		</div>
		<div id="mmain">
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="addId" value="保存" type="button" action="#{crbmMB.save}"
							onclick="if(!checkAdd()){return false;}" reRender="messageId"
							oncomplete="saveEnd();" requestDelay="50" rendered="true" />
					</div>
					<div id="mmain_cnd">
						<table>
							<tr>
								<td bgcolor="#efefef">
									订单编号:
								</td>
								<td colspan="3">
									<h:inputText id="biid" styleClass="datetime" value="#{crbmMB.bean.biid}"
										disabled="true" />
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									单据类型:
								</td>
								<td colspan="3">
									<h:selectOneMenu id="flag" value="#{crbmMB.bean.flag}" style="width:126px">
										<f:selectItem itemLabel="普通工单" itemValue="0" />
										<f:selectItem itemLabel="重工工单" itemValue="1" />
									</h:selectOneMenu>
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									供应商名称：
								</td>
								<td>
									<h:inputText id="ceve" styleClass="datetime" value="#{crbmMB.bean.ceve}"
										disabled="true" />
									<h:inputHidden id="hceve" value="#{crbmMB.bean.ceve}"/>	
									<h:inputHidden id="suid" value="#{crbmMB.bean.suid}"/>
									<img id="suidimg" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectSuin();" />
								</td>
								<td bgcolor="#efefef">
									库位号：
								</td>
								<td>
									<h:inputText id="whid" styleClass="datetime" value="#{crbmMB.bean.whid}"
										disabled="true" />
									<h:inputHidden id="hwhid" value="#{crbmMB.bean.whid}"/>	
									<img id="whidimg" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectWaho();" />
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									产品编码:
								</td>
								<td>
									<h:inputText id="prco" styleClass="datetime" value="#{crbmMB.bean.prco}"
										disabled="true" />
									<h:inputHidden id="hprco" value="#{crbmMB.bean.prco}"/>	
									<img id="prcoimg" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectInve();" />
								</td>
								<td bgcolor="#efefef">
									投产数量:
								</td>
								<td>
									<h:inputText id="prnu" styleClass="datetime" value="#{crbmMB.bean.prnu}" />
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									生产时间:
								</td>
								<td>
									<h:inputText id="pddt" styleClass="datetime" value="#{crbmMB.bean.pddt}"
										onfocus="#{gmanage.datePicker};" />
								</td>
								<td bgcolor="#efefef">
									到货时间:
								</td>
								<td>
									<h:inputText id="indt" styleClass="datetime" value="#{crbmMB.bean.indt}"
										onfocus="#{gmanage.datePicker};" />
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									<h:outputText value="备注:"></h:outputText>
								</td>
								<td colspan="3">
									<h:inputText id="rema" styleClass="datetime" value="#{crbmMB.bean.rema}" size="65" />
								</td>
							</tr>
						</table>
						<a4j:outputPanel id="messageId">
							<h:inputHidden id="mes" value="#{crbmMB.msg}"></h:inputHidden>
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>