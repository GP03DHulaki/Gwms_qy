<%@ page language="java" pageEncoding="UTF-8"%><%@ include
	file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.OtherinMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>编辑其它入库单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑其它入库单">
		<meta http-equiv="description" content="编辑其它入库单">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/TailHandler.js"></script>
		<script type="text/javascript" src="otherin.js"></script>
	</head>
	<%
	    String id = "";
	    OtherinMB ai = (OtherinMB) MBUtil.getManageBean("#{otherinMB}");
	    if (request.getParameter("pid") != null) {
	        id = request.getParameter("pid");
	        ai.getMbean().setBiid(id);
	    }
	    ai.getVouch();
	%>
	<body id="mmain_body" onload="initEdit();initDetail();">

		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;<a href="otherin.jsf"
				title="返回" class="return">入库</a>&gt;&gt;</font><b>编辑其它入库单</b>
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
								onclick="addNew();" rendered="#{otherinMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{otherinMB.updateHead}"
								onclick="if(!updateHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{otherinMB.MOD && otherinMB.commitStatus}"
								oncomplete="endUpdateHead();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{otherinMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50"
								rendered="#{otherinMB.DEL && otherinMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" id="submitMBut"
								onclick="if(!app()){return false};"
								rendered="#{otherinMB.APP && otherinMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{otherinMB.approveVouch}"
								reRender="showHeadButton,renderArea,output,detailbutton,showHead,head,tableid,input"
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
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="showOutput('gtable')" type="button" reRender="output" />
						</a4j:outputPanel>
					</div>

					<div id=mmain_cnd>
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="其它入库单:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{otherinMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="业务类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="dety" value="#{otherinMB.mbean.dety}"
											style="width:130px;" disabled="true">
											<f:selectItems value="#{otherinMB.butys}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="组织架构:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{otherinMB.mbean.orid}"
											disabled="true">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="入库仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whna" styleClass="datetime"
											value="#{otherinMB.mbean.whna}" disabled="true" />
										<h:inputHidden id="whid" value="#{otherinMB.mbean.whid}" />
									</td>
									<td id="initdisplay" colspan="2" style="display: none;">
										其他出库单号:
										<h:inputText id="srid" value="#{otherinMB.mbean.soco}"
											styleClass="datetime" size="16" disabled="true" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="4">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!otherinMB.commitStatus}"
											value="#{otherinMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div id=mmain_opt>
						<a4j:outputPanel id="detailbutton">
							<a4j:outputPanel
								rendered="#{otherinMB.MOD && otherinMB.commitStatus}">
								<a4j:commandButton id="addDBut" value="添加明细"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{otherinMB.addDetail}"
									reRender="renderArea,output,tableid"
									rendered="#{otherinMB.MOD && otherinMB.commitStatus}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="inButton" value="导入明细"
									rendered="#{otherinMB.MOD && otherinMB.commitStatus}"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="showImport();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明细"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{otherinMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,tableid"
									rendered="#{otherinMB.MOD && otherinMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:commandButton id="setCode4DBean" requestDelay="50"
							action="#{otherinMB.setCode4DBean}" onclick="startDo();"
							oncomplete="endCode4DBean();" reRender="input,renderArea" />
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="input">
							<h:panelGroup layout="block"
								rendered="#{otherinMB.MOD && otherinMB.commitStatus}">
								<table border="0" cellpadding="1" cellspacing="0">
									<tbody>
										<tr>
											<td>
												<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细" />
											</td>
											<td>
												<h:selectOneMenu id="autoItem" value="#{otherinMB.autoItem}"
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
													value="#{otherinMB.dbean.codetype}" layout="lineDirection"
													onclick="initEdit();t.batyClick(this);">
													<f:selectItems value="#{otherinMB.codetypes}" />
												</h:selectOneRadio>
											</td>
										<tr>
									</tbody>
								</table>
								<table border="0" cellpadding="0" cellspacing="0">
									<tbody>
										<tr>
											<td width="30px;">
												<h:outputText id="codeTitle" value="条码:"></h:outputText>
											</td>
											<td>
												<h:inputText id="baco" value="#{otherinMB.dbean.baco}"
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
												<h:inputText id="qty" value="#{otherinMB.dbean.qty}"
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
													value="#{otherinMB.dbean.whid}" />
												<img id="whid_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectWahod();" />
											</td>
										</tr>
									</tbody>
								</table>
							</h:panelGroup>
						</a4j:outputPanel>
					</div>
					<div>
						<a4j:outputPanel id="tableid">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="select a.did,a.roid,a.baco,a.inco,a.qty,a.whid,b.inna,b.inty,b.inse,b.volu,b.newe,b.inpr,b.colo,c.whna       
								from oide a left join inve b on a.inco = b.inco left join waho c on a.whid = c.whid  
								 Where a.biid = '#{otherinMB.mbean.biid}' "
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {oide},tablepk = {did})"
								gcolumn="gcid = roid(headtext = selall,name = roid,width = 20,align = center,type = checkbox,headtype = #{otherinMB.commitStatus ? 'checkbox' : 'hidden'});
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = inco(headtext = 商品编码,name = inco,width = 130,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 商品名称,name = inna,width = 160,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext = 数量,name = qty,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
									gcid = baco(headtext = 商品条码,name = baco,width = 180,align = left,type = text,headtype = sort ,datatype = string);
									gcid = whna(headtext = 库位名称,name = whna,width = 100,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inty(headtext = 商品品类,name = inty,width = 60,align = left,type = text,headtype = hidden ,datatype = string);
								" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{otherinMB.msg}" />
						<h:inputHidden id="roids" value="#{otherinMB.roids}" />
						<h:inputHidden id="sellist" value="#{otherinMB.sellist}" />
						<h:inputHidden id="filename" value="#{otherinMB.fileName}" />
						<h:inputHidden id="updatedata" value="#{otherinMB.updatedata}" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询商品信息" type="button" action="#{otherinMB.selInveBut}"
							id="selInveBut" onclick="if(!selInveBut()){return false};"
							reRender="detailButton" oncomplete="endSelInveBut();"
							requestDelay="50" />
					</div>

				</div>
			</h:form>
			<div id="import" style="display: none" align="left">
				<h:form id="file" enctype="multipart/form-data">
					<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
						value="#{otherinMB.myFile}" required="true" size="75" />
					<div id="mes"></div>
					<div align="center">
						<gw:GAjaxButton value="上传" onclick="return doImport();"
							id="import" theme="a_theme" />
						<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
							onclick="hideDiv()" type="button" />
					</div>
					<div style="display: none;">
						<h:commandButton value="上传" id="importBut"
							action="#{otherinMB.uploadFile}" />
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>