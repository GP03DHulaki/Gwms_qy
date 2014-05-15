<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.StockPlanMB"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>

<%
	StockPlanMB ai = (StockPlanMB) MBUtil
			.getManageBean("#{stockPlanMB}");
	if (null != request.getParameter("pid")) {
		ai.getMbean().setBiid(request.getParameter("pid"));
	}
	ai.getVouch();
%>
<html>
	<head>
		<title>编辑盘点计划单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="编辑盘点计划单">
		<link href="../../gwall/all.css" rel="stylesheet" type="text/css" />
		<script src="stockplan.js"></script>
		<script src="../../js/Gwalldate.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
	</head>
	<body id="mmain_body" onload="initload();">
		<div id="mydiv"
			style="width: 190px; height: 30px; bgcolor: #efefef; display: none;">
			<img src="../../images/indicator.gif" width="16" height="16" />
			<b><font color="white">正在处理，请稍等...</font> </b>
		</div>
		<DIV ID="mmain_nav">
			<font color="#000000"><a href="stockplan.jsf" class="return">库内处理</a>&gt;&gt;</font>
			<font color="#000000"><a href="stockplan.jsf" title="返回"
				class="return">盘点</a>&gt;&gt;</font>
			<b>编辑盘点计划单</b>
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
											rendered="#{stockPlanMB.ADD}"
											onmouseout="this.className='a4j_buton1'"
											styleClass="a4j_but1" oncomplete="addNew();" />
										<a4j:commandButton onmouseover="this.className='a4j_over1'"
											onmouseout="this.className='a4j_buton1'"
											styleClass="a4j_but1" id="updateId" value="保存单据"
											type="button" reRender="renderArea"
											action="#{stockPlanMB.updateHead}" onclick="updateHead();"
											oncomplete="endUpdateHead();" requestDelay="50"
											rendered="#{stockPlanMB.MOD && stockPlanMB.commitStatus && stockPlanMB.mbean.flag<'02'}" />
										<a4j:commandButton onmouseover="this.className='a4j_over1'"
											onmouseout="this.className='a4j_buton1'"
											styleClass="a4j_but1" id="delId" value="删除单据" type="button"
											onclick="if(!doDel()){return false;}"
											action="#{stockPlanMB.deleteHead}"
											reRender="mainButton,mes,renderArea" oncomplete="dndDele();"
											requestDelay="50"
											rendered="#{stockPlanMB.DEL && stockPlanMB.commitStatus && stockPlanMB.mbean.flag<'02'}" />
										<a4j:commandButton onmouseover="this.className='a4j_over1'"
											onmouseout="this.className='a4j_buton1'"
											styleClass="a4j_but1" id="approveId" value="审核单据"
											type="button" onclick="if(!app()){return false}"
											action="#{stockPlanMB.approveVouch}"
											reRender="mainButton,mes,renderArea,outTable" oncomplete="endApp();"
											requestDelay="50"
											rendered="#{stockPlanMB.APP && stockPlanMB.commitStatus}" />
										<a4j:commandButton value="查看盘点状态"
											onmouseover="this.className='a4j_over1'"
											onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
											onclick="showPath();" rendered="#{stockPlanMB.ADD}" />
										<a4j:commandButton onmouseover="this.className='a4j_over1'"
											onmouseout="this.className='a4j_buton1'"
											styleClass="a4j_but1" value="导出盘点结果" type="button"
											id="excelMBut" onclick="Gwallwin.winShowmask('TRUE');"
											reRender="outPutFileName,msg,renderArea"
											oncomplete="endDo();" requestDelay="50" rendered="false" />
										<a4j:commandButton onmouseover="this.className='my_over'"
											onmouseout="this.className='my_buton'" styleClass="my_but"
											value="导出需移库商品" type="button" id="excelXBut"
											onclick="Gwallwin.winShowmask('TRUE');"
											reRender="outPutFileName,msg,renderArea"
											oncomplete="endDo();" requestDelay="50" rendered="false" />
										<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
											onclick="reportExcel('gtable')" type="button" />
									</a4j:outputPanel>
								</td>
							</tr>
						</table>
					</div>
					<DIV ID="mmain_cnd">
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td bgcolor="#efefef">
									<h:outputText value="盘点计划单:" style="color:#7f7f7f;" />
								</td>
								<td>
									<a4j:outputPanel id="id">
										<h:inputText id="biid" styleClass="datetime"
											value="#{stockPlanMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</a4j:outputPanel>
								</td>
								<td bgcolor="#efefef">
									<h:outputText value="盘点类型:" style="color:#7f7f7f;" />
								</td>
								<td>
									<h:selectOneMenu id="nv_fromvoucher"
										style="width:80px;readonly:expression(this.readOnly=true);color:#7f7f7f;"
										value="01" disabled="true" onchange="valueChange();"
										styleClass="selectItem">
										<f:selectItem itemLabel="盘点计划" itemValue="01" />
										<f:selectItem itemLabel="粗盘差异" itemValue="02" />
										<f:selectItem itemLabel="拣货跳过" itemValue="03" />
									</h:selectOneMenu>
								</td>

							</tr>
							<tr>
								<td bgcolor="#efefef">
									<h:outputText value="盘点仓库:" />
								</td>
								<td>
									<h:inputText id="whna" styleClass="datetime"
										value="#{stockPlanMB.mbean.whna}" disabled="true" />
									<h:inputHidden id="waho" value="#{stockPlanMB.mbean.whid}" />
								</td>
								<td bgcolor="#efefef">
									<h:outputText value="盘点方式:" style="color:#7f7f7f;" />
								</td>
								<td>
									<h:selectOneMenu id="pmmt" disabled="true"
										style="width:85px;readonly:expression(this.readOnly=true);color:#7f7f7f;"
										value="#{stockPlanMB.mbean.pmmt}" onchange="valueChange();"
										styleClass="selectItem">
										<f:selectItem itemLabel="按库位盘点" itemValue="01" />
										<f:selectItem itemLabel="按商品盘点" itemValue="02" />
									</h:selectOneMenu>
								</td>
								<td bgcolor="#efefef">
									<h:outputText value="库存调整方式:" style="color:#7f7f7f;" />
								</td>
								<td>
									<h:selectOneMenu id="rsmt" value="#{stockPlanMB.mbean.rsmt}"
										styleClass="selectItem" disabled="true"
										style="width:85px;readonly:expression(this.readOnly=true);color:#7f7f7f;">
										<f:selectItem itemLabel="盘点计划调整" itemValue="01" />
										
										</h:selectOneMenu>
								</td>
							</tr>
							<tr id="warehouse">
								<td bgcolor="#efefef" valign="top">
									<h:outputText value="盘点库位:" style="color:#7f7f7f;" />
								</td>
								<td colspan="8">
									<h:inputTextarea id="vc_warehouseid"
										style="readonly:expression(this.readOnly=true);color:#7f7f7f;"
										value="#{stockPlanMB.mbean.item}" cols="105" rows="3" />
								</td>
							</tr>
							<tr id="inventory" style="display: none;">
								<td bgcolor="#efefef" valign="top">
									<h:outputText value="盘点商品:" style="color:#7f7f7f;" />
								</td>
								<td colspan="8">
									<h:inputTextarea id="vc_invcode"
										value="#{stockPlanMB.mbean.item}" cols="105" rows="3"
										style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									<h:inputHidden id="item" value="#{stockPlanMB.mbean.item}"></h:inputHidden>
								</td>
							</tr>
							<tr id="users">
								<td bgcolor="#efefef" valign="top">
									<h:outputText value="操作人:" />
								</td>
								<td colspan="7">
									<h:inputTextarea id="opna" value="#{stockPlanMB.mbean.opna}"
										style="readonly:expression(this.readOnly=true);color:#7f7f7f;"
										cols="105" rows="3" />
									<a4j:outputPanel rendered="stockPlanMB.commitStatus">
										<h:graphicImage id="userImg" style="cursor:pointer"
											rendered="true" url="../../images/find.gif"
											onclick="return selectUser();" />
									</a4j:outputPanel>
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									<h:outputText value="备注:">
									</h:outputText>
								</td>
								<td colspan="8">
									<h:inputText id="rema" styleClass="datetime" disabled="false"
										value="#{stockPlanMB.mbean.rema}" size="85" />
								</td>
							</tr>
						</table>
					</DIV>
					<DIV ID="voucher_detail">
						<a4j:outputPanel id="outTable">
							<g:GTable gid="gtable2" gtype="grid" gversion="2" gdebug="false"
								gselectsql="SELECT  a.biid,a.whid,a.inco,sum(a.qty) as qty,sum(a.fqty) as fqty,a.orid,b.inna,b.inty,b.inpr,b.colo,b.inse,b.volu,b.newe,sum(a.fqty-a.qty) as tqty FROM pmde a
											LEFT JOIN inve b ON  a.inco=b.inco where biid='#{stockPlanMB.mbean.biid}'
											group by a.biid,a.whid,a.inco,a.orid,b.inna,b.inty,b.inpr,b.colo,b.inse,b.volu,b.newe
											"
								gpage="(pagesize = 40)" gsort="whid" gsortmethod="asc"
								gcolumn="gcid = 0(headtext = 行号,name = rowid,width = 50,headtype = text,align = center,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 140,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 规格,name = colo,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 规格码,name = inse,width = 90,align = left,type = text,headtype = sort ,datatype = string);
									gcid = whid(headtext = 库位,name = whid,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = qty(headtext = 帐面数量,name = qty,width = 75,headtype = sort,align = right,type = text,datatype=number,dataformat={###,###,##0},summary=this);
									gcid = fqty(headtext = 实盘数量,name = qty,width = 75,headtype = sort,align = right,type = text,datatype=number,dataformat={###,###,##0},summary=this);
									gcid = tqty(headtext = 差异数量,name = tqty,width = 75,headtype = sort,align = right,type = text,datatype=number,dataformat={###,###,##0},summary=this);
									" />
						</a4j:outputPanel>
					</DIV>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{stockPlanMB.msg}" />
							<h:inputHidden id="roids" value="#{stockPlanMB.roids}" />
							<h:inputHidden id="sellist" value="#{stockPlanMB.sellist}" />
							<h:inputHidden id="updatedata" value="#{stockPlanMB.updatedata}" />
						</a4j:outputPanel>
					</div>
				</DIV>
			</h:form>
		</f:view>
	</body>
</html>

