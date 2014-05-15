<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.CarScheMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
	CarScheMB ai = (CarScheMB) MBUtil.getManageBean("#{carScheMB}");
	if (null != request.getParameter("biid")) {
		ai.getvouch(request.getParameter("biid"));
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="编辑订单明细">
		<script type="text/javascript" src="carsche.js"></script>
	</head>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_nav>
						<a id="linkid" href="#" onclick='window.close();' class="return"
							title="返回">配车调度</a>&gt;&gt;
						<b>编辑订单</b>
						<br>
					</div>
					<div id=mmain_opt>

					</div>
					<div style="display: none;">
						<h:inputHidden id="msg" value="#{carScheMB.msg}" />
						<h:inputHidden id="sellist" value="#{carScheMB.sellist}" />
					</div>
					<a4j:outputPanel id="headButton">
						<div id=mmain_opt>
							<gw:GAjaxButton theme="a_theme" id="updateId" value="保存"
								onclick="startDo();" action="#{carScheMB.updatebill}"
								reRender="msg" oncomplete="endSave();" requestDelay="50"
								rendered="#{carScheMB.MOD}" />
							<gw:GAjaxButton theme="a_theme" value="返回"
								onclick='window.close();' />
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="headmain">
						<div id=mmain_cnd>
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td>
										出库订单:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext" size="20"
											value="#{carScheMB.outOrderBean.biid}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0" />
									</td>
									<td>
										客&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;户:
									</td>
									<td>
										<h:inputText id="cuna" size="20" styleClass="inputtext"
											value="#{carScheMB.outOrderBean.cuna}" disabled="true" />
										<h:inputHidden id="cuid"
											value="#{carScheMB.outOrderBean.cuid}" />
									</td>
									<td>
										承运商:
									</td>
									<td>
										<h:inputText id="lpna" size="20" styleClass="inputtext"
											value="#{carScheMB.outOrderBean.lpco}" disabled="true" />
										<h:inputHidden id="lpco"
											value="#{carScheMB.outOrderBean.lpco}" />
									</td>
								</tr>
								<tr>
									<td>
										审核日期:
									</td>
									<td>
										<h:inputText id="chdt" size="20" styleClass="inputtext"
											value="#{carScheMB.outOrderBean.chdt}" disabled="true" />
									</td>
									<%-- 
									<td valign="top">
										送达地区:
									</td>
									<td>
										<h:selectOneMenu id="gead"
											value="#{carScheMB.outOrderBean.gead}"
											style="width:130px">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{carScheMB.areaList}" />
										</h:selectOneMenu>
									</td>
									--%>
									<td valign="top">
										线&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;路:
									</td>
									<td>
										<h:selectOneMenu id="lico"
											value="#{carScheMB.outOrderBean.lico}" style="width:130px">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{carScheMB.lineList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td valign="top">
										详细地址:
									</td>
									<td colspan="7">
										<h:inputText id="orad" value="#{carScheMB.outOrderBean.orad}"
											styleClass="inputtext" size="95" />
									</td>
								</tr>
								<tr>
									<td>
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="inputtext" size="95"
											disabled="true" value="#{carScheMB.outOrderBean.rema}" />
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
											Select a.did,a.inco,a.qty,b.inna,b.inty,b.inse,b.volu,b.newe,b.inpr,b.colo,a.gqty,isnull(s.uqty,0) as uqty        
											From oubd a left join inve b On a.inco = b.inco  
											LEFT JOIN (SELECT inco,SUM(uqty) AS uqty FROM f_getstocknumbers('#{carScheMB.outOrderBean.orid}') GROUP BY inco
											) s ON a.inco=s.inco 
											Where a.biid = '#{carScheMB.outOrderBean.biid}' 
											"
										gpage="(pagesize = -1)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
											gcid = inco(headtext = 商品编码,name = inco,width = 140,align = left,type = text,headtype = sort ,datatype = string);
											gcid = inna(headtext = 商品名称,name = inna,width = 220,align = left,type = text,headtype = sort ,datatype = string);
											gcid = inty(headtext = 商品品类,name = inty,width = 90,align = left,type = text,headtype = hidden ,datatype = string);
											gcid = qty(headtext =  数量,name = qty,width = 50,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
											gcid = gqty(headtext =  已备数量,name = gqty,width = 50,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,bgcolor={gcolumn[qty]>gcolumn[gqty]:#FFFF00},summary=this);
											gcid = uqty(headtext =  可用库存,name = uqty,width = 50,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,bgcolor={gcolumn[uqty]=0:#FF0000});
											gcid = inpr(headtext = 属性,name = inpr,width = 50,align = left,type = mask,typevalue=P:成品/S:半成品,headtype = hidden ,datatype = string);
											gcid = colo(headtext = 规格,name = colo,width = 50,align = left,type = text,headtype = hidden ,datatype = string);
											gcid = inse(headtext = 规格码,name = inse,width = 50,align = left,type = text,headtype = hidden ,datatype = string);
											gcid = volu(headtext = 体积,name = volu,width = 50,align = right,type = text,headtype = sort ,datatype = number,dataformat=0.00,summary=this);
											gcid = newe(headtext = 重量,name = newe,width = 50,align = right,type = text,headtype = sort ,datatype = number,dataformat=0.00,summary=this);
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