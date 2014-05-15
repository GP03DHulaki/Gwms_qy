<%@ page language="java" pageEncoding="UTF-8"%><%@ include
	file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>添加采购入库单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="添加采购入库单">
		<meta http-equiv="description" content="添加采购入库单">
		<script type="text/javascript" src="poin.js"></script>

	</head>

	<body id="mmain_body" onLoad="initAdd();">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;<a href="poin.jsf"
				class="return" title="返回">入库</a>&gt;&gt;</font><b>添加采购入库单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							rendered="#{poinMB.ADD}" onmouseout="this.className='a4j_buton'"
							styleClass="a4j_but" id="addId" value="保存" type="button"
							action="#{poinMB.addHead}"
							reRender="msg,showHead,vc_voucherid,input,whid"
							onclick="if(!addHead()){return false};"
							oncomplete="endAddHead();" requestDelay="50" />
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="input">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="采购入库单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{poinMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="来源类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{poinMB.mbean.soty}"
											style="width:130px;">
											<f:selectItem itemLabel="入库任务" itemValue="intask" />
											<%--<f:selectItem itemLabel="质检单" itemValue="check" />--%>
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="来源单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="soco" styleClass="datetime"
											value="#{poinMB.mbean.soco}" />
										<img id="orid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectSoco();" />
									</td>
								</tr>
								<tr>
								
									<td>
										<h:outputText value="入库仓库:"></h:outputText>
									</td>
									<td>
	                                   <h:inputText id="whid" styleClass="datetime"
	                                   disabled="true" size="20" />
									     <h:inputHidden id="whid_h"  value="#{poinMB.mbean.whid}"  />
									</td> 
									<td>
										<h:outputText value="经手人:"></h:outputText>
									</td>
									<td>
										<h:inputText id="opna" styleClass="datetime"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;"
											value="#{poinMB.mbean.opna}" size="20" />
										<img id="emp_img" style="cursor: pointer;"
											src="../../images/find.gif" onclick="selectuser();" />
									</td>
									<td>
										过账时间:
									</td>
									<td>
										<h:inputText id="gddt" styleClass="datetime"
											value="#{poinMB.mbean.gddt}"
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="3">
										<h:inputText id="rema" styleClass="datetime"
											value="#{poinMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{poinMB.msg}" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>