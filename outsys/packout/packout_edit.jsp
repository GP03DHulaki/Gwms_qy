<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.util.MBUtil"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@page import="com.gwall.view.PackOutMB"%>
<%
    String srcPath = request.getContextPath();
    PackOutMB ai = (PackOutMB) MBUtil
            .getManageBean("#{packOutMB}");
    if (request.getParameter("pid") != null) {
        ai.getMbean().setBiid(request.getParameter("pid"));
    }
    ai.getVouch();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>拆包明细</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="拆包明细">
		<script type="text/javascript" src="packout.js"></script>
		<link href="<%=srcPath%>/GwallJS/Gtab/GtabPage.css" rel="stylesheet"
			type="text/css"></link>
		<script type="text/javascript"
			src="<%=srcPath%>/GwallJS/Gtab/GtabPage.js"></script>
		<script type='text/javascript' src='<%=srcPath%>/gwall/all.js'></script>
		<link rel="stylesheet" type="text/css"
			href="<%=srcPath%>/gwall/all.css">
	</head>
	<body id="mmain_body">
		<div id="mmain">
			<f:view>
				<h:form id="edit">
					<div id=mmain_nav>
						<a id="linkid" href="packout.jsf" class="return" title="返回">出库处理</a>&gt;&gt;
						<b>编辑出库复核单</b>
						<br>
					</div>
					<div id="mmain_opt">
						<a4j:outputPanel id="mainBut">
							<a4j:commandButton value="添加单据" type="button"
								onmouseover="this.className='a4j_over1'" id="addBut"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								oncomplete="addNew();" rendered="#{packOutMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								onclick="if(!headCheck()){return false};"
								reRender="msg,headPanel,output,outTable,detailButton"
								action="#{packOutMB.updateHead}" oncomplete="endDo();"
								requestDelay="50"
								rendered="#{packOutMB.MOD && packOutMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								type="button" onmouseout="this.className='a4j_buton1'"
								onclick="if(!doDeleteAll2()){return false};" value="删除单据"
								id="delMBut"
								reRender="output,renderArea,main,mainBut,msg,output2"
								oncomplete="endDo2();" action="#{packOutMB.deleteHead}"
								styleClass="a4j_but1"
								rendered="#{packOutMB.DEL && packOutMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								type="button" onmouseout="this.className='a4j_buton1'"
								styleClass="a4j_but1" value="审核单据" oncomplete="endDo();location.reload();"
								action="#{packOutMB.approveVouch}"
								onclick="if(!startApp()){return false;}"
								reRender="orderTable,output,renderArea,main,mainBut,msg,output2,detailButton,detailFrame"
								rendered="#{packOutMB.APP && packOutMB.commitStatus}"
								id="appBut" />
						
						</a4j:outputPanel>
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="main">
							<table cellpadding="1" cellspacing="1" border="0">
								<tr>
									<td>
										拆包单号:
									</td>
									<td oncontextmenu='return(false);' onpaste='return false'>
										<h:inputText id="biid" styleClass="inputtext" size="18"
											value="#{packOutMB.mbean.biid}"
											onfocus="t.canFocus(this);" style="color:#7f7f7f;" />
									</td>
									<td>
										创&nbsp;建&nbsp;&nbsp;人:
									</td>
									<td>
										<h:inputText id="nv_creatorname" styleClass="inputtext"
											size="18" value="#{packOutMB.mbean.crna}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
									<td>
										创建时间:
									</td>
									<td>
										<h:inputText id="crdt" styleClass="inputtext" size="20"
											value="#{packOutMB.mbean.crdt}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
								</tr>
								<tr>
									<td>
										来源类型:
									</td>
									<td>
										<h:selectOneMenu id="soty"
											value="#{packOutMB.mbean.soty}" disabled="true">
											<f:selectItem itemLabel="销售订单" itemValue="OUTORDER" />
										</h:selectOneMenu>

									</td>
									<td>
										来源单号:
									</td>
									<td>
										<h:inputText id="soco" styleClass="inputtext" size="20"
											value="#{packOutMB.mbean.soco}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
								</tr>
								<tr>
									<td valign="top">
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="9">
										<h:inputText size="100" id="rema" styleClass="inputtext"
											value="#{packOutMB.mbean.rema}" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
							<a4j:outputPanel id="detailButton">
							<div id="mmain_opt">
								<a4j:commandButton id="addDButs" value="添加明细"
									onclick="showAddDetail();window.reload;"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" reRender="renderArea,output,orderTable"
									rendered="#{packOutMB.MOD && packOutMB.commitStatus}"
									requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明细"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{packOutMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,orderTable"
									rendered="#{packOutMB.DEL && packOutMB.commitStatus}"
									oncomplete="endDeleleDetail();" requestDelay="50" />
						
							</div>
						</a4j:outputPanel>
					</div>
						<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="outdetail">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gsort="weig" gsortmethod="ASC"
										gselectsql="
											Select a.did,a.inco,b.inna,a.qty,a.weig,a.lpco,a.loco,c.lpna
											From pode a left join inve b On a.inco = b.inco 
											LEFT JOIN lpin c ON a.lpco=c.lpco
											Where a.biid = '#{packOutMB.mbean.biid}'
											"
										gpage="(pagesize = 15)"
										gupdate="(table = {pode},tablepk = {did})"
										gcolumn="gcid = did(headtext = selall,name = id_id,width = 20,headtype = hidden,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
											gcid = inco(headtext = 商品编码,name = inco,width = 100,align = left,type = text,headtype = sort ,datatype = string);
											gcid = inna(headtext = 商品名称,name = inna,width = 150,align = left,type = text,headtype = sort ,datatype = string);
											gcid = lpco(headtext = 快递公司,name = lpco,width = 70,align = left,type = text,headtype = sort ,datatype = string);
											gcid = loco(headtext = 快递单号,name = loco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
											gcid = qty(headtext =  数量,name = qty,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##);
											gcid = weig(headtext =  重量,name = weig,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##);
										" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="item" value="#{packOutMB.sellist}" />
							<h:inputHidden id="msg" value="#{packOutMB.msg}" />
							<a4j:commandButton id="refBut" value="刷新列表"
									style="display:none;" reRender="tableid,outdetail,head" />
							<a4j:commandButton id="showRe" value="刷新全部"
									style="display:none;" reRender="tableid,outdetail,head" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>