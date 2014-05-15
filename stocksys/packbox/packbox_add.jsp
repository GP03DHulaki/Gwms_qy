<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<html>
	<head>
		<title>新增装箱单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="添加拼盘单">
		<script src="packbox.js"></script>
	</head>
	<div id="mydiv"
		style="width: 190px; height: 30px; bgcolor: #efefef; display: none;">
		<img src="../../images/indicator.gif" width="16" height="16" />
		<b><font color="white">正在处理,请稍等...</font> </b>
	</div>
	<div id="mmain_nav">
		<font color="#000000"> <a id="linkid" href="packbox.jsf"
			class="return" title="返回">库内处理</a>&gt;&gt;</font>
		<font color="#000000">装箱&gt;&gt;</font>
		<b>添加装箱单</b>
	</div>
	<body onLoad="showMes_add()" id="mmain_body">
		<f:view>
			<h:form id="edit">
				<span style="position: absolute; color: #7f7f7f;" id='explain'
					onclick="hiddenSpan(explain);"> 不填则系统自动生成 </span>
				<div id="mmain_opt">
					<a4j:commandButton onmouseover="this.className='a4j_over'"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
						id="addId" value="保存" type="button" rendered="#{packBoxMB.ADD}"
						action="#{packBoxMB.addHead}"
						onclick="if(!headCheck()){return false;}" reRender="messageId,msg"
						oncomplete="endDo();" requestDelay="50" />
				</div>

				<div id="mmain_cnd">
					<table cellpadding="2" cellspacing="2" border="0">
						<tr>
							<td>
								<h:outputText value="装箱单号:" />
							</td>
							<td>
								<a4j:outputPanel id="id">
									<h:inputText id="vc_voucherid" styleClass="datetime"
										value="自动生成"
										style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
								</a4j:outputPanel>
							</td>
							<td>
								<h:outputText value="装箱类型:" />
							</td>
							<td>
								<h:selectOneMenu id="soty" value="#{packBoxMB.mbean.dety}"
									onchange="hiddenSoco(this);" style="width:130px;">
									<f:selectItem itemLabel="质检装箱" itemValue="01" />
									<f:selectItem itemLabel="库内装箱" itemValue="02" />
									<f:selectItem itemLabel="库外装箱" itemValue="03" />
								</h:selectOneMenu>
							</td>
							<td id='td_soco'>
								来源单号:
								<h:inputText id="soco" value="#{packBoxMB.mbean.soco}"
									styleClass="datetime" />
								<h:graphicImage style="cursor:pointer;"
									url="../../images/find.gif" onclick="selectSoco();" />
							</td>
						</tr>
						<tr>
							<td>
								箱&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:
							</td>
							<td>
								<h:inputText id="boco" styleClass="datetime"
									onclick="hiddenSpan('explain');"
									value="#{packBoxMB.mbean.boco}" />
								<h:graphicImage style="cursor:pointer;"
									url="../../images/find.gif"
									onclick="hiddenSpan('explain');selectPaco();" />
							</td>
							<td>
								仓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;库:
							</td>
							<td>
								<h:selectOneMenu id="whid" value="#{packBoxMB.mbean.whid}"
									style="width:130px;">
									<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
								</h:selectOneMenu>
							</td>
						</tr>
						<tr>
							<td valign="top">
								备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
							</td>
							<td colspan="3">
								<h:inputText id="nv_remark" styleClass="datetime"
									value="#{packBoxMB.mbean.rema}" size="68" />
							</td>
						</tr>
					</table>
				</div>
				<a4j:outputPanel id="messageId">
					<h:inputHidden id="orid" value="#{packBoxMB.orids}"></h:inputHidden>
					<h:inputHidden id="msg" value="#{packBoxMB.msg}"></h:inputHidden>
				</a4j:outputPanel>
				<%-- 	
				<td>
					<h:inputHidden id="whid" value="#{packBoxMB.mbean.whid}"></h:inputHidden>
					<h:inputText id="whna" styleClass="datetime" />
					<h:graphicImage style="cursor:hand" url="../../images/find.gif"
								onclick="selectWaho();" />
				</td>
				<tr>
					<td>
						<h:outputText value="货位条码:"></h:outputText>
					</td>
					<td>
						<h:inputText id="whid" styleClass="datetime"
							value="#{packBoxMB.mbean.whid}" />
						<img id="whid_img" style="cursor: hand"
							src="../../images/find.gif" onclick="selectWahod();" />
					</td>
				</tr>
				--%>
			</h:form>
		</f:view>
	</body>
</html>
