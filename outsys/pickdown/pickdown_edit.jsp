<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.PickDownMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>拣货下架</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="拣货下架">
		<script type="text/javascript" src="pickdown.js"></script>
	</head>
	<%
	    String id = "";
	    PickDownMB ai = (PickDownMB) MBUtil.getManageBean("#{pickDownMB}");
	    if (request.getParameter("pid") != null) {
	        id = request.getParameter("pid");
	        ai.getMbean().setBiid(id);
	    }
	    ai.getVouch();
	%>
	<body id=mmain_body onload="initEdit();initDetail();">
		<f:view>
			<div id="mmain_nav">
				<font color="#000000">出库处理&gt;&gt;<a href="pickdown.jsf">备货处理</a>&gt;&gt;</font><b>编辑拣货下架</b>
				<br>
			</div>
			<div id="mmain">
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="output">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" rendered="#{pickDownMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{pickDownMB.updateHead}"
								onclick="if(!updateHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{pickDownMB.MOD && pickDownMB.commitStatus}"
								oncomplete="endUpdateHead();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{pickDownMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50"
								rendered="#{pickDownMB.DEL && pickDownMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" onclick="app();"
								rendered="#{pickDownMB.APP && pickDownMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{pickDownMB.approveVouch}" id="submitMBut"
								reRender="showHeadButton,renderArea,input,output,detailbutton,showHead,tableid,head"
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
							<h:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" rendered="false"
								styleClass="a4j_but1" onclick="doPrintRep();" />
							<a4j:commandButton type="button" value="打印唯品箱码"
								onmouseover="this.className='a4j_over1'"
								action="#{pickDownMB.printBox}" onclick="startDo();"
								onmouseout="this.className='a4j_buton1'" reRender="msg,filename"
								rendered="#{!pickDownMB.commitStatus}" styleClass="a4j_but1"
								oncomplete="Gwallwin.winShowmask('FALSE');" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
							<!-- <gw:GAjaxButton id="otpDBut1" value="导出EXCEL" theme="b_theme"
								onclick="showOutput('gtable')" type="button" reRender="output" /> -->
						</a4j:outputPanel>
					</div>

					<div id=mmain_cnd>
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="拣货下架单:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{pickDownMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										来源类型:
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{pickDownMB.mbean.soty}"
											style="width:130px;" disabled="true">
											<f:selectItem itemLabel="备货任务" itemValue="PICKTASK" />
											<f:selectItem itemLabel="补货任务" itemValue="shelftask" />
										</h:selectOneMenu>
									</td>
									<td>
										来源单号:
									</td>
									<td>
										<h:inputText id="soco" size="20" styleClass="inputtext"
											value="#{pickDownMB.mbean.soco}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
										<!--<img id="suid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectFrom();" />
								-->
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="拣货人员:"></h:outputText>
									</td>
									<td>
										<h:inputText id="crna" styleClass="datetime"
											value="#{pickDownMB.mbean.crna}" disabled="true" />
									</td>
									<td>
										<h:outputText value="拣货仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whna" styleClass="datetime"
											value="#{pickDownMB.mbean.whna}" disabled="true" />
									</td>
									<td>
										<h:outputText value="单据标志:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="sk_flag" value="#{pickDownMB.mbean.flag}"
											disabled="true">
											<f:selectItems value="#{pickDownMB.flags}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr id="car">
									<td>
										<h:outputText value="上架车:"></h:outputText>
									</td>
									<td>
										<h:inputText id="wana" styleClass="datetime"
											value="#{pickDownMB.mbean.wana}" disabled="true" />
										<h:inputHidden id="waid" value="#{pickDownMB.mbean.waid}" />
										<img id="whid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectWaid();" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="3">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!pickDownMB.commitStatus}"
											value="#{pickDownMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="vertical-align: top;"></div>
					<SPAN ID="detail_ctrl" class="ctrl_show"
						onclick="JS_ExtraFunction();"></SPAN>
					<font color="#4990dd" style="font-weight: bolder; cursor: pointer"
						onclick="JS_ExtraFunction();">拣货下架任务明细:</font>
					<div id="ExtraFunction" style="display: none;">
						<a4j:outputPanel id="countPage">
							<iframe frameborder="0" src="showAllInventory.jsf" width="100%">
							</iframe>
						</a4j:outputPanel>
					</div>

					<div id=mmain_opt>
						<a4j:outputPanel id="detailbutton">
							<a4j:outputPanel
								rendered="#{pickDownMB.MOD && pickDownMB.commitStatus}">
								<a4j:commandButton id="addDBut" value="添加明细"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{pickDownMB.addDetail}"
									reRender="renderArea,outputtable,tableid,countPage"
									rendered="#{pickDownMB.ADD && pickDownMB.commitStatus}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明细"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{pickDownMB.deleteDetail}"
									onclick="if(!delDetail(gtable2)){return false};"
									reRender="renderArea,outputtable,tableid,countPage"
									rendered="#{pickDownMB.DEL && pickDownMB.commitStatus && false}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{pickDownMB.MOD && pickDownMB.commitStatus && false}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{pickDownMB.updateDetail}"
									reRender="renderArea,output" oncomplete="endUpdateDetail();"
									requestDelay="50" />
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="input">
						<a4j:outputPanel
							rendered="#{pickDownMB.MOD && pickDownMB.commitStatus}">
							<div id=mmain_cnd>
								<div style="display: none;">
									<a4j:commandButton id="setCode4DBean" requestDelay="50"
										action="#{pickDownMB.setCode4DBean}" onclick="startDo();"
										oncomplete="endCode4DBean();"
										reRender="codePanel,renderArea,msg,input" />
								</div>
								<table border="0" cellpadding="1" cellspacing="0">
									<tbody>
										<tr>
											<td>
												<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
											</td>
											<td>
												<h:selectOneMenu id="autoItem"
													value="#{pickDownMB.autoItem}"
													onchange="t.setIsAutoAdd(this.value);">
													<f:selectItem itemValue="0" itemLabel="否" />
													<f:selectItem itemValue="1" itemLabel="是" />
												</h:selectOneMenu>
											</td>
											<td>
												<h:outputText value="条码类型:" title="F9键切换条码类型" />
											</td>
											<td>
												<h:selectOneRadio id="batp" style="width:220px;"
													value="#{pickDownMB.dbean.codetype}" layout="lineDirection"
													onclick="initEdit();t.batyClick(this);">
													<f:selectItems value="#{pickDownMB.codetypes}" />
												</h:selectOneRadio>
											</td>
										</tr>
									</tbody>
								</table>
								<table>
									<tbody>
										<tr>
											<td>
												<h:outputText value="库位:"></h:outputText>
											</td>
											<td>
												<h:inputText id="dwhid" styleClass="datetime"
													onkeydown="t.keyPressDeal(this);" onfocus="this.select();"
													value="#{pickDownMB.dbean.whid}" disabled="false" />
												<img id="whid_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectWahod();" />
											</td>
											<td>
												<h:outputText value="条码:"></h:outputText>
											</td>
											<td>
												<h:inputText id="baco" value="#{pickDownMB.dbean.baco}"
													onfocus="this.select();" size="42" styleClass="datetime"
													onkeypress="t.keyPressDeal(this);" />
												<img id="invcode_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectInveAdd();" />
											</td>
											<td>
												<h:outputText value="数量:"></h:outputText>
											</td>
											<td oncontextmenu='return(false);' onpaste='return false'>
												<h:inputText id="qty" value="#{pickDownMB.dbean.qty}"
													onfocus="t.elementFocus();t.canFocus(this);" size="16"
													onkeydown="t.keyPressDeal(this);" styleClass="datetime" />
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</a4j:outputPanel>
					</a4j:outputPanel>
					<div>
						<a4j:outputPanel id="outputtable">
							<g:GTable gid="gtable" gtype="grid" gdebug="false" gsort="soid"
								gsortmethod="asc"
								gselectsql="select distinct a.did,a.inco,a.qty,a.pbid,a.whid,b.inna,b.inty,b.inse,b.volu,b.newe,b.inpr,b.colo,a.baco,d.soid      
								from pkde a left join inve b on a.inco = b.inco
								JOIN pkma c ON a.biid=c.biid LEFT JOIN pkln d ON c.soco=d.biid AND a.pbid=d.oubi and a.inco=d.inco
								Where a.biid = '#{pickDownMB.mbean.biid}' "
								gpage="(pagesize = -1)" gversion="2"
								gupdate="(table = {csde},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
								gcid = whid(headtext = 下架货位,name = whid,width = 120,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
								gcid = qty(headtext = 拣货数量,name = qty,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event)&&onchange=textChange(this)});
								gcid = soid(headtext = 序号,name = soid,width = 60,align = center,type = text,headtype = sort ,datatype = string);
								gcid = inna(headtext = 商品名称,name = inna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
								gcid = colo(headtext = 规格,name = colo,width = 90,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inse(headtext = 规格码,name = inse,width = 90,align = left,type = text,headtype = sort ,datatype = string);
								gcid = pbid(headtext = 所属订单,name = pbid,width = 160,align = left,type = text,headtype = sort ,datatype = string);
								gcid = baco(headtext = 条码,name = baco,width = 250,align = left,type = text,headtype = sort ,datatype = string);
					" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{pickDownMB.msg}" />
							<h:inputHidden id="sellist" value="#{pickDownMB.sellist}" />
							<h:inputHidden id="filename" value="#{pickDownMB.fileName}" />
							<a4j:commandButton value="刷新" type="button" id="showtable"
								reRender="outputtable,output,head" requestDelay="50" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>