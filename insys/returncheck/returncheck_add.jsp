<%@ page language="java" pageEncoding="utf-8"%><%@ include file="../../include/include_imp.jsp" %>
<html>
	<head>
		<title>质检返修单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="返修单">
		<script type="text/javascript" src="returncheck.js"></script>

	</head>

	<body id="mmain_body" onload="initAdd();">
		<f:view>
			<h:form id="edit">
				<div id=mmain>
					<div>
						<a id="linkid" href="returncheck.jsf" class="return" title="返回">质检返修单</a>
						>>添加返修单
					</div>
					<div id=mmain_opt>
						<a4j:commandButton id="addId" value="保存"
							onclick="if(headCheck()){}else{return false};"
							action="#{returncheckMB.addHead}" reRender="msg"
							oncomplete="endAddHead();" onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<div id=mmain_cnd>
						<table>
							<tr>
								<td >
									<h:outputText value="返修单号:"></h:outputText>
								</td>
								<td>
									<h:inputText id="biid" styleClass="datetime"
										value="自动生成" disabled="true"/>	
								</td>								
							</tr>
							<tr>
								<td>
									检验员工号:
								</td>
								<td>
									<h:inputText id="vc_checkuserid"
										value="#{returncheckMB.mbean.crus}" styleClass="datetime"
										size="20" onkeypress="formsubmit_saveHead(event);"
										 />
									<img id="emp_img" style="cursor: pointer;"
										src="../../images/find.gif" onclick="selectCheckuserid();" />
								</td>
							</tr>
							<tr>
								<td>
									供应商名称:
								</td>
								<td>
									<h:inputText id="suna" styleClass="datetime"
										style="readonly:expression(this.readOnly=true);color:#A0A0A0;"
										value="#{returncheckMB.mbean.suna}" />
									<h:inputHidden id="suid" value="#{returncheckMB.mbean.suid}" />
									<img id="suid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectSuin();" />
								</td>								
							</tr>
							<tr>
								<td>
									备注:
								</td>
								<td colspan="2">
									<h:inputText id="rema" styleClass="datetime"
										value="#{returncheckMB.mbean.rema}" size="70" />
								</td>
							</tr>
						</table>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{returncheckMB.msg}"></h:inputHidden>
							<h:inputHidden id="rename" value="" />
							<h:inputHidden id="nv_checkusername" value="#{returncheckMB.mbean.crna}" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>
