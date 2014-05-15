<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.OutOrderMB"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%
	OutOrderMB ai = (OutOrderMB) MBUtil.getManageBean("#{outOrderMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>退货计划明细导入</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="gwall">
		<meta http-equiv="description" content="退货计划明细导入">
		<script type="text/javascript" src="outorder.js"></script>
	</head>

	<body id='mmain_body'>
		<div id='mmain_nav'>
			<a id="linkid" href="outorder.jsf" class="return" title="返回">出库处理</a>&gt;&gt;
			<b>退货计划明细导入</b>
			<br>
		</div>
		<div id='mmain'>
			<f:view>
				<h:form id="edit" enctype="multipart/form-data">
					<div>
						<font color="red" size="3">注：导入的文件类型必须为XLS，文件大小必须小于5MB。</font>
					</div>
					<br />
					<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
						value="#{outOrderMB.upFile}" required="true" size="75" />
					<div id="mes"></div>
					<div id='mmain_opt'>
						<gw:GAjaxButton theme="a_theme" id="doImp" value="确定"
							type="button" onclick="return doImport();"
							oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
							action="#{outOrderMB.search}" />
						<gw:GAjaxButton value="返回" theme="a_theme" onclick="backList();" />
					</div>
					<div style="display: none;">
						<h:commandButton value="上传" id="importBut"
							action="#{returnPlanMB.importExcel}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>