<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.StockOutMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
    StockOutMB ai = (StockOutMB) MBUtil.getManageBean("#{stockOutMB}");
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
		<script type="text/javascript" src="stockout.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/Msgbox.js"></script>
	</head>
	<body id='mmain_body' onload="initEdit();initDetail();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_nav>
						<a id="linkid" href="stockout.jsf" class="return" title="返回">出库处理</a>&gt;&gt;
						<b>编辑出库明细</b>
						<br>
					</div>
					<div id=mmain_opt>

					</div>
					<a4j:outputPanel id="message">
						<div style="display: none;">
							<h:inputHidden id="msg" value="#{stockOutMB.msg}" />
							<h:inputHidden id="sellist" value="#{stockOutMB.sellist}" />
							<h:inputHidden id="filename" value="#{stockOutMB.fileName}" />
							<h:inputHidden id="updatedata" value="#{stockOutMB.updatedata}" />
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="headButton">
						<div id=mmain_opt>
							<gw:GAjaxButton value="添加单据" theme="b_theme"
								action="#{stockOutMB.clearMBean}" oncomplete="addNew();"
								id="addHead" rendered="#{stockOutMB.ADD}" />

							<gw:GAjaxButton theme="b_theme" id="updateId" value="保存单据"
								type="button" onclick="if(!addHead()){return false};"
								action="#{stockOutMB.updateHead}"
								reRender="msg,headButton,detailButton,headmain,outdetail"
								oncomplete="endDo();" requestDelay="50"
								rendered="#{stockOutMB.MOD && stockOutMB.commitStatus}" />

							<gw:GAjaxButton theme="b_theme" id="delMBut" value="删除单据"
								type="button" action="#{stockOutMB.deleteHead}"
								onclick="deleteHead()" oncomplete="endDeleteHead();"
								requestDelay="50"
								reRender="msg,headButton,headmain,detailButton"
								rendered="#{stockOutMB.DEL && stockOutMB.commitStatus}" />

							<a4j:commandButton
								onmouseover="this.className='a4j_over1';msgbox.show('审核成功后即会扣减相应库存');"
								onmouseout="this.className='a4j_buton1';msgbox.hide();"
								styleClass="a4j_but1"
								rendered="#{stockOutMB.APP && stockOutMB.commitStatus}"
								id="appMBut" value="审核单据" type="button"
								action="#{stockOutMB.approveVouch}"
								onclick="if(!checkApp()){return false};"
								reRender="msg,headButton,detailButton,headmain,outdetail"
								oncomplete="endApp();" requestDelay="50" />
							<!-- 
							<a4j:commandButton id="wrBackBut" value="回写单据" type="button"
								rendered="#{stockOutMB.SPE && !stockOutMB.commitStatus}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{stockOutMB.writeBackVouch}" oncomplete="endApp();"
								reRender="headButton,msg" disabled="#{!stockOutMB.canWriteBack}"
								styleClass="a4j_but1" onclick="startDo();" />
							 -->

							<a4j:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{stockOutMB.printReport}"
								rendered="#{stockOutMB.PRN && !stockOutMB.commitStatus && false}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output,msg,message"
								requestDelay="1000" />

							<a4j:commandButton type="button" value="总仓打印"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{stockOutMB.printReportPackage}"
								rendered="#{stockOutMB.PRN && !stockOutMB.commitStatus && false}"
								styleClass="a4j_but1" onclick="printReportPackage();"
								oncomplete="endPrintReportPackage();"
								reRender="renderArea,outTable,output,msg,message"
								requestDelay="1000" />

							<a4j:commandButton type="button" value="乐购打印"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{stockOutMB.printReportLt}"
								rendered="#{stockOutMB.PRN && !stockOutMB.commitStatus && false}"
								styleClass="a4j_but1" onclick="printReportLt();"
								oncomplete="endPrintReportLt();"
								reRender="renderArea,outTable,output,msg,message"
								requestDelay="1000" />

						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="headmain">
						<div id=mmain_cnd>
							<table cellpadding="3" cellspacing="0" border="0">
								<tr>
									<td>
										出库单号:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext" size="20"
											value="#{stockOutMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
									</td>
									<td>
										来源类型:
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{stockOutMB.mbean.soty}"
											style="width:130px;" disabled="true">
											<f:selectItem itemLabel="出库订单" itemValue="OUTORDER" />
											<f:selectItem itemLabel="装车计划" itemValue="ENTRUCKPLAN" />
										</h:selectOneMenu>
									</td>
									<td>
										来源单号:
									</td>
									<td>
										<h:inputText id="soco" size="20" styleClass="inputtext"
											value="#{stockOutMB.mbean.soco}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
										<a4j:outputPanel
											rendered="#{stockOutMB.commitStatus && false}">
											<img id="suid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectFrom();" />
										</a4j:outputPanel>
									</td>
								</tr>
								<tr>
									<td>
										出库仓库:
									</td>
									<td>
										<h:inputText id="whna" styleClass="inputtext" size="20"
											value="#{stockOutMB.mbean.whna}" disabled="true" />
										<h:inputHidden id="whid" value="#{stockOutMB.mbean.whid}" />
										<a4j:outputPanel
											rendered="#{stockOutMB.commitStatus && false}">
											<img id="whid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="return selectWaho();" />
										</a4j:outputPanel>
									</td>
									<td>
										经手人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											disabled="#{!stockOutMB.commitStatus}"
											value="#{stockOutMB.mbean.opna}" />
									</td>
									<td>
										组织架构:
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{stockOutMB.mbean.orid}"
											onchange="doSearch();" disabled="true">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="inputtext" size="95"
											disabled="#{!stockOutMB.commitStatus}"
											value="#{stockOutMB.mbean.rema}" />
									</td>
								</tr>
							</table>
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="detailButton"
						rendered="#{stockOutMB.commitStatus}">
						<div id="mmain_opt">

							<a4j:commandButton id="addDBut" value="添加明細"
								onclick="if(!addDetail()){return false};"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" action="#{stockOutMB.addDetail}"
								reRender="msg,headButton,detailButton,headmain,outdetail"
								rendered="#{stockOutMB.MOD && stockOutMB.commitStatus}"
								oncomplete="endAddDetail();" requestDelay="50" />
							<a4j:commandButton id="deleteDBut" value="刪除明細"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" action="#{stockOutMB.deleteDetail}"
								onclick="if(!delDetail(gtable)){return false};"
								reRender="msg,headButton,detailButton,headmain,outdetail"
								rendered="#{stockOutMB.MOD && stockOutMB.commitStatus}"
								oncomplete="endDelDetail();" requestDelay="50" />
							<a4j:commandButton id="saveDBut" value="保存明细"
								onmouseover="this.className='a4j_over1'"
								rendered="#{stockOutMB.MOD && stockOutMB.commitStatus && false}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="if(!updateDetail()){return false};" type="button"
								action="#{stockOutMB.updateDetail}"
								reRender="msg,headButton,detailButton,headmain,outdetail"
								oncomplete="endUpdateDetail();" requestDelay="50" />
						</div>
					</a4j:outputPanel>

					<a4j:outputPanel id="input">
						<a4j:outputPanel
							rendered="#{stockOutMB.MOD && stockOutMB.commitStatus}">
							<div id=mmain_cnd>
								<div style="display: none;">
									<a4j:commandButton id="setCode4DBean" requestDelay="50"
										action="#{stockOutMB.setCode4DBean}" onclick="startDo();"
										oncomplete="endCode4DBean();"
										reRender="codePanel,renderArea,msg" />
								</div>
								<table border="0" cellpadding="1" cellspacing="0">
									<tr>
										<td>
											<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
										</td>
										<td>
											<h:selectOneMenu id="autoItem" value="#{stockOutMB.autoItem}"
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
												value="#{stockOutMB.dbean.codetype}" layout="lineDirection"
												onclick="initEdit();t.batyClick(this);">
												<f:selectItems value="#{stockOutMB.codetypes}" />
											</h:selectOneRadio>
										</td>
									</tr>
								</table>
								<a4j:outputPanel id='codePanel'>
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td width="30px;">
												<h:outputText value="库位:"></h:outputText>
											</td>
											<td>
												<h:inputText id="dwhid" styleClass="datetime" size="15"
													onkeydown="t.keyPressDeal(this);" onfocus="this.select();"
													value="#{stockOutMB.dbean.whid}" />
												<img id="whid_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectWahod();" />
											</td>
											<td width="30px;">
												<h:outputText id="codeTitle" value="条码:"></h:outputText>
											</td>
											<td>
												<h:inputText id="baco" value="#{stockOutMB.dbean.baco}"
													onfocus="this.select();" styleClass="datetime" size="42"
													onkeypress="t.keyPressDeal(this);" onblur="t.setCode4DBean();"/>
												<img id="invcode_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectCode();" />
											</td>
											<td width="30px;">
												<h:outputText value="数量:"></h:outputText>
											</td>
											<td oncontextmenu='return(false);' onpaste='return false'>
												<h:inputText id="qty" value="#{stockOutMB.dbean.qty}"
													onfocus="t.elementFocus();t.canFocus(this);"
													onkeydown="t.keyPressDeal(this);" styleClass="datetime"
													size="10" />
											</td>
										</tr>
									</table>
								</a4j:outputPanel>
							</div>
						</a4j:outputPanel>
					</a4j:outputPanel>

					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="outdetail">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											Select a.did,a.roid,a.inco,b.asco,a.qty,a.whid,a.baco,b.inna,b.inty,b.inse,b.colo      
											From olde a left join inve b On a.inco = b.inco 
											Where a.biid = '#{stockOutMB.mbean.biid}'
											"
										gpage="(pagesize = -1)"
										gupdate="(table = {olde},tablepk = {did})"
										gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox ,headtype = #{stockOutMB.commitStatus ? 'checkbox' : 'hidden'});
										gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
										gcid = roid(headtext = roid,name = roid,type = text,headtype = hidden ,datatype = string);
										gcid = inco(headtext = 商品编码,name = inco,width = 80,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inna(headtext = 商品名称,name = inna,width = 160,align = left,type = text,headtype = sort ,datatype = string);
										gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
										gcid = qty(headtext = 数量,name = qty,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
										gcid = whid(headtext = 出库货位,name = whid,width = 120,align = left,type = text,headtype = sort ,datatype = string);
										gcid = baco(headtext = 商品条码,name = baco,width = 240,align = left,type = text,headtype = sort ,datatype = string);
										" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
				</h:form>

				<div id="errmsg" style="display: none">
					<div id=mmain_cnd align="left">
						<span id="mes" style="color: red;"></span>
						<div align="center">
							<button type="button" onclick="Gwallwin.winClose();"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" class="a4j_but">
								关闭
							</button>
						</div>
					</div>
				</div>
				<a4j:outputPanel id="renderArea">
					<h:inputHidden id="msg" value="#{stockOutMB.msg}" />
				</a4j:outputPanel>
			</f:view>
		</div>
	</body>
</html>