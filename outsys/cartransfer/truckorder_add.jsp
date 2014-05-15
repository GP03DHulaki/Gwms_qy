<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>出库计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" src="truckorder.js"></script>
	</head>
	<body id=mmain_body">
		<div id=mmain>
			<f:view>
				<h:form id="list">
				<div id=mmain_nav>
					<a id="linkid" href="truckorder.jsf" class="return" title="返回">出库处理</a>&gt;&gt;<b>添加装车计划</b><br>
				</div>
				<div id=mmain_opt>
					<a4j:commandButton onmouseover="this.className='a4j_over'" 
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
						id="addId" value="保存" type="button" 
						action="#{carTransferMB.addHead}"
						onclick="if(!addHead()){return false};" reRender="msg,main"
						 requestDelay="50" oncomplete="endADD();"
						 rendered="#{carTransferMB.ADD}"/>
						  
						
				</div>
				<div id=mmain_cnd>
					<a4j:outputPanel id="main">
						<table cellpadding="3" cellspacing="0" border="0">
							<tr>
								<td>
									装车计划:
								</td>
								<td>
									<h:inputText id="biid" styleClass="inputtext" size="16"  
										style="readonly:expression(this.readOnly=true);color:#A0A0A0;"
										value="自动生成" />
								</td>
								<td>
									来源类型:
								</td>
								<td>
									<h:selectOneMenu id="soty"
											value="#{truckOrderMB.soty}"
											onchange="valuechanger();" >
											<f:selectItem itemLabel="销售订单" itemValue="OUTORDER" />
										  	<f:selectItem itemLabel="调拨计划" itemValue="TRANPLAN" /> 
										</h:selectOneMenu>	
								</td>
								<td>
									物流商:
								</td>
								<td>
									<h:inputText id="lpna" styleClass="datetime"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;"
											value="#{carTransferMB.lpna}" />
										<h:inputHidden id="lpco" value="#{carTransferMB.lpco}" />
										<img id="suid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectLpco();" />
								</td>
							</tr>
							<tr>
								<td valign="top">
									备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
								</td>
								<td colspan="9">
									<h:inputText size="90" id="rema" styleClass="inputtext"
										value="#{carTransferMB.rema}"/>
								</td>
							</tr>
						</table>
					</a4j:outputPanel>
				</div>
				<h:inputHidden id="msg" value="#{carTransferMB.msg}"></h:inputHidden>
			    <h:inputHidden id="vc_storehouseid" value=""></h:inputHidden>
				<div style="display: none">
					<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
						oncomplete="javascript:window.location.href='outplan_edit.jsf'"
						style="display:none;" />	
				</div>
				<%--
				<td>
					仓库:
				</td>
				<td>
					<h:inputText id="nv_storehousename" styleClass="inputtext" size="12" 
						value=""
						style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
				</td>
				
				--%>
			</h:form>	
			</f:view>
		</div>
	</body>
</html>