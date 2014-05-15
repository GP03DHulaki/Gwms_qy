<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.StockAdjustMB"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑移库单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑移库单">
		<meta http-equiv="description" content="编辑移库单">
		<script type="text/javascript" src="stockresult.js"></script>
	</head>
	<%
		String id = "";
		StockAdjustMB ai = (StockAdjustMB) MBUtil
				.getManageBean("#{stockadjustMB}");
		if (request.getParameter("pid") != null) {
			id = request.getParameter("pid");
			ai.getMbean().setBiid(id);
		}
		ai.getVouch();
	%>
	<body id="mmain_body">
		<div id="mmain_nav">
			<div id="mmain_nav">
				<FONT color="#000000">库内处理</FONT>&gt;&gt;
				<FONT color="#000000"><a id="linkid" href="stockresult.jsf"
					class="return" title="返回">盘点</a>
				</FONT>&gt;&gt;
				<B>盘盈盘亏信息记录</B>
				<br>
			</div>
			<f:view>
				<h:form id="edit">
					<div id="mmain">
						<div id="mmain_opt">
							<a4j:outputPanel id="output">
								<a4j:commandButton id="wrBackBut" value="回写单据" type="button"
									rendered="#{stockadjustMB.APP && !stockadjustMB.commitStatus && false}"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'"
									action="#{stockadjustMB.writeBackVouch}" oncomplete="endApp();"
									reRender="output,renderArea"
									disabled="#{!stockadjustMB.canWriteBack}" styleClass="a4j_but1"
									onclick="startDo();" />
								<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
									onclick="reportExcel('gtable')" type="button" />
							</a4j:outputPanel>
						</div>
						<div id="mmain_cnd">
							<a4j:outputPanel id="head">
								<table border="0" cellspacing="0" cellpadding="3">
									<tr>
										<td>
											<h:outputText value="盘盈盘亏单号:"></h:outputText>
										</td>
										<td>
											<h:inputText id="biid" styleClass="datetime"
												value="#{stockadjustMB.mbean.biid}" disabled="true" />
										</td>
										<td>
											<h:outputText value="盘点人:"></h:outputText>
										</td>
										<td>
											<h:inputText id="stna" styleClass="datetime" disabled="true"
												value="#{stockadjustMB.mbean.crna}" />
										</td>
									</tr>

									<tr>
										<td>
											<h:outputText value="备注:"></h:outputText>
										</td>
										<td colspan="5">
											<h:inputText id="rema" styleClass="datetime"
												disabled="#{!stockadjustMB.commitStatus}"
												value="#{stockadjustMB.mbean.rema}" size="80" />
										</td>
									</tr>
								</table>
							</a4j:outputPanel>
						</div>
						<div>
							<a4j:outputPanel id="tableid">
								<g:GTable gid="gtable" gtype="grid" gdebug="false"
									gselectsql="SELECT distinct a.did, a.biid,a.inco,a.qty,a.whid,a.fqty,a.tqty,
											b.inna,b.inty,b.inpr,b.colo,b.inse,b.volu,b.newe
											FROM mtde a 
											LEFT JOIN inve b ON a.inco = b.inco
											Where a.biid = '#{stockadjustMB.mbean.biid}' "
									gpage="(pagesize = 20)" gversion="2" gsort="whid"
									gsortmethod="asc" gupdate="(table = {msde},tablepk = {did})"
									gcolumn="gcid = 0(headtext = 行号,name = rowid,width = 50,headtype = text,align = center,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = inco,width = 110,headtype = sort,align = left,type = text,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 170,headtype = sort,align = left,type = text,datatype=string);
											gcid = inpr(headtext = 属性,name = inpr,width = 90,align = left,type = mask,typevalue=P:成品/S:半成品,headtype = sort ,datatype = string);
											gcid = colo(headtext = 规格,name = colo,width = 122,align = left,type = text,headtype = sort ,datatype = string);
											gcid = inse(headtext = 规格码,name = inse,width = 90,align = left,type = text,headtype = sort ,datatype = string);
											gcid = volu(headtext = 体积,name = volu,width = 80,align = left,type = text,headtype = sort ,datatype = number,dataformat=0.00);
											gcid = whid(headtext = 库位,name = whid,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = qty(headtext = 帐面数量,name = qty,width = 75,headtype = sort,align = right,type = text,datatype=number,dataformat={###,###,##0},summary=this);
											gcid = fqty(headtext = 实盘数量,name = qty,width = 75,headtype = sort,align = right,type = text,datatype=number,dataformat={###,###,##0},summary=this);
											gcid = tqty(headtext = 差异数量,name = qty,width = 75,headtype = sort,align = right,type = text,datatype=number,dataformat={###,###,##0},summary=this);
									" />
							</a4j:outputPanel>
						</div>
					</div>
					
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{stockadjustMB.msg}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
	</body>
</html>