<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.SaleReturnMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑销售退货入库单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑销售退货入库单">
		<meta http-equiv="description" content="编辑销售退货入库单">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/TailHandler.js"></script>
		<script type="text/javascript" src="salesreturn.js"></script>
	</head>
	<%
	    String id = "";
	    SaleReturnMB ai = (SaleReturnMB) MBUtil
	            .getManageBean("#{saleReturnMB}");
	    if (request.getParameter("pid") != null) {
	        id = request.getParameter("pid");
	        ai.getMbean().setBiid(id);
	    }
	    ai.getVouch();
	%><body id="mmain_body" onload="initEdit();initDetail()">
		<div id="mmain_nav">
			<font color="#000000">退货处理&gt;&gt;<a id="linkid" title="返回"
				class="return" href="salesreturn.jsf">销售退货入库</a>&gt;&gt;</font><b>编辑销售退货入库单</b>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id="mmain_opt">
						<a4j:outputPanel id="output">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" rendered="#{saleReturnMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{saleReturnMB.updateHead}" onclick="updateHead()"
								oncomplete="endUpdateHead();" reRender="output,renderArea"
								requestDelay="50"
								rendered="#{saleReturnMB.MOD && saleReturnMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{saleReturnMB.deleteHead}"
								onclick="if(!doDel()){return false;}"
								reRender="output,renderArea" oncomplete="endDele();"
								requestDelay="50"
								rendered="#{saleReturnMB.DEL && saleReturnMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" id="submitMBut"
								onclick="if(!app()){return false;}"
								rendered="#{saleReturnMB.APP && saleReturnMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{saleReturnMB.approveVouch}"
								reRender="renderArea,output,tableid,inputPanel,detailbutton"
								oncomplete="endApp();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="tijiao" value="提交" type="button" action=""
								onclick="tijiao()"
								reRender="output,renderArea,head,countPage,detailbutton,inputPanel,tableid"
								oncomplete="endTijiao();" requestDelay="50" rendered="false" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="huitui" value="回退" type="button" action=""
								onclick="huitui()"
								reRender="output,renderArea,head,countPage,detailbutton,inputPanel,tableid"
								oncomplete="endHuitui();" requestDelay="50" rendered="false"></a4j:commandButton>
							<a4j:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{saleReturnMB.printReport}"
								rendered="#{saleReturnMB.PRN && !saleReturnMB.commitStatus}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output" requestDelay="1000" />
							<a4j:commandButton id="wrBackBut" value="回写单据" type="button"
								rendered="#{saleReturnMB.SPE && !saleReturnMB.commitStatus}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{saleReturnMB.writeBackVouch}" oncomplete="endApp();"
								reRender="output,renderArea"
								disabled="#{!saleReturnMB.canWriteBack}" styleClass="a4j_but1"
								onclick="startDo();" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="销售退货入库单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{saleReturnMB.mbean.biid}" disabled="true" />
									</td>
									<a4j:outputPanel id="head1" rendered="#{saleReturnMB.isPlan}">
										<td>
											<h:outputText value="退货计划单号:"></h:outputText>
										</td>
										<td>
											<h:inputText id="soco1" styleClass="datetime" disabled="true"
												value="#{saleReturnMB.mbean.soco}" />
										</td>
									</a4j:outputPanel>
									<a4j:outputPanel id="head2" rendered="#{saleReturnMB.isReturn}">
										<td>
											<h:outputText value="销售退货单号:"></h:outputText>
										</td>
										<td>
											<h:inputText id="soco2" styleClass="datetime" disabled="true"
												value="#{saleReturnMB.mbean.soco}" />
										</td>
									</a4j:outputPanel>


									<td>
										<h:outputText value="入库仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whna" styleClass="datetime"
											value="#{saleReturnMB.mbean.whna}" disabled="true" />
										<h:inputHidden id="fwhid" value="#{saleReturnMB.mbean.whid}" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="组织架构:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{saleReturnMB.mbean.orid}"
											disabled="#{!saleReturnMB.commitStatus}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="操作时间:"></h:outputText>
									</td>
									<td>
										<h:inputText id="stdt" styleClass="datetime" disabled="true"
											value="#{saleReturnMB.mbean.crdt}" />
									</td>
									<td>
										<h:outputText value="单据标志:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="flag" value="#{saleReturnMB.mbean.flag}"
											disabled="true">
											<f:selectItems value="#{saleReturnMB.flags}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="经手人:"></h:outputText>
									</td>
									<td>
										<h:inputText id="opna" styleClass="datetime"
											value="#{saleReturnMB.mbean.opna}" size="20" />
									</td>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!saleReturnMB.commitStatus}"
											value="#{saleReturnMB.mbean.rema}" size="68" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="detailbutton">
						<a4j:outputPanel rendered="#{saleReturnMB.commitStatus}">
							<div id="mmain_opt">
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{saleReturnMB.addDetail}"
									reRender="renderArea,tableid"
									rendered="#{saleReturnMB.ADD && saleReturnMB.commitStatus}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{saleReturnMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,tableid"
									rendered="#{saleReturnMB.DEL && saleReturnMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<a4j:commandButton id="impBut" value="导入明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{saleReturnMB.MOD && saleReturnMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									 onclick="showImport()" reRender="msg,renderArea,output,tableid"
									requestDelay="50" />
								<a4j:commandButton id="downloadmb" value="模板下载" type="button"
									rendered="#{saleReturnMB.SPE && saleReturnMB.commitStatus}" onclick="downloadmb()"
									reRender="msg,headButton,renderArea,output,tableid" requestDelay="50"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
							</div>
						</a4j:outputPanel>
					</a4j:outputPanel>


					<a4j:outputPanel id="inputPanel">
						<a4j:outputPanel rendered="#{saleReturnMB.commitStatus}">
							<div id=mmain_cnd>
								<div style="display: none;">
									<a4j:commandButton id="setCode4DBean" requestDelay="50"
										action="#{saleReturnMB.setCode4DBean}" onclick="startDo();"
										oncomplete="endCode4DBean();" reRender="renderArea,qty" />
								</div>
								<table border="0" cellpadding="1" cellspacing="0">
									<tr>
										<td>
											<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
										</td>
										<td>
											<h:selectOneMenu id="autoItem"
												value="#{saleReturnMB.autoItem}"
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
												value="#{saleReturnMB.dbean.codetype}"
												layout="lineDirection"
												onclick="initEdit();t.batyClick(this);">
												<f:selectItem itemValue="04" itemLabel="商品编码" />
												<f:selectItem itemValue="03" itemLabel="商品条码" />
												
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
											<h:inputText id="baco" value="#{saleReturnMB.dbean.baco}"
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
											<h:inputText id="qty" value="#{saleReturnMB.dbean.qty}"
												onfocus="t.elementFocus();t.canFocus(this);"
												onkeydown="t.keyPressDeal(this);" styleClass="datetime"
												size="10" />
										</td>
										<td>
											<h:outputText value="入库货位:"></h:outputText>
										</td>
										<td>
											<h:inputText id="dwhid" styleClass="datetime"
												onkeydown="t.keyPressDeal(this);"
												onfocus="this.select();t.elementFocus();"
												value="#{saleReturnMB.dbean.whid}" disabled="false" />
											<img id="whid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectWahod();" />
										</td>
										<%--
										<td>
											<h:outputText value="备注:"></h:outputText>
										</td>
										<td>
											<h:inputText id="drema" styleClass="datetime"
												value="#{saleReturnMB.dbean.rema}" />
										</td>
									--%>
									</tr>
								</table>
							</div>
						</a4j:outputPanel>
					</a4j:outputPanel>

					<a4j:outputPanel id="tableid">
						<g:GTable gid="gtable" gtype="grid" gdebug="false"
							gselectsql="SELECT distinct a.did,a.baco,a.roid, a.biid,a.inco,a.whid,a.qty,b.inna,b.asco,b.psco,b.inty,b.inpr,p.tyna,b.colo,b.inse,b.volu,b.newe
									FROM rsde a 
									LEFT JOIN inve b ON a.inco = b.inco
									left join prty p on p.inty = b.inty
									Where a.biid = '#{saleReturnMB.mbean.biid}' "
							gpage="(pagesize = 20)" gversion="2"
							gupdate="(table = {rsde},tablepk = {did})"
							gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = #{saleReturnMB.commitStatus ? 'checkbox' : 'hidden'});
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = roid(name = roid,type = text,headtype = hidden ,datatype = string);
									gcid = baco(headtext = 商品条码,name = baco,width = 230,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 商品名称,name = inna,width = 130,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = whid(headtext = 入库货位,name = whid,width = 100,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext = 数量,name = qty,width = 100,align = right,type = text,headtype = sort ,datatype = number,dataformat=0.##);
								" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{saleReturnMB.msg}" />
							<h:inputHidden id="roids" value="#{saleReturnMB.roids}" />
							<h:inputHidden id="sellist" value="#{saleReturnMB.sellist}" />
							<h:inputHidden id="filename" value="#{saleReturnMB.fileName}" />
							<h:inputHidden id="updatedata" value="#{saleReturnMB.updatedata}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="查询商品信息" type="button" action="#{saleReturnMB.selInveBut}"
								id="selInveBut" onclick="if(!selInveBut()){return false};"
								reRender="detailButton" oncomplete="endSelInveBut();"
								requestDelay="50" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
				<div id="import" style="display: none" align="left">
					<h:form id="file" enctype="multipart/form-data">
						<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
							value="#{saleReturnMB.myFile}" required="true" size="75" />
						<div id="mes"></div>
						<div align="center">
							<gw:GAjaxButton value="上传" onclick="return doImport();"
								id="import" theme="a_theme" />
							<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
								onclick="Close()" type="button" />
						</div>
						<div style="display: none;">
							<h:commandButton value="上传" id="importBut"
								action="#{saleReturnMB.uploadFile}" />
						</div>
					</h:form>
				</div>
		</f:view>
	</body>
</html>