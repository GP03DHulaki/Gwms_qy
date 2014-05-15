<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>添加出库单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="添加出库单">
		<script type="text/javascript" src="stockout.js"></script>
		<script type="text/javascript">
			var urlmap = hashMap;
			urlmap.Set('OUTORDER','../../common/outorder_sel/outorder_sel.jsf?retvid=edit:soco&retorid=edit:orid');
			urlmap.Set('ENTRUCKPLAN','../../common/etrucplan_sel/etrucplan_sel.jsf?retvid=edit:soco&retorid=edit:orid&srcmodu=OUTORDER');
		</script>
	</head>
	<body id='mmain_body' onload="cleartext();">
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id='mmain_nav'>
						<a id="linkid" href="stockout.jsf" class="return" title="返回">出库处理</a>&gt;&gt;
						<b>添加出库单</b>
						<br>
					</div>
					<div id='mmain_opt'>
						<gw:GAjaxButton rendered="#{stockOutMB.ADD}" theme="a_theme"
							id="addId" value="保存" type="button"
							action="#{stockOutMB.addHead}" reRender="msg,main"
							onclick="if(!addHead()){return false};" oncomplete="endDo();"
							requestDelay="50" />
					</div>
					<div id='mmain_cnd'>
						<a4j:outputPanel id="main">
							<table cellpadding="3" cellspacing="0" border="0">
								<tr>
									<td>
										出库单号:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext" size="20"
											value="#{stockOutMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
									</td>
									<td>
										来源类型:
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{stockOutMB.mbean.soty}"
											style="width:130px;">
											<f:selectItem itemLabel="出库订单" itemValue="OUTORDER" />
											<%-- 
											<f:selectItem itemLabel="装车计划" itemValue="ENTRUCKPLAN"/>
											--%>
										</h:selectOneMenu>
									</td>
									<td>
										来源单号:
									</td>
									<td>
										<h:inputText id="soco" size="20" styleClass="inputtext"
											value="#{stockOutMB.mbean.soco}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
										<img id="suid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectFrom();" />
									</td>
								</tr>
								<tr>
									<td>
										出库仓库:
									</td>
									<td>
										<h:selectOneMenu id="whid" value="#{stockOutMB.mbean.whid}"
											style="width:130px;">
											<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
										</h:selectOneMenu>
										<%-- 
										<h:inputText id="whna" styleClass="inputtext" size="20"
											value="#{stockOutMB.mbean.whna}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
										<h:inputHidden id="whid" value="#{stockOutMB.mbean.whid}" />
										<img id="whid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="return selectWaho();" />
										--%>
									</td>
									<td>
										经手人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											value="#{stockOutMB.mbean.opna}" />
										<img id="emp_img" style="cursor: pointer;" src="../../images/find.gif" onclick="selectuser();" />
									</td>
									<td>
										过账时间:
									</td>
									<td>
										<h:inputText id="gddt" styleClass="datetime"
											value="#{stockOutMB.mbean.gddt}"
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});" />
									</td>
								</tr>
								<tr>
									<td>
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="inputtext" size="95"
											value="#{stockOutMB.mbean.rema}" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<h:inputHidden id="msg" value="#{stockOutMB.msg}" />
					<h:inputHidden id="orid" value="#{stockOutMB.mbean.orid}" />
				</h:form>
			</f:view>
		</div>
	</body>
</html>