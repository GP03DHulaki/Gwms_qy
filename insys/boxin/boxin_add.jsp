<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>添加入库装箱单</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="其它入库单">
<meta http-equiv="description" content="其它入库单">
<script type="text/javascript" src="boxin.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
	
</head>

<body id="mmain_body" onload="initAdd();">
	<div id="mmain_nav">
		<font color="#000000">入库处理&gt;&gt;<a href="boxin.jsf"
			title="返回" class="return">入库</a>&gt;&gt;</font><b>添加入库装箱单</b> <br>
	</div>
	<f:view>
		<div id="mmain">
			<h:form id="edit">
				<div id="mmain_opt">
					<a4j:commandButton onmouseover="this.className='a4j_over'"
						rendered="#{boxInMB.ADD}" onmouseout="this.className='a4j_buton'"
						styleClass="a4j_but" id="addId" value="保存" type="button"
						action="#{boxInMB.addHead}" reRender="msg,showHead"
						onclick="if(!addHead()){return false};" oncomplete="endAddHead();"
						requestDelay="50" />
				</div>
				<div id="mmain_cnd">
					<a4j:outputPanel id="showHead">
						<table border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td><h:outputText value="单据单号:"></h:outputText></td>
								<td><h:inputText id="biid" styleClass="inputtext"
										value="#{boxInMB.mbean.biid}" disabled="true" /></td>
								<td><h:outputText value="来源单号:"></h:outputText></td>
								<td><h:inputText id="soco" styleClass="inputtext"
										value="#{boxInMB.mbean.soco}"  ></h:inputText>
									<img id="invsrid_img1"
									style="cursor: pointer" src="../../images/find.gif"
									onclick="selectSoco();" />
								</td>
										
								<td><h:outputText value="物流编码:"></h:outputText></td>
								<td>
									<h:inputText id="inco" styleClass="inputtext"
											value="#{boxInMB.mbean.inco}" disabled="false" />
										<img id="invsrid_img2"
										style="cursor: pointer" src="../../images/find.gif"
										onclick="selectInco();" />
								</td>

							</tr>
							<tr>
								<td><h:outputText value="数量:"></h:outputText></td>
								<td>
									<h:inputText id="qty" styleClass="inputtext" value="#{boxInMB.mbean.qty}">
									</h:inputText>
								</td>
								<td><h:outputText value="备注:"></h:outputText></td>
								<td colspan="5"><h:inputText id="rema"
										styleClass="inputtext" value="#{boxInMB.mbean.rema}" size="80" ></h:inputText>
								</td>
							</tr>
						</table>
					</a4j:outputPanel>
				</div>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{boxInMB.msg}" />
					</a4j:outputPanel>
				</div>
			</h:form>
	</f:view>
</body>
</html>