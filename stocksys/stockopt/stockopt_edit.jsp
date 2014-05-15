<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.gwall.view.StockOptMB"%>
<%@ include file="../../include/include_imp.jsp" %>


<%
	StockOptMB ai = (StockOptMB) MBUtil.getManageBean("#{stockOptMB}");
	if (request.getParameter("pid") != null) {
		ai.getMbean().setBiid(request.getParameter("pid"));
	}
	ai.getVouch();
%>
<html>
	<head>
		<title>编辑盘点操作单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="编辑盘点操作单">
		<script src="stockopt.js"></script>
	</head>
	<body onLoad="initEdit();initDetail();" id="mmain_body">
		<DIV ID="mmain">
			<div ID="mmain_nav">
				<font color="#000000"><a href="stockopt.jsf" class="return">库内处理</a>&gt;&gt;</font>
				<font color="#000000">盘点&gt;&gt;</font>
				<b>编辑盘点操作单</b>
			</div>
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:outputPanel id="output">
							<a4j:commandButton value="添加单据" type="button"
								onmouseover="this.className='a4j_over1'"
								rendered="#{stockOptMB.ADD}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								onclick="if(!headCheck()){return false};" reRender="msg"
								action="#{stockOptMB.updateHead}" oncomplete="endDo();"
								requestDelay="50"
								rendered="#{stockOptMB.MOD && stockOptMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								onclick="if(!doDel()){return false;}" reRender="msg"
								action="#{stockOptMB.deleteHead}" oncomplete="endDele();"
								requestDelay="50"
								rendered="#{stockOptMB.DEL && stockOptMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="approveId" value="审核单据" type="button"
								onclick="if(!app()){return false};"
								action="#{stockOptMB.approveVouch}"
								reRender="msg,headPanel,outTable,detailButton,output"
								oncomplete="endApp();" requestDelay="50"
								rendered="#{stockOptMB.APP && stockOptMB.commitStatus}" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable2')" type="button" />
						</a4j:outputPanel>
					</div>
					<div ID="mmain_cnd">
						<a4j:outputPanel id="headPanel">
							<table>
								<tr>
									<td bgcolor="#efefef">
										<h:outputText value="盘点操作单:">
										</h:outputText>
									</td>
									<td>
										<h:inputText styleClass="datetime" id="biid"
											value="#{stockOptMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
									<td bgcolor="#efefef">
										<h:outputText value="盘点计划单:" />
									</td>
									<td>
										<h:inputText styleClass="datetime" id="nv_fromvoucherid"
											value="#{stockOptMB.mbean.pbid}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
									<td bgcolor="#efefef">
										<h:outputText value="盘点货位:" />
									</td>
									<td>
										<h:inputText id="vc_warehouseid"
											value="#{stockOptMB.mbean.whid}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;"
											styleClass="datetime" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										<h:outputText value="盘点人:" />
									</td>
									<td>
										<h:inputText value="#{stockOptMB.mbean.crna}"
											id="nv_creatorname"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;"
											styleClass="datetime" />
									</td>
									<td bgcolor="#efefef">
										<h:outputText value="开始时间:" />
									</td>
									<td>
										<h:inputText id="dt_begintime"
											value="#{stockOptMB.mbean.crdt}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;"
											styleClass="datetime" />
									</td>
									<td bgcolor="#efefef">
										<h:outputText value="结束时间:" />
									</td>
									<td>
										<h:inputText id="dt_endtime" value="#{stockOptMB.mbean.chdt}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;"
											styleClass="datetime" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										<h:outputText value="备注:">
										</h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="nv_remark" styleClass="datetime"
											disabled="false" value="#{stockOptMB.mbean.rema}" size="90" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="detailButton" >
						<a4j:outputPanel rendered="#{stockOptMB.commitStatus}">
							<div id="mmain_opt">
								<a4j:commandButton id="addDBut"
									onmouseover="this.className='a4j_over1'"
									rendered="#{stockOptMB.ADD && stockOptMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									value="增加明细" type="button" action="#{stockOptMB.addDetail}"
									onclick="if(!addDetail()){return false};"
									reRender="msg,outTable" oncomplete="endAddDetail();"
									requestDelay="50" />
								<a4j:commandButton id="delDBut"
									onmouseover="this.className='a4j_over1'"
									rendered="#{stockOptMB.DEL && stockOptMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									value="删除明细" type="button" action="#{stockOptMB.deleteDetail}"
									onclick="if(!delDetail('gtable2')){return false};"
									reRender="msg,outTable" oncomplete="endDelDetail();"
									requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="false"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{stockOptMB.updateDetail}" reRender="msg"
									oncomplete="endUpdateDetail();" requestDelay="50" />
							</div>
							<div id="mmain_cnd">
							<div style="display: none;">
								<a4j:commandButton id="setCode4DBean" requestDelay="50"
									action="#{stockOptMB.setCode4DBean}" onclick="startDo();"
									oncomplete="endCode4DBean();" reRender="renderArea,qty" />
							</div>						
								<table border="0" cellpadding="1" cellspacing="0">
									<tr>
										<td>
											<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
										</td>
										<td>
											<h:selectOneMenu id="autoItem" value="#{stockOptMB.autoItem}"
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
												value="#{stockOptMB.dbean.codetype}" layout="lineDirection"
												onclick="initEdit();t.batyClick(this);">
												<f:selectItems value="#{stockOptMB.codetypes}" />
											</h:selectOneRadio>
										</td>
									</tr>
								</table>
								<table>
									<tr>
										<td>
											<h:outputText value="条码:"></h:outputText>
										</td>
										<td>
											<h:inputText id="baco" value="#{stockOptMB.dbean.baco}"
											 onfocus="this.select();" onkeypress="t.keyPressDeal(this);"
												styleClass="datetime" size="42"/>
											<img id="invcode_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectInveAdd();" />
										</td>
										<td>
											<h:outputText value="数量:"></h:outputText>
										</td>
										<td>
											<h:inputText id="qty" value="#{stockOptMB.dbean.qty}"
												onkeyup="this.value=this.value.replace(/\D|^0/g,'')"
												onfocus="t.elementFocus();t.canFocus(this);"
												onkeydown="t.keyPressDeal(this);"
												styleClass="datetime" size="16" />
										</td>
									</tr>
								</table>
							</div>
						</a4j:outputPanel>
					</a4j:outputPanel>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2" gdebug="false"
							gpage="(pagesize=-1)"
							gselectsql="SELECT distinct a.did,a.biid,a.baco,a.boco,a.inco,a.qty,b.inna,b.inty,b.inpr,b.colo,b.inse,b.volu,b.newe,a.whid FROM pede a LEFT JOIN inve b ON a.inco=b.inco where a.biid='#{stockOptMB.mbean.biid}'"
							gupdate="(table = {pede},tablepk = {did})"
							gcolumn="gcid = did(headtext = selall,name = did,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
									gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = baco(headtext = 商品条码,name = baco,width = 240,align = left,type = text,headtype = sort ,datatype = string);
									gcid = boco(headtext = 箱条码,name = boco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inco(headtext = 商品编码,name = inco,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 160,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = whid(headtext = 库位,name = whid,width = 90,align = left,type = text,headtype = sort ,datatype = string);									
									gcid = qty(headtext = 数量,name = qty,width = 80,headtype = sort,align = right,type = text, update=edit,datatype=number,dataformat={0},summary=this);
									" />
					</a4j:outputPanel>
					<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{stockOptMB.msg}" />
						<h:inputHidden id="roids" value="#{stockOptMB.roids}" />
						<h:inputHidden id="sellist" value="#{stockOptMB.sellist}" />
						<h:inputHidden id="updatedata" value="#{stockOptMB.updatedata}" />
						<h:inputHidden id="flag" value="#{stockOptMB.mbean.flag}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</DIV>
	</body>
</html>