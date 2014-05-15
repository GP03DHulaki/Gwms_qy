<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.ReturnPlanMB"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑退货计划单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑退货计划单">
		<meta http-equiv="description" content="编辑退货计划单">
		<script type="text/javascript" src="returnplan.js"></script>
	</head>
	<%
		String id = "";
		ReturnPlanMB ai = (ReturnPlanMB) MBUtil
				.getManageBean("#{returnPlanMB}");
		if (request.getParameter("pid") != null) {
			id = request.getParameter("pid");
			ai.getMbean().setBiid(id);
		}
		ai.getVouch();
	%>
	<body id="mmain_body" onload="initEdit();">
		<div id="mmain_nav">
			<font color="#000000">退货处理&gt;&gt;<a id="linkid" title="返回"
				class="return" href="returnplan.jsf">销售退货计划</a>&gt;&gt;</font><b>编辑销售退货计划单</b>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id="mmain_opt">
						<a4j:outputPanel id="output">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" rendered="#{returnPlanMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{returnPlanMB.updateHead}" onclick="updateHead()"
								oncomplete="endUpdateHead();" reRender="output,renderArea"
								requestDelay="50"
								rendered="#{returnPlanMB.MOD && returnPlanMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{returnPlanMB.deleteHead}"
								onclick="if(!doDel()){return false;}"
								reRender="output,renderArea" oncomplete="endDele();"
								requestDelay="50"
								rendered="#{returnPlanMB.DEL && returnPlanMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" id="submitMBut"
								onclick="if(!app()){return false};"
								rendered="#{returnPlanMB.APP && returnPlanMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{returnPlanMB.approveVouch}"
								reRender="detailButtont,renderArea,output,head,tableid"
								oncomplete="endApp();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="tijiao" value="提交" type="button" action=""
								onclick="tijiao()"
								reRender="output,renderArea,head,detailButtont,tableid"
								oncomplete="endTijiao();" requestDelay="50" rendered="false" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="huitui" value="回退" type="button" action=""
								onclick="huitui()"
								reRender="output,renderArea,head,detailbutton,input,tableid"
								oncomplete="endHuitui();" requestDelay="50" rendered="false"></a4j:commandButton>
							<a4j:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{returnPlanMB.printReport}"
								rendered="#{returnPlanMB.PRN && !returnPlanMB.commitStatus}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output" requestDelay="1000" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="showHead">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="单据单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{returnPlanMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>									
									<td>
									<h:outputText value="单据类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="buty" style="width:130px;" disabled="true"
											value="#{returnPlanMB.mbean.buty}">
											<f:selectItems value="#{returnPlanMB.butys}" />
										</h:selectOneMenu>
									</td>
									<td>
										组织架构:
									</td>
									<td>
										<h:selectOneMenu id="iorid" value="#{returnPlanMB.mbean.orid}">
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
											value="#{returnPlanMB.mbean.whna}" disabled="true" />
										<h:inputHidden id="whid" value="#{returnPlanMB.mbean.whid}"/>
									</td>
									<td>
										<h:outputText value="退货时间:"></h:outputText>
									</td>
									<td>
										<h:inputText id="stdt" styleClass="datetime"
											value="#{returnPlanMB.mbean.stdt}"
											disabled="#{!returnPlanMB.commitStatus}"
											onfocus="#{gmanage.datePicker};" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!returnPlanMB.commitStatus}"
											value="#{returnPlanMB.mbean.rema}" size="68" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div id="mmain_opt">
						<a4j:outputPanel id="detailButtont">
							<a4j:outputPanel rendered="#{returnPlanMB.commitStatus}">
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="showAddDetail();"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" reRender="renderArea,output,tableid,msg"
									rendered="#{returnPlanMB.ADD && returnPlanMB.commitStatus}"
									requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{returnPlanMB.MOD && returnPlanMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{returnPlanMB.updateDetail}"
									reRender="renderArea,output" oncomplete="endUpdateDetail();"
									requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{returnPlanMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,tableid"
									rendered="#{returnPlanMB.DEL && returnPlanMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<div>
						<a4j:outputPanel id="tableid">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="SELECT distinct a.did,a.biid,a.roid,a.soco,a.fbid,a.inco,p.tyna,a.baco,a.whid,b.psco,
											b.asco,a.dqty,a.qty,b.inna,b.inty,b.inpr,b.colo,b.inse,b.volu,b.newe,a.rqty,a.pric,a.loco FROM rpde a 
											LEFT JOIN inve b ON a.inco = b.inco
											left join prty p on p.inty = b.inty
											Where a.biid = '#{returnPlanMB.mbean.biid}' "
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {rpde},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = #{returnPlanMB.commitStatus ? 'checkbox' : 'hidden'});
										gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
										gcid = roid(name = roid,type = text,headtype = hidden ,datatype = string);
										gcid = soco(headtext = 销售订单,name = biid,width = 150,align = left,type = text,headtype = sort ,datatype = string);
										gcid = loco(headtext = 运单号,name = biid,width = 90,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inna(headtext = 商品名称,name = inna,width = 130,align = left,type = text,headtype = sort ,datatype = string);
										gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
										gcid = baco(headtext = 商品条码,name = baco,width = 100,align = left,type = text,headtype = sort ,datatype = string);
										gcid = qty(headtext = 数量,name = qty,width = 60,align = right,type = #{returnPlanMB.commitStatus ? 'input' : 'text'},headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
										gcid = pric(headtext = 价格,name = pric,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.00,update=edit,summary=this);
										gcid = rqty(headtext = 入库数量,name = rqty,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
										gcid = dqty(headtext = 收货数量,name = dqty,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
									" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{returnPlanMB.msg}" />
							<h:inputHidden id="roids" value="#{returnPlanMB.roids}" />
							<h:inputHidden id="sellist" value="#{returnPlanMB.sellist}" />
							<h:inputHidden id="incos" value="#{returnPlanMB.mbean.incos}" />
							<h:inputHidden id="updatedata" value="#{returnPlanMB.updatedata}" />
							<a4j:commandButton id="refBut" value="刷新明细" type="button" reRender="tableid" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>