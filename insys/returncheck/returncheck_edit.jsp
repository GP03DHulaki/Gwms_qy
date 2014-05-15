<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.ReturnCheckMB"%>
<%@ include file="../../include/include_imp.jsp" %>
<%
	ReturnCheckMB ai = (ReturnCheckMB) MBUtil.getManageBean("#{returncheckMB}");
	if(request.getParameter("biid") != null)
	{
		ai.getMbean().setBiid(request.getParameter("biid"));
		ai.setSk_biid(request.getParameter("biid"));
	}else
	{
		ai.setSk_biid(ai.getMbean().getBiid());
	}
	
	ai.getVouch();	
	//清空查询
	ai.search();
%>
<html>
	<head>
		<title>检验单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<script type="text/javascript" src="returncheck.js"></script>
	</head>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_nav>
						<a href="returncheck.jsf" class="return">质检返修单</a>>>
						<b>编辑质检返修单</b>
					</div>
					<div id=mmain_opt>
						<a4j:outputPanel id="mainButton">
							<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							rendered="#{returncheckMB.ADD}" onclick="addNew();" />							
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" action="#{returncheckMB.deleteHead}"
							onclick="if(!doDeleteHead()){return false};"
							rendered="#{returncheckMB.DEL && returncheckMB.approveFlag}" reRender="msg"
							oncomplete="endDoList();" requestDelay="50" />
							<a4j:commandButton id="approveUpdate" value="审核单据"
								onmouseover="this.className='a4j_over1'" rendered="#{returncheckMB.APP && returncheckMB.approveFlag}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" action="#{returncheckMB.approveVouch}"
								onclick="if(approveVouch()){}else{return false;}"
								reRender="msg,output,mainButton,detailButton"
								oncomplete="Gwallwin.winShowmask('FALSE');alert($('list:msg').value);" />		
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="main">
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td>
										返修单号:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext"
											size="20" value="#{returncheckMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>									
									<td>
										制单人:
									</td>
									<td>
										<h:inputText id="crna" styleClass="inputtext"
											size="20" value="#{returncheckMB.mbean.crna}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
									<td>
										制单日期:
									</td>
									<td>
										<h:inputText id="crdt" styleClass="inputtext"
											size="22" value="#{returncheckMB.mbean.crdt}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
								</tr>
								<tr>
									<td>
										备注:
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="inputtext"
											size="100" value="#{returncheckMB.mbean.rema}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>					
					<a4j:outputPanel id="detailButton" rendered="#{returncheckMB.approveFlag}">
						<div id=mmain_opt_create>
							<a4j:commandButton id="addDetail" value="增加明细"
								onclick="addReturnCheckDetails();"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" oncomplete="endAddDetails();"
								reRender="msg,output" requestDelay="50" />
							<a4j:commandButton id="deleteCheckDetails" value="删除明细"
								onclick="if(!doDeleteDetail()){return false};"
								action="#{returncheckMB.deleteDetail}" reRender="msg,output"
								oncomplete="endAddDetail();" onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1">
							</a4j:commandButton>
						</div>			
					</a4j:outputPanel>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
							gselectsql="
							SELECT  a.did,a.inco,c.inna,c.colo,c.inse,a.qty,a.soco
							from rcde a join rcma b on a.biid=b.biid
							join inve c on a.inco=c.inco
							where 1=1
							#{returncheckMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="gcid = did(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 40,headtype = text,align = center,type = text,datatype=string);							
							gcid = did(headtext = did,name = did,width = 70,headtype = sort,align = right,type = hidden,datatype=number);
							gcid = soco(headtext = 质检单号,name = soco,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = inco(headtext = 商品编码,name = inco,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = inna(headtext = 商品名称,name = inna,width = 120,align = left,type = text,headtype = sort,datatype = string);
							gcid = colo(headtext = 规格,name =colo,width = 120,align = left,type = text,headtype = sort,datatype = string);
							gcid = inse(headtext = 规格码,name = inse,width = 75,headtype = sort,align = left,type = text,datatype = string);
							gcid = qty(headtext = 数量,name = qty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat=0,summary=this,gscript={onkeypress=return isInteger(event),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderCheck">
						<h:inputHidden id="msg" value="#{returncheckMB.msg}" />
						<h:inputHidden id="item" value="#{returncheckMB.item}" />
						<a4j:commandButton id="refBut" value="刷新列表" style="display:none;" reRender="output" />
					</a4j:outputPanel>
				</h:form>
			</f:view>
		</div>

	</body>
</html>