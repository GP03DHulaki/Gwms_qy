<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.MoinMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>编辑生产入库单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑生产入库单">
		<meta http-equiv="description" content="编辑生产入库单">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="moin.js"></script>
	</head>
	<%
		String id = "";
		MoinMB ai = (MoinMB) MBUtil.getManageBean("#{moinMB}");
		if (request.getParameter("pid") != null) {
			id = request.getParameter("pid");
			ai.getMbean().setBiid(id);
		}
		ai.getVouch();
	%>
	<body id="mmain_body" onload="initEdit();">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;<a href="moin.jsf" title="返回" class="return">入库</a>&gt;&gt;</font><b>编辑生产入库单</b>
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
								onclick="addNew();" rendered="#{moinMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{moinMB.updateHead}"
								onclick="if(!updateHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{moinMB.MOD && moinMB.commitStatus}"
								oncomplete="endUpdateHead();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{moinMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50"
								rendered="#{moinMB.DEL && moinMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" onclick="app();"
								rendered="#{moinMB.APP && moinMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{moinMB.approveVouch}" id="submitMBut"
								reRender="showHeadButton,renderArea,output,detailbutton,showHead,head,tableid,input"
								oncomplete="endApp();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="tijiao" value="提交" type="button" action=""
								onclick="tijiao()"
								reRender="output,renderArea,head,countPage,detailbutton,input,tableid"
								oncomplete="endTijiao();" requestDelay="50" rendered="false" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="huitui" value="回退" type="button" action=""
								onclick="huitui()"
								reRender="output,renderArea,head,countPage,detailbutton,input,tableid"
								oncomplete="endHuitui();" requestDelay="50" rendered="false" />
							<a4j:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{moinMB.printReport}"
								rendered="#{moinMB.PRN && !moinMB.commitStatus}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output" requestDelay="1000" />
							<a4j:commandButton id="wrBackBut" value="回写单据" type="button"
								rendered="#{moinMB.SPE && !moinMB.commitStatus}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{moinMB.writeBackVouch}" oncomplete="endApp();"
								reRender="output,renderArea" disabled="#{!moinMB.canWriteBack}"
								styleClass="a4j_but1" onclick="startDo();" />	
						</a4j:outputPanel>
					</div>

					<div id=mmain_cnd>
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="生产入库单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{moinMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										来源类型:
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{moinMB.mbean.soty}"
											style="width:130px;" disabled="true">
											<f:selectItem itemLabel="生产包装计划" itemValue="MOPLAN" />
										</h:selectOneMenu>
									</td>
									<td>
										来源单号:
									</td>
									<td>
										<h:inputText id="soco" size="20" styleClass="inputtext"
											value="#{moinMB.mbean.soco}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
										<!--<img id="suid_img" style="cursor: pointer"
							src="../../images/find.gif" onclick="selectFrom();" />
					-->
									</td>
									<td>
										<h:outputText value="单据标志:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="flag" value="#{moinMB.mbean.flag}"
											disabled="true">
											<f:selectItems value="#{moinMB.flags}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="入库类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="dety" value="#{moinMB.mbean.dety}"
											disabled="true">
											<f:selectItems value="#{moinMB.butys}" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="送货人编码:"></h:outputText>
									</td>
									<td>
										<h:inputText id="opna" styleClass="datetime"
											disabled="#{!moinMB.commitStatus}"
											value="#{moinMB.mbean.opna}" />
									</td>
									<td>
										<h:outputText value="组织架构:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="orid1" value="#{moinMB.mbean.orid}"
										 	disabled="#{!moinMB.commitStatus}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="入库人:"></h:outputText>
									</td>
									<td>
										<h:inputText id="crna" styleClass="datetime" disabled="true"
											value="#{moinMB.mbean.crna}" />
									</td>
									<td>
										<h:outputText value="入库仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whna" styleClass="datetime"
											value="#{moinMB.mbean.whna}" disabled="true" />
										<h:inputHidden id="whid" value="#{moinMB.mbean.whid}"></h:inputHidden>
										<a4j:outputPanel rendered="#{moinMB.commitStatus && (moinMB.mbean.whna==null ? true : false) }">
											<img id="whid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectWaho();" />
										</a4j:outputPanel>
									</td>
									
									<td>
										<h:outputText value="入库时间:"></h:outputText>
									</td>
									<td>
										<h:inputText id="crdt" styleClass="datetime" disabled="true"
											value="#{moinMB.mbean.crdt}" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!moinMB.commitStatus}"
											value="#{moinMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<!--
		
		<a4j:outputPanel id="countPage">
			<div id="mmain_cnd">
				<iframe id="view" frameborder="0" src="count.jsf" width="98%"
					height="120px;"></iframe>
			</div>
		</a4j:outputPanel>
		
		-->
					<div id=mmain_opt>
						<a4j:outputPanel id="detailbutton">
							<a4j:outputPanel rendered="#{moinMB.MOD && moinMB.commitStatus}">
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{moinMB.addDetail}"
									reRender="renderArea,output,tableid"
									rendered="#{moinMB.ADD && moinMB.commitStatus}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{moinMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,tableid"
									rendered="#{moinMB.DEL && moinMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{moinMB.MOD && moinMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{moinMB.updateDetail}" reRender="renderArea,output"
									oncomplete="endUpdateDetail();" requestDelay="50" />
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="input">
						<a4j:outputPanel rendered="#{moinMB.MOD && moinMB.commitStatus}">
							<div id=mmain_cnd>
								<table>
									<tr>
										<td>
											<h:outputText value="商品编码:"></h:outputText>
										</td>
										<td>
											<h:inputText id="inco" value="#{moinMB.dbean.inco}"
												styleClass="datetime" size="16" onkeypress="clickInve();" />
											<img id="invcode_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectInveAdd();" />
										</td>
										<td>
											<h:outputText value="数量:"></h:outputText>
										</td>
										<td>
											<h:inputText id="qty" value="#{moinMB.dbean.qty}"
												styleClass="datetime" size="16" />
										</td>
										<td>
											<h:outputText value="货位编码:"></h:outputText>
										</td>
										<td>
											<h:inputText id="dwhid" styleClass="datetime"
												value="#{moinMB.dbean.whid}" disabled="false" />
											<img id="whid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectWahod();" />
										</td>
									</tr>
								</table>
							</div>
						</a4j:outputPanel>
					</a4j:outputPanel>


					<div>
						<a4j:outputPanel id="tableid">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="select a.did,a.inco,a.qty,a.whid,b.inna,b.inty,d.tyna,b.inst,b.volu,b.newe,b.inpr,b.colo,c.whna       
								from csde a left join inve b on a.inco = b.inco left join waho c on a.whid = c.whid left join prty d on b.inty = d.inty   
								 Where a.biid = '#{moinMB.mbean.biid}' "
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {csde},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = checkbox);
						gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
						gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
						gcid = inna(headtext = 商品名称,name = inna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
						gcid = colo(headtext = 花色,name = colo,width = 90,align = left,type = text,headtype = sort ,datatype = string);
						gcid = inst(headtext = 规格,name = inst,width = 90,align = left,type = text,headtype = sort ,datatype = string);
						gcid = tyna(headtext = 商品品类,name = tyna,width = 90,align = left,type = text,headtype = sort ,datatype = string);
						gcid = inpr(headtext = 属性,name = inpr,width = 90,align = left,type = mask,typevalue=P:成品/S:半成品/M:商品,headtype = sort ,datatype = string);
						gcid = volu(headtext = 体积,name = volu,width = 90,align = right,type = text,headtype = sort ,datatype = number,dataformat=0.00);
						gcid = newe(headtext = 重量,name = newe,width = 90,align = right,type = text,headtype = sort ,datatype = number,dataformat=0.00);
						gcid = qty(headtext =  入库数量,name = qty,width = 50,align = right,type = #{moinMB.commitStatus ? 'input' : 'text' },headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
						gcid = whna(headtext = 入库货位,name = whna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
						" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{moinMB.msg}" />
							<h:inputHidden id="roids" value="#{moinMB.roids}" />
							<h:inputHidden id="sellist" value="#{moinMB.sellist}" />
							<h:inputHidden id="filename" value="#{moinMB.fileName}" />
							<h:inputHidden id="updatedata" value="#{moinMB.updatedata}" />

							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="查询商品信息" type="button" action="#{moinMB.selInveBut}"
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