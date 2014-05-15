<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.view.PickTaskMB"%>
<%@ page import="javax.faces.model.SelectItem"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	String id = "";
	PickTaskMB ai = (PickTaskMB) MBUtil.getManageBean("#{pickTaskMB}");
	if (request.getParameter("isAll") != null) {
		SelectItem item = new SelectItem("", "");
		ArrayList list = new ArrayList();
		list.add(item);
		ai.setWhidlist(null);
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>添加备货任务单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="添加备货任务单">
		<meta http-equiv="description" content="添加备货任务单">
		<script type="text/javascript" src="picktask.js"></script>
	</head>

	<body id="mmain_body" onLoad="initAdd();">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;备货处理&gt;&gt;</font><b>添加备货任务单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							rendered="#{pickTaskMB.ADD}"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="addId" value="保存" type="button"
							action="#{pickTaskMB.addHead}"
							reRender="msg,showHead,vc_voucherid"
							onclick="if(!addHead()){return false};"
							oncomplete="endAddHead();" requestDelay="50" />
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="input">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="备货入库单:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{pickTaskMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="来源类型"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{pickTaskMB.mbean.soty}"
											style="width:130px;">
											<f:selectItem itemLabel="备货计划" itemValue="ENTRUCKPLAN" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="来源单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="soco" styleClass="datetime"
											value="#{pickTaskMB.mbean.soco}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
										<h:inputHidden id="orid" value="#{pickTaskMB.mbean.orid}"></h:inputHidden>
										<img id="orid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectLtma();" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="任务优先级:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="tale" value="#{pickTaskMB.mbean.tale}">
											<f:selectItems value="#{pickTaskMB.tales}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="任务执行人:"></h:outputText>
									</td>
									<td>
										<h:inputText id="sina" styleClass="datetime"
											value="#{pickTaskMB.mbean.sina}" />
										<h:inputHidden id="sius" value="#{pickTaskMB.mbean.sius}" />
										<img id="orid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectUser();" />
									</td>
									<td>
										<h:outputText value="仓库:"></h:outputText>
									</td>
									<td>
										<a4j:outputPanel id="showWaho">
											<h:selectOneMenu id="whid" value="#{pickTaskMB.mbean.whid}">
												<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
											</h:selectOneMenu>
										</a4j:outputPanel>
									</td>

								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="3">
										<h:inputText id="rema" styleClass="datetime"
											value="#{pickTaskMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{pickTaskMB.msg}" />
						</a4j:outputPanel>
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							rendered="#{pickTaskMB.ADD}"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="getWaho" value="刷新" type="button" reRender="showWaho"
							requestDelay="50" />
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>