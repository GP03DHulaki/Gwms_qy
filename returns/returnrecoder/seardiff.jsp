<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.ReturnRecodeMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑退货清点单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑退货清点单">
		<meta http-equiv="description" content="编辑退货清点单">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/TailHandler.js"></script>
		<script type="text/javascript" src="returnrecoder.js"></script>
	</head>
	<%
		String id = "";
		ReturnRecodeMB ai = (ReturnRecodeMB) MBUtil
				.getManageBean("#{returnRecodeMB}");
		if (request.getParameter("pid") != null) {
			id = request.getParameter("pid");
			ai.getMbean().setBiid(id);
		}
		ai.getVouch();
	%>
	<body id="mmain_body" onload="initEdit();initDetail();">
		<div id="mmain_nav">
			<font color="#000000">退货处理&gt;&gt;<a id="linkid" title="返回"
				class="return" href="returnrecoder.jsf">不合格商品清点</a>&gt;&gt;</font><b>编辑退货清点单</b>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id="mmain_opt">
						<a4j:outputPanel id="output">
							<a4j:commandButton value="调整差异"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								action="#{returnRecodeMB.operDiff }"
								onclick="startDiff();" oncomplete="endDiff();"
								rendered="#{returnRecodeMB.SPE && returnRecodeMB.diffshow}" reRender="msg,output"/>
							<a name="errorder" class="default_a" id="errorder"
								href="javascript:goToErr(0)"><font size="3">返回</font> </a>
						</a4j:outputPanel>
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="showHead">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="单据单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{returnRecodeMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
								<tr>
									<td>
										组织架构:
									</td>
									<td>
										<h:selectOneMenu id="orid"
											value="#{returnRecodeMB.mbean.orid}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="清点时间:"></h:outputText>
									</td>
									<td>
										<h:inputText id="stdt" styleClass="datetime"
											value="#{returnRecodeMB.mbean.stdt}"
											disabled="#{!returnRecodeMB.commitStatus}"
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!returnRecodeMB.commitStatus}"
											value="#{returnRecodeMB.mbean.rema}" size="68" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>

					<a4j:outputPanel id="input"
						rendered="#{returnRecodeMB.commitStatus}">
						<div id=mmain_cnd>
							<div style="display: none;">
								<a4j:commandButton id="setCode4DBean" requestDelay="50"
									action="#{returnRecodeMB.setCode4DBean}" onclick="startDo();"
									oncomplete="endCode4DBean();" reRender="renderArea,qty" />
							</div>
							<table border="0" cellpadding="1" cellspacing="0">
								<tr>
									<td>
										<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="autoItem" value="#{otherOutMB.autoItem}"
											onchange="t.setIsAutoAdd(this.value);">
											<f:selectItem itemValue="0" itemLabel="否" />
											<f:selectItem itemValue="1" itemLabel="是" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="条码类型:" title="F9键切换条码类型" />
									</td>
									<td>
										<h:selectOneRadio id="batp" style="width:220px;"
											value="#{returnRecodeMB.dbean.codetype}"
											layout="lineDirection"
											onclick="initEdit();t.batyClick(this);">
											<f:selectItem itemValue="03" itemLabel="商品条码" />
											<f:selectItem itemValue="04" itemLabel="商品编码" />
										</h:selectOneRadio>
									</td>
								</tr>
							</table>
							<table>
								<tr>
									<td>
										<h:outputText value="入库货位:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whid" styleClass="datetime"
											onkeydown="t.keyPressDeal(this);"
											onfocus="this.select();t.elementFocus();"
											value="#{returnRecodeMB.dbean.whid}" disabled="false" />
										<img id="whid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectWahod();" />
									</td>
									<td>
										<h:outputText value="条码:"></h:outputText>
									</td>
									<td>
										<h:inputText id="baco" value="#{returnRecodeMB.dbean.baco}"
											onblur="t.setCode4DBean();" onfocus="this.select();"
											onkeypress="t.keyPressDeal(this);" styleClass="datetime"
											size="42" />
										<img id="invcode_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectInveAdd();" />
									</td>
									<td width="30px;">
										<h:outputText value="数量:"></h:outputText>
									</td>
									<td oncontextmenu='return(false);' onpaste='return false'>
										<h:inputText id="qty" value="#{returnRecodeMB.dbean.qty}"
											onfocus="t.elementFocus();t.canFocus(this);"
											onkeydown="t.keyPressDeal(this);" styleClass="datetime"
											size="10" />
									</td>

								</tr>
							</table>
					</a4j:outputPanel>
					<div>
						<a4j:outputPanel id="tableid">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="SELECT b.inco,b.baco,b.chfl,sum(isnull(b.noqty,0))as noqty,sum(isnull(b.yesqty,0)) as yesqty,b.whid,c.inna,c.colo,c.inse
											  FROM (
												SELECT moid,inco,baco,chfl,CASE moid WHEN 'ReturnPutaway' then qty END AS 'noqty',
												case moid when 'srde' THEN qty END AS 'yesqty',whid FROM (
													select moid,inco,baco,chfl,qty,whid from ssde WHERE moid='ReturnPutaway' AND stat=4 and biid = '#{returnRecodeMB.mbean.biid}'
													UNION ALL 
													SELECT 'srde' AS moid, inco,baco,chfl,qty,whid FROM srde where biid = '#{returnRecodeMB.mbean.biid}'
												)a
												WHERE 1=1 GROUP BY moid,inco,baco,chfl,qty,whid
											)b JOIN inve c 
											ON b.inco=c.inco
											GROUP BY b.inco,b.baco,b.chfl,b.whid,c.inna,c.colo,c.inse
											"
								gpage="(pagesize = 40)" gversion="2"
								gupdate="(table = {srde},tablepk = {did})"
								gcolumn="gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
										gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inna(headtext = 商品名称,name = inna,width = 130,align = left,type = text,headtype = sort ,datatype = string);
										gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
										gcid = baco(headtext = 商品条码,name = baco,width = 250,align = left,type = text,headtype = sort ,datatype = string);
										gcid = noqty(headtext = 不合格数量,name = noqty,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,bgcolor={gcolumn[yesqty]=gcolumn[noqty]:#00FF00});
										gcid = yesqty(headtext = 清点数量,name = yesqty,width = 60,align = right,type =text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,bgcolor={gcolumn[yesqty]=gcolumn[noqty]:#00FF00});
										" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{returnRecodeMB.msg}" />
							<h:inputHidden id="roids" value="#{returnRecodeMB.roids}" />
							<h:inputHidden id="sellist" value="#{returnRecodeMB.sellist}" />
							<h:inputHidden id="updatedata"
								value="#{returnRecodeMB.updatedata}" />
							<a4j:commandButton id="refBut" value="刷新明细" type="button"
								reRender="tableid" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>