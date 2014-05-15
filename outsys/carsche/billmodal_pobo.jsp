<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.view.CarScheMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
	CarScheMB ai = (CarScheMB) MBUtil.getManageBean("#{carScheMB}");
	if(null != request.getParameter("biid")){
		ai.getvouch(request.getParameter("biid"));
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑调拨计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="编辑调拨计划">
		<script type="text/javascript" src="entrucksche.js"></script>
	</head>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_nav>
						<a id="linkid" href="#" onclick='window.close();' class="return"
							title="返回">备货调度</a>&gt;&gt;
						<b>编辑调拨计划</b>
						<br>
					</div>
					<div id=mmain_opt>

					</div>
					<div style="display: none;">
						<h:inputHidden id="msg" value="#{entrSchePbPlanMB.msg}" />
						<h:inputHidden id="sellist" value="#{entrSchePbPlanMB.sellist}" />
					</div>
					<a4j:outputPanel id="headButton">
						<div id=mmain_opt>
							<gw:GAjaxButton theme="a_theme" id="updateId" value="保存"
								onclick="startDo();" action="#{entrSchePbPlanMB.updatebill}"
								reRender="msg" oncomplete="endSave();" requestDelay="50"
								rendered="#{entrSchePbPlanMB.MOD}" />
							<gw:GAjaxButton theme="a_theme" value="返回"
								onclick='window.close();' />
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="headmain">
						<div id=mmain_cnd>
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td>
										采购退货计划:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext" size="20"
											value="#{entrSchePbPlanMB.purRePlanMBean.biid}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0" />
									</td>
									<td>
										供应商:
									</td>
									<td>
										<h:inputText id="outwhna" size="20" styleClass="inputtext"
											value="#{entrSchePbPlanMB.purRePlanMBean.stna}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0" />
										<h:inputHidden id="cuid"
											value="#{entrSchePbPlanMB.purRePlanMBean.stna}" />
									</td>
									<td>
										退货仓库:
									</td>
									<td>
										<h:inputText id="whna" size="20" styleClass="inputtext"
											value="#{entrSchePbPlanMB.purRePlanMBean.whna}"
											disabled="true" />
									</td>
								</tr>
								<tr>
									<td>
										审核日期:
									</td>
									<td>
										<h:inputText id="chdt" size="20" styleClass="inputtext"
											value="#{entrSchePbPlanMB.purRePlanMBean.chdt}"
											disabled="true" />
									</td>
									<td valign="top">
										线&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;路:
									</td>
									<td>
										<h:selectOneMenu id="lico"
											value="#{entrSchePbPlanMB.purRePlanMBean.lico}"
											style="width:130px">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{entrSchePbPlanMB.lineList}" />
										</h:selectOneMenu>
									</td>
									<%-- 
									<td valign="top">
										送达地区:
									</td>
									<td>
										<h:selectOneMenu id="gead"
											value="#{entrSchePbPlanMB.purRePlanMBean.gead}"
											style="width:130px">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{entrSchePbPlanMB.areaList}" />
										</h:selectOneMenu>
									</td>
									--%>
								</tr>
								<tr>
									<td>
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="inputtext" size="95"
											disabled="true"
											value="#{entrSchePbPlanMB.purRePlanMBean.rema}" />
									</td>
								</tr>
							</table>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="outdetail">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											Select a.did,a.inco,a.qty,b.inna,b.inty,b.inse,b.volu,b.newe,b.inpr,b.colo      
											From prde a left join inve b On a.inco = b.inco  
											Where a.biid = '#{entrSchePbPlanMB.purRePlanMBean.biid}'
											"
										gpage="(pagesize = -1)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
											gcid = inco(headtext = 商品编码,name = inco,width = 140,align = left,type = text,headtype = sort ,datatype = string);
											gcid = inna(headtext = 商品名称,name = inna,width = 220,align = left,type = text,headtype = sort ,datatype = string);
											gcid = inty(headtext = 商品类别,name = inty,width = 90,align = left,type = text,headtype = hidden ,datatype = string);
											gcid = qty(headtext =  数量,name = qty,width = 90,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
											gcid = inpr(headtext = 属性,name = inpr,width = 90,align = left,type = mask,typevalue=P:成品/S:半成品,headtype = hidden ,datatype = string);
											gcid = colo(headtext = 规格,name = colo,width = 90,align = left,type = text,headtype = hidden ,datatype = string);
											gcid = inse(headtext = 规格码,name = inse,width = 90,align = left,type = text,headtype = hidden ,datatype = string);
											gcid = volu(headtext = 体积(m³),name = volu,width = 90,align = right,type = text,headtype = sort ,datatype = number,dataformat=0.00,summary=this);
											gcid = newe(headtext = 重量(㎏),name = newe,width = 90,align = right,type = text,headtype = sort ,datatype = number,dataformat=0.00,summary=this);
										" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
				</h:form>
			</f:view>
		</div>
	</body>
</html>