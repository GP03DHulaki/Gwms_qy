<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<html>
	<head>
		<title>检验单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="检验单">
		<script src="check.js"></script>

	</head>

	<body id="mmain_body" onload="initAdd();">
		<f:view>
			<h:form id="edit">
				<div id=mmain>
					<div>
						<a id="linkid" href="check.jsf" class="return" title="返回">检验单</a>
						>>添加检验单
					</div>
					<div id=mmain_opt>
						<a4j:commandButton id="addId" value="保存"
							onclick="if(headCheck()){}else{return false};"
							action="#{checkMB.addHead}" reRender="msg"
							oncomplete="endAddHead();" onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<div id=mmain_cnd>
						<table border="0">
							<tr>
								<td >
									<h:outputText value="检验单号:"></h:outputText>
								</td>
								<td colspan="3">
									<h:inputText id="biid" styleClass="datetime"
										value="#{checkMB.mbean.biid}" disabled="true"/>	
								</td>								
							</tr>
							<tr>
								<td>
									检验员工号:
								</td>
								<td>
									<h:inputText id="vc_checkuserid"
										value="#{checkMB.mbean.opna}" styleClass="datetime"
										size="20" onkeypress="formsubmit_saveHead(event);"
										 />
									<img id="emp_img" style="cursor: pointer;"
										src="../../images/find.gif" onclick="selectCheckuserid();" />
								</td>
								<td>
									来源单号:
								</td>
								<td>
									<h:inputText id="soco" styleClass="datetime" 
											value="#{checkMB.mbean.soco}" />
									<img id="suidimg" style="cursor: pointer;"
										src="../../images/find.gif" onclick="selectSoco();" ; />
								</td>				
							</tr>
							<tr>
								<td>
									备注:
								</td>
								<td colspan="3">
									<h:inputText id="rema" styleClass="datetime"
										value="#{checkMB.mbean.rema}" size="70" />
								</td>
							</tr>
						</table>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{checkMB.msg}"></h:inputHidden>
							<h:inputHidden id="rename" value="" />
							<h:inputHidden id="nv_checkusername" value="" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>
