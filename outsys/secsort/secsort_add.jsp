<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>添加二次分拣单</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="添加二次分拣单">
	<meta http-equiv="description" content="添加二次分拣单">
	<script type="text/javascript" src="secsort.js"></script>

</head>
  
<body id="mmain_body" onload="initAdd();">
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;备货处理&gt;&gt;</font><b>添加二次分拣单</b><br></div>
	<f:view>
		<h:form id="edit">
		<div id="mmain">
			<div id=mmain_opt>
				<a4j:commandButton onmouseover="this.className='a4j_over'" rendered="#{secsortMB.ADD}"
					onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
					id="addId" value="保存" type="button" action="#{secsortMB.addHead}"
					reRender="msg,showHead,vc_voucherid" onclick="if(!addHead()){return false};"
					oncomplete="endAddHead();" requestDelay="50" />
			</div>
			<div id=mmain_cnd>
			<a4j:outputPanel id="input">
				<table border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td >
							<h:outputText value="二次分拣单:"></h:outputText>
						</td>
						<td>
							<h:inputText id="biid" styleClass="datetime"
								value="#{secsortMB.mbean.biid}" disabled="true"/>	
						</td>
						<td>
							<h:outputText value="来源类型"></h:outputText>
						</td>
						<td>
							<h:selectOneMenu id="soty" value="#{secsortMB.mbean.soty}" style="width:130px;">
								<f:selectItem itemLabel="拣货下架" itemValue="PICKDOWN"/>
							</h:selectOneMenu>
						</td>
						
					</tr>
					<tr>
						<td>
							经手人:
						</td>
						<td>
							<h:inputText id="opna" styleClass="inputtext" 
								value="#{secsortMB.mbean.opna}" />
						</td>
						<td>
							<h:outputText value="来源单号:"></h:outputText>
						</td>
						<td>
							<h:inputText id="soco" styleClass="datetime"
								value="#{secsortMB.mbean.soco}" 
								style="readonly:expression(this.readOnly=true);color:#7f7f7f;"/>
							<h:inputHidden id="whid" value="#{secsortMB.mbean.whid}"></h:inputHidden>
							<img id="orid_img" style="cursor: pointer"
									src="../../images/find.gif" onclick="selectPkma();" />	
						</td>
					</tr>
					<tr>
						<td>
							<h:outputText value="备注:"></h:outputText>
						</td>
						<td colspan="3">
							<h:inputText id="rema" styleClass="datetime"
								value="#{secsortMB.mbean.rema}" size="80" />
						</td>
					</tr>
				</table>
			</a4j:outputPanel>
			</div>
			<div style="display: none;">
				<a4j:outputPanel id="renderArea">
					<h:inputHidden id="msg" value="#{secsortMB.msg}" />
				</a4j:outputPanel>
			</div>
		</div>
		</h:form>
	</f:view>
</body>
</html>