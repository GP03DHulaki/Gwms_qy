<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="javax.faces.el.ValueBinding"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>ASN单</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="ASN单">
	<meta http-equiv="description" content="ASN单">
	<script type="text/javascript" src="asn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
</head>
  
<body id="mmain_body" onload="initAdd();">
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;<a href="asn.jsf" title="返回" class="return">ASN单</a>&gt;&gt;</font><b>添加ASN单</b><br></div>
	<f:view>
	<div id="mmain">
	<h:form id="edit">
	<div id=mmain_opt>
		<a4j:commandButton onmouseover="this.className='a4j_over'" rendered="#{asnMB.ADD}"
			onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
			id="addId" value="保存" type="button" action="#{asnMB.addHead}"
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
							value="#{asnMB.mbean.biid}" disabled="true"/>	
					</td>
					<td>
						<h:outputText value="入库仓库:"></h:outputText>
					</td>
					<td>
						<h:inputText id="whna" styleClass="datetime"
							value="#{asnMB.mbean.whna}" disabled="true"/>
						<h:inputHidden id="whid" value="#{asnMB.mbean.whid}"/>	
						<img id="whid_img" style="cursor: pointer"
								src="../../images/find.gif" onclick="selectWaho();" />		
					</td>
					<td>
						<h:outputText value="组织架构:"></h:outputText>
					</td>
					<td>
						<h:inputText id="orna" styleClass="datetime"
							value="#{asnMB.mbean.orna}" disabled="true"/>
						<h:inputHidden id="orid" value="#{asnMB.mbean.orid}"/>	
						<img id="orid_img" style="cursor: pointer"
								src="../../images/find.gif" onclick="selectOrga();" />	
					</td>
				</tr>
				<tr>
					<td>
						<h:outputText value="供应商名称:"></h:outputText>
					</td>
					<td>
						<h:inputText id="suna" styleClass="datetime"
							style="readonly:expression(this.readOnly=true);color:#A0A0A0;"
							value="#{asnMB.mbean.suna}"/>
						<h:inputHidden id="suid" value="#{asnMB.mbean.suid}"/>	
						<img id="suid_img" style="cursor: pointer"
								src="../../images/find.gif" onclick="selectSuin();" />
					</td>
					<td>
						<h:outputText value="预计到货时间:"></h:outputText>
					</td>
					<td>
						<h:inputText id="indt" styleClass="datetime"
							value="#{asnMB.mbean.indt}"  onfocus="#{gmanage.datePicker}"/>
					</td>
				</tr>
				<tr>
					<td>
						<h:outputText value="备注:"></h:outputText>
					</td>
					<td colspan="5">
						<h:inputText id="rema" styleClass="datetime"
							value="#{asnMB.mbean.rema}" size="80" />
					</td>
				</tr>
			</table>
		</a4j:outputPanel>
		</div>
		<div style="display: none;">
			<a4j:outputPanel id="renderArea">
				<h:inputHidden id="msg" value="#{asnMB.msg}" />
			</a4j:outputPanel>
		</div>
	</h:form>
	</f:view>
</body>
</html>