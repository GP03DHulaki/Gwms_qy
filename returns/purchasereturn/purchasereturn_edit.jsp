<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.PurchaseReturnsMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑采购退货出库单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑采购退货出库单">
		<meta http-equiv="description" content="编辑采购退货出库单">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="purchasereturn.js"></script>
	</head>
	<%
		String id = "";
		PurchaseReturnsMB ai = (PurchaseReturnsMB) MBUtil
				.getManageBean("#{purchaseReturnMB}");
		if (request.getParameter("pid") != null) {
			id = request.getParameter("pid");
			ai.getMbean().setBiid(id);
		}
		ai.getVouch();
	%>
	<body id="mmain_body" onload="initEdit();initDetail();">
		<div id="mmain_nav">
			<font color="#000000">退货处理&gt;&gt;<a id="linkid" title="返回"
				class="return" href="purchasereturn.jsf">采购退货出库</a>&gt;&gt;</font><b>编辑采购退货出库单</b>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id="mmain_opt">
						<a4j:outputPanel id="output">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" rendered="#{purchaseReturnMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{purchaseReturnMB.updateHead}" onclick="updateHead()"
								oncomplete="endUpdateHead();" reRender="output,renderArea"
								requestDelay="50"
								rendered="#{purchaseReturnMB.MOD && purchaseReturnMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{purchaseReturnMB.deleteHead}"
								onclick="if(!doDel()){return false;}"
								reRender="output,renderArea" oncomplete="endDele();"
								requestDelay="50"
								rendered="#{purchaseReturnMB.DEL && purchaseReturnMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" id="submitMBut"
								onclick="if(!app()){return false};"
								rendered="#{purchaseReturnMB.APP && purchaseReturnMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{purchaseReturnMB.approveVouch}"
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
								action="#{purchaseReturnMB.printReport}"
								rendered="#{purchaseReturnMB.PRN && !purchaseReturnMB.commitStatus}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output" requestDelay="1000" />
							<a4j:commandButton id="wrBackBut" value="回写单据" type="button"
								rendered="#{purchaseReturnMB.SPE && !purchaseReturnMB.commitStatus}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{purchaseReturnMB.writeBackVouch}" oncomplete="endApp();"
								reRender="output,renderArea" disabled="#{!purchaseReturnMB.canWriteBack}"
								styleClass="a4j_but1" onclick="startDo();" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="采购退货出库单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{purchaseReturnMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="采购退货计划单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="soco" styleClass="datetime" disabled="true"
											value="#{purchaseReturnMB.mbean.soco}" />
									</td>
									<td>
										<h:outputText value="出库仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whna" styleClass="datetime"
											value="#{purchaseReturnMB.mbean.whna}" disabled="true" />
										<h:inputHidden id="fwhid"
											value="#{purchaseReturnMB.mbean.whid}" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="组织架构:"></h:outputText>
									</td>
									<td>
										<h:inputText id="orna" styleClass="datetime"
											value="#{purchaseReturnMB.mbean.orna}" disabled="true" />
										<h:inputHidden id="orid"
											value="#{purchaseReturnMB.mbean.orid}" />
										<a4j:outputPanel rendered="#{purchaseReturnMB.commitStatus}">
											<img id="orid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectOrga();" />
										</a4j:outputPanel>
									</td>
									<td>
										<h:outputText value="退货供应商:"></h:outputText>
									</td>
									<td>
										<h:inputText id="stdt" styleClass="datetime" disabled="true"
											value="#{purchaseReturnMB.mbean.stna}" />
									</td>
									<td>
										<h:outputText value="单据标志:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="flag"
											value="#{purchaseReturnMB.mbean.flag}" disabled="true">
											<f:selectItems value="#{purchaseReturnMB.flags}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
								<td>
									<h:outputText value="经手人:"></h:outputText>
								</td>
								<td>
									<h:inputText id="opna" styleClass="datetime"
										value="#{purchaseReturnMB.mbean.opna}" />
								</td>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="3">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!purchaseReturnMB.commitStatus}"
											value="#{purchaseReturnMB.mbean.rema}" size="68" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div id="mmain_opt">
						<a4j:outputPanel id="detailbutton">
							<a4j:outputPanel rendered="#{purchaseReturnMB.commitStatus}">
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{purchaseReturnMB.addDetail}"
									reRender="renderArea,output,tableid"
									rendered="#{purchaseReturnMB.ADD && purchaseReturnMB.commitStatus}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{purchaseReturnMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,tableid"
									rendered="#{purchaseReturnMB.DEL && purchaseReturnMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'" style="display:none"
									rendered="#{purchaseReturnMB.MOD && purchaseReturnMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{purchaseReturnMB.updateDetail}"
									reRender="renderArea,output,tableid" oncomplete="endUpdateDetail();"
									requestDelay="50" />
								<a4j:commandButton id="impBut" value="导入明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{purchaseReturnMB.MOD && purchaseReturnMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									 onclick="showImport()" reRender="msg,renderArea,output,tableid"
									requestDelay="50" />
								<a4j:commandButton id="downloadmb" value="模板下载" type="button"
									rendered="#{purchaseReturnMB.SPE && purchaseReturnMB.commitStatus}" onclick="downloadmb()"
									reRender="msg,headButton,renderArea,output,tableid" requestDelay="50"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />	
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="input">
						<a4j:outputPanel rendered="#{purchaseReturnMB.commitStatus}">
							<div id=mmain_cnd>
								<div style="display: none;">
									<a4j:commandButton id="setCode4DBean" requestDelay="50"
										action="#{purchaseReturnMB.setCode4DBean}" onclick="startDo();"
										oncomplete="endCode4DBean();"
										reRender="codePanel,renderArea,msg" />
								</div>
								<table border="0" cellpadding="1" cellspacing="0">
									<tr>
										<td>
											<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
										</td>
										<td>
											<h:selectOneMenu id="autoItem" value="#{purchaseReturnMB.autoItem}"
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
												value="#{purchaseReturnMB.dbean.codetype}" layout="lineDirection"
												onclick="initEdit();t.batyClick(this);">
												<f:selectItems value="#{purchaseReturnMB.codetypes}" />
											</h:selectOneRadio>
										</td>
									</tr>
								</table>
								<table>
									<tr>
										<td>
											<h:outputText value="库位:"></h:outputText>
										</td>
										<td>
											<h:inputText id="dwhid" styleClass="datetime"
											onkeydown="t.keyPressDeal(this);" onfocus="this.select();"
												value="#{purchaseReturnMB.dbean.whid}"/>
											<img id="whid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectWahod();" />
										</td>
										<td>
											<h:outputText value="条码:"></h:outputText>
										</td>
										<td>
											<h:inputText id="baco" value="#{purchaseReturnMB.dbean.baco}"
											onblur="t.setCode4DBean();" onfocus="this.select();" onkeypress="t.keyPressDeal(this);"
												styleClass="datetime" size="42"  />
											<img id="invcode_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectInveAdd();" />
										</td>
										<td>
											<h:outputText value="数量:"></h:outputText>
										</td>
										<td>
											<h:inputText id="qty" value="#{purchaseReturnMB.dbean.qty}"
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
					<div>
						<a4j:outputPanel id="tableid">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="SELECT distinct a.did,a.roid,p.tyna,a.biid,a.inco,a.baco,a.whid,a.qty,b.inna,b.inty,b.inpr,b.colo,b.inse,b.volu,b.newe,b.psco,b.asco
											FROM prde a 
											LEFT JOIN inve b ON b.inco = ISNULL((select inco from dbo.F_GetIncoBiid(a.inco)),a.inco)
											left join prty p on p.inty = b.inty
											Where a.biid = '#{purchaseReturnMB.mbean.biid}' "
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {msde},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = #{purchaseReturnMB.commitStatus ? 'checkbox' : 'hidden'});
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = roid(headtext = roid,name = roid,type = text,headtype = hidden ,datatype = string);
									gcid = inco(headtext = 商品编码,name = inco,width = 190,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 商品名称,name = inna,width = 150,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext = 出库数量,name = qty,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
									gcid = baco(headtext = 商品条码,name = baco,width = 210,align = left,type = text,headtype = sort ,datatype = string);
									gcid = whid(headtext = 出库货位,name = whid,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{purchaseReturnMB.msg}" />
							<h:inputHidden id="roids" value="#{purchaseReturnMB.roids}" />
							<h:inputHidden id="filename" value="#{purchaseReturnMB.fileName}" />
							<h:inputHidden id="sellist" value="#{purchaseReturnMB.sellist}" />
							<h:inputHidden id="updatedata"
								value="#{purchaseReturnMB.updatedata}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="查询商品信息" type="button"
								action="#{purchaseReturnMB.selInveBut}" id="selInveBut"
								onclick="if(!selInveBut()){return false};"
								reRender="detailButton" oncomplete="endSelInveBut();"
								requestDelay="50" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
			<div id="import" style="display: none" align="left">
					<h:form id="file" enctype="multipart/form-data">
						<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
							value="#{purchaseReturnMB.myFile}" required="true" size="75" />
						<div id="mes"></div>
						<div align="center">
							<gw:GAjaxButton value="上传" onclick="return doImport();"
								id="import" theme="a_theme" />
							<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
								onclick="Close()" type="button" />
						</div>
						<div style="display: none;">
							<h:commandButton value="上传" id="importBut"
								action="#{purchaseReturnMB.uploadFile}" />
						</div>
					</h:form>
				</div>
		</f:view>
	</body>
</html>
