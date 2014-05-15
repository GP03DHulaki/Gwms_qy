<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<title>添加到货检验单</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="添加到货检验单">
	<meta http-equiv="description" content="添加到货检验单">
	<script type="text/javascript" src="iqc.js"></script>

</head>
  
<body id="mmain_body" onLoad="clearText();">
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;入库&gt;&gt;</font><b>添加到货检验单</b><br></div>
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
						<h:outputText value="到货检验单号:"></h:outputText>
					</td>
					<td>
						<h:inputText id="vc_voucherid" styleClass="datetime"
							value="" disabled="true"/>	
					</td>
					<td>
						<a4j:outputPanel rendered="true" >
							<h:outputText value="到货检验类型:"></h:outputText>
						</a4j:outputPanel>
					</td>
					<td>
						<a4j:outputPanel rendered="true" >
						<h:selectOneMenu id="vc_operatetype" value="" 
								onchange = "onclose();">
							<f:selectItem itemLabel="采购" itemValue="01" />
							<f:selectItem itemLabel="ASN" itemValue="02" />
							<f:selectItem itemLabel="生产" itemValue="03" />
						</h:selectOneMenu>
						</a4j:outputPanel>
					</td>
					<td>
						<h:outputText value="订单号:"></h:outputText>
					</td>
					<td>
						<h:inputText id="nv_fromvoucherid" styleClass="datetime"
							value=""/>
						<h:graphicImage url="../../images/find.gif"
							onclick="selectObj1('selectPurApp.jsf');"
							style='cursor:pointer'></h:graphicImage>
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