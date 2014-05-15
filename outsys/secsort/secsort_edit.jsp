<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.view.SecsortMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	String id = "";
	SecsortMB ai = (SecsortMB) MBUtil.getManageBean("#{secsortMB}");
	if (request.getParameter("pid") != null) {
		id = request.getParameter("pid");
		ai.getMbean().setBiid(id);
	}
	ai.getVouch();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑二次分拣单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑二次分拣单">
		<meta http-equiv="description" content="编辑二次分拣单">
		<script type="text/javascript" src="secsort.js"></script>
	</head>
	<body onload="init();">
		<div id="mmain_nav">
			<font color="#000000">出库处理&gt;&gt;备货处理&gt;&gt;</font><b>编辑二次分拣单</b>
			<br>
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="output">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" rendered="#{secsortMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{secsortMB.updateHead}"
								onclick="if(!updateHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{secsortMB.MOD && secsortMB.commitStatus}"
								oncomplete="endUpdateHead();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{secsortMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50"
								rendered="#{secsortMB.DEL && secsortMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" onclick="app();"
								rendered="#{secsortMB.APP && secsortMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{secsortMB.approveVouch}" id="submitMBut"
								reRender="showHeadButton,renderArea,input,output,detailbutton,showHead,tableid,head,countPage"
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
						</a4j:outputPanel>
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="二次分拣单:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{secsortMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										来源类型:
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{secsortMB.mbean.soty}"
											style="width:130px;" disabled="true">
											<f:selectItem itemLabel="拣货下架" itemValue="PICKDOWN" />
										</h:selectOneMenu>
									</td>
									<td>
										来源单号:
									</td>
									<td>
										<h:inputText id="soco" size="20" styleClass="inputtext"
											value="#{secsortMB.mbean.soco}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
										<!--<img id="suid_img" style="cursor: pointer"
								src="../../images/find.gif" onclick="selectFrom();" />
						-->
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="分拣人员:"></h:outputText>
									</td>
									<td>
										<h:inputText id="crna" styleClass="datetime"
											value="#{secsortMB.mbean.crna}" disabled="true" />
									</td>
									<td>
										<h:outputText value="来源仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whna" styleClass="datetime"
											value="#{secsortMB.mbean.whna}" disabled="true" />
									</td>
									<td>
										<h:outputText value="单据标志:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="sk_flag" value="#{secsortMB.mbean.flag}"
											disabled="true">
											<f:selectItems value="#{secsortMB.flags}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="3">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!secsortMB.commitStatus}"
											value="#{secsortMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="vertical-align: top;"></div>
					<SPAN ID="detail_ctrl" class="ctrl_show"
						onclick="JS_ExtraFunction();"></SPAN>
					<font color="#4990dd" style="font-weight: bolder; cursor: pointer"
						onclick="JS_ExtraFunction();">待分拣明细:</font>
					<div id="ExtraFunction" style="display: none;">
						<a4j:outputPanel id="countPage">
							<iframe frameborder="0" src="showAllInventory.jsf" width="100%">
							</iframe>
						</a4j:outputPanel>
					</div>
					<div>
						<div id=mmain_opt>
							<a4j:outputPanel id="detailbutton">
								<a4j:outputPanel
									rendered="#{secsortMB.MOD && secsortMB.commitStatus}">
									<a4j:commandButton id="addDBut" value="添加明細"
										onclick="if(!addDetail()){return false};"
										onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										type="button" action="#{secsortMB.addDetail}"
										reRender="renderArea,output,tableid,countPage"
										rendered="#{secsortMB.ADD && secsortMB.commitStatus}"
										oncomplete="endAddDetail();" requestDelay="50" />
									<a4j:commandButton id="deleteDBut" value="刪除明細"
										onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										type="button" action="#{secsortMB.deleteDetail}"
										onclick="if(!delDetail(gtable2)){return false};"
										reRender="renderArea,output,tableid"
										rendered="#{secsortMB.DEL && secsortMB.commitStatus && false}"
										oncomplete="endDelDetail();" requestDelay="50" />
									<a4j:commandButton id="saveDBut" value="保存明细"
										onmouseover="this.className='a4j_over1'"
										rendered="#{secsortMB.MOD && secsortMB.commitStatus && false}"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										onclick="if(!updateDetail()){return false};" type="button"
										action="#{secsortMB.updateDetail}"
										reRender="renderArea,output" oncomplete="endUpdateDetail();"
										requestDelay="50" />
								</a4j:outputPanel>
							</a4j:outputPanel>
						</div>
						<a4j:outputPanel id="input">
							<a4j:outputPanel
								rendered="#{secsortMB.MOD && secsortMB.commitStatus}">
								<div id=mmain_cnd>
									<table>
										<tr>
											<td>
												<h:outputText value="物料编码:"></h:outputText>
											</td>
											<td>
												<h:inputText id="inco" value="#{secsortMB.dbean.inco}"
													styleClass="datetime" size="16" onkeypress="clickInve();" />
												<img id="invcode_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectInveAdd();" />
											</td>
											<td>
												<h:outputText value="数量:"></h:outputText>
											</td>
											<td>
												<h:inputText id="qty" value="#{secsortMB.dbean.qty}"
													styleClass="datetime" size="16" />
											</td>
											<td>
												<div id="showMsgDiv"
													style="width: 520px; border: 0px #CCCCCC solid; padding: 5px;"></div>
											</td>
										</tr>
									</table>
								</div>
							</a4j:outputPanel>
						</a4j:outputPanel>
						<font style="color: #4990dd"><B>已分拣列表:</B> </font>
						<a4j:outputPanel id="tableid">
							<g:GTable gid="gtable2" gtype="grid" gdebug="false"
								gselectsql="select a.did,a.inco,a.qty,a.whid,a.obid,a.obty,b.inna,b.inty,d.tyna,b.inst,b.volu,b.newe,b.inpr,b.colo,c.whna       
											from spde a left join inve b on a.inco = b.inco left join waho c on a.whid = c.whid left join prty d on b.inty = d.inty   
											 Where a.biid = '#{secsortMB.mbean.biid}' "
								gpage="(pagesize = -1)" gversion="2"
								gupdate="(table = {csde},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = checkbox);
							gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
							gcid = whna(headtext = 分配区位,name = whna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
							gcid = obty(headtext = 订单类型,name = obty,width = 100,align = left,type = text,headtype = sort ,datatype = string);
							gcid = obid(headtext = 订单单号,name = obid,width = 120,align = left,type = text,headtype = sort ,datatype = string);
							gcid = qty(headtext = 分拣数量,name = qty,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event)&&onchange=textChange(this)});
							gcid = inco(headtext = 物料编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
							gcid = inna(headtext = 物料名称,name = inna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
							gcid = colo(headtext = 花色,name = colo,width = 90,align = left,type = text,headtype = sort ,datatype = string);
							gcid = inst(headtext = 规格,name = inst,width = 90,align = left,type = text,headtype = sort ,datatype = string);
							gcid = tyna(headtext = 物料品类,name = tyna,width = 90,align = left,type = text,headtype = sort ,datatype = string);
							gcid = inpr(headtext = 属性,name = inpr,width = 90,align = left,type = mask,typevalue=P:成品/S:半成品/M:物料,headtype = sort ,datatype = string);
							gcid = volu(headtext = 体积,name = volu,width = 90,align = right,type = hidden,headtype = sort ,datatype = number,dataformat=0.00);
							gcid = newe(headtext = 重量,name = newe,width = 90,align = right,type = hidden,headtype = sort ,datatype = number,dataformat=0.00);
				" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{secsortMB.msg}" />
							<h:inputHidden id="sellist" value="#{secsortMB.sellist}" />
							<h:inputHidden id="updatedata" value="#{secsortMB.updatedata}" />
							<h:inputHidden id="waid" value="#{secsortMB.dbean.whid}" />
							<h:inputHidden id="obid" value="#{secsortMB.dbean.obid}" />
							<h:inputHidden id="obty" value="#{secsortMB.dbean.obty}" />
							<h:inputHidden id="showmsg" value="#{secsortMB.dbean.showmsg}" />
						</a4j:outputPanel>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询物料信息" type="button" action="#{secsortMB.selInveBut}"
							id="selInveBut" onclick="if(!selInveBut()){return false};"
							reRender="detailButton,input,renderArea"
							oncomplete="endSelInveBut();" requestDelay="50" />
						<a4j:commandButton value="刷新" type="button" id="showtable"
							reRender="tableid" requestDelay="50" />

					</div>


				</h:form>
			</div>

			<div id="import" style="display: none; height: 40px;" align="center">
				<h:form id="list">
					备货框货位编码:
					<h:inputText id="inputWhid" value="#{secsortMB.waid}"
						styleClass="datetime" size="16" onkeypress="clickWhid();" />
					<h:inputText id="temp" style="display:none;" styleClass="datetime"
						size="16" />
					<a4j:commandButton onmouseover="this.className='a4j_over1'"
						onmouseout="this.className='a4j_buton1'" style="display:none;"
						value="确定" type="button" action="#{secsortMB.updObWhid}"
						id="updObWhid" onclick="if(!updObWhid()){return false};"
						reRender="listRenderArea" oncomplete="endUpdObWhid();"
						requestDelay="50" />
					<a4j:outputPanel id="listRenderArea">
						<h:inputHidden id="listmsg" value="#{secsortMB.listmsg}" />
					</a4j:outputPanel>

				</h:form>
			</div>
		</f:view>
	</body>
</html>