<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.OutOrderMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
    OutOrderMB ai = (OutOrderMB) MBUtil.getManageBean("#{outOrderMB}");
    ai.getVouch();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑订单明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="编辑订单明细">
		<script type="text/javascript" src="outorder.js"></script>
	</head>
	<body id=mmain_body onload="initEdit();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_nav>
						<a id="linkid" href="outorder.jsf" class="return" title="返回">出库处理</a>&gt;&gt;
						<b>编辑出库订单明细</b>
						<br>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{outOrderMB.msg}" />
							<h:inputHidden id="sellist" value="#{outOrderMB.sellist}" />
							<h:inputHidden id="filename" value="#{outOrderMB.fileName}" />
							<h:inputHidden id="updatedata" value="#{outOrderMB.updatedata}" />
							<h:inputHidden id="flag" value="#{outOrderMB.mbean.flag}" />
							<h:inputHidden id="inco1" value="#{outOrderMB.dbean.oinco}" />
							<h:inputHidden id="cori" value="#{outOrderMB.mbean.cori}" />
							<h:inputHidden id="infl" value="#{outOrderMB.mbean.infl}" />
							<h:inputHidden id="bity" value="#{outOrderMB.mbean.bity}" />
						</a4j:outputPanel>
						<gw:GAjaxButton value="隐藏修改按钮" reRender="headmain,renderArea"
							action="#{outOrderMB.updateSep}" oncomplete="endChaStat();"
							id="hidupbut" rendered="#{outOrderMB.ADD}" />
					</div>
					<div style="display: none;">
						<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
							reRender="outdetail,renderArea" />
						<a4j:commandButton id="showRe" value="刷新全部" style="display:none;"
							reRender="outdetail,renderArea,headButton,headmain,EBUSSHOW,EBUS" />
					</div>
					<a4j:outputPanel id="headButton">
						<div id=mmain_opt>
							<!--<gw:GAjaxButton value="添加单据" theme="b_theme"
								action="#{outOrderMB.clearMBean}" oncomplete="addNew();"
								id="addHead" rendered="#{outOrderMB.ADD && false}" />
							-->
							<gw:GAjaxButton theme="b_theme" id="updateId" value="保存单据"
								type="button" onclick="if(!addHead()){return false};"
								action="#{outOrderMB.updateHead}"
								reRender="renderArea,headButton,detailButton,headmain,outdetail"
								oncomplete="endDo();" requestDelay="50"
								rendered="#{outOrderMB.MOD && outOrderMB.commitStatus && !outOrderMB.appShow}" />

							<gw:GAjaxButton theme="b_theme"
								rendered="#{outOrderMB.APP && outOrderMB.commitStatus && !outOrderMB.appShow && false}"
								id="appMBut2" value="文员审核" type="button"
								action="#{outOrderMB.approveVouchElement}"
								onclick="if(!checkApp()){return false};"
								reRender="renderArea,headButton,detailButton,headmain,outdetail,EBUS,EBUSSHOW"
								oncomplete="endApp();" requestDelay="50" />
							<gw:GAjaxButton theme="b_theme"
								rendered="#{outOrderMB.APP && outOrderMB.commitStatus}"
								id="appMBut" value="审核单据" type="button"
								action="#{outOrderMB.approveVouch}"
								onclick="if(!checkApp()){return false};"
								reRender="renderArea,headButton,detailButton,headmain,outdetail,EBUS,EBUSSHOW"
								oncomplete="endApp();" requestDelay="50" />
							<gw:GAjaxButton theme="b_theme"
								rendered="#{outOrderMB.APP && outOrderMB.unAppShow}" id="unApp"
								value="弃审订单" type="button" action="#{outOrderMB.unApproveVouch}"
								onclick="if(!unApp()){return false};"
								reRender="renderArea,headButton,detailButton,headmain,outdetail,EBUS,EBUSSHOW"
								oncomplete="endUnApp();" requestDelay="50" />

							<a4j:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{outOrderMB.printReport}" styleClass="a4j_but1"
								onclick="printReport();" oncomplete="endPrintReport();"
								rendered="#{outOrderMB.PRN}"
								reRender="renderArea,outTable,output" requestDelay="1000" />
							<gw:GAjaxButton theme="b_theme"
								rendered="#{outOrderMB.SPE && outOrderMB.closeShow && false}"
								id="closeVouch" value="关闭订单" type="button"
								action="#{outOrderMB.closeVouch}"
								onclick="if(!closeVouch()){return false};"
								reRender="renderArea,headButton,detailButton,headmain,outdetail"
								oncomplete="endCloseVouch();" requestDelay="50" />
							<gw:GAjaxButton theme="b_theme" id="delMBut" value="删除单据"
								type="button" action="#{outOrderMB.deleteHead}"
								onclick="deleteHead()" oncomplete="endDeleteHead();"
								requestDelay="50"
								reRender="renderArea,headButton,headmain,detailButton"
								rendered="#{outOrderMB.DEL && outOrderMB.commitStatus && !outOrderMB.appShow}" />
							<%-- 
							<gw:GAjaxButton theme="b_theme" id="billtotask" value="生成拣货任务"
								type="button" action="#{outOrderMB.biidToTask}"
								onclick="if(!isToTask()){return false};" oncomplete="endDeleteHead();"
								requestDelay="50"
								reRender="renderArea,headButton,headmain,detailButton,outdetail"
								rendered="#{outOrderMB.SPE}" />
							--%>
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="headmain">
						<div id=mmain_cnd>
							<table cellpadding="1" cellspacing="1" border="0">
								<tr>
									<td>
										出库订单:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext" size="20"
											value="#{outOrderMB.mbean.biid}" readonly="true"
											style="color:#A0A0A0;" />
									</td>
									<td>
										订单类型:
									</td>
									<td>
										<h:selectOneMenu id="buty" value="#{outOrderMB.mbean.buty}"
											style="width:130px;" disabled="#{!outOrderMB.commitStatus}">
											<f:selectItems value="#{outOrderMB.butys}" />
										</h:selectOneMenu>
									</td>
									<td>
										组织架构:
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{outOrderMB.mbean.orid}"
											disabled="#{!outOrderMB.commitStatus}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
									<td>
										发货级别:
									</td>
									<td>
										<h:selectOneMenu id="tale" value="#{outOrderMB.mbean.tale}"
											disabled="#{!outOrderMB.commitStatus}" style="width:130px;"
											onchange="changeStat();">
											<f:selectItem itemLabel="普通" itemValue="0" />
											<f:selectItem itemLabel="紧急" itemValue="1" />
											<f:selectItem itemLabel="高级" itemValue="10" />
										</h:selectOneMenu>
									</td>
									<%-- 
									<td>
										<h:inputText id="orna" size="20" styleClass="inputtext"
											value="#{outOrderMB.mbean.orna}" disabled="true" />
										<h:inputHidden id="orid" value="#{outOrderMB.mbean.orid}" />
										<a4j:outputPanel rendered="#{outOrderMB.commitStatus}">
											<img id="orid_img" style="cursor: pointer;"
												src="../../images/find.gif" onclick="selectOrga();" />
										</a4j:outputPanel>
									</td>
									--%>
								</tr>
								<tr>
									<td>
										客户名称:
									</td>
									<td>
										<h:inputText id="cuna" size="20" styleClass="inputtext"
											value="#{outOrderMB.mbean.cuna}" readonly="true"
											style="color:#A0A0A0;" />
										<a4j:outputPanel
											rendered="#{outOrderMB.commitStatus && false}">
											
										</a4j:outputPanel>
									</td>
									<td>
										客户订单号:
									</td>
									<td>
										<h:inputText id="cbid" styleClass="inputtext" size="20"
											disabled="#{!outOrderMB.commitStatus}"
											value="#{outOrderMB.mbean.cbid}" />
									</td>
									<td>
										路&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;线:
									</td>
									<td>
										<h:selectOneMenu id="lico" style="width:130px;"
											value="#{outOrderMB.mbean.lico}"
											disabled="#{!outOrderMB.commitStatus}">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{lineMB.itemlist}" />
										</h:selectOneMenu>
									</td>
									<td>
										物流商:
									</td>
									<td>
										<h:selectOneMenu id="lpco" style="width:200px;"
											value="#{outOrderMB.mbean.lpco}"
											disabled="#{!outOrderMB.commitStatus}">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{carrierMB.list}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										装车要求:
									</td>
									<td>
										<h:selectOneMenu id="dety" value="#{outOrderMB.mbean.dety}"
											disabled="#{outOrderMB.mbean.flag>='31' ? true : false}"
											style="width:130px;" onchange="changeStat();">
											<f:selectItem itemLabel="允许部分装车" itemValue="1" />
											<f:selectItem itemLabel="不允许部分装车" itemValue="0" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="发货仓库:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="whid" value="#{outOrderMB.mbean.whid}"
											style="width:130px;" disabled="true">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{warehouseMB.wareList}" />
										</h:selectOneMenu>
									</td>
									<td>
										快递单号:
									</td>
									<td>
										<h:inputText id="loco" styleClass="inputtext" size="20"
											disabled="#{!outOrderMB.commitStatus}"
											value="#{outOrderMB.mbean.loco}" />
									</td>
										<td>
										订单到期日期:
									</td>
									<td>
										<h:inputText id="endt" value="#{outOrderMB.mbean.endt}"
											disabled="#{!outOrderMB.commitStatus}"
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
											styleClass="inputtext" />
									</td>
									<td>
										<h:outputText value="目标公司(专柜):"
											rendered="#{outOrderMB.mbean.infl==1 ? true : false}" />
									</td>
									<td>
										<h:selectOneMenu id="oori" value="#{outOrderMB.mbean.oori}"
											rendered="#{outOrderMB.mbean.infl==1 ? true : false}"
											onchange="clearfina();"
											disabled="#{!outOrderMB.commitStatus || outOrderMB.EBUSShow}">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{outOrderMB.ooriList}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="最终客户:"
											rendered="#{outOrderMB.mbean.infl==1 ? true : false}" />
									</td>
									<td>
										<!--
										<h:selectOneMenu id="fin1a" value="#{outOrderMB.mbean.fina}" onchange="clearoori();"
											rendered="#{outOrderMB.mbean.infl==1 ? true : false}" 
											disabled="#{!outOrderMB.commitStatus || outOrderMB.EBUSShow}">
											<f:selectItem itemLabel="" itemValue=""/>
											<f:selectItems value="#{outOrderMB.finaList}" />
										</h:selectOneMenu>
										-->
										<a4j:outputPanel
											rendered="#{outOrderMB.mbean.infl==1 ? true : false}">
											<t:inputText id="finm" size="40" styleClass="inputtext"
												value="#{outOrderMB.mbean.finm}" onchange="clearoori();"
												disabled="true" />
											<h:inputHidden id="fina" value="#{outOrderMB.mbean.fina}" />
											<a4j:outputPanel
												rendered="#{outOrderMB.commitStatus && !outOrderMB.EBUSShow}">
												<img id="suid_img" style="cursor: hand"
													src="../../images/find.gif" onclick="selectCuin1();" />
											</a4j:outputPanel>
										</a4j:outputPanel>
									</td>
								</tr>
								<tr>
									<td>
										目&nbsp;&nbsp;的&nbsp;地:
									</td>
									<td colspan="5">
										<h:inputText id="orad" value="#{outOrderMB.mbean.orad}"
											disabled="#{!outOrderMB.commitStatus}" styleClass="inputtext"
											size="102" />
									</td>
									<td>
										特殊提示:
									</td>
									<td>
										<h:selectOneMenu id="tsmg" value="#{outOrderMB.mbean.tsmg}"
											disabled="#{!outOrderMB.commitStatus}">
											<f:selectItem itemLabel="---------无---------" itemValue="0" />
											<f:selectItem itemLabel="需打包" itemValue="1" />
											<f:selectItem itemLabel="需换条码" itemValue="2" />
											<f:selectItem itemLabel="需盖条码" itemValue="4" />
											<f:selectItem itemLabel="需打包并换条码" itemValue="3" />
											<f:selectItem itemLabel="需打包并盖条码" itemValue="5" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="inputtext" size="102"
											disabled="#{!outOrderMB.commitStatus}"
											value="#{outOrderMB.mbean.rema}" />
									</td>
									<td>
										总&nbsp;金&nbsp;额:
									</td>
									<td>
										<h:inputText id="aggr" styleClass="inputtext" size="20"
											readonly="true" style="color:#A0A0A0;"
											value="#{outOrderMB.mbean.aggr}" />
									</td>

								</tr>
								<tr>
									<td>
										总&nbsp;&nbsp;体&nbsp;积:
									</td>
									<td>
										<h:inputText id="tavo" styleClass="inputtext" size="20"
											readonly="true" style="color:#A0A0A0;"
											value="#{outOrderMB.mbean.tavo}" />
									</td>
									<td>
										总&nbsp;&nbsp;重&nbsp;量:
									</td>
									<td>
										<h:inputText id="tawe" styleClass="inputtext" size="20"
											readonly="true" style="color:#A0A0A0;"
											value="#{outOrderMB.mbean.tawe}" />
									</td>
										<td>
										称重重量:
									</td>
									<td>
										<h:inputText id="czwe" styleClass="inputtext" size="20"
											readonly="true" style="color:#A0A0A0;"
											value="#{outOrderMB.mbean.czwe}" />
									</td>
									
									<td>
										总&nbsp;&nbsp;数&nbsp;量:
									</td>
									<td>
										<h:inputText id="tanu" styleClass="inputtext" size="20"
											readonly="true" style="color:#A0A0A0;"
											value="#{outOrderMB.mbean.tanu}" />
									</td>
								
								</tr>
							</table>
							<div>
								<a4j:outputPanel id="EBUSSHOW"
									rendered="#{(outOrderMB.EBUSShow||outOrderMB.IMPORTShow)}">
										店铺简称:
										<h:inputText id="caco" styleClass="inputtext" size="20"
										value="#{outOrderMB.mbean.caco}" disabled="true" />
										买家昵称:
										<h:inputText id="nick" styleClass="inputtext" size="20"
										value="#{outOrderMB.mbean.nick}" disabled="true" />
										
										收&nbsp;&nbsp;货&nbsp;人:
										<h:inputText id="rena" styleClass="inputtext" size="20"
										value="#{outOrderMB.mbean.rena}" />
										手机:
										<h:inputText id="reca" styleClass="inputtext" size="20"
										value="#{outOrderMB.mbean.reca}" />
									<span style="color: red; display: none;"><B>判断手机号码位数是否是11位</B>
									</span>
									<br>
										应付款:
										<h:inputText id="orco" styleClass="inputtext" size="20"
										value="#{outOrderMB.mbean.orco}" disabled="true" />
										实际支付:
										<h:inputText id="paym" styleClass="inputtext" size="20"
										value="#{outOrderMB.mbean.paym}" disabled="true" />
										快递费用:
										<h:inputText id="poco" styleClass="inputtext" size="20"
										value="#{outOrderMB.mbean.poco}" disabled="true" />
										联系电话:
										<h:inputText id="reph" styleClass="inputtext" size="20"
										value="#{outOrderMB.mbean.reph}" />
									<br>
										促销信息:
										<h:inputText id="rem4" styleClass="inputtext" size="160"
										value="#{outOrderMB.mbean.rem4}" />
									<br>
										买家备注:
										<h:inputText id="rem1" styleClass="inputtext" size="120"
										value="#{outOrderMB.mbean.rem1}" disabled="true" />
									<br>
										卖家备注:
										<h:inputText id="rem2" styleClass="inputtext" size="120"
										value="#{outOrderMB.mbean.rem2}" />
									<span style="color: red; display: none;"><B>审核添加赠品和发票</B>
									</span>
									<br>
										省:
										<h:inputText id="prov" styleClass="inputtext" size="13"
										value="#{outOrderMB.mbean.prov}" />
										
										市:
										<h:inputText id="city" styleClass="inputtext" size="13"
										value="#{outOrderMB.mbean.city}" />
										
										区:
										<h:inputText id="area" styleClass="inputtext" size="13"
										value="#{outOrderMB.mbean.area}" />
									
										收货地址:
										<h:inputText id="rsad" styleClass="inputtext" size="80"
										value="#{outOrderMB.mbean.rsad}" />
									<span style="color: red; display: none;"><B>判断快递公司 </B>
									</span>
								</a4j:outputPanel>
							</div>
						</div>
					</a4j:outputPanel>
					<%-- 
					<a4j:outputPanel id="ShowKA"
						rendered="#{(outOrderMB.KAShow || outOrderMB.POSShow) && outOrderMB.commitStatus}">
						<div style="vertical-align: top;"></div>
						<SPAN ID="detail_ctrl" class="ctrl_show"
							onclick="JS_ExtraFunction();"></SPAN>
						<font color="#4990dd" style="font-weight: bolder; cursor: pointer"
							onclick="JS_ExtraFunction();">单据花色调整差异明细:</font>
						<div id="ExtraFunction" style="display: none;">
							<a4j:outputPanel id="countPage">
								<iframe frameborder="0" src="showObbd.jsf" width="100%">
								</iframe>
							</a4j:outputPanel>
						</div>
					</a4j:outputPanel>
					--%>

					<a4j:outputPanel id="detailButton">
						<a4j:outputPanel
							rendered="#{outOrderMB.commitStatus && !outOrderMB.appShow && (outOrderMB.KAShow || outOrderMB.POSShow) }">
							<div id="mmain_opt">
								<!--<a4j:commandButton id="addDBut" value="添加明細"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{outOrderMB.addDetail}"
									reRender="renderArea,headButton,detailButton,headmain,outdetail,countPage"
									rendered="#{outOrderMB.MOD && outOrderMB.commitStatus}"
									oncomplete="endAddDetail();" requestDelay="50" />-->
								<a4j:commandButton id="addDButs" value="添加明細"
									onclick="showAddDetail()"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" reRender="renderArea,outdetail"
									rendered="#{outOrderMB.ADD && outOrderMB.commitStatus}"
									requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{outOrderMB.MOD && outOrderMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{outOrderMB.updateDetail}"
									reRender="renderArea,headButton,detailButton,headmain,outdetail,countPage"
									oncomplete="endUpdateDetail();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{outOrderMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,headButton,detailButton,headmain,outdetail,countPage"
									rendered="#{outOrderMB.DEL && outOrderMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<gw:GAjaxButton id="impDBut" value="导入明细" theme="b_theme"
									rendered="#{outOrderMB.IMP && outOrderMB.commitStatus}"
									onclick="showImport()" type="button" />
							</div>
						</a4j:outputPanel>
					</a4j:outputPanel>
					<a4j:outputPanel id="EBUS">
						<a4j:outputPanel
							rendered="#{(outOrderMB.EBUSShow||outOrderMB.IMPORTShow) && outOrderMB.commitStatus&& !outOrderMB.appShow}">
							<a4j:commandButton value="调整商品"
								onmouseover="this.className='a4j_over1'"
								reRender="renderArea,headButton,detailButton,headmain,outdetail"
								rendered="#{outOrderMB.SPE && outOrderMB.commitStatus && false}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="if(!modifyinco()){return false};"
								oncomplete="Gwallwin.winShowmask('FALSE');" />
							<a4j:commandButton id="addDBut1" value="添加商品"
								onclick="if(!addDetail()){return false};"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" action="#{outOrderMB.addDetail}"
								reRender="renderArea,headButton,detailButton,headmain,outdetail,countPage"
								rendered="#{outOrderMB.MOD && outOrderMB.commitStatus}"
								oncomplete="endAddDetail();" requestDelay="50" />
							<a4j:commandButton id="deleteDBut1" value="刪除商品"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" action="#{outOrderMB.deleteDetail}"
								onclick="if(!delDetail(gtable)){return false};"
								reRender="renderArea,headButton,detailButton,headmain,outdetail,countPage"
								rendered="#{outOrderMB.DEL && outOrderMB.commitStatus}"
								oncomplete="endDelDetail();" requestDelay="50" />
							<div id="mmain_cnd">
								<table>
									<tr>
										<td>
											<h:outputText value="商品编码:"></h:outputText>
										</td>
										<td>
											<h:inputText id="ninco" value="#{outOrderMB.dbean.inco}"
												rendered="#{outOrderMB.MOD && outOrderMB.commitStatus}"
												styleClass="datetime" size="22" />
											<img id="invcode_img" style="cursor: pointer;"
												src="../../images/find.gif" onclick="selectInve();" />
										</td>
										<td>
											<h:outputText value="数量:"></h:outputText>
										</td>
										<td>
											<h:inputText id="qty" value="#{outOrderMB.dbean.qty}"
												rendered="#{outOrderMB.MOD && outOrderMB.commitStatus}"
												onkeypress="addDetailKey();return isInteger(event)"
												onchange="textChange(this)" styleClass="datetime" size="16" />
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
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gsort="tqty" gsortmethod="ASC"
										gselectsql="
											Select a.did,a.inco,b.inna,b.inse,b.colo,a.qty,a.gqty,a.tqty,s.jqty,s.bqty,s.cqty,s.yqty,a.ispk
											From oubd a left join inve b On a.inco = b.inco 
											left JOIN obma c on c.biid=a.biid
											LEFT JOIN f_stock_type('#{outOrderMB.mbean.orid}') s ON a.inco=s.inco and c.whid=s.whco
											Where  a.biid = '#{outOrderMB.mbean.biid}'
											"
										gpage="(pagesize = -1)"
										gupdate="(table = {oubd},tablepk = {did})"
										gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox ,headtype = #{outOrderMB.commitStatus ? 'checkbox' : 'hidden'});
											gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
											gcid = ispk(headtext = 商品属性,name = ispk,width = 70,align = center,type = mask,headtype = sort ,datatype = string,typevalue=1:正常商品/0:赠品);
											gcid = inco(headtext = 商品编码,name = inco,width = 100,align = left,type = text,headtype = sort ,datatype = string);
											gcid = inna(headtext = 商品名称,name = inna,width = 150,align = left,type = text,headtype = sort ,datatype = string);
											gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
											gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
											gcid = qty(headtext =  订单数量,name = qty,width = 60,align = right,type = #{outOrderMB.commitStatus ? 'input' : 'text' },headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
											gcid = tqty(headtext =  已锁定数量,name = tqty,width = 70,align = right,type = text,headtype= sort, datatype =number,dataformat=0,bgcolor={gcolumn[qty]>gcolumn[tqty]:#66FF00});
											gcid = gqty(headtext =  已拣数量,name = gqty,width = 70,align = right,type = text,headtype= sort, datatype =number,dataformat=0);
											gcid = jqty(headtext =  拣货库位数,name = jqty,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0,bgcolor={gcolumn[jqty]=0:#FF0000});
											gcid = yqty(headtext =  溢出库位数,name = yqty,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0);
											gcid = bqty(headtext =  备货区总数,name = bqty,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0);
											gcid = cqty(headtext =  移动库位总数,name = cqty,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0);
										" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>

				</h:form>

				<div id="import" style="display: none" align="left">
					<h:form id="file" enctype="multipart/form-data">
						<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
							value="#{outOrderMB.upFile}" required="true" size="75" />
						<div id="mes"></div>
						<div align="center">
							<gw:GAjaxButton value="上传" onclick="return doImport();"
								id="import" theme="a_theme" />
							<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
								onclick="hideDiv()" type="button" />
						</div>
						<div style="display: none;">
							<h:commandButton value="上传" id="importBut"
								action="#{outOrderMB.uploadFile}" />
						</div>
					</h:form>
				</div>
			</f:view>
		</div>
	</body>
</html>