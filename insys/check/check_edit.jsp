<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.CheckMB"%><%@ include file="../../include/include_imp.jsp" %>
<%
	String path = request.getContextPath();
	CheckMB ai = (CheckMB) MBUtil.getManageBean("#{checkMB}");
	ai.getVouch();
	//清空查询
	ai.setSearchSQL("");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>检验单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript" src="check.js"></script>
	</head>
	<body id=mmain_body onload="textClear('list','vc_barcode,qty');">
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_nav>
						<a href="check.jsf" class="return">检验单</a>>>
						<b>编辑检验单</b>
					</div>
					<div id=mmain_opt>
						<a4j:outputPanel id="mainButton">
							<!-- 创建 -->
							<a4j:commandButton id="approveCreate" value="生成任单"
								onmouseover="this.className='a4j_over1'" rendered="#{checkMB.MOD&&checkMB.approveStatus && !checkMB.approveFlag}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" action="#{checkMB.approveCreate}"
								onclick="if(approveCreate()){}else{return false;}"
								reRender="msg"
								oncomplete="endApprove()"/>
							
							<!-- 修改 -->
							<a4j:commandButton id="approveUpdate" value="检验单完成"
								onmouseover="this.className='a4j_over1'" rendered="#{checkMB.MOD&&!checkMB.approveStatus && !checkMB.approveFlag}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" action="#{checkMB.approveVouch}"
								onclick="if(approveVouch()){}else{return false;}"
								reRender="msg,output,mainButton,detailButton"
								oncomplete="Gwallwin.winShowmask('FALSE');alert($('list:msg').value);" />
							<a4j:commandButton id="updateCheckDetailEx" value="保存调整明细"
								onclick="if(updateCheckDetailsEx()){}else{return false;}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" action="#{checkMB.updateCheckDetailsEx}"
								reRender="msg,output" rendered="#{checkMB.SPE && checkMB.approveFlag}"
								oncomplete="endUpdateDetailEx();" requestDelay="50" />
							<a4j:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{checkMB.printReport}"
								rendered="#{checkMB.PRN}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();" requestDelay="1000" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="main">
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td>
										检验单:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext"
											size="20" value="#{checkMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
									<td>
										单号:
									</td>
									<td>
										<h:inputText id="soco"
											value="#{checkMB.mbean.soco}" styleClass="datetime"
											size="20"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;"  />
									</td>									
									<td>
										制单人:
									</td>
									<td>
										<h:inputText id="crna" styleClass="inputtext"
											size="20" value="#{checkMB.mbean.crna}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
									<td>
										制单日期:
									</td>
									<td>
										<h:inputText id="crdt" styleClass="inputtext"
											size="22" value="#{checkMB.mbean.crdt}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
								</tr>
								<tr>
									<td>
										检验员:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext"
											size="20" value="#{checkMB.mbean.opna}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="detailButton">
						<a4j:outputPanel rendered="#{!checkMB.approveStatus && !checkMB.approveFlag}">
							<div id=mmain_opt>		
								 <a4j:commandButton id="addDetail" value="增加明细"
									onclick="selectCheckBarCodeList();"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button"
									reRender="msg,output" requestDelay="50" />
								 <a4j:commandButton id="updateDetail" value="保存明细"
									onclick="if(updateDetail()){}else{return false;}"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{checkMB.updateDetail}"
									reRender="msg,output" oncomplete="endUpdateDetail();" requestDelay="50" />
								<a4j:commandButton id="deleteCheckDetail" value="删除明细"
									onclick="if(!doDeleteDetail(gtable)){return false};"
									action="#{checkMB.deleteCheckDetail}" reRender="msg,output"
									oncomplete="endAddDetail();" onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1">
								</a4j:commandButton>
							</div>
							
						</a4j:outputPanel>
						
						<a4j:outputPanel rendered="#{checkMB.approveStatus && !checkMB.approveFlag}">
							<div id=mmain_opt_create>
								
								<a4j:commandButton id="updateCheckDetail" value="保存明细"
									onclick="if(updateCheckDetails()){}else{return false;}"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{checkMB.updateCheckDetail}"
									reRender="msg,output" oncomplete="endUpdateDetail();" requestDelay="50" />
								
							</div>
						</a4j:outputPanel>						
					</a4j:outputPanel>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
							gselectsql="
							SELECT a.did,a.roid,a.biid,a.inco,c.inna,c.colo,c.inse,b.qty,b.aqty,b.bqty,b.cqty
							,(select sum(f.qty) as dqty from psma e join psde f on e.biid = f.biid where e.soco = d.soco and f.inco = a.inco group by f.inco) as inqty,
							isnull(a.uqty,'0') as uqty
							from ckde a 
							JOIN dbo.F_GetCheckInfo('#{checkMB.mbean.biid}') b  on a.biid =b.biid  and a.inco=b.inco
							JOIN inve c on a.inco = c.inco
							JOIN ckma d on a.biid = d.biid
							where a.biid = '#{checkMB.mbean.biid}' #{checkMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="gcid = roid(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 40,headtype = text,align = center,type = text,datatype=string);
							gcid = roid(headtext = roid,name = roid,width = 70,headtype = sort,align = right,type = hidden,datatype=number);
							gcid = did(headtext = did,name = did,width = 70,headtype = sort,align = right,type = hidden,datatype=number);
							gcid = inco(headtext = 商品编码,name = inco,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = inna(headtext = 商品名称,name = inna,width = 120,align = left,type = text,headtype = sort,datatype = string);
							gcid = colo(headtext = 规格,name =colo,width = 120,align = left,type = text,headtype = sort,datatype = string);
							gcid = inse(headtext = 规格码,name = inse,width = 75,headtype = sort,align = left,type = text,datatype = string);
							gcid = inqty(headtext = 已入库数量,name = inqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat=0,summary=this,gscript={onkeypress=return isInteger(event),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
							gcid = qty(headtext = 待检数量,name = qty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat=0,summary=this,gscript={onkeypress=return isInteger(event),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
							gcid = aqty(headtext = 合格数量,name = aqty,width = 70,headtype = sort,align = right,type = #{!checkMB.approveStatus && !checkMB.approveFlag?'input':'text'},datatype=number,dataformat=0,#{!checkMB.approveStatus?'summary=this,':''} gscript={onkeypress=return isInteger(event),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
							gcid = bqty(headtext = 不合格数量,name = bqty,width = 70,headtype = sort,align = right,type = #{!checkMB.approveStatus && !checkMB.approveFlag?'input':'text'},datatype=number,dataformat=0,#{!checkMB.approveStatus?'summary=this,':''} gscript={onkeypress=return isInteger(event),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
							gcid = cqty(headtext = 残次品数量,name = cqty,width = 70,headtype = sort,align = right,type = #{!checkMB.approveStatus && !checkMB.approveFlag?'input':'text'},datatype=number,dataformat=0,#{!checkMB.approveStatus?'summary=this,':''} gscript={onkeypress=return isInteger(event),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
							gcid = uqty(headtext = 调整合格数量,name = uqty,width = 80,headtype = sort,align = right,type = #{checkMB.SPE && checkMB.approveFlag ? 'input' : 'hidden' },datatype=number,dataformat=0,gscript={onkeypress=return isInteger(event),keyhandle(this)&&onkeydown=keyhandleupdown(this)});
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderCheck">
						<h:inputHidden id="msg" value="#{checkMB.msg}" />
						<h:inputHidden id="item" value="#{checkMB.item}" />
						<h:inputHidden id="incos" value="#{checkMB.incos}" />
						<h:inputHidden id="qtys" value="#{checkMB.qtys}" />
						<h:inputHidden id="filename" value="#{checkMB.fileName}" />
						<h:inputHidden id="rename" value="" />
						<a4j:commandButton id="refBut" value="刷新列表" style="display:none;" reRender="output" />
					</a4j:outputPanel>
				</h:form>
			</f:view>
		</div>

	</body>
</html>