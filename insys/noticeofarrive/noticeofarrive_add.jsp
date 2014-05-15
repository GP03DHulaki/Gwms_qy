<%@ page language="java" pageEncoding="UTF-8"%><%@ include
	file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>添加到货通知单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="添加到货通知单">
		<meta http-equiv="description" content="添加到货通知单">
		<script type="text/javascript" src="noticeofarrive.js"></script>
	</head>
	<body id="mmain_body" onLoad="clearText();">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;<a href="noticeofarrive.jsf"
				title="返回" class="return">入库</a>&gt;&gt;</font><b>添加到货通知单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id="mmain_opt">
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="addId" value="保存" type="button"
							action="#{noticeOfArriveMB.addHead}"
							onclick="if(!headAdd()){return false};"
							reRender="input,renderArea" oncomplete="endHeadAdd();"
							requestDelay="50" rendered="#{noticeOfArriveMB.ADD}" />
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="input">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="到货通知单:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime" value="自动生成"
											disabled="true" />
									</td>
									<td>
										是否质检:
									</td>
									<td>
										<h:selectOneMenu id="isch"
											value="#{noticeOfArriveMB.mbean.isch}">
											<f:selectItem itemLabel="否" itemValue="0" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="入库仓库:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="whid" value="#{noticeOfArriveMB.mbean.whid}"
											style="width:130px;">
											<f:selectItems value="#{warehouseMB.wareList}" />
										</h:selectOneMenu>
									</td> 
									
									
								</tr>
								<tr>
								<td>
										供应商名称:
									</td>
									<td>
										<h:inputText id="suna" styleClass="datetime"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;"
											value="#{noticeOfArriveMB.mbean.suna}" />
										<h:inputHidden id="suid" value="#{noticeOfArriveMB.mbean.suid}" />
										<img id="suid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectSuin();" />
									</td>
									<td>
										预计到货时间:
									</td>
									<td>
										<h:inputText id="indt" styleClass="datetime"
											value="#{noticeOfArriveMB.mbean.indt}"
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" />
									</td>	
									<td>
										<h:outputText value="批次号:"></h:outputText>
									</td>
									<td oncontextmenu="return(false);" onpaste="return false">
										<h:inputText id="bato" styleClass="datetime"
											style="color:#7f7f7f;" value="#{noticeOfArriveMB.mbean.bato}" />
									</td>
									
									
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="nv_remark" styleClass="datetime"
											value="#{noticeOfArriveMB.mbean.rema}" size="75" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{noticeOfArriveMB.msg}" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>