<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="javax.faces.el.ValueBinding"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>生产入库单</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="生产入库单">
	<meta http-equiv="description" content="生产入库单">
	<script type="text/javascript" src="moin.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
</head>
  
<body id="mmain_body" onload="initAdd();">
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;<a href="moin.jsf" title="返回" class="return">入库</a>&gt;&gt;</font><b>添加生产入库单</b><br></div>
	<f:view>
	<div id="mmain">
	<h:form id="edit">
	<div id=mmain_opt>
		<a4j:commandButton onmouseover="this.className='a4j_over'" rendered="#{moinMB.ADD}"
			onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
			id="addId" value="保存" type="button" action="#{moinMB.addHead}"
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
							value="#{moinMB.mbean.biid}" disabled="true"/>	
					</td>
					<td>
						来源类型:
					</td>
					<td>
						<h:selectOneMenu id="soty" value="#{moinMB.mbean.soty}" 
							style="width:130px;">
							<f:selectItem itemLabel="生产包装计划" itemValue="MOPLAN"/>
						</h:selectOneMenu>
					</td>
					<td>
						来源单号:
					</td>
					<td>
						<h:inputText id="soco" size="20" styleClass="inputtext"
							value="#{moinMB.mbean.soco}"
							style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
						<img id="suid_img" style="cursor: pointer"
							src="../../images/find.gif" onclick="selectFrom();" />
					</td>
				</tr>
				<tr>
					<td>
						<h:outputText value="入库仓库:"></h:outputText>
					</td>
					<td>
						<h:inputText id="whna" styleClass="datetime"
							value="#{moinMB.mbean.whna}" disabled="true"/>
						<h:inputHidden id="whid" value="#{moinMB.mbean.whid}"></h:inputHidden>
					</td>
					<td>
						<h:outputText value="送货人:"></h:outputText>
					</td>
					<td>
						<h:inputText id="opna" styleClass="datetime"
							value="#{moinMB.mbean.opna}" />
					</td>
					<td>
						<h:outputText value="入库类型:"></h:outputText>
					</td>
					<td>
							<h:selectOneMenu id="dety" value="#{moinMB.mbean.dety}"
											disabled="true">
							<f:selectItems value="#{moinMB.butys}" />
							</h:selectOneMenu>
					</td>
				</tr>
				
				<tr>
					<td>
						<h:outputText value="备注:"></h:outputText>
					</td>
					<td colspan="5">
						<h:inputText id="rema" styleClass="datetime"
							value="#{moinMB.mbean.rema}" size="80" />
					</td>
				</tr>
			</table>
		</a4j:outputPanel>
		</div>
		<div style="display: none;">
			<a4j:outputPanel id="renderArea">
				<h:inputHidden id="msg" value="#{moinMB.msg}" />
			</a4j:outputPanel>
		</div>
	</h:form> 
	</f:view>
</body>
</html>