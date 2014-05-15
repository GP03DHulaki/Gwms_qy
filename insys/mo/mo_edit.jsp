<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.page import="javax.faces.context.FacesContext" />
<jsp:directive.page import="javax.faces.el.ValueBinding" />
<%@ page import="com.gwall.view.CrbmMB"%><%@ include file="../../include/include_imp.jsp" %>
<html>
	<head>
		<title>编辑生产工单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="编辑生产工单">
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gwalldate.js'></script>
		<script src="mo.js"></script>
	</head>
	<%
		FacesContext context = FacesContext.getCurrentInstance();
		ValueBinding binding = context.getApplication().createValueBinding("#{crbmMB}");
		CrbmMB mb = (CrbmMB)binding.getValue(context);
		String biid = "";
		if (request.getParameter("biid") != null) {
			biid = request.getParameter("biid").toString();
			mb.setBean(biid);
		}
	%>
	<body onLoad="">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;订单&gt;&gt;</font><b>编码生产订单</b>
		</div>
		<div id="mmain">
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:outputPanel id="output">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="javascript:window.location.href='mo_add.jsf'"/>
							<a4j:outputPanel rendered="#{crbmMB.bean.checkVoucher}">
								<a4j:commandButton onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									id="updateId" value="修改表头" type="button" action=""
									onclick=""
									reRender="messageId,output,tableId" oncomplete=""
									requestDelay="50" rendered="false"/>
								<a4j:commandButton onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									id="delId" value="删除单据" type="button" 
									onclick="startDelete();" action="#{crbmMB.deleteItem}" 
									oncomplete="endDelete();" reRender="messageId" requestDelay="50"/>
								<a4j:commandButton onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									id="approveId" value="审核单据" type="button" action=""
									onclick=""
									reRender="messageId,output,detailId,outputTable"
									oncomplete="" requestDelay="50" rendered="false"/>
								</a4j:outputPanel>
								<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
									onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>

					<div id="mmain_cnd">
						<a4j:outputPanel id="outputTable">
							<table>
								<tr>
									<td bgcolor="#efefef">
										订单编号:
									</td>
									<td colspan="3">
										<h:inputText id="biid" styleClass="datetime"
											value="#{crbmMB.bean.biid}" disabled="true" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										单据类型:
									</td>
									<td>
										<h:selectOneMenu id="flag" value="#{crbmMB.bean.flag}"
											style="width:126px" disabled="true">
											<f:selectItem itemLabel="普通工单" itemValue="0" />
											<f:selectItem itemLabel="重工工单" itemValue="1" />
										</h:selectOneMenu>
									</td>
									<td bgcolor="#efefef">
										单据状态：
									</td>
									<td>
										<h:selectOneMenu id="stat" value="#{crbmMB.bean.stat}"
											style="width:126px">
											<f:selectItem itemLabel="有效" itemValue="0" />
											<f:selectItem itemLabel="注销" itemValue="1" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										供应商名称：
									</td>
									<td>
										<h:inputText id="ceve" styleClass="datetime"
											value="#{crbmMB.bean.ceve}" disabled="true"/>
										<h:inputHidden id="hceve" value="#{crbmMB.bean.ceve}" />
										<h:inputHidden id="suid" value="#{crbmMB.bean.suid}" />
										<img id="suidimg" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectSuin();" />
									</td>
									<td bgcolor="#efefef">
										库位号：
									</td>
									<td>
										<h:inputText id="whid" styleClass="datetime"
											value="#{crbmMB.bean.whid}" disabled="true"/>
										<h:inputHidden id="hwhid" value="#{crbmMB.bean.whid}" />
										<img id="whidimg" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectWaho();" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										产品编码:
									</td>
									<td>
										<h:inputText id="prco" styleClass="datetime"
											value="#{crbmMB.bean.prco}" disabled="true"/>
										<h:inputHidden id="hprco" value="#{crbmMB.bean.prco}" />
										<img id="prcoimg" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectInve();" />
									</td>
									<td bgcolor="#efefef">
										投产数量:
									</td>
									<td>
										<h:inputText id="prnu" styleClass="datetime"
											value="#{crbmMB.bean.prnu}" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										生产时间:
									</td>
									<td>
										<h:inputText id="pddt" styleClass="datetime"
											value="#{crbmMB.bean.pddt}"
											onfocus="#{gmanage.datePicker};" />
									</td>
									<td bgcolor="#efefef">
										到货时间:
									</td>
									<td>
										<h:inputText id="indt" styleClass="datetime"
											value="#{crbmMB.bean.indt}"
											onfocus="#{gmanage.datePicker};" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="3">
										<h:inputText id="rema" styleClass="datetime"
											value="#{crbmMB.bean.rema}" size="65" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="messageId">
						<h:inputHidden id="msg" value="#{crbmMB.msg}"></h:inputHidden>
					</a4j:outputPanel>
					<h:inputHidden id="nv_username" value=""></h:inputHidden>
					<h:inputHidden id="vc_userid" value=""></h:inputHidden>
				</h:form>
			</f:view>
		</div>
	</body>
</html>