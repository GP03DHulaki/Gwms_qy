<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.PickScheMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
	PickScheMB ai = (PickScheMB) MBUtil
			.getManageBean("#{pickscheMB}");
	ai.getVouch();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑备货调度</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="编辑订单明细">
		<script type="text/javascript" src="picksche.js"></script>
	</head>
	<body id=mmain_body onload="initEdit();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_nav>
						<a id="linkid" href="picksche.jsf" class="return" title="返回">出库处理</a>
						&gt;&gt;备货处理&gt;&gt;
						<b>编辑备货调度</b>
						<br>
					</div>
					<div style="display: none;">
						<h:inputHidden id="msg" value="#{pickscheMB.msg}" />
						<h:inputHidden id="sellist" value="#{pickscheMB.sellist}" />
						<a4j:commandButton id="refBut" value="刷新列表" style="display:none;" reRender="outdetail,headmain" />
					</div>
					<a4j:outputPanel id="headButton">
						<div id=mmain_opt>
							<gw:GAjaxButton theme="b_theme" id="delMBut" value="删除单据"
								type="button" action="#{pickscheMB.deleteHead}"
								onclick="deleteHead()" oncomplete="endDeleteHead();"
								requestDelay="50"
								reRender="msg,headButton,headmain,detailButton"
								rendered="#{pickscheMB.DEL && pickscheMB.commitStatus}" />

							<gw:GAjaxButton theme="b_theme" id="updateId" value="保存单据"
								type="button" onclick="if(!addHead()){return false};"
								action="#{pickscheMB.updateHead}"
								reRender="msg,headButton,detailButton,headmain,outdetail,orderTable"
								oncomplete="endDo();" requestDelay="50"
								rendered="#{pickscheMB.MOD && pickscheMB.commitStatus}" />

							<gw:GAjaxButton theme="b_theme"
								rendered="#{pickscheMB.APP && pickscheMB.commitStatus}"
								id="appMBut" value="审核单据" type="button"
								action="#{pickscheMB.approveVouch}"
								onclick="if(!checkApp()){return false};"
								reRender="msg,headButton,detailButton,headmain,outdetail,orderTable"
								oncomplete="endApp();" requestDelay="50" />
						</div>
					</a4j:outputPanel>
					<div id=mmain_cnd>
						<a4j:outputPanel id="headmain">
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td>
										备货调度单:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext" size="20"
											value="#{pickscheMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
									</td>
									<td>
										来源类型:
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{pickscheMB.mbean.soty}"
											disabled="true" style="width:130px;">
											<f:selectItem itemLabel="出库订单" itemValue="OUTORDER" />
										</h:selectOneMenu>
									</td>
									<td>
										经手人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											disabled="#{!pickscheMB.commitStatus}"
											value="#{pickscheMB.mbean.opna}" />
									</td>
								</tr>
								<tr>
									<td>
										总体积:
									</td>
									<td>
										<h:inputText id="tavo" styleClass="inputtext" size="20"
											disabled="true" value="#{pickscheMB.mbean.tavo}" />
									</td>
									<td>
										总重量:
									</td>
									<td>
										<h:inputText id="tawe" styleClass="inputtext" size="20"
											disabled="true" value="#{pickscheMB.mbean.tawe}" />
									</td>
									<td>
										总数量:
									</td>
									<td>
										<h:inputText id="tanu" styleClass="inputtext" size="20"
											disabled="true" value="#{pickscheMB.mbean.tanu}" />
									</td>
								</tr>
								<tr>
									<td>
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="inputtext" size="95"
											disabled="#{!pickscheMB.commitStatus}"
											value="#{pickscheMB.mbean.rema}" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>

					<a4j:outputPanel id="orderTable">
						<div style="vertical-align: top;"></div>
						<SPAN ID="detail_ctrl" class="ctrl_show"
							onclick="JS_ExtraFunction();"></SPAN>
						<font color="#4990dd" style="font-weight: bolder; cursor: pointer;"
							onclick="JS_ExtraFunction();">订单列表:</font>
						<div id="ExtraFunction" >
							<div id=mmain_cnd>
								<iframe frameborder="0" src="outordesrs.jsf" width="100%"
									height="300px" id="orders">
								</iframe>
							</div>
						</div>
					</a4j:outputPanel>

					<div>
						<b></b>
					</div>
					<div id=mmain_cnd>
						备货调度明细:
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<a4j:outputPanel id="outdetail">
										<g:GTable gid="gtable" gtype="grid" gversion="2"
											gdebug="false"
											gselectsql="
											Select a.did,a.inco,a.qty,b.inna,b.inty,c.tyna,b.inse,
											ISNULL(b.volu,0)*qty AS volu,ISNULL(b.newe,0)*qty AS newe,b.inpr,b.colo
											From ltdb a left join inve b On a.inco = b.inco  
											left join prty c on b.inty = c.inty 
											Where a.biid = '#{pickscheMB.mbean.biid}'
											"
											gpage="(pagesize = -1)"
											gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
											gcid = inco(headtext = 商品编码,name = inco,width = 140,align = left,type = text,headtype = sort ,datatype = string);
											gcid = inna(headtext = 商品名称,name = inna,width = 215,align = left,type = text,headtype = sort ,datatype = string);
											gcid = tyna(headtext = 商品类别,name = tyna,width = 90,align = left,type = text,headtype = sort ,datatype = string);
											gcid = qty(headtext =  数量,name = qty,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
											gcid = volu(headtext = 体积,name = volu,width = 90,align = right,type = text,headtype = sort ,datatype = number,dataformat=0.######,summary=this);
											gcid = newe(headtext = 重量,name = newe,width = 90,align = right,type = text,headtype = sort ,datatype = number,dataformat=0.######,summary=this);
											gcid = colo(headtext = 规格,name = colo,width = 90,align = left,type = text,headtype = sort ,datatype = string);
											gcid = inse(headtext = 规格码,name = inse,width = 90,align = left,type = text,headtype = sort ,datatype = string);
										" />
									</a4j:outputPanel>
								</td>
							</tr>
						</table>
				</h:form>
			</f:view>
		</div>
	</body>
</html>