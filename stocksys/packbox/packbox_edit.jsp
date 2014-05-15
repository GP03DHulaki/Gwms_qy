<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.PackBoxMB"%>

<%
    PackBoxMB ai = (PackBoxMB) MBUtil.getManageBean("#{packBoxMB}");
    if (request.getParameter("pid") != null) {
        ai.getMbean().setBiid(request.getParameter("pid"));
    }
    ai.getVouch();
%>
<html>
	<head>
		<title>编辑装箱单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="编辑装箱单">
		<script src="packbox.js"></script>
	</head>
	<body onLoad="initDetail();initEdit();" id="mmain_body">

		<div ID="mmain_nav">
			<font color="#000000"><a href="packbox.jsf" class="return">库内处理</a>&gt;&gt;</font>
			<b>编辑装箱单</b>
		</div>
		<f:view>
			<DIV ID="mmain">
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:outputPanel id="outputPanel">
							<a4j:commandButton value="添加单据" type="button"
								onmouseover="this.className='a4j_over1'"
								rendered="#{packBoxMB.ADD}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								onclick="if(!headCheck_update()){return false};"
								reRender="msg,outTable" action="#{packBoxMB.updateHead}"
								oncomplete="endDo();" requestDelay="50"
								rendered="#{packBoxMB.MOD && packBoxMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								onclick="if(!doDel()){return false;}" reRender="msg"
								action="#{packBoxMB.deleteHead}" oncomplete="endDele();"
								requestDelay="50"
								rendered="#{packBoxMB.DEL && packBoxMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="approveId" value="审核单据" type="button"
								onclick="if(!app()){return false};"
								action="#{packBoxMB.approveVouch}"
								reRender="msg,headPanel,outTable,detailButton,outputPanel,inputPanel,renderArea"
								oncomplete="endApp();" requestDelay="50"
								rendered="#{packBoxMB.APP && packBoxMB.commitStatus}" />
							<a4j:commandButton type="button" value="打印箱码"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{packBoxMB.printReport}"
								rendered="#{packBoxMB.PRN && !packBoxMB.commitStatus}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output" requestDelay="500" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<div ID="mmain_cnd">
						<a4j:outputPanel id="headPanel">
							<table cellpadding="2" cellspacing="2" border="0">
								<tr>
									<td>
										<h:outputText value="装箱单号:">
										</h:outputText>
									</td>
									<td>
										<h:inputText styleClass="datetime" id="biid"
											value="#{packBoxMB.mbean.biid}" onfocus="this.blur();"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
									<td>
										<h:outputText value="装箱类型:" />
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{packBoxMB.mbean.dety}"
											style="width:130px;" disabled="true">
											<f:selectItem itemLabel="质检装箱" itemValue="01" />
											<f:selectItem itemLabel="库内装箱" itemValue="02" />
											<f:selectItem itemLabel="库外装箱" itemValue="03" />
										</h:selectOneMenu>
									</td>
									<h:panelGroup
										rendered="#{packBoxMB.mbean.dety=='01' ? true : false}">
										<td id='td_soco' colspan="2">
											来源单号:
											<h:inputText id="soco" value="#{packBoxMB.mbean.soco}"
												disabled="true" styleClass="datetime" />
										</td>
									</h:panelGroup>
								</tr>
								<tr>
									<td>
										箱&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:
									</td>
									<td>
										<h:inputText id="boco" value="#{packBoxMB.mbean.boco}"
											styleClass="datetime" onfocus="this.blur();"
											style="color:#7f7f7f;" />
									</td>
									<td>
										仓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;库:
									</td>
									<td>
										<h:selectOneMenu id="whid" value="#{packBoxMB.mbean.waid}"
											style="width:130px;" disabled="true">
											<f:selectItems value="#{warehouseMB.wareList}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="装 箱 人:" />
									</td>
									<td>
										<h:inputText value="#{packBoxMB.mbean.crna}"
											id="nv_creatorname" disabled="true" style="color:#7f7f7f;"
											styleClass="datetime" />
									</td>
								</tr>
								<tr>
									<td>
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText id="nv_remark" styleClass="datetime"
											disabled="false" value="#{packBoxMB.mbean.rema}" size="90" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="detailButton">
							<a4j:outputPanel rendered="#{packBoxMB.commitStatus}">
								<div id="mmain_opt">
									<a4j:commandButton id="addDBut"
										onmouseover="this.className='a4j_over1'"
										rendered="#{packBoxMB.ADD && packBoxMB.commitStatus}"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										value="增加明细" type="button" action="#{packBoxMB.addDetail}"
										onclick="if(!addDetail()){return false};"
										reRender="msg,outTable" oncomplete="endAddDetail();"
										requestDelay="50" />
									<a4j:commandButton id="delDBut"
										onmouseover="this.className='a4j_over1'"
										rendered="#{packBoxMB.DEL && packBoxMB.commitStatus}"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										value="删除明细" type="button" action="#{packBoxMB.deleteDetail}"
										onclick="if(!doDeleteDetail()){return false};"
										reRender="msg,outTable" oncomplete="endDelDetail();"
										requestDelay="50" />
									<a4j:commandButton id="saveDBut" value="保存明细"
										onmouseover="this.className='a4j_over1'" rendered="false"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										onclick="if(!updateDetail()){return false};" type="button"
										action="#{packBoxMB.updateDetail}" reRender="msg"
										oncomplete="endUpdateDetail();" requestDelay="50" />
								</div>

								<div style="display: none;">
									<a4j:commandButton id="setCode4DBean" requestDelay="50"
										action="#{packBoxMB.setCode4DBean}" onclick="startDo();"
										oncomplete="endCode4DBean();"
										reRender="codePanel,renderArea,msg,input" />
								</div>
								<table border="0" cellpadding="2" cellspacing="0">
									<tr>
										<td>
											<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
										</td>
										<td>
											<h:selectOneMenu id="autoItem" value="#{packBoxMB.autoItem}"
												onchange="t.setIsAutoAdd(this.value);">
												<f:selectItem itemValue="0" itemLabel="否" />
												<f:selectItem itemValue="1" itemLabel="是" />
											</h:selectOneMenu>
										</td>
										<td>
											<h:outputText value="条码类型:" title="F9键切换条码类型" />
										</td>
										<td>
											<h:selectOneRadio id="batp"
												value="#{packBoxMB.dbean.codetype}" layout="lineDirection"
												onclick="continueAdd();t.batyClick(this);">
												<f:selectItems value="#{packBoxMB.codetypes}" />
											</h:selectOneRadio>
										</td>
									<tr>
								</table>
							</a4j:outputPanel>
						</a4j:outputPanel>
						<a4j:outputPanel id="inputPanel">
							<a4j:outputPanel rendered="#{packBoxMB.commitStatus}">
								<table border="0" cellpadding="1" cellspacing="0">
									<tr>
										<a4j:outputPanel
											rendered="#{packBoxMB.mbean.dety=='02' ? true : false}">
											<td width="60px;">
												<h:outputText value="来源库位:"></h:outputText>
											</td>
											<td>
												<h:inputText id="dwhid" styleClass="datetime" size="15"
													onkeydown="t.keyPressToObj(this,'edit:baco');"
													onfocus="this.select();" value="#{packBoxMB.dbean.whid}" />
												<img id="whid_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectWahod();" />
											</td>
										</a4j:outputPanel>
										<td width="30px;">
											<h:outputText id="codeTitle" value="条码:"></h:outputText>
										</td>
										<td>
											<h:inputText id="baco" value="#{packBoxMB.dbean.baco}"
												onfocus="this.select();t.elementFocus();"
												styleClass="datetime" size="42"
												onkeypress="t.keyPressDeal(this);" />
											<img id="invcode_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectCode();" />
										</td>
										<td width="30px;">
											<h:outputText value="数量:"></h:outputText>
										</td>
										<td oncontextmenu='return(false);' onpaste='return false'>
											<h:inputText id="qty" value="#{packBoxMB.dbean.qty}"
												onfocus="t.elementFocus();t.canFocus(this);"
												onkeydown="t.keyPressDeal(this);" styleClass="datetime"
												size="10" />
										</td>
									</tr>
								</table>
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>

					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2" gdebug="false"
							gpage="(pagesize=20)"
							gselectsql="SELECT a.did,a.baco,a.inco,a.qty,a.whid,b.inna,b.inty,b.inse,b.volu,b.newe,b.inpr,b.colo,c.whna,a.roid 
								FROM pvde a left join inve b on a.inco = b.inco left join waho c on a.whid = c.whid  
								where a.biid='#{packBoxMB.mbean.biid}'
							"
							gcolumn="gcid = roid(headtext = selall,name = roid,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
									gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 100,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 商品名称,name = inna,width = 160,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = baco(headtext = 商品条码,name = baco,width = 220,align = left,type = text,headtype = sort ,datatype = string);
									gcid = whna(headtext = 来源库位,name = whna,width = 100,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext = 数量,name = qty,width = 60,headtype = sort,align = right,type = text, update=edit,datatype=number,dataformat={0});
									" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="sellist" value="#{packBoxMB.sellist}" />
							<h:inputHidden id="flag" value="#{packBoxMB.mbean.flag}" />
							<h:inputText id="msg" value="#{packBoxMB.msg}" />
							<h:inputHidden id="filename" value="#{packBoxMB.fileName}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</DIV>
		</f:view>

	</body>
</html>