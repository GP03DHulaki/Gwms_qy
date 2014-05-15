<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="com.gwall.pojo.stockin.CpbDBean"%>
<%@page import="com.gwall.pojo.stockin.CpbMBean"%><%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.PurchaseMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>添加预约</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="添加预约">
	<script type="text/javascript" src="purchase.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
</head>
<body id="mmain_body" onload="initAdd();">
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;<a href="purchase.jsf" class="return" title="返回">采购预约</a>&gt;&gt;</font><b>添加采购预约</b><br></div>
	<f:view>
	<div id="mmain">
	<h:form id="edit">
	<div id=mmain_opt>
		<a4j:commandButton onmouseover="this.className='a4j_over'" rendered="#{purchaseMB.ADD}"
			onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
			id="addId" value="保存" type="button" action="#{purchaseMB.addHead}"
			reRender="msg,showHead,vc_voucherid" onclick="if(!addHead()){return false};"
			oncomplete="endAddHead();" requestDelay="50" />
			
	</div>
		<div id=mmain_cnd>
		<a4j:outputPanel id="showHead">
			<table border="0" cellspacing="0" cellpadding="3">
				<tr>
					<td >
						<h:outputText value="预约单号:"></h:outputText>
					</td>
					<td>
						<h:inputText id="biid" styleClass="datetime"
							value="#{purchaseMB.mbean.biid}" disabled="true"/>	
					</td>
					<td >
						<h:outputText value="是否紧急:"></h:outputText>
					</td>
					<td>
						<h:selectOneMenu id="tales" value="#{purchaseMB.mbean.tale}">
							<f:selectItems value="#{purchaseMB.tales}" />
						</h:selectOneMenu>
					</td>
				</tr>
				<tr>
				<td>
						<h:outputText value="供应商名称:"></h:outputText>
				</td>
				<td>
						<h:inputText id="suna" styleClass="datetime"
							style="readonly:expression(this.readOnly=true);color:#A0A0A0;"
							value="#{purchaseMB.mbean.suna}"  />
						<h:inputHidden id="suid" value="#{purchaseMB.mbean.suid}"/>	
						<img id="suid_img" style="cursor: pointer"
								src="../../images/find.gif" onclick="selectSuin();" />
				</td>
				<td>
						<h:outputText value="预约到货时间:"></h:outputText>
				</td>
				<td>
						<h:inputText id="pcdt" styleClass="datetime" size="13"
							value="#{purchaseMB.mbean.pcdt}"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH'});"/>时
				</td>
				</tr>
				<tr>
					<td>
						<h:outputText value="备注:"></h:outputText>
					</td>
					<td colspan="5">
						<h:inputText id="rema" styleClass="datetime"
							value="#{purchaseMB.mbean.rema}" size="80" />
					</td>
				</tr>
			</table>
		</a4j:outputPanel>
		</div>
		<div style="display: none;">
			<a4j:outputPanel id="renderArea">
				<h:inputHidden id="msg" value="#{purchaseMB.msg}" />
			</a4j:outputPanel>
		</div>
	</h:form>
	</div>
	</f:view>
</body>
</html>