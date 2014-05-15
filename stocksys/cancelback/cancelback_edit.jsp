<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.stock.CancelBackMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
    CancelBackMB ai = (CancelBackMB) MBUtil
            .getManageBean("#{cancelBackMB}");
    ai.getVouch();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑单据明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="编辑单据明细">
		<script type="text/javascript" src="cancelback.js"></script>
	</head>
	<body id='mmain_body' onload="initEdit();initDetail();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_nav>
						<a id="linkid" href="cancelback.jsf" class="return" title="返回">库内处理</a>&gt;&gt;
						<b>编辑单据明细</b>
						<br>
					</div>
					<div id=mmain_opt>

					</div>
					<a4j:outputPanel id="message">
						<div style="display: none;">
							<h:inputHidden id="msg" value="#{cancelBackMB.msg}" />
							<h:inputHidden id="sellist" value="#{cancelBackMB.sellist}" />
							<h:inputHidden id="filename" value="#{cancelBackMB.fileName}" />
							<h:inputHidden id="updatedata" value="#{cancelBackMB.updatedata}" />
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="headButton">
						<div id=mmain_opt>
							<gw:GAjaxButton value="添加单据" theme="b_theme"
								action="#{cancelBackMB.clearMBean}" oncomplete="addNew();"
								id="addHead" rendered="#{cancelBackMB.ADD}" />

							<gw:GAjaxButton theme="b_theme" id="updateId" value="保存单据"
								type="button" onclick="if(!addHead()){return false};"
								action="#{cancelBackMB.updateHead}"
								reRender="msg,headButton,detailButton,headmain,outdetail"
								oncomplete="endDo();" requestDelay="50"
								rendered="#{cancelBackMB.MOD && cancelBackMB.commitStatus}" />

							<gw:GAjaxButton theme="b_theme" id="delMBut" value="删除单据"
								type="button" action="#{cancelBackMB.deleteHead}"
								onclick="deleteHead()" oncomplete="endDeleteHead();"
								requestDelay="50"
								reRender="msg,headButton,headmain,detailButton"
								rendered="#{cancelBackMB.DEL && cancelBackMB.commitStatus}" />

							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								rendered="#{cancelBackMB.APP && cancelBackMB.commitStatus}"
								id="appMBut" value="审核单据" type="button"
								action="#{cancelBackMB.approveVouch}"
								onclick="if(!checkApp()){return false};"
								reRender="msg,headButton,detailButton,headmain,outdetail,input"
								oncomplete="endApp();" requestDelay="50" />

							<a4j:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{cancelBackMB.printReport}"
								rendered="#{cancelBackMB.PRN && !cancelBackMB.commitStatus && false}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output,msg,message"
								requestDelay="1000" />
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="headmain">
						<div id=mmain_cnd>
							<table cellpadding="3" cellspacing="0" border="0">
								<tr>
									<td>
										单据单号:
									</td>
									<td oncontextmenu='return(false);' onpaste='return false'>
										<h:inputText id="biid" styleClass="inputtext" size="20"
											value="#{cancelBackMB.mbean.biid}" onfocus="this.blur();"
											style="color:#A0A0A0;" />
									</td>
									<td>
										移动库位:
									</td>
									<td oncontextmenu='return(false);' onpaste='return false'>
										<h:inputText id="owid" styleClass="inputtext" size="20"
											value="#{cancelBackMB.mbean.owid}" onfocus="this.blur();"
											style="color:#A0A0A0;" />
									</td>
									<td>
										经手人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											disabled="#{!cancelBackMB.commitStatus}"
											value="#{cancelBackMB.mbean.opna}" />
									</td>
									<td>
										组织架构:
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{cancelBackMB.mbean.orid}"
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
											disabled="#{!cancelBackMB.commitStatus}"
											value="#{cancelBackMB.mbean.rema}" />
									</td>
								</tr>
							</table>
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="detailButton"
						rendered="#{cancelBackMB.commitStatus}">
						<a4j:outputPanel>
							<div id="mmain_opt">
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{cancelBackMB.addDetail}"
									reRender="msg,headButton,detailButton,headmain,outdetail"
									rendered="#{cancelBackMB.MOD && cancelBackMB.commitStatus}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{cancelBackMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="msg,headButton,detailButton,headmain,outdetail"
									rendered="#{cancelBackMB.MOD && cancelBackMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{cancelBackMB.MOD && cancelBackMB.commitStatus && false}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{cancelBackMB.updateDetail}"
									reRender="msg,headButton,detailButton,headmain,outdetail"
									oncomplete="endUpdateDetail();" requestDelay="50" />
							</div>
						</a4j:outputPanel>
					</a4j:outputPanel>

					<a4j:outputPanel id="input">
						<a4j:outputPanel
							rendered="#{cancelBackMB.MOD && cancelBackMB.commitStatus}">
							<div id=mmain_cnd>
								<div style="display: none;">
									<a4j:commandButton id="setCode4DBean" requestDelay="50"
										action="#{cancelBackMB.setCode4DBean}" onclick="startDo();"
										oncomplete="endCode4DBean();"
										reRender="codePanel,renderArea,msg" />
								</div>
								<table border="0" cellpadding="1" cellspacing="0">
									<tbody>
										<tr>
											<td>
												<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
											</td>
											<td>
												<h:selectOneMenu id="autoItem"
													value="#{cancelBackMB.autoItem}"
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
													value="#{cancelBackMB.dbean.codetype}"
													layout="lineDirection"
													onclick="initEdit();t.batyClick(this);">
													<f:selectItems value="#{cancelBackMB.codetypes}" />
												</h:selectOneRadio>
											</td>
										</tr>
									</tbody>
								</table>
								<a4j:outputPanel id='codePanel'>
									<table border="0" cellpadding="0" cellspacing="0">
										<tbody>
											<tr>
												<td width="60px;">
													<h:outputText value="出库订单:"></h:outputText>
												</td>
												<td>
													<h:inputText id="soco" styleClass="datetime" size="25"
														onkeydown="t.keyPressDeal(this);" onfocus="this.select();"
														value="#{cancelBackMB.dbean.soco}" />
												</td>
												<td width="30px;">
													<h:outputText id="codeTitle" value="条码:"></h:outputText>
												</td>
												<td>
													<h:inputText id="baco" value="#{cancelBackMB.dbean.baco}"
														onfocus="this.select();" styleClass="datetime" size="42"
														onkeypress="t.keyPressDeal(this);" />
													<img id="invcode_img" style="cursor: pointer"
														src="../../images/find.gif" onclick="selectCode();" />
												</td>
												<td width="30px;">
													<h:outputText value="数量:"></h:outputText>
												</td>
												<td oncontextmenu='return(false);' onpaste='return false'>
													<h:inputText id="qty" value="#{cancelBackMB.dbean.qty}"
														onfocus="t.elementFocus();t.canFocus(this);"
														onkeydown="t.keyPressDeal(this);" styleClass="datetime"
														size="10" />
												</td>
											</tr>
										</tbody>
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
											Select a.did,a.roid,a.inco,a.qty,a.whid,a.baco,b.inna,b.inty,b.inse,b.colo,a.soco,a.soty      
											From cbde a left join inve b On a.inco = b.inco 
											Where a.biid = '#{cancelBackMB.mbean.biid}'
											"
										gpage="(pagesize = -1)"
										gupdate="(table = {cbde},tablepk = {did})"
										gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox ,headtype = #{cancelBackMB.commitStatus ? 'checkbox' : 'hidden'});
										gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
										gcid = roid(headtext = roid,name = roid,type = text,headtype = hidden ,datatype = string);
										gcid = did(headtext = did,name = did,type = text,headtype = hidden ,datatype = string);
										gcid = soco(headtext = 出库订单,name = soco,width = 150,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inco(headtext = 商品编码,name = inco,width = 160,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inna(headtext = 商品名称,name = inna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
										gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
										gcid = qty(headtext = 数量,name = qty,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
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
					<h:inputHidden id="msg" value="#{cancelBackMB.msg}" />
				</a4j:outputPanel>
			</f:view>
		</div>
	</body>
</html>