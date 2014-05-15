<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.stock.AfterSingleMB"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
	AfterSingleMB ai = (AfterSingleMB) MBUtil
			.getManageBean("#{afterSignleMB}");
	if (null != request.getParameter("pid")) {
		ai.getMbean().setBiid(request.getParameter("pid"));
	}
	ai.getVouch();
%>
<html>
	<head>
		<title>编辑追单记录</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="编辑追单记录">
		<script src="aftersingle.js"></script>
	</head>
	<body id="mmain_body" onload="initload();">
		<div id="mydiv"
			style="width: 190px; height: 30px; bgcolor: #efefef; display: none;">
			<img src="../../images/indicator.gif" width="16" height="16" />
			<b><font color="white">正在处理，请稍等...</font> </b>
		</div>
		<DIV ID="mmain_nav">
			<font color="#000000"><a href="aftersingle.jsf" class="return">库内处理</a>&gt;&gt;</font>
			<font color="#000000">追单&gt;&gt;</font>
			<b>编辑追单记录</b>
		</DIV>
		<f:view>
			<h:form id="edit">
				<DIV ID="mmain">
					<div id="mmain_opt">
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td>
									<a4j:outputPanel id="mainButton">
										<a4j:commandButton value="添加单据" type="button"
											onmouseover="this.className='a4j_over1'"
											rendered="#{afterSignleMB.ADD}"
											onmouseout="this.className='a4j_buton1'"
											styleClass="a4j_but1" oncomplete="addNew();" />
										<a4j:commandButton onmouseover="this.className='a4j_over1'"
											onmouseout="this.className='a4j_buton1'"
											styleClass="a4j_but1" id="updateId" value="保存单据"
											type="button" reRender="renderArea"
											action="#{afterSignleMB.updateHead}" onclick="updateHead();"
											oncomplete="endUpdateHead();" requestDelay="50"
											rendered="#{afterSignleMB.MOD && afterSignleMB.commitStatus && afterSignleMB.mbean.flag<'02'}" />
										<a4j:commandButton onmouseover="this.className='a4j_over1'"
											onmouseout="this.className='a4j_buton1'"
											styleClass="a4j_but1" id="delId" value="删除单据" type="button"
											onclick="if(!doDel()){return false;}"
											action="#{afterSignleMB.deleteHead}"
											reRender="mainButton,mes,renderArea" oncomplete="endDele();"
											requestDelay="50"
											rendered="#{afterSignleMB.DEL && afterSignleMB.commitStatus && afterSignleMB.mbean.flag<'02'}" />
										<a4j:commandButton onmouseover="this.className='a4j_over1'"
											onmouseout="this.className='a4j_buton1'"
											styleClass="a4j_but1" id="approveId" value="审核单据"
											type="button" onclick="if(!app()){return false}"
											action="#{afterSignleMB.approveVouch}"
											reRender="mainButton,msg,renderArea,detailbutton,optPlan"
											oncomplete="endApp();" requestDelay="50"
											rendered="#{afterSignleMB.APP && afterSignleMB.commitStatus}" />
									</a4j:outputPanel>
								</td>
							</tr>
						</table>
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="input">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{afterSignleMB.mbean.biid}" />
									</td>
									<td>
										<h:outputText value="移库车:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whid" styleClass="inputtext" size="20"
											value="#{afterSignleMB.mbean.whid}" />
										<img id="emp_img" style="cursor: pointer;"
											src="../../images/find.gif"
											onclick="selectWhid('9','ALL','edit:owid','')" />
									</td>
									<td>
										经手人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											value="#{afterSignleMB.mbean.opna}" />
										<img id="emp_img" style="cursor: pointer;"
											src="../../images/find.gif" onclick="selectuser();" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="nv_remark" styleClass="datetime"
											value="#{afterSignleMB.mbean.rema}" size="100" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div id="mmain_opt">
						<a4j:outputPanel id="detailbutton">
							<a4j:outputPanel
								rendered="#{afterSignleMB.MOD && afterSignleMB.commitStatus}">
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{afterSignleMB.addDetail}"
									reRender="renderArea,outTable,msg"
									rendered="#{afterSignleMB.ADD && afterSignleMB.commitStatus}"
									oncomplete="endAddDetail1();" requestDelay="50" />

								<a4j:commandButton id="deleteDBut" value="刪除单据明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{afterSignleMB.deleteDetail}"
									onclick="if(!delDetail(gtable2)){return false};"
									reRender="renderArea,output,tableid"
									rendered="#{afterSignleMB.DEL && afterSignleMB.commitStatus && false}"
									oncomplete="endDelDetail();" requestDelay="50" />
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="optPlan">
							<a4j:outputPanel rendered="#{afterSignleMB.commitStatus}">
								<table border="0" cellpadding="0" cellspacing="0">
									<tbody>
										<tr>
											<td width="60px;">
												<h:outputText value="快递单:"></h:outputText>
											</td>
											<td>
												<h:inputText id="loco" styleClass="datetime" size="25"
													onfocus="this.select();"
													value="#{afterSignleMB.dbean.loco}"
													onkeypress="formsubmit(event);" />
												<img id="whid_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectLoco();" />
											</td>
										</tr>
									</tbody>
								</table>
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<DIV ID="voucher_detail">
						<a4j:outputPanel id="outTable">
							<g:GTable gid="gtable2" gtype="grid" gversion="2" gdebug="false"
								gselectsql="SELECT  a.did,a.biid,a.whid,a.baco,a.inco,a.qty,a.orid,b.inna,b.inty,b.inpr,b.colo,b.inse,b.volu,b.newe 
										 ,a.ouid,a.loco from asde a
											LEFT JOIN inve b ON  a.inco=b.inco where biid='#{afterSignleMB.mbean.biid}'
											"
								gpage="(pagesize = 40)" gsort="whid" gsortmethod="asc"
								gcolumn="gcid =  did(headtext = selall,name = did,width = 30,align = center,type = checkbox ,headtype = #{afterSignleMB.commitStatus ? 'checkbox' : 'hidden'});
												gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
												gcid = ouid(headtext = 订单,name = ouid,width = 130,headtype = sort,align = left,type = text,datatype=string);
												gcid = loco(headtext = 快递单号,name = loco,width = 130,headtype = sort,align = left,type = text,datatype=string);
												gcid = baco(headtext = 条码,name = baco,width = 120,headtype = sort,align = left,type = text,datatype=string);
												gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
												gcid = inna(headtext = 商品名称,name = inna,width = 140,headtype = sort,align = left,type = text,datatype=string);
												gcid = colo(headtext = 规格,name = colo,width = 120,align = left,type = text,headtype = sort ,datatype = string);
												gcid = inse(headtext = 规格码,name = inse,width = 90,align = left,type = text,headtype = sort ,datatype = string);
												gcid = whid(headtext = 库位,name = whid,width = 100,headtype = sort,align = left,type = text,datatype=string);
												gcid = qty(headtext = 数量,name = qty,width = 75,headtype = sort,align = right,type = text,datatype=number,dataformat={###,###,##0},summary=this);
												" />
						</a4j:outputPanel>
					</DIV>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{afterSignleMB.msg}" />
							<h:inputHidden id="roids" value="#{afterSignleMB.roids}" />
							<h:inputHidden id="sellist" value="#{afterSignleMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</DIV>
			</h:form>
		</f:view>
	</body>
</html>

