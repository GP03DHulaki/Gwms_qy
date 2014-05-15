<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.ReturnPutawayMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>编辑销售退货上架单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑销售退货上架单">
		<meta http-equiv="description" content="编辑销售退货上架单">
		<script type="text/javascript" src="returnputaway.js"></script>
	</head>
	<%
	    String id = "";
		ReturnPutawayMB ai = (ReturnPutawayMB) MBUtil.getManageBean("#{returnPutawayMB}");
	    if (request.getParameter("pid") != null) {
	        id = request.getParameter("pid");
	        ai.getMbean().setBiid(id);
	    }
	    ai.getVouch();
	%>
	<body id="mmain_body">

		<div id="mmain_nav">
			<font color="#000000">销售退货上架&gt;&gt;<a href="returnputaway.jsf"
				title="返回" class="return">销售退货上架</a>&gt;&gt;</font><b>编辑销售退货上架单</b>
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
								onclick="addNew();" rendered="#{returnPutawayMB.ADD}" />
							<!--  
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{returnPutawayMB.updateHead}"
								onclick="if(!updateHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{returnPutawayMB.MOD && returnPutawayMB.commitStatus}"
								oncomplete="endUpdateHead();" />
							-->
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{returnPutawayMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50"
								rendered="#{returnPutawayMB.DEL && returnPutawayMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" id="submitMBut"
								rendered="#{returnPutawayMB.APP && returnPutawayMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{returnPutawayMB.approveVouch}"
								reRender="showHeadButton,renderArea,output,detailbutton,showHead,head,tableid,input"
								oncomplete="endAlertMsg();" requestDelay="50" />		
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>

					<div id=mmain_cnd>
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="销售退货上架单:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{returnPutawayMB.mbean.biid}" disabled="true" />
									</td>									
									<td>
										<h:outputText value="组织架构:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{returnPutawayMB.mbean.orid}"
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
										<h:selectOneMenu id="whid" value="#{returnPutawayMB.mbean.whid}"
											disabled="true">
											<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="上架类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="dety" value="#{returnPutawayMB.mbean.dety}" disabled="true">
											<f:selectItem itemLabel= "合格品" itemValue= "01"/> 
											<f:selectItem itemLabel= "不合格品" itemValue= "05"/> 
										</h:selectOneMenu>
									</td>
									<!-- 
									<td id="initdisplay" colspan="2" style="display: none;">
										来源单号:
										<h:inputText id="srid" value="#{returnPutawayMB.mbean.soco}"
											styleClass="datetime" size="16" disabled="true" />
									</td>
									 -->
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="4">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!returnPutawayMB.commitStatus}"
											value="#{returnPutawayMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div id=mmain_opt>
						<a4j:outputPanel id="detailbutton">
							<a4j:outputPanel
								rendered="#{returnPutawayMB.MOD && returnPutawayMB.commitStatus}">
								<a4j:commandButton id="addDBut" value="添加明细"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{returnPutawayMB.addDetail}"
									reRender="renderArea,output,tableid"
									rendered="#{returnPutawayMB.MOD && returnPutawayMB.commitStatus}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明细"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{returnPutawayMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,tableid"
									rendered="#{returnPutawayMB.MOD && returnPutawayMB.commitStatus}"
									oncomplete="endAlertMsg();" requestDelay="50" />
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="input">
							<h:panelGroup layout="block"
								rendered="#{returnPutawayMB.MOD && returnPutawayMB.commitStatus}">
								<table border="0" cellpadding="1" cellspacing="0">
									<tbody>
										<tr>
											<td>
												<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细" />
											</td>
											<td>
												<h:selectOneMenu id="autoItem" value="#{returnPutawayMB.autoItem}"
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
													value="#{returnPutawayMB.dbean.codetype}" layout="lineDirection"
													onclick="initEdit();t.batyClick(this);">
													<f:selectItems value="#{returnPutawayMB.codetypes}" />
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
												<h:inputText id="baco" value="#{returnPutawayMB.dbean.baco}"
													onblur="t.setCode4DBean();" onfocus="this.select();"
													styleClass="datetime" size="35"
													onkeypress="t.keyPressDeal(this);" />
												<!-- 
												<img id="invcode_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectCode();" />
												 -->
											</td>
											<td width="30px;">
												<h:outputText value="数量:"></h:outputText>
											</td>
											<td oncontextmenu='return(false);' onpaste='return false'>
												<h:inputText id="qty" value="#{returnPutawayMB.dbean.qty}"
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
													onchange="onchangeWhid();" style="readonly:expression(this.readOnly=true);color:#7f7f7f;"
													value="#{returnPutawayMB.dbean.whid}" />
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
								from rude a left join inve b on a.inco = b.inco left join waho c on a.whid = c.whid  
								 Where a.biid = '#{returnPutawayMB.mbean.biid}' "
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {oide},tablepk = {did})"
								gcolumn="gcid = roid(headtext = selall,name = roid,width = 20,align = center,type = checkbox,headtype = #{returnPutawayMB.commitStatus ? 'checkbox' : 'hidden'});
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = inco(headtext = 商品编码,name = inco,width = 130,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 商品名称,name = inna,width = 160,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext = 数量,name = qty,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
									gcid = baco(headtext = 商品条码,name = baco,width = 180,align = left,type = text,headtype = sort ,datatype = string);
									gcid = whid(headtext = 库位编码,name = whid,width = 100,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inty(headtext = 商品品类,name = inty,width = 60,align = left,type = text,headtype = hidden ,datatype = string);
								" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{returnPutawayMB.msg}" />
						<h:inputHidden id="sellist" value="#{returnPutawayMB.sellist}" />
					</a4j:outputPanel>
				</div>
			</h:form>
		</f:view>
	</body>
</html>