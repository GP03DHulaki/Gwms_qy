<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.TraninMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>编辑调拨入库单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑调拨入库单">
		<meta http-equiv="description" content="编辑调拨入库单">
		<script type="text/javascript" src="tranin.js"></script>
	</head>
	<%
	    String id = "";
	    TraninMB ai = (TraninMB) MBUtil.getManageBean("#{traninMB}");
	    if (request.getParameter("pid") != null) {
	        id = request.getParameter("pid");
	        ai.getMbean().setBiid(id);
	    }
	    ai.getVouch();
	%>
	<body id="mmain_body" onload="initEdit();">
		<div id="mmain_nav">
			<font color="#000000">库内处理&gt;&gt;<a id="linkid" title="返回"
				class="return" href="tranin.jsf">调拨入库</a>&gt;&gt;</font><b>编辑调拨入库单</b>
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
								onclick="addNew();" rendered="#{traninMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{traninMB.updateHead}"
								onclick="if(!updateHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{traninMB.MOD && traninMB.commitStatus}"
								oncomplete="endUpdateHead();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{traninMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50"
								rendered="#{traninMB.DEL && traninMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" onclick="app();"
								rendered="#{traninMB.APP && traninMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{traninMB.approveVouch}" id="submitMBut"
								reRender="showHeadButton,renderArea,input,output,detailbutton,showHead,tableid,head"
								oncomplete="endApp();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="tijiao" value="提交" type="button" action=""
								onclick="tijiao()"
								reRender="output,renderArea,head,countPage,detailbutton,input,tableid"
								oncomplete="endTijiao();" requestDelay="50" rendered="false" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
							<!-- 
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="huitui" value="回退" type="button" action=""
								onclick="huitui()"
								reRender="output,renderArea,head,countPage,detailbutton,input,tableid"
								oncomplete="endHuitui();" requestDelay="50" rendered="false" />
							
							<a4j:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{traninMB.printReport}"
								rendered="#{traninMB.PRN && !traninMB.commitStatus}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output" requestDelay="1000" />
							
							<a4j:commandButton id="wrBackBut" value="回写单据" type="button"
								rendered="#{traninMB.SPE && !traninMB.commitStatus}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{traninMB.writeBackVouch}" oncomplete="endApp();"
								reRender="output,renderArea" disabled="#{!traninMB.canWriteBack}"
								styleClass="a4j_but1" onclick="startDo();" />	
							 -->
						</a4j:outputPanel>
					</div>

					<div id=mmain_cnd>
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="调拨入库单:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{traninMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										来源类型:
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{traninMB.mbean.soty}"
											style="width:130px;" disabled="true">
											<f:selectItem itemLabel="调拨计划" itemValue="TRANPLAN" />
											<f:selectItem itemLabel="调拨出库" itemValue="TRANOUT" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="来源单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="soco" styleClass="datetime"
											value="#{traninMB.mbean.soco}" disabled="true" />
									</td>

								</tr>
								<tr>
									<td>
										<h:outputText value="入库仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="owna" styleClass="datetime"
											value="#{traninMB.mbean.owna}" disabled="true" />
									</td>
									<td>
										经手人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											disabled="#{!traninMB.commitStatus}"
											value="#{traninMB.mbean.opna}" />
									</td>
									<td>
										组织架构:
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{traninMB.mbean.orid}"
											disabled="#{!traninMB.commitStatus}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!traninMB.commitStatus}"
											value="#{traninMB.mbean.rema}" size="100" />
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
					<div id=mmain_opt>
						<a4j:outputPanel id="detailbutton">
							<a4j:outputPanel
								rendered="#{traninMB.MOD && traninMB.commitStatus}">
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{traninMB.addDetail}"
									reRender="renderArea,output,tableid"
									rendered="#{traninMB.MOD && traninMB.commitStatus}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{traninMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,tableid"
									rendered="#{traninMB.MOD && traninMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{false && traninMB.MOD && traninMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{traninMB.updateDetail}" reRender="renderArea,output"
									oncomplete="endUpdateDetail();" requestDelay="50" />
									<a4j:commandButton id="impBut" value="导入明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{traninMB.MOD && traninMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									 onclick="showImport()" reRender="msg,renderArea,output"
									requestDelay="50" />
								<a4j:commandButton id="downloadmb" value="模板下载" type="button"
									rendered="#{traninMB.SPE && traninMB.commitStatus}" onclick="downloadmb()"
									reRender="msg,headButton,detailButton,outdetail" requestDelay="50"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="input">
							<a4j:outputPanel
								rendered="#{traninMB.MOD && traninMB.commitStatus}">
								<table border="0" cellpadding="1" cellspacing="0">
									<tbody>
										<tr>
											<td>
												<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
											</td>
											<td>
												<h:selectOneMenu id="autoItem" value="#{traninMB.autoItem}"
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
													value="#{traninMB.dbean.codetype}" layout="lineDirection"
													onclick="initEdit();t.batyClick(this);">
													<f:selectItems value="#{traninMB.codetypes}" />
												</h:selectOneRadio>
											</td>
										<tr>
									</tbody>
								</table>
								<table>
									<tbody>
										<tr>
											<td>
												<h:outputText value="条码:"></h:outputText>
											</td>
											<td>
												<h:inputText id="baco" value="#{traninMB.dbean.baco}"
													styleClass="datetime" size="32" onkeypress="clickInve();" />
												<img id="invcode_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectInveAddEx();" />
											</td>
											<td>
												<h:outputText value="数量:"></h:outputText>
											</td>
											<td>
												<h:inputText id="qty" value="#{traninMB.dbean.qty}"
													onkeyup="this.value=this.value.replace(/\D|^0/g,'')"
													styleClass="datetime" size="16" />
											</td>
											<td>
												<h:outputText value="库位:"></h:outputText>
											</td>
											<td>
												<h:inputText id="dwhid" value="#{traninMB.dbean.whid}"
													styleClass="datetime" size="15" />
												<img id="invcode_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectDWare();" />
											</td>
										</tr>
									</tbody>
								</table>
								<!-- 
								<table>
									<tr>
										<td>
											<h:outputText value="商品属性:"></h:outputText>
										</td>
										<td width = "130px;">
											<h:selectOneRadio id="ch_dflag" value="01"  
												layout="lineDirection" onclick = "tobarcode();">
												<f:selectItem itemLabel="正品" itemValue="01" />
												<f:selectItem itemLabel="残品" itemValue="02" />
											</h:selectOneRadio>
										</td>
										<td>
											<h:outputText value="商品编码:"></h:outputText>
										</td>
										<td>
											<h:inputText id="inco" value="#{traninMB.dbean.inco}"
												styleClass="datetime" size="16" onkeypress="clickInve();" />
											<img id="invcode_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectInveAdd();" />
										</td>
										<td>
											<h:outputText value="数量:"></h:outputText>
										</td>
										<td>
											<h:inputText id="qty1" value="#{traninMB.dbean.qty}"
												styleClass="datetime" size="16" />
										</td>
										<td>
											<h:outputText value="货位编码:"></h:outputText>
										</td>
										<td>
											<h:inputText id="dwhid1" styleClass="datetime"
												value="#{traninMB.dbean.whid}" disabled="false" />
											<img id="whid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectWahod();" />
										</td>
									</tr>
								</table>
							 -->
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>

					<div>
						<a4j:outputPanel id="tableid">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="select a.did,a.roid,a.inco,a.qty,a.whid,b.inna,b.inty,p.tyna,b.inst,b.volu,b.newe,b.inpr,b.inse,b.colo,c.whna       
								from pade a left join inve b on a.inco = b.inco left join waho c on a.whid = c.whid  
								left join prty p on p.inty = b.inty
								 Where a.biid = '#{traninMB.mbean.biid}' "
								gpage="(pagesize = -1)" gversion="2"
								gupdate="(table = {psde},tablepk = {roid})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = checkbox);
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 商品名称,name = inna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = tyna(headtext = 商品品类,name = inty,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 规格码,name = inse,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 规格,name = colo,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext =  数量,name = qty,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
									gcid = whid(headtext = 入库货位,name = whid,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = whna(headtext = 入库货位,name = whna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{traninMB.msg}" />
							<h:inputHidden id="roids" value="#{traninMB.roids}" />
							<h:inputHidden id="sellist" value="#{traninMB.sellist}" />
							<h:inputHidden id="filename" value="#{traninMB.fileName}" />
							<h:inputHidden id="updatedata" value="#{traninMB.updatedata}" />
							<h:inputHidden id="powh" value="#{traninMB.mbean.powh}" />
							<h:inputHidden id="pfwh" value="#{traninMB.mbean.pfwh}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="查询商品信息" type="button" action="#{traninMB.selInveBut}"
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
							value="#{traninMB.myFile}" required="true" size="75" />
						<div id="mes"></div>
						<div align="center">
							<gw:GAjaxButton value="上传" onclick="return doImport();"
								id="import" theme="a_theme" />
							<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
								onclick="Close()" type="button" />
						</div>
						<div style="display: none;">
							<h:commandButton value="上传" id="importBut"
								action="#{traninMB.uploadFile}" />
						</div>
					</h:form>
				</div>
		</f:view>
	</body>
</html>