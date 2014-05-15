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
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" rendered="#{returnRecodeMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{returnRecodeMB.updateHead}" onclick="updateHead()"
								oncomplete="endUpdateHead();" reRender="output,renderArea"
								requestDelay="50"
								rendered="#{returnRecodeMB.MOD && returnRecodeMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{returnRecodeMB.deleteHead}"
								onclick="if(!doDel()){return false;}"
								reRender="output,renderArea" oncomplete="endDele();"
								requestDelay="50"
								rendered="#{returnRecodeMB.DEL && returnRecodeMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" id="submitMBut"
								onclick="if(!app()){return false};"
								rendered="#{returnRecodeMB.APP && returnRecodeMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{returnRecodeMB.approveVouch}"
								reRender="detailButtont,renderArea,output,head,tableid"
								oncomplete="endApp();" requestDelay="50" />
							<a4j:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="printReport();" oncomplete="endPrintReport();"
								rendered="false" reRender="renderArea,outTable,output"
								requestDelay="1000" />
							<a name="errorder" class="default_a" id="errorder"
								href="javascript:goToErr(1)"><font size="3">查看清点差异</font>
							</a>
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
									<td>
										<h:outputText value="单据类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="buty" style="width:130px;"
											disabled="true" value="#{returnRecodeMB.mbean.buty}">
											<f:selectItems value="#{returnRecodeMB.butys}" />
										</h:selectOneMenu>
									</td>
								</tr>
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
					<div id="mmain_opt">
						<a4j:outputPanel id="detailButtont">
							<a4j:outputPanel rendered="#{returnRecodeMB.commitStatus}">
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{returnRecodeMB.addDetail}"
									reRender="renderArea,tableid"
									rendered="#{returnRecodeMB.ADD && returnRecodeMB.commitStatus}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{returnRecodeMB.MOD && returnRecodeMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{returnRecodeMB.updateDetail}"
									reRender="renderArea,output" oncomplete="endUpdateDetail();"
									requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{returnRecodeMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,tableid"
									rendered="#{returnRecodeMB.DEL && returnRecodeMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
							</a4j:outputPanel>
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
								gselectsql="SELECT distinct a.did,a.biid,a.roid,a.inco,p.tyna,a.baco,a.whid,b.psco,a.qty,b.inna,b.inty,b.inpr,b.colo,b.inse,b.volu,b.newe FROM srde a 
											LEFT JOIN inve b ON a.inco = b.inco
											left join prty p on p.inty = b.inty
											Where a.biid = '#{returnRecodeMB.mbean.biid}' "
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {srde},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = #{returnRecodeMB.commitStatus ? 'checkbox' : 'hidden'});
										gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
										gcid = roid(name = roid,type = text,headtype = hidden ,datatype = string);
										gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inna(headtext = 商品名称,name = inna,width = 130,align = left,type = text,headtype = sort ,datatype = string);
										gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
										gcid = baco(headtext = 商品条码,name = baco,width = 250,align = left,type = text,headtype = sort ,datatype = string);
										gcid = qty(headtext = 清点数量,name = qty,width = 60,align = right,type = #{returnRecodeMB.commitStatus ? 'input' : 'text'},headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
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