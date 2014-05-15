<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>拆包</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="拆包">
		<script type="text/javascript" src="packout.js"></script>
	</head>
	<body id=mmain_body onload="addClear();">
		<div id=mmain> 
			<f:view>
				<h:form id="edit">
					<div id=mmain_nav>
						<a id="linkid" href="packout.jsf" class="return" title="返回">出库处理</a>&gt;&gt;
						<b>添加拆包单据</b>
						<br>
					</div>
					<div id="mmain_opt">
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="addId" value="保存" type="button"
							action="#{packOutMB.addHead}"
							onclick="if(!headCheck()){return false};" reRender="msg,main"
							requestDelay="50" oncomplete="endDo();"
							rendered="#{packOutMB.ADD}" />

					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="main">
							<table cellpadding="1" cellspacing="1" border="0" >
								<tr>
									<td>
										拆包单号:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;"
											value="自动生成" />
									</td>
									<td>
										来源类型:
									</td>
									<td>
										<h:selectOneMenu id="soty"
											value="#{packOutMB.mbean.soty}"
											onchange="valuechanger();">
											<f:selectItem itemLabel="销售订单" itemValue="OUTORDER" />
										</h:selectOneMenu>

									</td>
									<td>
										来源单号:
									</td>
									<td>
										<h:inputText id="soco" styleClass="inputtext"
											value="#{packOutMB.mbean.soco}" />
										<h:graphicImage id="selectFrom" style="cursor:pointer;"
											url="../../images/find.gif" onclick="selectFromNo();" />
									</td>
								</tr>
								<tr>
									<td valign="top">
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText size="90" id="nv_remark" styleClass="inputtext"
											value="#{packOutMB.mbean.rema}" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<h:inputHidden id="msg" value="#{packOutMB.msg}"></h:inputHidden>
					<h:inputHidden id="vc_storehouseid" value=""></h:inputHidden>
					<div style="display: none">
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							oncomplete="javascript:window.location.href='packout_edit.jsf'"
							style="display:none;" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>