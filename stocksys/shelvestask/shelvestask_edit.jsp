<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@ page import="com.gwall.view.stock.ShelvesTaskMB"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>上架任务</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="上架任务">
		<meta http-equiv="description" content="上架任务">
		<script type="text/javascript" src="shelvestask.js"></script>
	</head>
	<%
		String id = "";
		ShelvesTaskMB ai = (ShelvesTaskMB) MBUtil
				.getManageBean("#{shelvestaskMB}");
		if (request.getParameter("pid") != null) {
			id = request.getParameter("pid");
			ai.getMbean().setBiid(id);
		}
		ai.getVouch();
	%>

	<body id="mmain_body" onload="initEdit();">
		<div id="mmain_nav">
			<font color="#000000">库内处理&gt;&gt;<a href="shelvestask.jsf"
				class="return" title="返回">上架任务</a>&gt;&gt;</font><b>编辑上架任务</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id=mmain_opt>
						<a4j:outputPanel id="showHeadButton">
							<%-- 
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" rendered="#{pubmMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{pubmMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea"
								oncomplete="endDeleteHead();" requestDelay="50"
								rendered="#{pubmMB.DEL && pubmMB.commitStatus}" />--%>
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								onclick="if(!app()){return false};"
								rendered="#{shelvestaskMB.APP && shelvestaskMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								requestDelay="50" oncomplete="endApp();"
								action="#{shelvestaskMB.approveVouch}" id="submitMBut"
								reRender="showHeadButton,renderArea,output,detailButton,showHead" />
							<a4j:commandButton value="拣货路径"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="showPath();"
								rendered="#{shelvestaskMB.LST && !shelvestaskMB.commitStatus}" />
							<a4j:commandButton value="修改执行人"
								action="#{shelvestaskMB.modifysius}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="modifysius();" rendered="#{pickTaskMB.ADD}" />
							<a4j:commandButton value="关闭单据"
								onmouseover="this.className='a4j_over1'"
								action="#{shelvestaskMB.updateHead}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="if(!doClose()){return false};" rendered="#{pickTaskMB.SPE}"
								oncomplete="endDoClose();"
								reRender="renderArea,output,showHead,showHeadButton" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="showHead">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="单据单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{shelvestaskMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="上架仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whna" styleClass="datetime"
											value="#{shelvestaskMB.mbean.whna}" disabled="true" />
									</td>
									<td>
										<h:outputText value="单据标志:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="flag" value="#{shelvestaskMB.mbean.flag}"
											disabled="true">
											<f:selectItems value="#{shelvestaskMB.flags}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="任务执行人:"></h:outputText>
									</td>
									<td>
										<h:inputText id="sina" styleClass="datetime"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;"
											value="#{shelvestaskMB.mbean.sina}" />
										<h:inputHidden id="sius" value="#{shelvestaskMB.mbean.sius}" />
										<%-- 
										<a4j:outputPanel rendered="#{shelvestaskMB.commitStatus}">
											<img id="orid_img" style="cursor: hand"
												src="../../images/find.gif" onclick="selectUser();" />
										</a4j:outputPanel>
										--%>
									</td>

								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!shelvestaskMB.commitStatus}"
											value="#{shelvestaskMB.mbean.rema}" size="90" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div>
						<a4j:outputPanel id="detailButton">
							<div id="mmain_opt">
							<!--  	<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{shelvestaskMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,countPage"
									rendered="#{shelvestaskMB.MOD && shelvestaskMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
							-->
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{shelvestaskMB.MOD}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{shelvestaskMB.updateDetail}"
									reRender="renderArea,output,countPage"
									oncomplete="endUpdateDetail();" requestDelay="50" />
							</div>
							<%--
							<a4j:outputPanel rendered="#{shelvestaskMB.MOD && shelvestaskMB.commitStatus}">
								<div id="mmain_cnd">
									<table>
										<tr>
											<td>
												<h:outputText value="物料编码:"></h:outputText>
											</td>
											<td>
												<h:inputText id="inco" value="#{shelvestaskMB.dbean.inco}"
													styleClass="datetime" size="16" onkeypress="clickInve();" />
												<img id="invcode_img" style="cursor: hand"
													src="../../images/find.gif" onclick="selectInveAdd();" />
											</td>
											<td>
												<h:outputText value="数量:"></h:outputText>
											</td>
											<td>
												<h:inputText id="qty" value="#{shelvestaskMB.dbean.qty}"
													styleClass="datetime" size="16" />
											</td>
										</tr>
									</table>
								</div>
							 --%>
						</a4j:outputPanel>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="select a.did,a.inco,d.inna,d.iftl,a.whid,c.lonu,c.hinu,a.qty,d.colo,d.inse 
											from stde a left join waho c on a.whid=c.whid
											left join inve d on a.inco=d.inco where a.biid = '#{shelvestaskMB.mbean.biid}' "
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {stde},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = checkbox);
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 商品名称,name = inna,width = 140,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = whid(headtext = 待上架库位,name = whid,width = 100,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext = 待上架数量,name = qty,width = 80,align = right,type = #{shelvestaskMB.commitStatus ? 'input' : 'text' },headtype= sort, datatype = number,dataformat=0.##,update=edit,summary=this);
									gcid = lonu(headtext = 库位安全库存,name = lonu,width = 80,align = right,type = text,headtype= sort, datatype = number,dataformat=0.##,summary=this);
									" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{shelvestaskMB.msg}" />
							<h:inputHidden id="roids" value="#{shelvestaskMB.roids}" />
							<h:inputHidden id="sellist" value="#{shelvestaskMB.sellist}" />
							<h:inputHidden id="filename" value="#{shelvestaskMB.fileName}" />
							<h:inputHidden id="updatedata"
								value="#{shelvestaskMB.updatedata}" />

							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="查询物料信息" type="button"
								action="#{shelvestaskMB.selInveBut}" id="selInveBut"
								onclick="if(!selInveBut()){return false};"
								reRender="detailButton" oncomplete="endSelInveBut();"
								requestDelay="50" />
							<a4j:commandButton id="showRe" value="刷新全部"
									style="display:none;" reRender="tableid,outdetail,head" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>