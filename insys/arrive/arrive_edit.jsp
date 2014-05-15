<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.PurchaseArriveMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑采购到货单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑采购到货单">
		<meta http-equiv="description" content="编辑采购到货单">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="arrive.js"></script>
	</head>

	<%
	    String id = "";
	    PurchaseArriveMB ai = (PurchaseArriveMB) MBUtil
	            .getManageBean("#{purchaseArrvicMB}");
	    if (request.getParameter("pid") != null) {
	        id = request.getParameter("pid");
	        ai.getMbean().setBiid(id);
	    }
	    ai.getVouch();
	%>
	<body id="mmain_body" >
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;<a href="arrive.jsf"
				title="返回" class="return">入库</a>&gt;&gt;</font><b>编辑采购到货单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id="mmain_opt">
						<a4j:outputPanel id="output">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" rendered="#{purchaseArrvicMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{purchaseArrvicMB.updateHead}"
								onclick="if(!updateHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{purchaseArrvicMB.MOD && purchaseArrvicMB.commitStatus}"
								oncomplete="endUpdateHead();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{purchaseArrvicMB.deleteHead}"
								onclick="if(!doDel()){return false;}"
								reRender="output,renderArea" oncomplete="endDele();"
								requestDelay="50"
								rendered="#{purchaseArrvicMB.DEL && purchaseArrvicMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="approveId" value="审核" type="button"
								action="#{purchaseArrvicMB.existsApprove}"
								onclick="if(!app()){return false;}"
								reRender="output,renderArea,head,countPage,detailbutton,input,tableid"
								oncomplete="endExists();" requestDelay="50"
								rendered="#{purchaseArrvicMB.APP && purchaseArrvicMB.commitStatus}" />
							<a4j:commandButton 	id="rapprove" value="补做采购订单" type="button"
								action="#{purchaseArrvicMB.redoPubm}"
								reRender="output,renderArea,head,countPage,detailbutton,input,tableid"
								style="display:none" oncomplete="endApp();" />
							<a4j:commandButton 	id="approve" value="审核单据" type="button"
								action="#{purchaseArrvicMB.approveVouch}"
								reRender="output,renderArea,head,countPage,detailbutton,input,tableid"
								style="display:none" oncomplete="endApp();" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>

					<div id="mmain_cnd">
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="采购到货单:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{purchaseArrvicMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="单据类型:" />
									</td>
									<td>
										<h:selectOneMenu id="dety" disabled="true"
											value="#{purchaseArrvicMB.mbean.dety}">
											<f:selectItems value="#{purchaseArrvicMB.detys}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="来源类型:" />
									</td>
									<td>
										<h:selectOneMenu id="soty" disabled="true"
											value="#{purchaseArrvicMB.mbean.soty}">
											<f:selectItems value="#{purchaseArrvicMB.sotys}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="来源单号:"></h:outputText>
									</td>
									<td>
										<%--style="readonly:expression(this.readOnly=true);color:#7f7f7f;" --%>
										<h:inputText id="soco" styleClass="datetime"
											style="color:#7f7f7f;" readonly="true"
											value="#{purchaseArrvicMB.mbean.soco}" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="nv_remark" styleClass="datetime"
											disabled="#{!purchaseArrvicMB.commitStatus}"
											value="#{purchaseArrvicMB.mbean.rema}" size="90" />
												<h:inputHidden id="isty" value="#{purchaseArrvicMB.mbean.isty}"/>
									</td>
								
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div id="mmain_opt">
						<a4j:outputPanel id="detailbutton">
							<a4j:outputPanel rendered="#{purchaseArrvicMB.commitStatus}">
								<a4j:commandButton onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									value="添加明细" type="button" reRender="tableid,tableid2"
									onclick="showAddDetail();" rendered="#{purchaseArrvicMB.MOD}"
									requestDelay="50" />

								<a4j:commandButton onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									value="删除明细" type="button"
									action="#{purchaseArrvicMB.deleteDetail}"
									onclick="if(!delDetail('gtable')){return false};"
									rendered="#{purchaseArrvicMB.MOD}"
									reRender="tableid,renderArea" oncomplete="endDelDetail();"
									requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{purchaseArrvicMB.MOD && purchaseArrvicMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{purchaseArrvicMB.updateDetail}"
									reRender="renderArea,output,countPage,tableid,msg"
									oncomplete="endUpdateDetail();" />
								<a4j:commandButton id="newDBut" value="新增明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{purchaseArrvicMB.MOD && purchaseArrvicMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="addDiv();" type="button"  />
								<gw:GAjaxButton id="impDBut" value="导入明细" theme="b_theme"
									rendered="#{purchaseArrvicMB.MOD && purchaseArrvicMB.commitStatus}"
									onclick="showImport()" type="button" />
							</a4j:outputPanel>
							<a4j:commandButton id="saveDButEx" value="保存调整明细"
								onmouseover="this.className='a4j_over1'"
								rendered="#{purchaseArrvicMB.SPE&&purchaseArrvicMB.mbean.dety=='01'&& !purchaseArrvicMB.commitStatus}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="if(!updateDetailEx()){return false};" type="button"
								action="#{purchaseArrvicMB.updateDetailEx}"
								reRender="renderArea,output,countPage,tableid,msg"
								oncomplete="endUpdateDetailEx();" />
						</a4j:outputPanel>
					</div>
					<div>
						<a4j:outputPanel id="tableid">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="
									SELECT a.did,a.soco,a.biid,a.baco,a.inco,a.qty,b.inna,b.inse,b.colo,isnull(a.uqty,0) as uqty
									FROM rgde a 
									LEFT JOIN inve b ON a.inco=b.inco JOIN rgma d ON a.biid=d.biid
									where a.biid='#{purchaseArrvicMB.mbean.biid}'
								"
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {rgde},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
								gcid = soco(headtext = 到货通知单,name = soco,width = 120,align = left,type = text,headtype = sort ,datatype = string,update=edit);
								gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string,update=edit);
								gcid = inna(headtext = 商品名称,name = inna,width = 200,align = left,type = text,headtype = sort ,datatype = string);
								gcid = colo(headtext = 规格,name = colo,width = 80,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inse(headtext = 规格码,name = inse,width = 80,align = left,type = text,headtype = sort ,datatype = string);
								gcid = qty(headtext =  #{purchaseArrvicMB.mbean.titlestr},summary=this,name = qty,width = 90,align = right,update=edit,type = #{purchaseArrvicMB.commitStatus ? 'input' : 'text' },headtype=sort,datatype=number,dataformat={0},gscript={onkeypress=return isInteger(event),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
" />
						</a4j:outputPanel>
					</div>

					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{purchaseArrvicMB.msg}" />
							<h:inputHidden id="sellist" value="#{purchaseArrvicMB.sellist}" />
							<h:inputHidden id="orid" value="#{purchaseArrvicMB.orid}" />
							<h:inputHidden id="socos" value="#{purchaseArrvicMB.socos}" />
							<h:inputHidden id="incos" value="#{purchaseArrvicMB.incos}" />
							<h:inputHidden id="qtys" value="#{purchaseArrvicMB.qtys}" />
							<h:inputHidden id="updatedata"
								value="#{purchaseArrvicMB.updatedata}" />
							<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
								reRender="tableid" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
				<div id="edit" style="display:none ">
					<h:form id="edit1">
						<a4j:outputPanel id="editpanel">
							<table align=center>
								<tr>
									<td bgcolor="#efefef">
										商品编码：
									</td>
									<td>
										<h:inputText id="inco" value="#{purchaseArrvicMB.dbean.inco}"
											styleClass="inputtext" onfocus="this.select()" />
										<img id="invcode_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectInve();" />
									</td>
									<td bgcolor="#efefef">
										商品名称：
									</td>
									<td>
										<h:inputText id="inna" value="#{purchaseArrvicMB.dbean.inna}"
											disabled="true" styleClass="inputtext" onfocus="this.select()" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										到货数量：
									</td>
									<td>
										<h:inputText id="qty" value="#{purchaseArrvicMB.dbean.qty}"
											styleClass="inputtext" onclick="this.select()" />
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										<a4j:commandButton id="saveid" action="#{purchaseArrvicMB.addDetailOne}"
											value="保存" reRender="tableid,msg,renderArea"
											onclick="if(!formCheck()){return false};"
											oncomplete="endDo();" onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{purchaseArrvicMB.MOD}">
										</a4j:commandButton>
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv1(1);" />
									</td>
								</tr>
							</table>	
						</a4j:outputPanel>
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{purchaseArrvicMB.msg}" />
						</a4j:outputPanel>
					</h:form>
	
				</div>
				<div id="import" style="display: none" align="left">
				<h:form id="file" enctype="multipart/form-data">
					<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
						value="#{purchaseArrvicMB.myFile}" required="true" size="75" />
					<div id="mes"></div>
					<div align="center">
						<gw:GAjaxButton value="上传" onclick="return doImport();"
							id="import" theme="a_theme" />
						<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
							onclick="hideDiv()" type="button" />
					</div>
					<div style="display: none;">
						<h:commandButton value="上传" id="importBut"
							action="#{purchaseArrvicMB.uploadFile}" />
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>
<%--
<a4j:outputPanel id="tableid">
	<g:GTable gid="gtable" gtype="grid" gdebug="true"
		gselectsql="SELECT a.did,a.soco,a.biid,a.paco,a.baco,a.boco,a.inco,a.qty,a.whid,b.inna,b.inse,b.colo,b.inun,c.cpqty,isnull(a.uqty,'0') as uqty
		FROM rgde a LEFT JOIN inve b ON a.inco=b.inco 
		LEFT JOIN (SELECT inco,qty AS cpqty,soco FROM cpbd WHERE biid='#{purchaseArrvicMB.mbean.soco}') c ON a.inco=c.inco and a.soco=c.soco
		where a.biid='#{purchaseArrvicMB.mbean.biid}' "
		gpage="(pagesize = 20)" gversion="2"
		gupdate="(table = {rgde},tablepk = {did})"
		gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = checkbox);
		gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
		gcid = soco(headtext = 采购订单,name = soco,width = 120,align = left,type = text,headtype = sort ,datatype = string,update=edit);
		gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string,update=edit);
		gcid = inna(headtext = 商品名称,name = inna,width = 200,align = left,type = text,headtype = sort ,datatype = string);
		gcid = colo(headtext = 规格,name = colo,width = 80,align = left,type = text,headtype = sort ,datatype = string);
		gcid = inse(headtext = 规格码,name = inse,width = 80,align = left,type = text,headtype = sort ,datatype = string);
		gcid = cpqty(headtext =  #{purchaseArrvicMB.colName},name = cpqty,summary=this,width = 70,align = right,update=edit,type = text,headtype=sort,datatype=number,dataformat={0});
		gcid = qty(headtext =  #{purchaseArrvicMB.mbean.titlestr},summary=this,name = qty,width = 90,align = right,update=edit,type = #{purchaseArrvicMB.commitStatus ? 'input' : 'text' },headtype=sort,datatype=number,dataformat={0},gscript={onkeypress=return isInteger(event),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
		gcid = uqty(headtext = 调整数量,name = uqty,width = 90,align = right,update=edit,type = #{purchaseArrvicMB.SPE&&purchaseArrvicMB.mbean.dety=='01'&& !purchaseArrvicMB.commitStatus ? 'input' : 'hidden' },headtype=sort,datatype=number,dataformat={0},gscript={onkeypress=return isInteger(event),keyhandle(this)&&onkeydown=keyhandleupdown(this)});
		" />
</a4j:outputPanel>
--%>