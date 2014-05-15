<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>移库单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="移库单">
		<meta http-equiv="description" content="移库单">
		<script type="text/javascript" src="move.js"></script>
	</head>

	<body id="mmain_body" onload="initAdd();">
		<div id="mmain_nav">
			<font color="#000000">库内处理&gt;&gt;<a id="linkid"  href="move.jsf" title="返回" class="return">移库</a>&gt;&gt;</font><b>添加移库单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain_opt">
					<a4j:commandButton onmouseover="this.className='a4j_over'"
						rendered="#{shiftLibraryMB.ADD}"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
						id="addId" value="保存" type="button"
						action="#{shiftLibraryMB.addHead}"
						reRender="msg,showHead,vc_voucherid"
						onclick="if(!addHead()){return false};" oncomplete="endAddHead();"
						requestDelay="50" ></a4j:commandButton>
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
									<h:outputText value="移库仓库:"></h:outputText>
								</td>
								<td>
									<h:inputText id="whna" styleClass="datetime"
										value="#{shiftLibraryMB.mbean.whna}" disabled="true" />
									<h:inputHidden id="whid" value="#{shiftLibraryMB.mbean.whid}" />
									<img id="whid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectWaho();" />
								</td>
								<!--  								
								<td>
									<h:outputText value="业务类型:"></h:outputText>
								</td>
								<td>
									<h:selectOneMenu id="buty" value="#{shiftLibraryMB.mbean.buty}">
										<f:selectItems value="#{shiftLibraryMB.butys}" />
									</h:selectOneMenu>
								</td>
								-->
							</tr>
							<tr>
								<td>
									<h:outputText value="备注:"></h:outputText>
								</td>
								<td colspan="5">
									<h:inputText id="rema" styleClass="datetime"
										value="#{shiftLibraryMB.mbean.rema}" size="80" />
								</td>
							</tr>
						</table>
					</a4j:outputPanel>
				</div>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{shiftLibraryMB.msg}" />
						<h:inputHidden id="orid" value="#{shiftLibraryMB.orid}"></h:inputHidden>
					</a4j:outputPanel>
				</div>
			</h:form>
		</f:view>
	</body>
</html>