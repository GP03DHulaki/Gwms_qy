<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@	page import="com.gwall.view.TranOutMB"%>

<%
	TranOutMB ai = (TranOutMB) MBUtil.getManageBean("#{tranOutMB}");
	ai.getVouch();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑出库明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="编辑出库明细">
		<script type="text/javascript" src="tranout.js"></script>
	</head>
	<body id=mmain_body onload="initEdit();initDetail();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id="mmain_nav">
						<div id="mmain_nav">
							<font color="#000000"> 库内处理 &gt;&gt;<a id="linkid"
								href="tranout.jsf" class="return" title="返回">调拨出库</a>&gt;&gt;</font><b>编辑调拨出库单</b>
							<br>
						</div>
					</div>
					<div id="mmain_opt">

					</div>
					<a4j:outputPanel id="renderArea">
						<div style="display: none;">
							<h:inputHidden id="msg" value="#{tranOutMB.msg}" />
							<h:inputHidden id="sellist" value="#{tranOutMB.sellist}" />
							<h:inputHidden id="updatedata" value="#{tranOutMB.updatedata}" />
							<h:inputHidden id="filename" value="#{tranOutMB.fileName}" />
							<h:inputHidden id="pfwh" value="#{tranOutMB.mbean.pfwh}" />
							<h:inputHidden id="powh" value="#{tranOutMB.mbean.powh}" />
						</div>
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
							reRender="outdetail,headmain" />
					</div>
					<a4j:outputPanel id="headButton">
						<div id="mmain_opt">
							<gw:GAjaxButton value="添加单据" theme="b_theme"
								action="#{tranOutMB.clearMBean}" oncomplete="addNew();"
								id="addHead" rendered="#{tranOutMB.ADD}" />
							<gw:GAjaxButton theme="b_theme" id="updateId" value="保存单据"
								type="button" onclick="if(!addHead()){return false};"
								action="#{tranOutMB.updateHead}"
								reRender="msg,headButton,detailButton,outdetail"
								oncomplete="endDo();" requestDelay="50"
								rendered="#{tranOutMB.MOD && tranOutMB.commitStatus}" />
							<gw:GAjaxButton theme="b_theme" id="delMBut" value="删除单据"
								type="button" action="#{tranOutMB.deleteHead}"
								onclick="deleteHead()" oncomplete="endDeleteHead();"
								requestDelay="50" reRender="msg,headButton,detailButton"
								rendered="#{tranOutMB.DEL && tranOutMB.commitStatus}" />
							<gw:GAjaxButton theme="b_theme"
								rendered="#{tranOutMB.APP && tranOutMB.commitStatus}"
								id="appMBut" value="审核单据" type="button"
								action="#{tranOutMB.approveVouch}"
								onclick="if(!checkApp()){return false};"
								reRender="msg,headButton,detailButton,outdetail,opna,iwimgPanel,rema,soty"
								oncomplete="endApp();" requestDelay="50" />
							<a4j:commandButton id="wrBackBut" value="回写单据" type="button"
								rendered="#{false && tranOutMB.SPE && !tranOutMB.commitStatus}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{tranOutMB.writeBackVouch}" oncomplete="endApp();"
								reRender="headButton,msg" disabled="#{!tranOutMB.canWriteBack}"
								styleClass="a4j_but1" onclick="startDo();" />
							<a4j:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{tranOutMB.printReport}"
								rendered="#{tranOutMB.PRN && !tranOutMB.commitStatus}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output" requestDelay="1000" />
							<a4j:commandButton type="button" value="无单价打印"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{tranOutMB.printReportNoprice}"
								rendered="#{false && tranOutMB.PRN && !tranOutMB.commitStatus}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output" requestDelay="1000" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="headmain">
						<div id=mmain_cnd>
							<table cellpadding="0" cellspacing="3" border="0">
								<tr>
									<td colspan="4">
										调拨出库:
										<h:inputText id="biid" styleClass="inputtext" size="20"
											value="#{tranOutMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
										来源类型:
										<h:selectOneMenu id="soty" value="#{tranOutMB.mbean.soty}"
											style="width:130px;" disabled="true">
											<f:selectItem itemLabel="调拨计划" itemValue="TRANPLAN" />
											<f:selectItem itemLabel="无" itemValue="" />
										</h:selectOneMenu>
									</td>
									<td>
										<a4j:outputPanel id="socoPanel"
											rendered="#{tranOutMB.mbean.soty=='' ? false : true}">
										来源单号: 
										<h:inputText id="soco" size="20" styleClass="inputtext"
												value="#{tranOutMB.mbean.soco}" disabled="true" />
										</a4j:outputPanel>
									</td>
								</tr>
								<tr>
									<td colspan="4" id="whid_td">
										出库仓库:
										<h:inputText id="whna" size="20" styleClass="inputtext"
											value="#{tranOutMB.mbean.fwna}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
										入库仓库:
										<h:inputText id="owna" size="20" styleClass="inputtext"
											value="#{tranOutMB.mbean.owna}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
										<a4j:outputPanel id="iwimgPanel"
											rendered="#{tranOutMB.commitStatus && tranOutMB.mbean.soty=='' ? true : false}">
											<img id="iwid_img" style="cursor: pointer"
												src="../../images/find.gif"
												onclick="return selectWaho1('edit:powh','edit:owna');" />
										</a4j:outputPanel>
									</td>
									<td>
										组织架构:
										<h:selectOneMenu id="orid" value="#{tranOutMB.mbean.orid}"
											disabled="#{!tranOutMB.commitStatus}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td colspan="5">
										经&nbsp;手&nbsp;&nbsp;人:
										<h:inputText id="opna" styleClass="inputtext" size="20"
											disabled="#{!tranOutMB.commitStatus}"
											value="#{tranOutMB.mbean.opna}" />
										备&nbsp;&nbsp;&nbsp;注:
										<h:inputText id="rema" styleClass="inputtext" size="50"
											disabled="#{!tranOutMB.commitStatus}"
											value="#{tranOutMB.mbean.rema}" />
									</td>
								</tr>
							</table>
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="detailButton">
						<a4j:outputPanel rendered="#{tranOutMB.commitStatus}">
							<div id="mmain_opt">
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{tranOutMB.addDetail}"
									reRender="msg,headButton,detailButton,outdetail"
									rendered="#{tranOutMB.ADD && tranOutMB.commitStatus}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{false && tranOutMB.MOD && tranOutMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{tranOutMB.updateDetail}"
									reRender="msg,headButton,detailButton,outdetail"
									oncomplete="endUpdateDetail();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{tranOutMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="msg,headButton,detailButton,outdetail"
									rendered="#{tranOutMB.DEL && tranOutMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<a4j:commandButton id="impBut" value="导入明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{tranOutMB.MOD && tranOutMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									 onclick="showImport()" reRender="msg,headButton,detailButton,outdetail"
									requestDelay="50" />
								<a4j:commandButton id="downloadmb" value="模板下载" type="button"
									rendered="#{tranOutMB.SPE && tranOutMB.commitStatus}" onclick="downloadmb()"
									reRender="msg,headButton,detailButton,outdetail" requestDelay="50"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />

								<!-- 
								<a4j:commandButton id="addDetails" value="导入计划明细"
									onmouseover="this.className='a4j_over1'"
									action="#{tranOutMB.importBatch}"
									onclick="Gwallwin.winShowmask('TRUE')"
									oncomplete="finishimport();"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" reRender="renderArea,outdetail"
									rendered="#{tranOutMB.SPE && tranOutMB.commitStatus}"
									requestDelay="50" />
								 -->
							</div>
							<div id="mmain_cnd">
								<div style="display: none;">
									<a4j:commandButton id="setCode4DBean" requestDelay="50"
										action="#{tranOutMB.setCode4DBean}" onclick="startDo();"
										oncomplete="endCode4DBean();" reRender="renderArea,qty" />
								</div>
								<table border="0" cellpadding="1" cellspacing="0">
									<tr>
										<td>
											<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
										</td>
										<td>
											<h:selectOneMenu id="autoItem" value="#{tranOutMB.autoItem}"
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
												value="#{tranOutMB.dbean.codetype}" layout="lineDirection"
												onclick="initEdit();t.batyClick(this);">
												<f:selectItems value="#{tranOutMB.codetypes}" />
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
											<h:inputText id="dwhid" value="#{tranOutMB.dbean.whid}"
												styleClass="datetime" size="22" />
											<img id="invcode_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectDWare();" />
										</td>
										<td>
											<h:outputText value="条码:"></h:outputText>
										</td>
										<td>
											<h:inputText id="baco" value="#{tranOutMB.dbean.baco}"
												onblur="t.setCode4DBean();" onfocus="this.select();"
												styleClass="datetime" size="42"
												onkeypress="t.keyPressDeal(this);" />
											<img id="invcode_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectInveAdd();" />
										</td>
										<td>
											<h:outputText value="数量:"></h:outputText>
										</td>
										<td>
											<h:inputText id="qty" value="#{tranOutMB.dbean.qty}"
												onfocus="t.elementFocus();t.canFocus(this);"
												onkeydown="t.keyPressDeal(this);" styleClass="datetime"
												size="10" />
										</td>

									</tr>
								</table>
							</div>
						</a4j:outputPanel>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="outdetail">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											Select a.did,a.roid,a.inco,a.baco,a.qty,a.whid,b.inna,b.inty,
											b.inse,b.volu,b.newe,b.inpr,b.colo,b.asco,b.psco,a.fqty     
											From pbde a left join inve b On a.inco = b.inco  
											Where a.biid = '#{tranOutMB.mbean.biid}'
											"
										gpage="(pagesize = -1)"
										gupdate="(table = {pbde},tablepk = {roid})"
										gcolumn="gcid = roid(headtext = selall,name = roid,width = 30,align = center,type = checkbox ,headtype = #{tranOutMB.commitStatus ? 'checkbox' : 'hidden'});
											gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
											gcid = inco(headtext = 商品编码,name = inco,width = 150,align = left,type = text,headtype = sort ,datatype = string);
											gcid = inna(headtext = 商品名称,name = inna,width = 150,align = left,type = text,headtype = sort ,datatype = string);
											gcid = baco(headtext = 商品条码,name = baco,width = 240,align = left,type = text,headtype = sort ,datatype = string);
											gcid = whid(headtext = 库位编码,name = whid,width = 120,align = left,type = text,headtype= sort,update=edit,headtype = sort ,datatype = string);
											gcid = colo(headtext = 规格,name = colo,width = 120,align = left,type = text,headtype = sort ,datatype = string);
											gcid = inse(headtext = 规格码,name = inse,width = 120,align = left,type = text,headtype = sort ,datatype = string);
											gcid = qty(headtext =  出库数量,name = qty,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});			
											gcid = fqty(headtext =  入库数量,name = fqty,width = 80,align = right,type = text,headtype= #{tranOutMB.commitStatus ? 'hidden' : 'sort'}, datatype =number,dataformat=0.##,update=edit,#{tranOutMB.commitStatus ? '' : 'summary=this,'}gscript={onkeypress=return isInteger(event)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});									
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
				</h:form>
				<div id="import" style="display: none" align="left">
					<h:form id="file" enctype="multipart/form-data">
						<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
							value="#{tranOutMB.myFile}" required="true" size="75" />
						<div id="mes"></div>
						<div align="center">
							<gw:GAjaxButton value="上传" onclick="return doImport();"
								id="import" theme="a_theme" />
							<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
								onclick="Close()" type="button" />
						</div>
						<div style="display: none;">
							<h:commandButton value="上传" id="importBut"
								action="#{tranOutMB.uploadFile}" />
						</div>
					</h:form>
				</div>
			</f:view>
		</div>
	</body>
</html>