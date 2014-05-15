<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.PoinMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>编辑采购入库单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑采购入库单">
		<meta http-equiv="description" content="编辑采购入库单">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/TailHandler.js"></script>
		<script type="text/javascript" src="poin.js"></script>

	</head>
	<%
	    String id = "";
	    PoinMB ai = (PoinMB) MBUtil.getManageBean("#{poinMB}");
	    if (request.getParameter("pid") != null) {
	        id = request.getParameter("pid");
	        ai.getMbean().setBiid(id);
	    }
	    ai.getVouch();
	%>
	<body id="mmain_body" onload="initDetail();initEdit();">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;<a href="poin.jsf"
				class="return" title="返回">入库</a>&gt;&gt;</font><b>编辑采购入库单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id=mmain_opt>
						<a4j:outputPanel id="output">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" rendered="#{poinMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{poinMB.updateHead}"
								onclick="if(!updateHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{poinMB.MOD && poinMB.commitStatus}"
								oncomplete="endUpdateHead();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{poinMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50"
								rendered="#{poinMB.DEL && poinMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" onclick="app();"
								rendered="#{poinMB.APP && poinMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{poinMB.approveVouch}" id="submitMBut"
								reRender="input,codePanel,showHeadButton,renderArea,output,tableid,head,detailbutton"
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
								oncomplete="endHuitui();" requestDelay="50" rendered="false" />
							<a4j:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{poinMB.printReport}"
								rendered="#{poinMB.PRN && !poinMB.commitStatus}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output" requestDelay="1000" />
							<a4j:commandButton id="wrBackBut" value="回写单据" type="button"
								rendered="#{poinMB.SPE && !poinMB.commitStatus}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{poinMB.writeBackVouch}" oncomplete="endApp();"
								reRender="output,renderArea" disabled="#{!poinMB.canWriteBack}"
								styleClass="a4j_but1" onclick="startDo();" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>

					<div id=mmain_cnd>
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="采购入库单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{poinMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="来源类型"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{poinMB.mbean.soty}"
											style="width:130px;" disabled="true">
											<f:selectItem itemLabel="入库任务" itemValue="intask" />

										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="来源单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="soco" styleClass="datetime"
											value="#{poinMB.mbean.soco}" disabled="true" />
										<h:inputHidden id="socoid" value="#{poinMB.mbean.soco}" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="入库仓库:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="whid" value="#{poinMB.mbean.whid}"
											style="width:130px;" disabled="true">
											<f:selectItems value="#{warehouseMB.wareList}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="经手人:"></h:outputText>
									</td>
									<td>
										<h:inputText id="opna" styleClass="datetime"
											disabled="#{!poinMB.commitStatus}"
											value="#{poinMB.mbean.opna}" size="20" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="3">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!poinMB.commitStatus}"
											value="#{poinMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<!--
		
		<a4j:outputPanel id="countPage">
			<div id="mmain_cnd">
				<iframe id="view" frameborder="0" src="count.jsf" width="98%"
					height="120px;"></iframe>
			</div>
		</a4j:outputPanel>
		
		-->

					<a4j:outputPanel id="detailbutton"
						rendered="#{poinMB.MOD && poinMB.commitStatus}">
						<a4j:outputPanel>
							<div id=mmain_opt>
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{poinMB.addDetail}"
									reRender="renderArea,output,tableid"
									rendered="#{poinMB.MOD && poinMB.commitStatus&&poinMB.mbean.soty=='intask'}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{poinMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,tableid"
									rendered="#{poinMB.MOD && poinMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{poinMB.MOD && poinMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{poinMB.updateDetail}" reRender="renderArea,output"
									oncomplete="endUpdateDetail();" requestDelay="50" />
								<a4j:commandButton id="impBut" value="导入明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{poinMB.MOD && poinMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									 onclick="showImport()" reRender="renderArea,output,tableid"
									requestDelay="50" />
								<a4j:commandButton id="downloadmb" value="模板下载" type="button"
									rendered="#{poinMB.SPE && poinMB.commitStatus}" onclick="downloadmb()"
									reRender="msg,headButton,renderArea,output,tableid" requestDelay="50"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />	
							</div>
						</a4j:outputPanel>
					</a4j:outputPanel>


					<a4j:outputPanel id="input">
						<a4j:outputPanel rendered="#{poinMB.MOD && poinMB.commitStatus&&poinMB.mbean.soty=='intask'}">
							<div id=mmain_cnd>
								<div style="display: none;">
									<a4j:commandButton id="setCode4DBean" requestDelay="50"
										action="#{poinMB.setCode4DBean}" onclick="startDo();"
										oncomplete="endCode4DBean();" reRender="renderArea,qty" />
								</div>
								<table border="0" cellpadding="1" cellspacing="0">
									<tr>
										<td>
											<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
										</td>
										<td>
											<h:selectOneMenu id="autoItem" value="#{poinMB.autoItem}"
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
												value="#{poinMB.dbean.codetype}" layout="lineDirection"
												onclick="initEdit();t.batyClick(this);">
												<f:selectItems value="#{poinMB.codetypes}" />
											</h:selectOneRadio>
										</td>
									</tr>
								</table>
								<a4j:outputPanel id='codePanel'>
									<table>
										<tr>
											<td width="30px;">
												<h:outputText id="codeTitle" value="条码:"></h:outputText>
											</td>
											<td>
												<h:inputText id="baco" value="#{poinMB.dbean.baco}"
													onblur="t.setCode4DBean();" onfocus="this.select();"
													onkeypress="t.keyPressDeal(this);" styleClass="datetime"
													size="42" />
												<img id="invcode_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectCode();" />
											</td>
											<td width="30px;">
												<h:outputText value="数量:"></h:outputText>
											</td>
											<td oncontextmenu='return(false);' onpaste='return false'>
												<h:inputText id="qty" value="#{poinMB.dbean.qty}"
													onfocus="t.elementFocus();t.canFocus(this);"
													onkeydown="t.keyPressDeal(this);" styleClass="datetime"
													size="10" />
											</td>
											<td width="30px;">
												<h:outputText value="库位:"></h:outputText>
											</td>
											<td>
												<h:inputText id="dwhid" styleClass="datetime" size="15"
													onkeydown="t.keyPressDeal(this);"
													onfocus="this.select();t.elementFocus();"
													value="#{poinMB.dbean.whid}" />
												<img id="whid_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectWahod();" />
											</td>
										</tr>
									</table>
								</a4j:outputPanel>
							</div>
						</a4j:outputPanel>
					</a4j:outputPanel>


					<div>
						<a4j:outputPanel id="tableid">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="select a.did,a.inco,a.baco,a.qty,a.whid,b.inna,b.inty,b.inse,b.colo,c.whna ,a.roid      
								from psde a left join inve b on a.inco = b.inco left join waho c on a.whid = c.whid  
								 Where a.biid = '#{poinMB.mbean.biid}' "
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {psde},tablepk = {did})"
								gcolumn="gcid = roid(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = checkbox);
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 商品名称,name = inna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext = 数量,name = qty,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
									gcid = whna(headtext = 入库货位,name = whna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = baco(headtext = 商品条码,name = baco,width = 240,align = left,type = text,headtype = sort ,datatype = string);
								" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{poinMB.msg}" />
							<h:inputHidden id="roids" value="#{poinMB.roids}" />
							<h:inputHidden id="sellist" value="#{poinMB.sellist}" />
							<h:inputHidden id="filename" value="#{poinMB.fileName}" />
							<h:inputHidden id="updatedata" value="#{poinMB.updatedata}" />
							<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
								reRender="tableid" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="查询商品信息" type="button" action="#{poinMB.selInveBut}"
								id="selInveBut" onclick="if(!selInveBut()){return false};"
								reRender="detailButton" oncomplete="endSelInveBut();"
								requestDelay="50" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
			<div id="import" style="display: none" align="left">
		<h:form id="file" enctype="multipart/form-data">
			<t:inputFileUpload id="upFile" styleClass="upfile"
				storage="file" value="#{poinMB.myFile}" required="true"
				size="75" />
			<div id="mes"></div>
			<div align="center">
				<gw:GAjaxButton value="上传" onclick="return doImport();"
					id="import" theme="a_theme" />
				<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
					onclick="Close()" type="button" />
			</div>
			<div style="display: none;">
				<h:commandButton value="上传" id="importBut"
					action="#{poinMB.uploadFile}" />
			</div>
		</h:form>
	</div>
		</f:view>
	</body>
</html>