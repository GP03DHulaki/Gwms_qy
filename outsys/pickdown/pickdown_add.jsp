<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<title>添加拣货下架单</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="添加拣货下架单">
	<meta http-equiv="description" content="添加拣货下架单">
	<script type="text/javascript" src="pickdown.js"></script>

</head>
  
<body id="mmain_body" onLoad="initAdd();">
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;备货处理&gt;&gt;</font><b>添加拣货下架单</b><br></div>
	<f:view>
	<h:form id="edit">
	<div id="mmain">
		<div id=mmain_opt>
			<a4j:commandButton onmouseover="this.className='a4j_over'" rendered="#{pickDownMB.ADD}"
				onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
				id="addId" value="保存" type="button" action="#{pickDownMB.addHead}"
				reRender="msg,showHead,vc_voucherid" onclick="if(!addHead()){return false};"
				oncomplete="endAddHead();" requestDelay="50" />
		</div>
		<div id=mmain_cnd>
		<a4j:outputPanel id="input">
			<table border="0" cellspacing="0" cellpadding="3">
				<tr>
					<td >
						<h:outputText value="拣货下架单:"></h:outputText>
					</td>
					<td>
						<h:inputText id="biid" styleClass="datetime"
							value="#{pickDownMB.mbean.biid}" disabled="true"/>	
					</td>
					<td>
						<h:outputText value="来源类型"></h:outputText>
					</td>
					<td>
						<h:selectOneMenu id="soty" value="#{pickDownMB.mbean.soty}" 
							style="width:130px;" onchange="onSoty();">
							<f:selectItem itemLabel="备货任务" itemValue="PICKTASK"/>
							<f:selectItem itemLabel="补货任务" itemValue="shelftask"/>
						</h:selectOneMenu>
					</td>
					<td>
						<h:outputText value="来源单号:"></h:outputText>
					</td>
					<td>
						<h:inputText id="soco" styleClass="datetime"
							value="#{pickDownMB.mbean.soco}" 
							style="readonly:expression(this.readOnly=true);color:#7f7f7f;"/>
						<h:inputHidden id="whid" value="#{pickDownMB.mbean.whid}"></h:inputHidden>
						<img id="pt_img" style="cursor: pointer"
								src="../../images/find.gif" onclick="selectPtma();" />	
						<img id="st_img" style="cursor: pointer"
								src="../../images/find.gif" onclick="selectStma();" />	
					</td>
				</tr>
				<tr id="car">
					<td>
						<h:outputText value="上架车:"></h:outputText>
					</td>
					<td>
						<h:inputText id="wana" styleClass="datetime"
							value="#{pickDownMB.mbean.wana}" disabled="true" />
						<h:inputHidden id="waid" value="#{pickDownMB.mbean.waid}" />
						<img id="whid_img" style="cursor: pointer"
							src="../../images/find.gif" onclick="selectWaid();" />
					</td>
				</tr>
				<tr>
					<td>
						<h:outputText value="备注:"></h:outputText>
					</td>
					<td colspan="3">
						<h:inputText id="rema" styleClass="datetime"
							value="#{pickDownMB.mbean.rema}" size="80" />
					</td>
				</tr>
			</table>
		</a4j:outputPanel>
		</div>
		<div style="display: none;">
			<a4j:outputPanel id="renderArea">
				<h:inputHidden id="msg" value="#{pickDownMB.msg}" />
			</a4j:outputPanel>
			
		</div>
		
	</div>
	</h:form>
	</f:view>
</body>
</html>