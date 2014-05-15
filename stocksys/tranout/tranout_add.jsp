<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>添加调拨出库单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="添加调拨出库单">
		<script type="text/javascript" src="tranout.js"></script>
	</head>
	<body id='mmain_body'>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id='mmain_nav'>
						<div id="mmain_nav">
							<font color="#000000"> 库内处理 &gt;&gt;<a id="linkid" href="tranout.jsf"
								class="return" title="返回">调拨出库</a>&gt;&gt;</font><b>添加调拨出库单</b>
							<br>
						</div>
					</div>
					<div id='mmain_opt'>
						<gw:GAjaxButton rendered="#{tranOutMB.ADD}" theme="a_theme"
							id="addId" value="保存" type="button" action="#{tranOutMB.addHead}"
							reRender="msg" onclick="if(!addHead()){return false};"
							oncomplete="endDo();" requestDelay="50" />
					</div>
					<div id='mmain_cnd'>
						<a4j:outputPanel id="main">
							<table cellpadding="4" cellspacing="0" border="0">
								<tr>
									<td>
										调拨出库单:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext" size="20"
											value="#{tranOutMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
									</td>
									<td>
										来源类型:
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{tranOutMB.mbean.soty}"
											style="width:130px;" onchange="changeFrom();">
											<f:selectItem itemLabel="调拨计划" itemValue="TRANPLAN" />
											<f:selectItem itemLabel="无" itemValue="" />
											</h:selectOneMenu>
									</td>
									<td>
										<span id="soco_td"> 来源单号: <h:inputText id="soco"
												size="20" styleClass="inputtext"
												value="#{tranOutMB.mbean.soco}"
												style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
											<img id="suid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectFrom();" /> </span>
									</td>
									<td>
									过账时间:
									</td>
									<td>
										<h:inputText id="gddt" styleClass="datetime"
											value="#{tranOutMB.mbean.gddt}"
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});" />
									</td>
								</tr>
								<tr>
									<td>
										经&nbsp;&nbsp;&nbsp;手&nbsp;&nbsp;&nbsp;人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											value="#{tranOutMB.mbean.opna}" />
									</td>
									<td colspan="4" id="whid_td">
										出库仓库:
										<h:inputText id="fwna" size="20" styleClass="inputtext"
											value="#{tranOutMB.mbean.fwna}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
										<img id="owid_img" style="cursor: pointer;display:none;"
											src="../../images/find.gif" 
											onclick="return selectWaho('edit:pfwh','edit:fwna');" />
										入库仓库:
										<h:inputText id="owna" size="20" styleClass="inputtext"
											value="#{tranOutMB.mbean.owna}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
										<img id="iwid_img" style="cursor: pointer;display:none;"
											src="../../images/find.gif"
											onclick="return selectWaho('edit:powh','edit:owna');" />
									</td>
								</tr>
								<tr>
									<td>
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="inputtext" size="95"
											value="#{tranOutMB.mbean.rema}" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<h:inputHidden id="msg" value="#{tranOutMB.msg}" />
					<h:inputHidden id="orid" value="#{tranOutMB.mbean.orid}" />
					<h:inputHidden id="pfwh" value="#{tranOutMB.mbean.pfwh}" />
					<h:inputHidden id="powh" value="#{tranOutMB.mbean.powh}" />
				</h:form>
			</f:view>
		</div>
	</body>
</html>