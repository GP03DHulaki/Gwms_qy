<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.ShiftLibraryMB"%>
<%@ include file="../../include/include_imp.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑移库单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑移库单">
		<meta http-equiv="description" content="编辑移库单">
		<script type="text/javascript" src="move.js"></script>
	</head>
	<%
		String id = "";
		ShiftLibraryMB ai = (ShiftLibraryMB) MBUtil
				.getManageBean("#{shiftLibraryMB}");
		if (request.getParameter("pid") != null) {
			id = request.getParameter("pid");
			ai.getMbean().setBiid(id);
		}
		ai.getVouch();
	%>
	<body id="mmain_body" onload="initEdit();">
		<div id="mmain_nav">
			<font color="#000000">库内处理&gt;&gt;<a id="linkid" title="返回"
				class="return" href="move.jsf">移库</a>&gt;&gt;</font><b>编辑移库单</b>
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
								onclick="addNew();" rendered="#{shiftLibraryMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{shiftLibraryMB.updateHead}" onclick="updateHead()"
								oncomplete="endUpdateHead();" reRender="output,renderArea,head"
								requestDelay="50"
								rendered="#{shiftLibraryMB.MOD && shiftLibraryMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{shiftLibraryMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50"
								rendered="#{shiftLibraryMB.DEL && shiftLibraryMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" id="submitMBut"
								onclick="app();"
								rendered="#{shiftLibraryMB.APP && shiftLibraryMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{shiftLibraryMB.approveVouch}"
								reRender="showHeadButton,renderArea,output,showHead,head,tableid,input,detailbutton"
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
								oncomplete="endHuitui();" requestDelay="50" rendered="false"></a4j:commandButton>
							<h:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" rendered="false"
								styleClass="a4j_but1" onclick="doPrintRep();" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="移库单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{shiftLibraryMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="移库仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whna" styleClass="datetime"
											value="#{shiftLibraryMB.mbean.whna}" disabled="true" />
										<h:inputHidden id="whid" value="#{shiftLibraryMB.mbean.whid}" />
										<!-- 
										<a4j:outputPanel rendered="#{shiftLibraryMB.commitStatus}">
											<img id="invcode_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectWaho();" />
										</a4j:outputPanel> -->
									</td>
									<td>
										<h:outputText value="组织架构:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="orna" styleClass="datetime"
											value="#{shiftLibraryMB.mbean.orna}" disabled="true" />
										<h:inputHidden id="orid" value="#{shiftLibraryMB.mbean.orid}" />
										<a4j:outputPanel rendered="#{false && shiftLibraryMB.commitStatus}">
											<img id="orid_img" style="cursor: pointer;"
												src="../../images/find.gif" onclick="selectOrga();" />
										</a4j:outputPanel>
									</td>
									<!-- 
									<td>
										<h:outputText value="业务类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="buty"
											value="#{shiftLibraryMB.mbean.buty}"
											disabled="#{!shiftLibraryMB.commitStatus}">
											<f:selectItems value="#{shiftLibraryMB.butys}" />
										</h:selectOneMenu>
									</td>
									 -->
								</tr>
								<tr>
									<td>
										<h:outputText value="移库人:"></h:outputText>
									</td>
									<td>
										<h:inputText id="stna" styleClass="datetime" disabled="true"
											value="#{shiftLibraryMB.mbean.crna}" />
									</td>
									<td>
										<h:outputText value="移库时间:"></h:outputText>
									</td>
									<td>
										<h:inputText id="stdt" styleClass="datetime" disabled="true"
											value="#{shiftLibraryMB.mbean.crdt}" />
									</td>
									<td>
										<h:outputText value="单据标志:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="flag"
											value="#{shiftLibraryMB.mbean.flag}" disabled="true">
											<f:selectItems value="#{shiftLibraryMB.flags}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!shiftLibraryMB.commitStatus}"
											value="#{shiftLibraryMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div id="mmain_opt">
						<a4j:outputPanel id="detailbutton">
							<a4j:outputPanel rendered="#{ shiftLibraryMB.commitStatus}">
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{shiftLibraryMB.addDetail}"
									reRender="renderArea,output,tableid"
									rendered="#{shiftLibraryMB.ADD && shiftLibraryMB.commitStatus}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{shiftLibraryMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,tableid"
									rendered="#{shiftLibraryMB.DEL && shiftLibraryMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'" style="display:none"
									rendered="#{shiftLibraryMB.MOD && shiftLibraryMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{shiftLibraryMB.updateDetail}"
									reRender="renderArea,output" oncomplete="endUpdateDetail();"
									requestDelay="50" />
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="input">
						<a4j:outputPanel
							rendered="#{shiftLibraryMB.MOD && shiftLibraryMB.commitStatus}">
							<div id=mmain_cnd>
								<table>
								<tr><td colspan='6'>
							
								<table><tr>
					<td>
						<h:outputText value="锁定数量:" title="设置为【是】扫描信息完成后回车自动添加明细"></h:outputText>
					</td>
					<td>
						<h:selectOneMenu id="autoItem" onchange="autoFill()">
							<f:selectItem itemValue="0" itemLabel="否" />
							<f:selectItem itemValue="1" itemLabel="是" />
						</h:selectOneMenu>
					</td>
									<td>
									<h:outputText value="条码类型:"></h:outputText>
									</td><td colspan="2">
										<h:selectOneRadio id="radio" style="width:220px;"
										value="#{shiftLibraryMB.dbean.stat}" layout="lineDirection">
											<f:selectItem itemLabel="商品编码" itemValue="04" />
											<f:selectItem itemLabel="箱码" itemValue="02" />
										</h:selectOneRadio>
									</td>
									</tr></table>
								</td></tr>
								<tr>
								<td>
									<h:outputText value="移出货位:"></h:outputText>
								</td>
								<td>
									<h:inputText id="fhid" styleClass="datetime"
										value="#{shiftLibraryMB.dbean.fhid}" disabled="false" />
									<img id="whid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectWahod();" />
								</td>
								<td><h:outputText value="条码:"></h:outputText>
									<h:inputText id="inco" value="#{shiftLibraryMB.dbean.inco}"
										styleClass="datetime" size="42"/>
									<img id="invcode_img" style="cursor: pointer"
									src="../../images/find.gif" onclick="if(!selectCode()){return false}" />
								</td>
								<td>
									<h:outputText value="数量:"></h:outputText>
								</td>
								<td>
									<h:inputText id="qty" styleClass="datetime"
										value="#{shiftLibraryMB.dbean.qty}" size="8"/>
								</td>
								<td>
									<h:outputText value="移入货位:"></h:outputText>
								</td>
								<td>
									<h:inputText id="owid" styleClass="datetime"
										value="#{shiftLibraryMB.dbean.owid}" disabled="false" />
									<img id="whid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectWahod2();" />
								</td>
									</tr>
								</table>
							</div>
						</a4j:outputPanel>
					</a4j:outputPanel>
					<div>
						<a4j:outputPanel id="tableid">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="SELECT distinct a.did,a.roid, a.biid,a.inco,a.baco,a.fwid,a.owid,a.qty,b.inna,b.inty,b.inpr,b.colo,b.inse,b.volu,b.newe
											FROM msde a 
											LEFT JOIN inve b ON b.inco = a.inco
											Where a.biid = '#{shiftLibraryMB.mbean.biid}' "
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {msde},tablepk = {did})"
								gcolumn="gcid = roid(headtext = selall,name = roid,width = 30,align = center,type = checkbox,headtype = #{shiftLibraryMB.commitStatus ? 'checkbox' : 'hidden'});
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 商品名称,name = inna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 规格,name = colo,width = 90,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 规格码,name = inse,width = 90,align = left,type = text,headtype = sort ,datatype = string);
									gcid = fwid(headtext = 出库货位,name = fwid,width = 100,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext = 数量,name = qty,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
									gcid = owid(headtext = 入库货位,name = owid,width = 100,align = left,type = text,headtype = sort ,datatype = string);
									gcid = baco(headtext = 商品条码,name = baco,width = 200,align = left,type = text,headtype = sort ,datatype = string);
								" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{shiftLibraryMB.msg}" />
							<h:inputHidden id="roids" value="#{shiftLibraryMB.roids}" />
							<h:inputHidden id="sellist" value="#{shiftLibraryMB.sellist}" />
							<h:inputHidden id="updatedata"
								value="#{shiftLibraryMB.updatedata}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="查询商品信息" type="button"
								action="#{shiftLibraryMB.selInveBut}" id="selInveBut"
								onclick="if(!selInveBut()){return false};"
								reRender="detailButton" oncomplete="endSelInveBut();"
								requestDelay="50" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>