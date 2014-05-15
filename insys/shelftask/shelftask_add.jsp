<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="javax.faces.el.ValueBinding"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<title>添加上架任务单</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="添加上架任务单">
	<meta http-equiv="description" content="添加上架任务单">
	<script type="text/javascript" src="shelftask.js"></script>
</head>

<body id="mmain_body" onLoad="clearText();">
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;上架&gt;&gt;</font><b>添加上架任务</b><br></div>
	<f:view>
	<h:form id="edit">
	<div id="mmain">
		<div id=mmain_opt>
			<a4j:commandButton onmouseover="this.className='a4j_over'"
				onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
				id="addId" value="保存" type="button" action=""
				onclick="if(!headAdd()){return false};" reRender="input,renderArea"
				oncomplete="endHeadAdd();" requestDelay="50" rendered="true" />
		</div>
		<div id=mmain_cnd>
		<a4j:outputPanel id="input">
			<table border="0" cellspacing="0" cellpadding="3">
				<tr>
					<td >
						<h:outputText value="单据单号:"></h:outputText>
					</td>
					<td>
						<h:inputText id="vc_voucherid" styleClass="datetime"
							value="" disabled="true"/>	
					</td>
				
				</tr>
				<tr>
					<td>
						<h:outputText value="备注:"></h:outputText>
					</td>
					<td colspan="3">
						<h:inputText id="nv_remark" styleClass="datetime"
							value="" size="65"/>
					</td>
				</tr>
			</table>
		</a4j:outputPanel>
		</div>
		<div style="display: none;">
			<a4j:outputPanel id="renderArea">
				<h:inputHidden id="msg" value="" />
			</a4j:outputPanel>
		</div>
	</div>
	</h:form>
	</f:view>
</body>
</html>