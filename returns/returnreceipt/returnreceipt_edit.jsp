<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.ReturnReceiptMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑销售退货收货单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑销售退货收货单">
		<meta http-equiv="description" content="编辑销售退货收货单">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/TailHandler.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="returnreceipt.js"></script>
	</head>
	<%
	    String id = "";
	    ReturnReceiptMB ai = (ReturnReceiptMB) MBUtil
	            .getManageBean("#{returnReceiptMB}");
	    if (request.getParameter("pid") != null) {
	        id = request.getParameter("pid");
	        ai.getMbean().setBiid(id);
	    }
	    ai.getVouch();
	%>
	<body id="mmain_body" onload="initEdit();initDetail()">
		<div id="mmain_nav">
			<font color="#000000">退货处理&gt;&gt;<a id="linkid" title="返回"
				class="return" href="returnreceipt.jsf">销售退货收货</a>&gt;&gt;</font><b>编辑销售退货收货单</b>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id="mmain_opt">
						<a4j:outputPanel id="output">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" rendered="#{returnReceiptMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{returnReceiptMB.updateHead}" onclick="updateHead()"
								oncomplete="endUpdateHead();" reRender="output,renderArea"
								requestDelay="50"
								rendered="#{returnReceiptMB.MOD && returnReceiptMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{returnReceiptMB.deleteHead}"
								onclick="if(!doDel()){return false;}"
								reRender="output,renderArea" oncomplete="endDele();"
								requestDelay="50"
								rendered="#{returnReceiptMB.DEL && returnReceiptMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" id="submitMBut"
								onclick="if(!app()){return false};"
								rendered="#{returnReceiptMB.APP && returnReceiptMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{returnReceiptMB.approveVouch}"
								reRender="showHeadButton,renderArea,output,head,tableid,input,detailbutton"
								oncomplete="endApp();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="tijiao" value="提交" type="button" action=""
								onclick="tijiao()"
								reRender="output,renderArea,head,countPage,detailbutton,input,tableid"
								oncomplete="endTijiao();" requestDelay="50" rendered="false" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="huitui" value="回退" type="button" action=""
								onclick="huitui()"
								reRender="output,renderArea,head,countPage,detailbutton,input,tableid"
								oncomplete="endHuitui();" requestDelay="50" rendered="false"></a4j:commandButton>
							<a4j:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{returnReceiptMB.printReport}"
								rendered="#{returnReceiptMB.PRN && !returnReceiptMB.commitStatus}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output" requestDelay="1000" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="head">
						<div id="mmain_cnd">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="销售退货收货单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{returnReceiptMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="退货计划单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="soco" styleClass="datetime" disabled="true"
											value="#{returnReceiptMB.mbean.soco}" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="经手人:"></h:outputText>
									</td>
									<td>
										<h:inputText id="opna" styleClass="datetime" size="20"
											value="#{returnReceiptMB.mbean.opna}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
									<td>
										<h:outputText value="入库仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whna" styleClass="datetime"
											value="#{returnReceiptMB.mbean.whna}" disabled="true" />
										<h:inputHidden id="whid" value="#{returnReceiptMB.mbean.whid}" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="组织架构:"></h:outputText>
									</td>
									<td>
										<h:inputText id="orna" styleClass="datetime"
											value="#{returnReceiptMB.mbean.orna}" disabled="true" />
										<h:inputHidden id="orid" value="#{returnReceiptMB.mbean.orid}" />
										<a4j:outputPanel rendered="#{returnReceiptMB.commitStatus}">
											<img id="orid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectOrga();" />
										</a4j:outputPanel>
									</td>
									<td>
										<h:outputText value="收货时间:"></h:outputText>
									</td>
									<td>
										<h:inputText id="stdt" styleClass="datetime" disabled="true"
											value="#{returnReceiptMB.mbean.crdt}" />
									</td>
									<td>
										<h:outputText value="单据标志:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="flag"
											value="#{returnReceiptMB.mbean.flag}" disabled="true">
											<f:selectItems value="#{returnReceiptMB.flags}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!returnReceiptMB.commitStatus}"
											value="#{returnReceiptMB.mbean.rema}" size="122" />
									</td>
								</tr>
							</table>

						</div>
					</a4j:outputPanel>
					<div id="mmain_opt">
						<a4j:outputPanel id="detailbutton">
							<a4j:outputPanel rendered="#{returnReceiptMB.commitStatus}">
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{returnReceiptMB.addDetail}"
									reRender="renderArea,output,tableid"
									rendered="#{returnReceiptMB.ADD && returnReceiptMB.commitStatus}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{returnReceiptMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,tableid"
									rendered="#{returnReceiptMB.DEL && returnReceiptMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<a4j:commandButton id="resertbut" value="重置"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" onclick="textClear('edit','baco')"
									rendered="#{returnReceiptMB.DEL && returnReceiptMB.commitStatus}" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'" style="display:none"
									rendered="#{returnReceiptMB.MOD && returnReceiptMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{returnReceiptMB.updateDetail}"
									reRender="renderArea,output" oncomplete="endUpdateDetail();"
									requestDelay="50" />
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="input"
						rendered="#{returnReceiptMB.commitStatus}">
						<div id=mmain_cnd>
							<div style="display: none;">
								<a4j:commandButton id="setCode4DBean" requestDelay="50"
									action="#{returnReceiptMB.setCode4DBean}" onclick="startDo();"
									oncomplete="endCode4DBean();" reRender="renderArea,qty" />
							</div>
							<table border="0" cellpadding="1" cellspacing="0">
								<tr>
									<td>
										<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="autoItem"
											value="#{returnReceiptMB.autoItem}"
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
											value="#{returnReceiptMB.dbean.codetype}"
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
										<h:outputText value="条码:"></h:outputText>
									</td>
									<td>
										<h:inputText id="baco" value="#{returnReceiptMB.dbean.baco}"
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
										<h:inputText id="qty" value="#{returnReceiptMB.dbean.qty}"
											onfocus="t.elementFocus();t.canFocus(this);"
											onkeydown="t.keyPressDeal(this);" styleClass="datetime"
											size="10" />
									</td>
								</tr>
							</table>
						</div>
					</a4j:outputPanel>
					<div>
						<a4j:outputPanel id="tableid">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="SELECT distinct a.roid,a.did,a.baco, a.biid,a.inco,p.tyna,b.inse,b.asco,a.whid,w.whna,a.qty,b.inna,b.inty,b.inpr,b.colo,b.newe
											FROM rrde a 
											LEFT JOIN inve b ON a.inco = b.inco
											left join prty p on p.inty = b.inty
											LEFT JOIN waho w on a.whid=w.whid
											Where a.biid = '#{returnReceiptMB.mbean.biid}' "
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {msde},tablepk = {did})"
								gcolumn="gcid = roid(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = #{returnReceiptMB.commitStatus ? 'checkbox' : 'hidden'});
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = baco(headtext = 商品条码,name = baco,width = 230,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inco(headtext = 商品编码,name = inco,width = 100,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 商品名称,name = inna,width = 130,align = left,type = text,headtype = sort ,datatype = string);
									gcid = tyna(headtext = 类别,name = inty,width = 60,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 规格,name = colo,width = 90,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 规格码,name = inse,width = 50,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext = 收货数量,name = qty,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,summary=this);
									gcid = whna(headtext = 入库货位,name = whna,width = 80,align = left,type = text,headtype = sort ,datatype = string);
									" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{returnReceiptMB.msg}" />
							<h:inputHidden id="roids" value="#{returnReceiptMB.roids}" />
							<h:inputHidden id="filename" value="#{returnReceiptMB.fileName}" />
							<h:inputHidden id="sellist" value="#{returnReceiptMB.sellist}" />
							<h:inputHidden id="updatedata"
								value="#{returnReceiptMB.updatedata}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="查询商品信息" type="button"
								action="#{returnReceiptMB.selInveBut}" id="selInveBut"
								onclick="if(!selInveBut()){return false};"
								reRender="detailButton" oncomplete="endSelInveBut();"
								requestDelay="50" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>