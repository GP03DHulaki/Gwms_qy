<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ include file="../../include/include_imp.jsp"%>

<html>
	<head>
		<title>新增盘点计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="新增盘点计划">
		<link href="../../gwall/all.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script src="stockplan.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
	</head>
	<div id="mydiv"
		style="width: 190px; height: 30px; bgcolor: #efefef; display: none;">
		<img src="../../images/indicator.gif" width="16" height="16" />
		<b><font color="white">正在处理，请稍等...</font> </b>
	</div>
	<body onLoad="clearhead();" id="mmain_body">
		<f:view>
			<h:form id="edit">
				<div id="mmain_nav">
					<font color="#000000">库内处理</font>&gt;&gt;
					<font color="#000000"><a id="linkid" href="stockplan.jsf"
						class="return" title="返回">盘点</a>&gt;&gt;</font>
					<b>添加盘点计划单</b>
				</div>
				<div id="mmain_opt">
					<a4j:commandButton onmouseover="this.className='a4j_over'"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
						id="addId" value="保存" type="button" rendered="#{stockPlanMB.ADD}"
						onclick="if(!addHead()){return false};" reRender="messageId"
						oncomplete="endAddHead();" requestDelay="50" action="#{stockPlanMB.addHead}"/>
				</div>
				<div id="mmain_cnd">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td bgcolor="#efefef">
								<h:outputText value="盘点计划单:"/>
							</td>
							<td>
								<a4j:outputPanel id="id">
									<h:inputText id="vc_voucherid" styleClass="datetime"
										value="自动生成"
										style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
								</a4j:outputPanel>
							</td>
							<td bgcolor="#efefef">
								<h:outputText value="盘点类型:"  />
							</td>
							<td>
								<h:selectOneMenu id="nv_fromvoucher"
									style="width:80px;readonly:expression(this.readOnly=true);color:#7f7f7f;"
									value="" disabled="true" onchange="valueChange();"
									styleClass="selectItem">
									<f:selectItem itemLabel="盘点计划" itemValue="01" />
								</h:selectOneMenu>
							</td>
							<td>
								过账时间:
							</td>
							<td>
								<h:inputText id="gddt" styleClass="datetime"
									value="#{stockPlanMB.mbean.gddt}"
									onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});" />
							</td>
						</tr>
						<tr>
							<td bgcolor="#efefef">
								<h:outputText value="盘点仓库:" />
							</td>
							<td>
								<h:inputText id="whna" styleClass="datetime"
									value="#{stockPlanMB.mbean.whna}" disabled="true" />
								<h:inputHidden id="waho" value="#{stockPlanMB.mbean.whid}" />
								<img id="whid_img" style="cursor: pointer"
									src="../../images/find.gif" onclick="selectWaho();" />
							</td>

							<td bgcolor="#efefef">
								<h:outputText value="盘点方式:" />
							</td>
							<td>
								<h:selectOneMenu id="pmmt" style="width:90px;"
									value="#{stockPlanMB.mbean.pmmt}" onchange="valueChange();"
									styleClass="selectItem">
									<f:selectItem itemLabel="按库位盘点" itemValue="01" />
									<f:selectItem itemLabel="按商品盘点" itemValue="02" />
								</h:selectOneMenu>
							</td>
							<td bgcolor="#efefef">
								<h:outputText value="库存调整方式:"/>
							</td>
							<td>
								<h:selectOneMenu id="rsmt" value="#{stockPlanMB.mbean.rsmt}"
									styleClass="selectItem">
									<f:selectItem itemLabel="盘点计划调整" itemValue="01" />
									
								</h:selectOneMenu>
							</td>
						</tr>
						<%--
							<td bgcolor="#efefef">
								<h:outputText value="盘点仓库:" />
							</td>
							<td>
								<h:inputText id="vc_storehouseid" size="12"
									value="#{checkPlanMB.bean.vc_storehouseid}"
									styleClass="datetime" />
								<h:graphicImage style="cursor:pointer" url="../../images/find.gif"
									onclick="selectStorehouse();" />
							</td>
							<td bgcolor="#efefef">
								<h:outputText value="库位跨度:" />
							</td>
							<td>
								<h:inputText id="in_warespan" styleClass="datetime"
									onkeypress="return isInteger(event);" onchange="textChange(this);"
									value="#{checkPlanMB.bean.in_warespan}" size="5" />
							</td>
							--%>
						<tr id="warehouse">
							<td bgcolor="#efefef" valign="top">
								<h:outputText value="盘点库位:" />
							</td>
							<td colspan="7">
								<h:inputTextarea id="vc_warehouseid"
									value="#{stockPlanMB.mbean.item}" cols="108" rows="4" />
								<h:graphicImage id="warehouseImg" style="cursor:pointer"
									url="../../images/find.gif"
									onclick="if(!selectWarehouse()){return false;};" />
							</td>
						</tr>
						<tr id="inventory" style="display: none;">
							<td bgcolor="#efefef" valign="top">
								<h:outputText value="盘点商品:" />
							</td>
							<td colspan="7">
								<h:inputTextarea id="vc_invcode" value="#{stockPlanMB.mbean.invcode}" cols="108" rows="4" />
								<h:graphicImage id="invcodeImg" style="cursor:pointer"
									url="../../images/find.gif" onclick="selectWarehouse();" />
							</td>
						</tr>
						<tr id="users">
							<td bgcolor="#efefef" valign="top">
								<h:outputText value="操作人:" />
							</td>
							<td colspan="7">
								<h:inputTextarea id="opna"
									value="#{stockPlanMB.mbean.opna}" cols="108" rows="3" />
								<h:graphicImage id="userImg" style="cursor:pointer"
									url="../../images/find.gif" onclick="return selectUser();" />
							</td>
						</tr>
						<tr>
							<td bgcolor="#efefef">
								<h:outputText value="备注:">
								</h:outputText>
							</td>
							<td colspan="7">
								<h:inputText id="rema" styleClass="datetime"
									value="#{stockPlanMB.mbean.rema}" size="108" />
							</td>
						</tr>
					</table>
				</div>
				<a4j:outputPanel id="messageId">
					<h:inputHidden id="msg" value="#{stockPlanMB.msg}" />
					<h:inputHidden id="orid" value="#{sessionScope.orid}"></h:inputHidden>
				</a4j:outputPanel>
			</h:form>
		</f:view>
	</body>
</html>
