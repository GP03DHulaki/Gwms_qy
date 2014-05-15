<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@ page import="com.gwall.view.ChangeOwidMB"%>

<%
    String id = "";
    ChangeOwidMB ai = (ChangeOwidMB) MBUtil.getManageBean("#{changeOwidMB}");
    if (request.getParameter("pid") != null) {
        id = request.getParameter("pid");
        ai.getMbean().setBiid(id);
    }
    ai.getVouch();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>变更条码</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="变更条码">
		<meta http-equiv="description" content="变更条码">
		<script type="text/javascript" src="changeowid.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/TailHandler.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/Msgbox.js"></script>
	</head>
	<body id="mmain_body" onload="initEdit();initDetail();">
		<div id=mmain_nav>
			<a id="linkid" href="changeowid.jsf" class="return" title="返回">库内处理</a>&gt;&gt;
			<b>编辑条码变更单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id=mmain_opt>
						<a4j:outputPanel id="showHeadButton">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								oncomplete="addNew();" id="addHead"
								rendered="#{changeOwidMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{changeOwidMB.updateHead}"
								onclick="if(!addHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{changeOwidMB.MOD&& changeOwidMB.commitStatus}"
								oncomplete="endDo();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{changeOwidMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50"
								rendered="#{changeOwidMB.DEL&& changeOwidMB.commitStatus}" />
							<a4j:commandButton
								onmouseover="this.className='a4j_over1';msgbox.show('审核成功后即会扣减相应库存');"
								onmouseout="this.className='a4j_buton1';msgbox.hide();"
								styleClass="a4j_but1" onclick="if(!checkApp()){return false};"
								value="审核单据"
								rendered="#{changeOwidMB.APP&& changeOwidMB.commitStatus}"
								action="#{changeOwidMB.approveVouch}" id="submitMBut"
								reRender="showHeadButton,renderArea,output,detailButton,showHead"
								oncomplete="endApp();" requestDelay="50" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="showHead">
							<table border="0" cellspacing="0" cellpadding="1">
								<tr>
									<td>
										<h:outputText value="单据单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime" size="20"
											value="#{changeOwidMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="业务类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{changeOwidMB.mbean.soty}"
											style="width:130px;" disabled="true">
											<f:selectItem itemValue="01" itemLabel="库内调整" />
											<f:selectItem itemValue="02" itemLabel="质检调整" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="经手人:" />
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											disabled="#{!changeOwidMB.commitStatus}"
											value="#{changeOwidMB.mbean.opna}" />
										<img id="emp_img" style="cursor: pointer;"
											src="../../images/find.gif" onclick="selectuser();" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="创建人编码:"></h:outputText>
									</td>
									<td>
										<h:inputText id="crus" styleClass="datetime" size="20"
											disabled="#{!changeOwidMB.commitStatus}"
											value="#{changeOwidMB.mbean.crus}" />
									</td>
									<td>
										<h:outputText value="创建人姓名:" />
									</td>
									<td>
										<h:inputText id="crna" styleClass="inputtext" size="20"
											disabled="#{!changeOwidMB.commitStatus}"
											value="#{changeOwidMB.mbean.crna}" />
									</td>
									<td>
										<h:outputText value="调拨前货主:" />
									</td>
									<td>
										<h:inputText id="frow" styleClass="inputtext" size="20"
											disabled="#{!changeOwidMB.frow}"
											value="#{changeOwidMB.mbean.frow}" />
									</td>
									<td>
										<h:outputText value="调拨后货主:" />
									</td>
									<td>
										<h:inputText id="toow" styleClass="inputtext" size="20"
											disabled="#{!changeOwidMB.toow}"
											value="#{changeOwidMB.mbean.toow}" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="仓库:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="whid" value="#{changeOwidMB.mbean.whid}"
											style="width:130px;">
											<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											value="#{changeOwidMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div id="mmain_opt">
						<a4j:outputPanel id="detailButton">
							<a4j:outputPanel rendered="#{changeOwidMB.commitStatus}">
								<a4j:commandButton id="addDBut" value="添加明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" onclick="if(!addDetail()){return false};"
									reRender="renderArea,output"
									rendered="#{changeOwidMB.ADD&&changeOwidMB.commitStatus}}"
									action="#{changeOwidMB.addDetail}" oncomplete="endAddDetail();"
									requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{changeOwidMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output"
									rendered="#{changeOwidMB.DEL&&changeOwidMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>

					<div id=mmain_cnd>
						<a4j:outputPanel id="input">
							<a4j:outputPanel
								rendered="#{changeOwidMB.MOD&&changeOwidMB.commitStatus}">
								<table border="0" cellpadding="1" cellspacing="0">
									<tbody>
										<tr>
											<td>
												<h:outputText value="条码类型:" title="F9键切换条码类型" />
											</td>
											<td>
												<h:selectOneRadio id="batp" style="width:220px;"
													value="#{changeOwidMB.dbean.codetype}"
													layout="lineDirection"
													onclick="initEdit();t.batyClick(this);">
													<f:selectItems value="#{changeOwidMB.codetypes}" />
												</h:selectOneRadio>
											</td>
										<tr>
									</tbody>
								</table>
								<table border="0" cellpadding="0" cellspacing="0">
									<tbody>
										<tr>
											<td>
												<h:outputText value="商品编码:"></h:outputText>
											</td>
											<td>
												<h:inputText id="baco" styleClass="datetime"
													value="#{changeOwidMB.dbean.baco}" size="32" />
												<a4j:outputPanel>
													<img id="whid_img" style="cursor: pointer"
														src="../../images/find.gif" onclick="beforechange();" />
												</a4j:outputPanel>
											</td>
											<td>
												<h:outputText value="变更数量:"></h:outputText>
											</td>
											<td>
												<h:inputText id="obco" styleClass="datetime"
													value="#{changeOwidMB.dbean.obco}" size='32' />
											</td>
										</tr>
									</tbody>
								</table>
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<div>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="select a.asco,a.roid,a.did,a.biid,a.baco,a.obco,a.whid,a.qty from ecde a left join inve b on a.baco = b.inco where a.biid='#{changeOwidMB.mbean.biid}' "
								gpage="(pagesize = -1)" gversion="2"
								gupdate="(table = {ecde},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox ,headtype = checkbox);
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = whid(headtext = 库位编码,name = whid,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = baco(headtext = 商品编码,name = baco,width = 200,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext =  变更数量,name = qty,width = 70,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event)&&onchange=textChange(this)});
									" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{changeOwidMB.msg}" />
							<h:inputHidden id="sellist" value="#{changeOwidMB.sellist}" />
							<h:inputHidden id="selqtys" value="#{changeOwidMB.selqtys}" />
							<h:inputHidden id="updatedata" value="#{changeOwidMB.updatedata}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="查询商品信息" type="button" action="#{changeOwidMB.selInveBut}"
								id="selInveBut" onclick="if(!selInveBut()){return false};"
								reRender="detailButton" oncomplete="endSelInveBut();"
								requestDelay="50" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>