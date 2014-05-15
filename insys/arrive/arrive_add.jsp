<%@ page language="java" pageEncoding="UTF-8"%><%@ include
	file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>添加采购到货单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="添加采购到货单">
		<meta http-equiv="description" content="添加采购到货单">
		<script type="text/javascript" src="arrive.js"></script>
	</head>
	<body id="mmain_body" onLoad="clearText();">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;<a href="arrive.jsf"
				title="返回" class="return">入库</a>&gt;&gt;</font><b>添加采购到货单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id="mmain_opt">
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="addId" value="保存" type="button"
							action="#{purchaseArrvicMB.addHead}"
							onclick="if(!headAdd()){return false};"
							reRender="input,renderArea" oncomplete="endHeadAdd();"
							requestDelay="50" rendered="#{purchaseArrvicMB.ADD}" />
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="input">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="采购到货单:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime" value="自动生成"
											disabled="true" />
									</td>
									<td>
										<h:outputText value="单据类型:" />
									</td>
									<td>
										<h:selectOneMenu id="dety"
											value="#{purchaseArrvicMB.mbean.dety}">
											<f:selectItems value="#{purchaseArrvicMB.detys}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="来源类型:" />
									</td>
									<td>
										<h:selectOneMenu id="soty"
											value="#{purchaseArrvicMB.mbean.soty}">
											<f:selectItem itemLabel="到货通知" itemValue="NoticeOfArrive" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="来源单号:"></h:outputText>
									</td>
									<td oncontextmenu="return(false);" onpaste="return false">
										<%--style="readonly:expression(this.readOnly=true);color:#7f7f7f;" 
										<f:selectItems value="#{purchaseArrvicMB.sotys}" />--%>
										<h:inputText id="soco" styleClass="datetime"
											onclick="this.blur();" onkeypress="return false;"
											style="color:#7f7f7f;" value="#{purchaseArrvicMB.mbean.soco}" />
										<img id="suidimg" style="cursor: pointer;"
											src="../../images/find.gif" onclick="selectSoco();" ; />
									</td>
									<%-- 
									<td>
										<h:outputText value="到货存放仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whid" styleClass="datetime"
											value="#{purchaseArrvicMB.mbean.whid}" />
										<h:inputHidden id="whna" value="" />
										<img id="suidimg" style="cursor: pointer;"
											src="../../images/find.gif" onclick="selectWaho();" />
									</td>
									--%>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="nv_remark" styleClass="datetime"
											value="#{purchaseArrvicMB.mbean.rema}" size="90" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{purchaseArrvicMB.msg}" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>