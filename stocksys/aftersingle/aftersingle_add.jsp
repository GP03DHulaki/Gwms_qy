<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>添加追单记录</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="添加追单记录">
		<meta http-equiv="description" content="添加追单记录">
		<script type="text/javascript" src="aftersingle.js"></script>
	</head>
	<body id="mmain_body" onLoad="clearText();">
		<div id="mmain_nav">
			<font color="#000000">库内处理&gt;&gt;<a href="aftersingle.jsf"
				title="返回" class="return">追单</a>&gt;&gt;</font><b>添加追单记录</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id="mmain_opt">
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="addId" value="保存" type="button"
							action="#{afterSignleMB.addHead}"
							onclick="if(!headAdd()){return false};"
							reRender="input,renderArea" oncomplete="endHeadAdd();"
							requestDelay="50" rendered="#{afterSignleMB.ADD}" />
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="input">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime" value="自动生成"
											disabled="true" />
									</td>
									<td>
										<h:outputText value="移库车:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whid" styleClass="inputtext" size="20"
											value="#{afterSignleMB.mbean.whid}" />
										<img id="emp_img" style="cursor: pointer;"
											src="../../images/find.gif"
											onclick="selectWhid('9','ALL','edit:whid','')" />
									</td>
									<td>
										经手人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											value="#{afterSignleMB.mbean.opna}" />
										<img id="emp_img" style="cursor: pointer;"
											src="../../images/find.gif" onclick="selectuser();" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											value="#{afterSignleMB.mbean.rema}" size="100" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{afterSignleMB.msg}" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>