<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>添加理货上架单</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="添加理货上架单">
	<meta http-equiv="description" content="添加理货上架单">
	<script type="text/javascript" src="shelf.js"></script>
</head>
  
<body id="mmain_body" onLoad="clearText();">
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;<a href="shelf.jsf" class="return" title="返回">上架</a>&gt;&gt;</font><b>添加理货上架单</b><br></div>
	<f:view>
	<h:form id="edit">
	<div id="mmain">
		<div id=mmain_opt>
			<a4j:commandButton onmouseover="this.className='a4j_over'"
				onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
				id="addId" value="保存" type="button" action="#{shelvMB.addHead}"
				onclick="if(!headAdd()){return false};" 
				oncomplete="endHeadAdd();" requestDelay="50"
				rendered="#{shelvMB.ADD}" reRender="renderArea,input" />
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
					<td>
						选择来源库位:
					</td>
					<td>
					<h:inputText id="whna" styleClass="datetime" disabled="true"
						value="#{shelvMB.mbean.whna}" />
					<h:inputHidden id='whid' value='#{shelvMB.mbean.whid}'></h:inputHidden>
					<img id="whid_img" style="cursor: pointer"
						src="../../images/find.gif" onclick="selectWaid();" />
					</td>
				</tr>
				<tr>
					<td>
						<h:outputText value="备注:"></h:outputText>
					</td>
					<td colspan="3">
						<h:inputText id="nv_remark" styleClass="datetime"
							value="#{shelvMB.mbean.rema}" size="85"/>
					</td>
				</tr>
			</table>
		</a4j:outputPanel>
		</div>
		<div style="display: none;">
			<a4j:outputPanel id="renderArea">
				<h:inputHidden id="msg" value="#{shelvMB.msg}" />
			</a4j:outputPanel>
		</div>
	</div>
	</h:form>
	</f:view>
</body>
</html>