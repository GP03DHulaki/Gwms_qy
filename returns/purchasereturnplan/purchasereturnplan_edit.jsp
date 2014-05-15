<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.PurchaseReturnsPlanMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑采购退货计划单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑采购退货计划单">
		<meta http-equiv="description" content="编辑采购退货计划单">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="purchasereturnplan.js"></script>
	</head>
	<%
		String id = "";
		PurchaseReturnsPlanMB ai = (PurchaseReturnsPlanMB) MBUtil
				.getManageBean("#{purchaseReturnPlanMB}");
		if (request.getParameter("pid") != null) {
			id = request.getParameter("pid");
			ai.getMbean().setBiid(id);
		}
		ai.getVouch();
	%>
	<body id="mmain_body" onload="initEdit();">
		<div id="mmain_nav">
			<font color="#000000">退货处理&gt;&gt;<a id="linkid" title="返回"
				class="return" href="purchasereturnplan.jsf">采购退货计划</a>&gt;&gt;</font><b>编辑采购退货计划单</b>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id="mmain_opt">
						<a4j:outputPanel id="output">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" rendered="#{purchaseReturnPlanMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{purchaseReturnPlanMB.updateHead}"
								onclick="updateHead()" oncomplete="endUpdateHead();"
								reRender="output,renderArea" requestDelay="50"
								rendered="#{purchaseReturnPlanMB.MOD && purchaseReturnPlanMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{purchaseReturnPlanMB.deleteHead}"
								onclick="if(!doDel()){return false;}"
								reRender="output,renderArea" oncomplete="endDele();"
								requestDelay="50"
								rendered="#{purchaseReturnPlanMB.DEL && purchaseReturnPlanMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" id="submitMBut"
								onclick="if(!app()){return false;}"
								rendered="#{purchaseReturnPlanMB.APP && purchaseReturnPlanMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{purchaseReturnPlanMB.approveVouch}"
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
								action="#{purchaseReturnPlanMB.printReport}"
								rendered="#{purchaseReturnPlanMB.PRN && !purchaseReturnPlanMB.commitStatus}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output" requestDelay="1000" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="采购退货计划:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{purchaseReturnPlanMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
									<td>
										<h:outputText value="业务类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="buty" style="width:130px;"
											value="#{purchaseReturnPlanMB.mbean.buty}">
											<f:selectItems value="#{purchaseReturnPlanMB.butys}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="组织架构:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{purchaseReturnPlanMB.mbean.orid}" 
											disabled="#{!purchaseReturnPlanMB.commitStatus}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="退货仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whna" styleClass="datetime"
											value="#{purchaseReturnPlanMB.mbean.whna}" disabled="true" />
									</td>
									<td>
										路&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;线:
									</td>
									<td>
										<h:selectOneMenu id="lico" style="width:130px;"
											value="#{purchaseReturnPlanMB.mbean.lico}">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{lineMB.itemlist}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="退货时间:"></h:outputText>
									</td>
									<td>
										<h:inputText id="stdt" styleClass="datetime"
											value="#{purchaseReturnPlanMB.mbean.stdt}"
											disabled="#{!purchaseReturnPlanMB.commitStatus}"
											onfocus="#{gmanage.datePicker};" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="供货商编号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="stus" styleClass="datetime"
											value="#{purchaseReturnPlanMB.mbean.stus}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
										<a4j:outputPanel id="whidimg" rendered="#{purchaseReturnPlanMB.commitStatus}">
											<img id="whid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectstus();" />
										</a4j:outputPanel>	
									</td>
									<td>
										<h:outputText value="供货商名称:"></h:outputText>
									</td>
									<td >
										<h:inputText id="stna" styleClass="datetime"
											value="#{purchaseReturnPlanMB.mbean.stna}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
									<td>
										<h:outputText value="单据标志:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="flag" style="width:130px;"
											value="#{purchaseReturnPlanMB.mbean.flag}" disabled="true">
											<f:selectItems value="#{purchaseReturnPlanMB.flags}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="经手人"></h:outputText>
									</td>
									<td>
										<h:inputText id="opna" styleClass="datetime"
											disabled="#{!purchaseReturnPlanMB.commitStatus}"
											value="#{purchaseReturnPlanMB.mbean.opna}" />
									</td>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!purchaseReturnPlanMB.commitStatus}"
											value="#{purchaseReturnPlanMB.mbean.rema}" size="70" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<!-- 
					<div id="mmain_cnd">
						<a4j:outputPanel id="count">
							<iframe id="po" frameborder="0" src="po.jsf" width="98%"
								height="100px;" style=""></iframe>
						</a4j:outputPanel>
					</div>
					 -->
					<div id="mmain_opt">
						<a4j:outputPanel id="detailButtont">
							<a4j:outputPanel rendered="#{purchaseReturnPlanMB.commitStatus}">
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="addDetail();" onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" reRender="renderArea,output,tableid,msg"
									rendered="#{purchaseReturnPlanMB.ADD && purchaseReturnPlanMB.commitStatus}"
									requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{purchaseReturnPlanMB.MOD && purchaseReturnPlanMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{purchaseReturnPlanMB.updateDetail}"
									reRender="renderArea,output" oncomplete="endUpdateDetail();"
									requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{purchaseReturnPlanMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,tableid"
									rendered="#{purchaseReturnPlanMB.DEL && purchaseReturnPlanMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<!-- 
								<a4j:commandButton id="deleteBut" value="清除0记录行"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{purchaseReturnPlanMB.clearDetail}"
									onclick="if(!clearDetail()){return false};"
									reRender="renderArea,output,tableid"
									rendered="#{purchaseReturnPlanMB.DEL && purchaseReturnPlanMB.commitStatus}"
									oncomplete="endClearDetail();" requestDelay="50" />
								 -->
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<div>
						<a4j:outputPanel id="tableid">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="
select  distinct a.did,a.roid, a.biid,a.inco,a.whid,a.qty,b.inna,b.asco,b.psco,b.inty,b.inpr,p.tyna,b.colo,b.inse,b.volu,b.newe
			FROM prbd a 
			LEFT JOIN inve b ON a.inco = b.inco
			left join prty p on p.inty = b.inty
			Where a.biid = '#{purchaseReturnPlanMB.mbean.biid}'"
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {prbd},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = #{purchaseReturnPlanMB.commitStatus ? 'checkbox' : 'hidden'});
										gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
										gcid = roid(headtext = roid,name = roid,type = text,headtype = hidden ,datatype = string);
										gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inna(headtext = 商品名称,name = inna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
										gcid = tyna(headtext = 商品品类,name = inty,width = 70,align = left,type = text,headtype = sort ,datatype = string);
										gcid = colo(headtext = 规格,name = colo,width = 110,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inse(headtext = 规格码,name = inse,width = 60,align = left,type = text,headtype = sort ,datatype = string);
										gcid = volu(headtext = 体积,name = volu,width = 90,align = left,type = text,headtype = sort ,datatype = number,dataformat=0.00);
										gcid = qty(headtext = 数量,name = qty,width = 60,align = right,type = #{purchaseReturnPlanMB.commitStatus ? 'input' : 'text'},headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
									" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{purchaseReturnPlanMB.msg}" />
							<h:inputHidden id="roids" value="#{purchaseReturnPlanMB.roids}" />
							<h:inputHidden id="filename" value="#{purchaseReturnPlanMB.fileName}" />
							<h:inputHidden id="sellist"
								value="#{purchaseReturnPlanMB.sellist}" />
							<h:inputHidden id="incos"
								value="#{purchaseReturnPlanMB.mbean.incos}" />
							<h:inputHidden id="soco"
								value="#{purchaseReturnPlanMB.mbean.soco}" />
							<h:inputHidden id="updatedata"
								value="#{purchaseReturnPlanMB.updatedata}" />
						</a4j:outputPanel>
						<a4j:outputPanel>
							<a4j:commandButton id="insertadds" value="保存明细"
								onmouseover="this.className='a4j_over1'" style="display:none"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="if(!insertin()){return false;}" type="button"
								action="#{purchaseReturnPlanMB.addDetail}"
								reRender="renderArea,tableid,msg" oncomplete="endAddDetail();"
								requestDelay="50" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>