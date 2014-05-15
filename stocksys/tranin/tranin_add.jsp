<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<title>添加调拨入库单</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="添加调拨入库单">
	<meta http-equiv="description" content="添加调拨入库单">
	<script type="text/javascript" src="tranin.js"></script>

</head>
  
<body id="mmain_body" onLoad="initAdd();">
	<div id="mmain_nav"><font color="#000000">库内处理&gt;&gt;<a id="linkid" href="tranin.jsf"
								class="return" title="返回">调拨入库</a>&gt;&gt;</font><b>添加调拨入库单</b><br></div>
	<f:view>
	<h:form id="edit">
	<div id="mmain">
		<div id=mmain_opt>
			<a4j:commandButton onmouseover="this.className='a4j_over'" rendered="#{traninMB.ADD}"
				onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
				id="addId" value="保存" type="button" action="#{traninMB.addHead}"
				reRender="msg,showHead,vc_voucherid" onclick="if(!addHead()){return false};"
				oncomplete="endAddHead();" requestDelay="50" />
		</div>
		<div id=mmain_cnd>
		<a4j:outputPanel id="input">
			<table border="0" cellspacing="0" cellpadding="3">
				<tr>
					<td >
						<h:outputText value="调拨入库单号:"></h:outputText>
					</td>
					<td>
						<h:inputText id="biid" styleClass="datetime"
							value="#{traninMB.mbean.biid}" style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />	
					</td>
					<td>
						来源类型:
					</td>
					<td>
						<h:selectOneMenu id="soty" value="#{traninMB.mbean.soty}" 
							style="width:130px;">
							<f:selectItem itemLabel="调拨计划" itemValue="TRANPLAN"/>
						</h:selectOneMenu>
					</td>
					<td>
					过账时间:
					</td>
					<td>
						<h:inputText id="gddt" styleClass="datetime"
							value="#{traninMB.mbean.gddt}"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});" />
					</td>
				</tr>
				<tr>
					<td>
						经手人:
					</td>
					<td>
						<h:inputText id="opna" styleClass="inputtext" size="20"
							value="#{traninMB.mbean.opna}" />
					</td>
					<td>
						<h:outputText value="来源单号:"></h:outputText>
					</td>
					<td>
						<h:inputText id="soco" styleClass="datetime"
							value="#{traninMB.mbean.soco}"  style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
						<img id="orid_img" style="cursor: pointer"
								src="../../images/find.gif" onclick="selectSoco();" />	
					</td>
				</tr>
				<tr>
					<td>
						<h:outputText value="备注:"></h:outputText>
					</td>
					<td colspan="3">
						<h:inputText id="rema" styleClass="datetime"
							value="#{traninMB.mbean.rema}" size="80" />
					</td>
				</tr>
			</table>
		</a4j:outputPanel>
		</div>
		<div style="display: none;">
			<a4j:outputPanel id="renderArea">
				<h:inputHidden id="msg" value="#{traninMB.msg}" />
				<h:inputHidden id="pfwh" value="#{traninMB.mbean.pfwh}" />
				<h:inputHidden id="powh" value="#{traninMB.mbean.powh}" />
			</a4j:outputPanel>
		</div>
	</div>
	</h:form>
	</f:view>
</body>
</html>