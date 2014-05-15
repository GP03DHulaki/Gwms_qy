<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.OtherOutMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>编辑其它出库单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑其它出库单">
		<meta http-equiv="description" content="编辑其它出库单">
		<script type='text/javascript' src='otherout.js'></script>

	</head>
	<%
	    String id = "";
	    OtherOutMB ai = (OtherOutMB) MBUtil.getManageBean("#{otherOutMB}");
	    if (request.getParameter("pid") != null) {
	        id = request.getParameter("pid");
	        ai.getMbean().setBiid(id);
	    }
	    ai.getVouch();
	%>
	<body id="mmain_body" onload="initEdit();initDetail();">
		<div id="mmain_nav">
			<a id="linkid" href="otherout.jsf" class="return" title="返回">出库处理</a>&gt;&gt;
			<b>编辑其它出库单</b>
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
								onclick="addNew();" rendered="#{otherOutMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{otherOutMB.updateHead}"
								onclick="if(!updateHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{otherOutMB.MOD && otherOutMB.commitStatus}"
								oncomplete="endUpdateHead();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{otherOutMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50"
								rendered="#{otherOutMB.DEL && otherOutMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" id="submitMBut"
								onclick="app();"
								rendered="#{otherOutMB.APP && otherOutMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{otherOutMB.approveVouch}"
								reRender="renderArea,output,detailbutton,head,tableid,input"
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
								action="#{otherOutMB.printReport}"
								rendered="#{otherOutMB.PRN && !otherOutMB.commitStatus}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output" requestDelay="1000" />
							<a4j:commandButton id="wrBackBut" value="回写单据" type="button"
								rendered="#{otherOutMB.SPE && !otherOutMB.commitStatus}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{otherOutMB.writeBackVouch}" oncomplete="endApp();"
								reRender="output,renderArea"
								disabled="#{!otherOutMB.canWriteBack}" styleClass="a4j_but1"
								onclick="startDo();" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="showOutput('gtable')" type="button" reRender="output" />
						</a4j:outputPanel>
					</div>

					<div id=mmain_cnd>
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="单据单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{otherOutMB.mbean.biid}" disabled="true" />
									</td>

									<td>
										<h:outputText value="业务类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="dety" value="#{otherOutMB.mbean.dety}"
											disabled="#{!otherOutMB.commitStatus}" style="width:130px;">
											<f:selectItems value="#{otherOutMB.butys}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="组织架构:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="orid1" value="#{otherOutMB.mbean.orid}"
											disabled="#{!otherOutMB.commitStatus}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="出库仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whna" styleClass="datetime"
											value="#{otherOutMB.mbean.whna}" disabled="true" />
										<h:inputHidden id="whid" value="#{otherOutMB.mbean.whid}" />
										<a4j:outputPanel
											rendered="#{otherOutMB.commitStatus && false }">
											<img id="invcode_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectWaho();" />
										</a4j:outputPanel>
									</td>
									<td>
										经&nbsp;&nbsp;手&nbsp;人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											disabled="#{!otherOutMB.commitStatus}"
											value="#{otherOutMB.mbean.opna}" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!otherOutMB.commitStatus}"
											value="#{otherOutMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div id=mmain_opt>
						<a4j:outputPanel id="detailbutton">
							<a4j:outputPanel
								rendered="#{otherOutMB.MOD && otherOutMB.commitStatus}">
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{otherOutMB.addDetail}"
									reRender="renderArea,output,tableid,msg"
									rendered="#{otherOutMB.ADD && otherOutMB.commitStatus}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="inButton" value="导入明细"
									rendered="#{otherOutMB.MOD && otherOutMB.commitStatus}"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="showImport();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{otherOutMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,tableid"
									rendered="#{otherOutMB.DEL && otherOutMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{otherOutMB.MOD && otherOutMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{otherOutMB.updateDetail}"
									reRender="renderArea,output,tableid"
									oncomplete="endUpdateDetail();" requestDelay="50" />
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="input">
							<h:panelGroup
								rendered="#{otherOutMB.MOD && otherOutMB.commitStatus}">
								<div style="display: none;">
									<a4j:commandButton id="setCode4DBean" requestDelay="50"
										action="#{otherOutMB.setCode4DBean}" onclick="startDo();"
										oncomplete="endCode4DBean();" reRender="input,renderArea" />
								</div>
								<table border="0" cellpadding="1" cellspacing="0">
									<tbody>
										<tr>
											<td>
												<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
											</td>
											<td>
												<h:selectOneMenu id="autoItem"
													value="#{otherOutMB.autoItem}"
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
													value="#{otherOutMB.dbean.codetype}" layout="lineDirection"
													onclick="initEdit();t.batyClick(this);">
													<f:selectItems value="#{otherOutMB.codetypes}" />
												</h:selectOneRadio>
											</td>
										</tr>
									</tbody>
								</table>
								<table border="0" cellpadding="0" cellspacing="0">
									<tbody>
										<tr>
											<td width="30px;">
												<h:outputText value="库位:"></h:outputText>
											</td>
											<td>
												<h:inputText id="dwhid" styleClass="datetime" size="15"
													onkeydown="t.keyPressDeal(this);" onfocus="this.select();"
													value="#{otherOutMB.dbean.whid}" />
												<img id="whid_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectWahod();" />
											</td>
											<td width="30px;">
												<h:outputText id="codeTitle" value="条码:"></h:outputText>
											</td>
											<td>
												<h:inputText id="baco" value="#{otherOutMB.dbean.baco}"
													onblur="t.setCode4DBean();" onfocus="this.select();"
													styleClass="datetime" size="42"
													onkeypress="t.keyPressDeal(this);" />
												<img id="invcode_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectCode();" />
											</td>
											<td width="30px;">
												<h:outputText value="数量:"></h:outputText>
											</td>
											<td oncontextmenu='return(false);' onpaste='return false'>
												<h:inputText id="qty" value="#{otherOutMB.dbean.qty}"
													onfocus="t.elementFocus();t.canFocus(this);"
													onkeydown="t.keyPressDeal(this);" styleClass="datetime"
													size="10" />
											</td>
										</tr>
									</tbody>
								</table>
							</h:panelGroup>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="tableid">
						<g:GTable gid="gtable" gtype="grid" gdebug="false"
							gselectsql="
								select a.did,a.inco,a.qty,a.whid,b.inna,a.roid,a.baco,
								b.inty,b.inse,b.volu,b.newe,b.inpr,b.colo,
								c.whna       
								from oode a 
								left join inve b on a.inco = b.inco 
								left join waho c on a.whid = c.whid  
								Where a.biid = '#{otherOutMB.mbean.biid}' "
							gpage="(pagesize = -1)" gversion="2"
							gupdate="(table = {oode},tablepk = {did})"
							gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = #{otherOutMB.commitStatus ? 'checkbox' : 'hidden'});
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = roid(headtext = roid,name = roid ,type = text,headtype = hidden ,datatype = string);
									gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 商品名称,name = inna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext = 数量,name = qty,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
									gcid = baco(headtext = 商品条码,name = baco,width = 260,align = left,type = text,headtype = sort ,datatype = string);
									gcid = whna(headtext = 出库库位名称,name = whid,width = 120,align = left,type = text,headtype = sort ,datatype = string);
							" />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderArea">
						<a4j:outputPanel>
							<h:inputHidden id="roids" value="#{otherOutMB.roids}" />
							<h:inputHidden id="sellist" value="#{otherOutMB.sellist}" />
							<h:inputHidden id="filename" value="#{otherOutMB.fileName}" />
							<h:inputHidden id="updatedata" value="#{otherOutMB.updatedata}" />
							<h:inputHidden id="msg" value="#{otherOutMB.msg}" />
						</a4j:outputPanel>
					</a4j:outputPanel>

					<div style="display: none;">
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询商品信息" type="button" action="#{otherOutMB.selInveBut}"
							id="selInveBut" onclick="if(!selInveBut()){return false};"
							reRender="detailButton" oncomplete="endSelInveBut();"
							requestDelay="50" />
					</div>
				</div>
			</h:form>
			<div id="import" style="display: none" align="left">
				<h:form id="file" enctype="multipart/form-data">
					<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
						value="#{otherOutMB.myFile}" required="true" size="75" />
					<div id="mes"></div>
					<div align="center">
						<gw:GAjaxButton value="上传" onclick="return doImport();"
							id="import" theme="a_theme" />
						<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
							onclick="hideDiv()" type="button" />
					</div>
					<div style="display: none;">
						<h:commandButton value="上传" id="importBut"
							action="#{otherOutMB.uploadFile}" />
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>