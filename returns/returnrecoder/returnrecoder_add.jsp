<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.ReturnRecodeMB"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>销售退货不合格商品清点</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="销售退货不合格商品清点">
		<meta http-equiv="description" content="销售退货不合格商品清点">
		<script type="text/javascript" src="returnrecoder.js"></script>
	</head>

	<%
		ReturnRecodeMB ai = (ReturnRecodeMB) MBUtil.getManageBean("#{returnRecodeMB}");
	
	%>

	<body id="mmain_body" onload="initAdd();">
		<div id="mmain_nav">
			<font color="#000000">退货处理&gt;&gt;<a id="linkid"
				href="returnrecoder.jsf" title="返回" class="return">不合格商品清点</a>&gt;&gt;</font><b>添加清点单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain_opt">
					<a4j:commandButton onmouseover="this.className='a4j_over'"
						rendered="#{returnRecodeMB.ADD}"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
						id="addId" value="保存" type="button"
						action="#{returnRecodeMB.addHead}"
						reRender="msg,vc_voucherid"
						onclick="if(!addHead()){return false};" oncomplete="endAddHead();"
						requestDelay="50"></a4j:commandButton>
				</div>
				<div id="mmain_cnd">
					<a4j:outputPanel id="showHead">
						<table border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td>
									<h:outputText value="单据单号:"></h:outputText>
								</td>
								<td>
									<h:inputText id="biid" styleClass="datetime" value="自动生成"
										disabled="true" />
								</td>
								<td>
									<h:outputText value="单据类型:"></h:outputText>
								</td>
								<td colspan="3">
									<h:selectOneMenu id="buty" style="width:130px;"
									value="#{returnRecodeMB.mbean.buty}">
										<f:selectItems value="#{returnRecodeMB.butys}" />
									</h:selectOneMenu>
								</td>
							</tr>
							<tr>
							<td>
								<h:outputText value="组织架构:"></h:outputText>
							</td>
							<td>
								<h:inputText id="orna" styleClass="datetime"
									value="#{returnRecodeMB.mbean.orna}" disabled="true" />
								<h:inputHidden id="orid" value="#{returnRecodeMB.mbean.orid}" />
									<img id="orid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectOrga();" />
							</td>
							<td>
								<h:outputText value="清理时间:"></h:outputText>
							</td>
							<td>
								<h:inputText id="stdt" styleClass="datetime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});"
									value="#{returnRecodeMB.mbean.stdt}" />
							</td>						
							</tr>
							<tr>
								<td>
									备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
								</td>
								<td colspan="5">
									<h:inputText id="rema" styleClass="datetime"
										value="#{returnRecodeMB.mbean.rema}" size="97" />
								</td>
							</tr>
						</table>
					</a4j:outputPanel>
				</div>
				<div style="display: none;">
						<h:inputHidden id="msg" value="#{returnRecodeMB.msg}" />
						
						<h:inputHidden id="sellist" value="#{returnRecodeMB.sellist}" />
						<a4j:commandButton id="showMe" value="刷新列表" style="display:none;"
							reRender="showHead" />
				</div>
			</h:form>
		</f:view>
	</body>
</html>