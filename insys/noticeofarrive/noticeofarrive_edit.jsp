<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.stockin.NoticeOfArriveMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑到货通知单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑到货通知单">
		<meta http-equiv="description" content="编辑到货通知单">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="noticeofarrive.js"></script>
	</head>

	<%
	    String id = "";
	    NoticeOfArriveMB ai = (NoticeOfArriveMB) MBUtil
	            .getManageBean("#{noticeOfArriveMB}");
	    if (request.getParameter("pid") != null) {
	        id = request.getParameter("pid");
	        ai.getMbean().setBiid(id);
	    }
	    ai.getVouch();
	%>
	<body id="mmain_body">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;<a href="noticeofarrive.jsf"
				title="返回" class="return">入库</a>&gt;&gt;</font><b>编辑到货通知单</b>
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
								onclick="addNew();" rendered="#{noticeOfArriveMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{noticeOfArriveMB.updateHead}"
								onclick="if(!updateHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{noticeOfArriveMB.MOD && noticeOfArriveMB.commitStatus}"
								oncomplete="endUpdateHead();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{noticeOfArriveMB.deleteHead}"
								onclick="if(!doDel()){return false;}"
								reRender="output,renderArea" oncomplete="endDele();"
								requestDelay="50"
								rendered="#{noticeOfArriveMB.DEL && noticeOfArriveMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="approveId" value="确认通知" type="button"
								action="#{noticeOfArriveMB.approveVouch}"
								onclick="if(!app()){return false;}"
								reRender="output,renderArea,head,countPage,detailbutton,input,tableid"
								oncomplete="endApp();" requestDelay="50"
								rendered="#{noticeOfArriveMB.APP && noticeOfArriveMB.commitStatus}" />

							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="qsbtn" value="确认到货" type="button" requestDelay="50"
								action="#{noticeOfArriveMB.conFirmArrive }"
								rendered="#{noticeOfArriveMB.APP && noticeOfArriveMB.isbtnarrvie}"
								reRender="output,tableid,head,detailbutton,renderArea"
								onclick="if(!cfmArriv()){return false;}"
								oncomplete="endcfmarrvie();" />


							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="finishArriveBT" value="完成清点" type="button" requestDelay="50"
								action="#{noticeOfArriveMB.finishArrive }"
								rendered="#{noticeOfArriveMB.APP && noticeOfArriveMB.isbtnth}"
								reRender="output,tableid,head,detailbutton,msg"
								onclick="if(!confirm('确定所有明细清点完成?')){return false;}else{Gwallwin.winShowmask('TRUE');}"
								oncomplete="endcfmarrvie();" />
								
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="jsbtn" value="拒收返厂" type="button" requestDelay="50"
								onclick="if(!st_reject()){return false;}"
								reRender="output,renderArea,head" oncomplete="end_reject();"
								action="#{ noticeOfArriveMB.reJect}"
								rendered="#{!noticeOfArriveMB.commitStatus && noticeOfArriveMB.isbtnjs}" />

							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="thbtn" value="不合格品返厂" type="button"
								onclick="if(!st_returns()){return false;}"
								reRender="output,renderArea,head,tableid"
								oncomplete="end_returns();"
								action="#{noticeOfArriveMB.resTuns }"
								rendered="#{!noticeOfArriveMB.commitStatus && noticeOfArriveMB.isbtnth}" />

							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="mckbtn" value="修改质检类型" type="button"
								onclick="if(!st_mdtype()){return false;}"
								oncomplete="end_mdtype();"
								action="#{noticeOfArriveMB.updateCheckType }"
								rendered="#{!noticeOfArriveMB.commitStatus && noticeOfArriveMB.isbtnup}"
								reRender="head,tableid,msg" />

							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="mtzdt" value="保存调整明细" type="button"
								onclick="if(!st_mddetail()){return false;}"
								oncomplete="end_mddetail();"
								action="#{noticeOfArriveMB.upDetailData }"
								rendered="#{!noticeOfArriveMB.commitStatus}"
								reRender="head,tableid,msg" />

						<!--	<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
								
						-->		
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{noticeOfArriveMB.export}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />	
								
								
								
								
								
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="rqbtn" value="入库回写" type="button" requestDelay="50"
								action="#{noticeOfArriveMB.comFirmStockIn}"
						
								reRender="output,tableid,head,detailbutton,renderArea"
								onclick="if(!confirm('确定回写入库信息?')){return false;}else{Gwallwin.winShowmask('TRUE');}"
								oncomplete="endcfmarrvie();" />
							
						</a4j:outputPanel>
					</div>

					<div id="mmain_cnd">
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="采购到货单:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{noticeOfArriveMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										是否质检:
									</td>
									<td>
										<h:selectOneMenu id="isch"
											value="#{noticeOfArriveMB.mbean.isch}">
											<f:selectItem itemLabel="否" itemValue="0" />
										</h:selectOneMenu>
									</td>
									<td>
										预计到货日期：
									</td>
									<td>
										<h:inputText id="indt" styleClass="datetime"
											value="#{noticeOfArriveMB.mbean.indt}" disabled="true" />
									</td>
									<td>
										确认到货日期：
									</td>
									<td>
										<h:inputText id="stdt" styleClass="datetime"
											value="#{noticeOfArriveMB.mbean.stdt}" disabled="true" />
									</td>
								</tr>
								<tr>
									<td>
											供应商名称:
									</td>
									<td>
										<h:inputText id="suna" styleClass="datetime"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;"
											value="#{noticeOfArriveMB.mbean.suna}" />
										<h:inputHidden id="suid" value="#{noticeOfArriveMB.mbean.suid}" />
										<img id="suid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectSuin();" />
									</td>
									<td>
										<h:outputText value="批次号:"></h:outputText>
									</td>
									<td oncontextmenu="return(false);" onpaste="return false">
										<h:inputText id="bato" styleClass="datetime"
											style="color:#7f7f7f;" value="#{noticeOfArriveMB.mbean.bato}" />
									</td>
									<td>
								      <h:outputText value="入库仓库:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="whid" value="#{noticeOfArriveMB.mbean.whid}"
											style="width:130px;"   disabled="true">
											<f:selectItems value="#{warehouseMB.wareList}" />
										</h:selectOneMenu>
									</td> 
									
									
									<!-- 
									<td>
										快递公司:
									</td>
									<td>
										<h:inputText id="lpna" styleClass="datetime"
											value="#{noticeOfArriveMB.mbean.lpna}" disabled="true" />
									</td>
									<td>
										快递单号:
									</td>
									<td>
										<h:inputText id="lpco" styleClass="datetime"
											value="#{noticeOfArriveMB.mbean.lpco}" disabled="true" />
									</td>
								
								</tr>
								<tr>
									<td>
										<h:outputText value="尺寸详情"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="side" styleClass="datetime" disabled="true"
											value="#{noticeOfArriveMB.mbean.side}" size="100" />
									</td>
									 -->
								
								</tr>
								
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="nv_remark" styleClass="datetime"
											value="#{noticeOfArriveMB.mbean.rema}" size="100" />
									</td>
								</tr>
								<!--  
								<tr>
									<td>
										<h:outputText value="拒收原因:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="nv_resn" styleClass="datetime"
											value="#{noticeOfArriveMB.mbean.resn}" size="100" />
									</td>
								</tr>
								-->
							</table>
						</a4j:outputPanel>
					</div>
					<div id="mmain_opt">
						<a4j:outputPanel id="detailbutton">
							<a4j:outputPanel rendered="#{noticeOfArriveMB.commitStatus}">
								<a4j:commandButton onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									value="添加明细" type="button" reRender="tableid,tableid2"
									onclick="showAddDetail();" rendered="#{noticeOfArriveMB.MOD}"
									requestDelay="50" />
								<gw:GAjaxButton id="impDBut" value="导入明细" theme="b_theme"
									rendered="#{noticeOfArriveMB.IMP && noticeOfArriveMB.commitStatus}"
									onclick="showImport()" type="button" />
								<a4j:commandButton onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									value="删除明细" type="button"
									action="#{noticeOfArriveMB.deleteDetail}"
									onclick="if(!delDetail('gtable')){return false};"
									rendered="#{noticeOfArriveMB.MOD}"
									reRender="tableid,renderArea" oncomplete="endDelDetail();"
									requestDelay="50" />
							</a4j:outputPanel>

							<a4j:commandButton id="chBtn" value="准备质检"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								reRender="renderArea,output,countPage,tableid,msg"
								onclick="if(!st_turncheck(gtable)){return false;}"
								oncomplete="end_turncheck();"
								rendered="#{noticeOfArriveMB.isbtnck && false}"
								action="#{noticeOfArriveMB.turnCheck }" />
							<a4j:commandButton id="InBtn" value="准备入库"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								reRender="renderArea,output,countPage,tableid,msg"
								onclick="if(!st_turnin(gtable)){return false;}"
								oncomplete="end_turnin();"
								rendered="#{ noticeOfArriveMB.isbtnin}"
								action="#{noticeOfArriveMB.turnIn }" />
							<a4j:commandButton id="cpBtn" value="残品入库"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								reRender="renderArea,output,countPage,tableid,msg"
								onclick="if(!st_turndefin(gtable)){return false;}"
								oncomplete="end_turndefin();"
								rendered="#{noticeOfArriveMB.isbtndefin && false}"
								action="#{noticeOfArriveMB.trunDefIn }" />
						</a4j:outputPanel>
					</div>
					<div>
						<a4j:outputPanel id="tableid">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="
									SELECT a.did,a.roid,a.soco,a.biid,a.inco,a.bupr,a.qty,a.aqty,a.cqty,a.qfqt,
									a.uqqt,a.dfqt,a.rqty,a.arqt,a.qirt,a.jqty,a.tqty,a.rema,b.inna,b.inse,b.colo 
									FROM nofd a 
									LEFT JOIN inve b ON a.inco=b.inco
									where a.biid='#{noticeOfArriveMB.mbean.biid}'
								"
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {nofd},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = checkbox);
										gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
										gcid = rema(headtext = 备注,   name = rema,width = 110,align = left,type = text,headtype = sort ,update=edit,datatype = number);
										gcid = qirt(headtext = 质检比率(%),   name = qirt,width = 110,align = left,type = hidden,headtype = #{noticeOfArriveMB.isbtnck ? 'sort' : 'hidden'} ,update=edit,datatype = number,dataformat=0);
										gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inna(headtext = 商品名称,name = inna,width = 200,align = left,type = text,headtype = sort ,datatype = string);
										gcid = colo(headtext = 规格,name = colo,width = 80,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inse(headtext = 规格码,name = inse,width = 80,align = left,type = text,headtype = sort ,datatype = string);
										gcid = bupr(headtext = 单价,name = inse,width = 80,align = left,type = text,headtype = sort ,datatype = number,dataformat={0.00});
										gcid = qty(headtext = 通知数量,name = qty,width = 80,align = right,type = text,headtype = sort ,datatype = number,dataformat={0});
										gcid = aqty(headtext = 清点数量,name = aqty,width = 80,align = right,type = #{noticeOfArriveMB.commitStatus ? 'text' : 'input'},headtype = sort ,datatype = number,dataformat={0});
										gcid = cqty(headtext = 待质检数量,name = cqty,width = 80,align = right,type = text,headtype = sort ,datatype = number,dataformat={0});
										gcid = qfqt(headtext = 合格数量,name = qfqt,width = 80,align = right,type = #{noticeOfArriveMB.commitStatus ? 'text' : 'input'},headtype = sort ,datatype = number,dataformat={0});
										gcid = uqqt(headtext = 不合格数量,name = uqqt,width = 80,align = right,type = text,headtype = sort ,datatype = number,dataformat={0});
										gcid = dfqt(headtext = 残品数量,name =dfqt,width = 80,align = right,type = text,headtype = sort ,datatype = number,dataformat={0});
										gcid = rqty(headtext = 待入库数量,name =rqty,width = 80,align = right,type = text,headtype = sort ,datatype = number,dataformat={0});
										gcid = arqt(headtext = 入库数量,name =arqt,width = 80,align = right,type = text,headtype = sort ,datatype = number,dataformat={0});
										gcid = jqty(headtext = 拒收数量,name =jqty,width = 80,align = right,type = text,headtype = sort ,datatype = number,dataformat={0});
										gcid = tqty(headtext = 退货数量,name =tqty,width = 80,align = right,type = text,headtype = sort ,datatype = number,dataformat={0});
								
								" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{noticeOfArriveMB.msg}" />
							<h:inputHidden id="sellist" value="#{noticeOfArriveMB.sellist}" />
							<h:inputHidden id="orid" value="#{noticeOfArriveMB.orid}" />
							<h:inputHidden id="incos" value="#{noticeOfArriveMB.incos}" />
							<h:inputHidden id="lqtys" value="#{noticeOfArriveMB.lqtys}" />
							<h:inputHidden id="hqtys" value="#{noticeOfArriveMB.hqtys}" />
							<h:inputHidden id="gsql" value="#{noticeOfArriveMB.gsql}" />
							<h:inputHidden id="outPutFileName" value="#{noticeOfArriveMB.outPutFileName}" />
							<h:inputHidden id="updatedata"
								value="#{noticeOfArriveMB.updatedata}" />
							<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
								reRender="tableid" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
			<div id="import" style="display: none" align="left">
				<h:form id="file" enctype="multipart/form-data">
					<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
						value="#{noticeOfArriveMB.myFile}" required="true" size="75" />
					<div id="mes"></div>
					<div align="center">
						<gw:GAjaxButton value="上传" onclick="return doImport();"
							id="import" theme="a_theme" />
						<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
							onclick="hideDiv()" type="button" />
					</div>
					<div style="display: none;">
						<h:commandButton value="上传" id="importBut"
							action="#{noticeOfArriveMB.uploadFile}" />
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>
