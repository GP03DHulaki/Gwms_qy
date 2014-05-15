<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@ page import="com.gwall.view.stock.ShelvesTaskMB"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>采购订单</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="采购订单">
	<meta http-equiv="description" content="采购订单">
	<link href="../../css/style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/Gwallwin.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/Gbase.js"></script>
	<script type="text/javascript" src="po.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
</head>
  
<body id="mmain_body" onload="initAdd();">
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;<a href="po.jsf" class="return" title="返回">订单</a>&gt;&gt;</font><b>添加采购订单</b><br></div>
	<f:view>
	<div id="mmain">
	<h:form id="edit">
	<div id=mmain_opt>
		<a4j:commandButton onmouseover="this.className='a4j_over'" rendered="#{pubmMB.ADD}"
			onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
			id="addId" value="保存" type="button" action="#{pubmMB.addHead}"
			reRender="msg,showHead,vc_voucherid" onclick="if(!addHead()){return false};"
			oncomplete="endAddHead();" requestDelay="50" />
	</div>
		<div id=mmain_cnd>
		<a4j:outputPanel id="showHead">
			<table border="0" cellspacing="0" cellpadding="3">
				<tr>
					<td >
						<h:outputText value="单据单号:"></h:outputText>
					</td>
					<td>
						<h:inputText id="biid" styleClass="datetime"
							value="#{pubmMB.mbean.biid}" disabled="true"/>	
					</td>
					<td>
						<h:outputText value="入库仓库:"></h:outputText>
					</td>
					<td>
						<h:inputText id="whna" styleClass="datetime"
							value="#{pubmMB.mbean.whna}" disabled="true"/>
						<h:inputHidden id="whid" value="#{pubmMB.mbean.whid}"/>	
						<img id="whid_img" style="cursor: hand"
								src="../../images/find.gif" onclick="selectWaho();" />		
					</td>
					<td>
						组织架构:
					</td>
					<td>
						<h:selectOneMenu id="orna" value="#{pubmMB.mbean.orid}">
							<f:selectItems value="#{OrgaMB.subList}" />
						</h:selectOneMenu>
					</td>
				</tr>
				<tr>
					<td>
						<h:outputText value="任务执行人:"></h:outputText>
					</td>
					<td>
						<h:inputText id="sina" styleClass="datetime"
							value="#{pubmMB.mbean.sina}" 
							/>
						<h:inputHidden id="sius" value="#{pubmMB.mbean.sius}"/>	
						<img id="orid_img" style="cursor: hand"
								src="../../images/find.gif" onclick="selectUser();" />	
					</td>
				</tr>
				<tr>
					<td>
						<h:outputText value="采购时间:"></h:outputText>
					</td>
					<td>
						<h:inputText id="pudt" styleClass="datetime"
							value="#{pubmMB.mbean.pudt}"  onfocus="#{gmanage.datePicker}"/>
					</td>
					<td>
						<h:outputText value="采购类型:"></h:outputText>
					</td>
					<td>
						<h:selectOneMenu id="buty" value="#{pubmMB.mbean.buty}" >
							<f:selectItems value="#{pubmMB.butys}"/>
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
							value="#{pubmMB.mbean.suna}"/>
						<h:inputHidden id="suid" value="#{pubmMB.mbean.suid}"/>	
						<img id="suid_img" style="cursor: hand"
								src="../../images/find.gif" onclick="selectSuin();" />
					</td>
					
					<td>
						<h:outputText value="预计到货时间:"></h:outputText>
					</td>
					<td>
						<h:inputText id="indt" styleClass="datetime"
							value="#{pubmMB.mbean.indt}"  onfocus="#{gmanage.datePicker}"/>
					</td>
				</tr>
				<tr>
					<td>
						<h:outputText value="备注:"></h:outputText>
					</td>
					<td colspan="5">
						<h:inputText id="rema" styleClass="datetime"
							value="#{pubmMB.mbean.rema}" size="80" />
					</td>
				</tr>
			</table>
		</a4j:outputPanel>
		</div>
		<div style="display: none;">
			<a4j:outputPanel id="renderArea">
				<h:inputHidden id="msg" value="#{pubmMB.msg}" />
			</a4j:outputPanel>
		</div>
	</h:form>
	</f:view>
</body>
</html>