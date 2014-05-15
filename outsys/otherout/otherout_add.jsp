<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>其它出库单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="其它出库单">
		<meta http-equiv="description" content="其它出库单">
		<script type="text/javascript" src="otherout.js"></script>
	</head>

	<body id="mmain_body" onload="initAdd();">
		<div id="mmain_nav">
			<a id="linkid" href="otherout.jsf" class="return" title="返回">出库处理</a>&gt;&gt;
			<b>添加其它出库单</b>
			<br>
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton id="addId" value="保存" type="button"
							rendered="#{otherOutMB.ADD}"
							onclick="if(!addHead()){return false};"
							action="#{otherOutMB.addHead}" requestDelay="50"
							oncomplete="endAddHead();" reRender="msg,showHead"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="showHead">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="单据单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{otherOutMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="业务类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="dety" value="#{otherOutMB.mbean.dety}"
											style="width:130px;">
											<f:selectItems value="#{otherOutMB.butys}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="组织架构:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="orid1" value="#{otherOutMB.mbean.orid}" >
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="出库仓库:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="whid" value="#{otherOutMB.mbean.whid}"
											style="width:130px;">
											<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
										</h:selectOneMenu>
										<%-- 
										<h:inputText id="whna" styleClass="datetime"
											value="#{otherOutMB.mbean.whna}" disabled="true" />
										<h:inputHidden id="whid" value="#{otherOutMB.mbean.whid}" />
										<img id="whid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectWaho();" />
										--%>
									</td>
									<td>
										经&nbsp;&nbsp;手&nbsp;人:
									</td>
									<td >
										<h:inputText id="nv_checkusername" styleClass="inputtext" size="20"
											value="#{otherOutMB.mbean.opna}" />
										<img id="emp_img" style="cursor: hand"
										src="../../images/find.gif" onclick="selectCheckuserid();" />
									</td>
									<td>
										来&nbsp;源&nbsp;单&nbsp;号:
									</td>
									<td>
										<h:inputText id="soco" styleClass="inputtext" size="20"
											value="#{otherOutMB.mbean.soco}" />
										<img id="emp_img" style="cursor: pointer;"
										src="../../images/find.gif" onclick="selectOtherOutSoco();" />
									</td>
								</tr>
								<tr>
									<td>
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											value="#{otherOutMB.mbean.rema}" size="90" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<h:inputHidden id="orid" value="#{sessionScope['orid']}" />
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{otherOutMB.msg}" />
							<h:inputHidden id="vc_checkuserid" value="" />
						</a4j:outputPanel>
					</div>
				</h:form>
		</f:view>
	</body>
</html>