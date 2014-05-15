<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>新增盘点操作单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="添加盘点操作单">
		<script src="stockopt.js"></script>
	</head>
	<div id="mydiv"
		style="width: 190px; height: 30px; bgcolor: #efefef; display: none;">
		<img src="../../images/indicator.gif" width="16" height="16" />
		<b><font color="white">正在处理,请稍等...</font> </b>
	</div>
	<div id="mmain_nav">
		<font color="#000000"> <a id="linkid" href="stockopt.jsf"
			class="return" title="返回">库内处理</a>&gt;&gt;</font>
		<font color="#000000">盘点&gt;&gt;</font>
		<b>添加盘点操作单</b>
	</div>
	<body onLoad="showMes_add()" id="mmain_body">
		<f:view>
			<h:form id="edit">

				<div id="mmain_opt">
					<a4j:commandButton onmouseover="this.className='a4j_over'"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
						id="addId" value="保存" type="button" rendered="#{stockOptMB.ADD}"
						action="#{stockOptMB.addHead}"
						onclick="if(!headCheck()){return false};" reRender="messageId,id"
						oncomplete="endDo();" requestDelay="50" />
				</div>
				<div id="mmain_cnd">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td bgcolor="#efefef">
								<h:outputText value="盘点操作单:" />
							</td>
							<td>
								<a4j:outputPanel id="id">
									<h:inputText id="vc_voucherid" styleClass="datetime"
										value="自动生成" size="12"
										style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
								</a4j:outputPanel>
							</td>
							<td bgcolor="#efefef">
								<h:outputText value="盘点计划单:" />
							</td>
							<td>
								<h:inputText id="nv_fromvoucherid" styleClass="datetime"
									value="#{stockOptMB.mbean.pbid}" style="readonly:expression(this.readOnly=true);" />
								<h:graphicImage style="cursor:pointer" url="../../images/find.gif"
									onclick="selectfromvoucherid();" />
							</td>
							<td bgcolor="#efefef">
								<h:outputText value="盘点货位:" />
							</td>
							<td>
								<h:inputText id="vc_warehouseid" value="#{stockOptMB.mbean.whid}" styleClass="datetime"
									 />
								<h:graphicImage style="cursor:pointer" url="../../images/find.gif"
									onclick="selectWhousehouse();" />
							</td>
						</tr>
						<tr>
							<td bgcolor="#efefef" valign="top">
								<h:outputText value="备注:" />
							</td>
							<td colspan="5">
								<h:inputText id="nv_remark" styleClass="datetime" value="#{stockOptMB.mbean.rema}"
									size="90" />
							</td>
						</tr>
					</table>
				</div>
				<a4j:outputPanel id="messageId">
					<h:inputHidden id="msg" value="#{stockOptMB.msg}"></h:inputHidden>
				</a4j:outputPanel>
			</h:form>
		</f:view>
	</body>
</html>
