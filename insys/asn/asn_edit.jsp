<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="javax.faces.el.ValueBinding"%>
<%@page import="com.gwall.view.AsnMB"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>ASN单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="ASN单">
		<meta http-equiv="description" content="ASN单">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/Gwalltag.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="asn.js"></script>
	</head>
	<%
		String id = "";
		FacesContext context = FacesContext.getCurrentInstance();
		ValueBinding binding = context.getApplication().createValueBinding(
				"#{asnMB}");
		AsnMB ai = (AsnMB) binding.getValue(context);
		if (request.getParameter("pid") != null) {
			id = request.getParameter("pid");
			ai.getMbean().setBiid(id);
		}
		ai.getVouch();
	%>

	<body id="mmain_body" onload="initEdit();">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;<a href="asn.jsf" title="返回"
				class="return">ASN单</a>&gt;&gt;</font><b>编辑ASN单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id="mmain_opt">
						<a4j:outputPanel id="showHeadButton">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" rendered="#{asnMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{asnMB.updateHead}"
								onclick="if(!updateHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{asnMB.MOD && asnMB.commitStatus}"
								oncomplete="endUpdateHead();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{asnMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50" rendered="#{asnMB.DEL && asnMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" onclick="app();"
								rendered="#{asnMB.APP && asnMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{asnMB.approveVouch}" id="submitMBut"
								reRender="showHeadButton,renderArea,output,detailButton,showHead"
								oncomplete="endApp();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" onclick="unApp();"
								rendered="#{asnMB.APP && !asnMB.commitStatus && false}"
								styleClass="a4j_but1" value="反审单据" type="button"
								action="#{asnMB.unApproveVouch}" id="unSubmitMBut"
								reRender="showHeadButton,renderArea,output,detailButton,showHead"
								oncomplete="endUnApp();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" onclick="selAllBar();"
								rendered="#{asnMB.LST && !asnMB.commitStatus}"
								styleClass="a4j_but1" value="查看全部条码" type="button" action=""
								reRender="showHeadButton,renderArea,output,detailButton"
								requestDelay="50" />
							<a4j:commandButton value="关闭单据"
								onmouseover="this.className='a4j_over1'" action=""
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="if(!doClose()){return false};" rendered="false"
								oncomplete="endDoClose();"
								reRender="renderArea,output,showHead,showHeadButton" />
							<a4j:commandButton type="button" value="打印条码"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" action=""
								rendered="false" styleClass="a4j_but1"
								onclick="if(!print(gtable)){return false};"
								oncomplete="lookPrint();" reRender="renderArea"
								requestDelay="1000" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="导出Excel" type="button" action="" id="excelMBut"
								onclick="Gwallwin.winShowmask('TRUE');"
								reRender="outPutFileName,msg" oncomplete="endDo();"
								requestDelay="50" rendered="false" />
						</a4j:outputPanel>
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="showHead">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="单据单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{asnMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="入库仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whna" styleClass="datetime"
											value="#{asnMB.mbean.whna}" disabled="true" />
										<h:inputHidden id="whid" value="#{asnMB.mbean.whid}" />
										<a4j:outputPanel rendered="#{asnMB.commitStatus}">
											<img id="invcode_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectWaho();" />
										</a4j:outputPanel>
									</td>
									<td>
										<h:outputText value="组织架构:"></h:outputText>
									</td>
									<td>
										<h:inputText id="orna" styleClass="datetime"
											value="#{asnMB.mbean.orna}" disabled="true" />
										<h:inputHidden id="orid" value="#{asnMB.mbean.orid}" />
										<a4j:outputPanel rendered="#{asnMB.commitStatus}">
											<img id="invcode_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectOrga();" />
										</a4j:outputPanel>

									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="供应商名称:"></h:outputText>
									</td>
									<td>
										<h:inputText id="suna" styleClass="datetime"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;"
											value="#{asnMB.mbean.suna}" disabled="#{!asnMB.commitStatus}" />
										<h:inputHidden id="suid" value="#{asnMB.mbean.suid}" />
										<a4j:outputPanel rendered="#{asnMB.commitStatus}">
											<img id="invcode_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectSuin();" />
										</a4j:outputPanel>
									</td>

									<td>
										<h:outputText value="预计到货时间:"></h:outputText>
									</td>
									<td>
										<h:inputText id="indt" styleClass="datetime"
											disabled="#{!asnMB.commitStatus}" value="#{asnMB.mbean.indt}"
											onfocus="#{gmanage.datePicker}" />
									</td>
									<td>
										<h:outputText value="单据状态:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="flag" value="#{asnMB.mbean.flag}"
											disabled="true">
											<f:selectItems value="#{asnMB.flags}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!asnMB.commitStatus}" value="#{asnMB.mbean.rema}"
											size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div>
						<a4j:outputPanel id="detailButton">
							<div id="mmain_opt">
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="if(!openAddDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="" reRender="renderArea,output"
									rendered="#{asnMB.MOD && asnMB.commitStatus}" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{asnMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output"
									rendered="#{asnMB.MOD && asnMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{asnMB.MOD && asnMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{asnMB.updateDetail}" reRender="renderArea,output"
									oncomplete="endUpdateDetail();" requestDelay="50" />
								<a4j:commandButton id="createBar" value="生成条码"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!createBar()){return false};" type="button"
									action="#{asnMB.createBar}" reRender="renderArea,output"
									oncomplete="endCreateBar();" requestDelay="50"
									rendered="#{asnMB.MOD && !asnMB.commitStatus}" />
							</div>
						</a4j:outputPanel>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="Select biid,did,roid,srid,poid,frid,inco,baco,colo,ceve,cecu,inse,
											vers,cpri,qty,fqty,inpa,bast,stat,whid,orid,rema 
											From asbd Where biid = '#{asnMB.mbean.biid}' "
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {asbd},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = checkbox);
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = roid(headtext = 行项目号,name = roid,width = 70,align = left,type = hidden,headtype = String);
									gcid = roid(headtext = 行项目号,name = roidlink,width = 70,align = left,type = link,headtype = sort ,typevalue = javascript:selectBar('gcolumn[roid]'));
									gcid = poid(headtext = 采购订单号,name = poid,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = frid(headtext = 采购订单行项目号,name = frid,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inco(headtext = 商品名称,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 规格,name = colo,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 尺寸,name = inse,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext = 采购数量,name = qty,width = 80,align = right,type = #{asnMB.commitStatus ? 'input' : 'text' },headtype= sort, datatype =number,dataformat=0,update=edit,summary=this);
									gcid = inpa(headtext = 内包装数量,name = inpa,width = 80,align = right,type = #{asnMB.commitStatus ? 'input' : 'text' },headtype= sort, datatype =number,dataformat=0,update=edit);
									gcid = stat(headtext = 状态,name = stat,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{asnMB.msg}" />
							<h:inputHidden id="roids" value="#{asnMB.roids}" />
							<h:inputHidden id="sellist" value="#{asnMB.sellist}" />
							<h:inputHidden id="updatedata" value="#{asnMB.updatedata}" />

							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="查询商品信息" type="button" action="#{asnMB.selInveBut}"
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