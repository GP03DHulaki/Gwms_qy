<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.EntruckPlanMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	EntruckPlanMB ai = (EntruckPlanMB) MBUtil
			.getManageBean("#{entruckPlanMB}");
	ai.getVouch();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑备货计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="编辑订单明细">
		<script type="text/javascript" src="entruckplan.js"></script>
	</head>
	<body id=mmain_body onload="initEdit();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_nav>
						<a id="linkid" href="entruckplan.jsf" class="return" title="返回">出库处理</a>
						&gt;&gt;装车处理&gt;&gt;
						<b>编辑备货计划</b>
						<br>
					</div>
					<div style="display: none;">
						<h:inputHidden id="msg" value="#{entruckPlanMB.msg}" />
						<h:inputHidden id="sellist" value="#{entruckPlanMB.sellist}" />
						<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
							reRender="outdetail,headmain" />
						<a4j:commandButton id="showRe" value="刷新全部" style="display:none;"
							reRender="outdetail,headmain" />
					</div>
					<a4j:outputPanel id="headButton">
						<div id=mmain_opt>
							<gw:GAjaxButton theme="b_theme" id="delMBut" value="删除单据"
								type="button" action="#{entruckPlanMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								oncomplete="endDeleteHead();" requestDelay="50"
								reRender="msg,headButton,headmain,detailButton"
								rendered="#{entruckPlanMB.DEL && entruckPlanMB.commitStatus}" />

							<gw:GAjaxButton theme="b_theme" id="updateId" value="保存单据"
								type="button" onclick="if(!addHead()){return false};"
								action="#{entruckPlanMB.updateHead}"
								reRender="msg,headButton,detailButton,headmain,outdetail,orderTable"
								oncomplete="endDo();" requestDelay="50"
								rendered="#{entruckPlanMB.MOD && entruckPlanMB.commitStatus}" />

							<gw:GAjaxButton theme="b_theme"
								rendered="#{entruckPlanMB.APP && entruckPlanMB.commitStatus}"
								id="appMBut" value="审核单据" type="button"
								action="#{entruckPlanMB.approveVouch}"
								onclick="if(!checkApp()){return false};"
								reRender="msg,headButton,detailButton,headmain,outdetail,orderTable"
								oncomplete="endApp();" requestDelay="50" />

							<a4j:commandButton id="sid" value="调整组织架构" size='100'
								styleClass="a4j_but1" onclick="showAdjust();"
								oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
								action="#{entruckPlanMB.search}" rendered="#{false && entruckPlanMB.MOD}" />

						</div>
					</a4j:outputPanel>
					<div id=mmain_cnd>
						<a4j:outputPanel id="headmain">
							<table cellpadding="3" cellspacing="0" border="0">
								<tr>
									<td>
										备货计划:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext" size="20"
											value="#{entruckPlanMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
									</td>
									<td>
										来源类型:
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{entruckPlanMB.mbean.soty}"
											disabled="true" style="width:130px;">
											<f:selectItem itemLabel="出库订单" itemValue="OUTORDER" />
											<f:selectItem itemLabel="调拨计划" itemValue="TRANPLAN" />
											<f:selectItem itemLabel="采购退货" itemValue="PURCHASERETURNPLAN" />
										</h:selectOneMenu>
									</td>
									<td>
										组织架构:
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{entruckPlanMB.mbean.orid}"
											disabled="true">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										分拣方式:
									</td>
									<td>
										<h:selectOneMenu id="bity" style="width:130px;"
											value="#{entruckPlanMB.mbean.bity}" disabled="true">
											<f:selectItem itemLabel="自动分配" itemValue="A" />
											<f:selectItem itemLabel="手动分配" itemValue="H" />
										</h:selectOneMenu>
									</td>
									<td>
										经&nbsp;&nbsp;手&nbsp;人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											disabled="#{!entruckPlanMB.commitStatus}"
											value="#{entruckPlanMB.mbean.opna}" />
									</td>
								</tr>
								<tr>
									<td>
										总&nbsp;&nbsp;体&nbsp;积:
									</td>
									<td>
										<h:inputText id="tavo" styleClass="inputtext" size="20"
											disabled="true" value="#{entruckPlanMB.mbean.tavo}" />
									</td>
									<td>
										总&nbsp;&nbsp;重&nbsp;量:
									</td>
									<td>
										<h:inputText id="tawe" styleClass="inputtext" size="20"
											disabled="true" value="#{entruckPlanMB.mbean.tawe}" />
									</td>
									<td>
										总&nbsp;&nbsp;数&nbsp;量:
									</td>
									<td>
										<h:inputText id="tanu" styleClass="inputtext" size="20"
											disabled="true" value="#{entruckPlanMB.mbean.tanu}" />
									</td>
								</tr>
								<tr>
									<td>
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="inputtext" size="95"
											disabled="#{!entruckPlanMB.commitStatus}"
											value="#{entruckPlanMB.mbean.rema}" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>

					<a4j:outputPanel id="orderTable">
						<div style="vertical-align: top;"></div>
						<SPAN ID="detail_ctrl" class="ctrl_show"
							onclick="JS_ExtraFunction();">&nbsp;</SPAN>
						<font color="#4990dd" style="font-weight: bolder; cursor: pointer"
							onclick="JS_ExtraFunction();">订单列表:</font>
						<div id="ExtraFunction">
							<div id=mmain_cnd>
								<iframe frameborder="0" src="outordesrs.jsf" width="100%"
									id="orders">
								</iframe>
							</div>
						</div>
					</a4j:outputPanel>

					<div>
						<b></b>
					</div>
					<div id=mmain_cnd>
						备货计划明细:
						<a4j:outputPanel id="outdetail">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<g:GTable gid="gtable" gtype="grid" gversion="2"
											gdebug="false"
											gselectsql="
											Select a.did,a.inco,a.qty,a.fqty,b.inna,b.inty,b.inse,ISNULL(s.uqty,0) AS uqty,c.tyna,
											ISNULL(b.volu,0)*qty AS volu,ISNULL(b.newe,0)*qty AS newe,b.inpr,b.colo
											From ltdb a left join inve b On a.inco = b.inco  
											left join prty c on b.inty = c.inty  
											LEFT JOIN (SELECT inco,SUM(uqty) AS uqty FROM f_getstocknumbers('#{entruckPlanMB.mbean.orid}') GROUP BY inco
											) s ON a.inco=s.inco
											Where a.biid = '#{entruckPlanMB.mbean.biid}'
											"
											gpage="(pagesize = -1)"
											gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
											gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
											gcid = inna(headtext = 商品名称,name = inna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
											gcid = colo(headtext = 规格,name = colo,width = 90,align = left,type = text,headtype = sort ,datatype = string);
											gcid = inse(headtext = 规格码,name = inse,width = 90,align = left,type = text,headtype = sort ,datatype = string);
											gcid = qty(headtext =  计划数量,name = qty,width = 70,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,summary=this);
											gcid = fqty(headtext = 已分配数量,name = fqty,width = 70,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,summary=this);
											gcid = uqty(headtext = 可用库存数,name = uqty,width = 70,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,summary=this);
										" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>