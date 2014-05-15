<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@ page import="com.gwall.view.PubmMB"%>

<%
    PubmMB ai = (PubmMB) MBUtil.getManageBean("#{pubmMB}");
    if (request.getParameter("pid") != null) {
        ai.getMbean().setBiid(request.getParameter("pid"));
    }
    ai.getVouch();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>采购订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="采购订单">
		<meta http-equiv="description" content="采购订单">
		<script type="text/javascript" src="po.js"></script>
		<style type="text/css">
.gopt span {
	cursor: pointer;
	color: #0000FF;
}
</style>
	</head>

	<f:view>
		<body id="mmain_body" onload="initEdit();">
			<div id="mmain_nav">
				<font color="#000000">入库处理&gt;&gt;<a href="po.jsf"
					class="return" title="返回">订单</a>&gt;&gt;</font><b>编辑采购订单</b>
				<br>
			</div>
			<h:form id="edit">
				<div id="mmain">
					<div id=mmain_opt>
						<a4j:outputPanel id="showHeadButton">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" rendered="#{pubmMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{pubmMB.updateHead}"
								onclick="if(!updateHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{pubmMB.MOD && pubmMB.commitStatus}"
								oncomplete="endUpdateHead();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateIdOuto" value="保存单据" type="button"
								action="#{pubmMB.updateHeadOuto}"
								onclick="if(!updateHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{pubmMB.MOD && !pubmMB.commitStatus}"
								oncomplete="endUpdateHead();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{pubmMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50"
								rendered="#{pubmMB.DEL && pubmMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								onclick="if(!app()){return false};"
								rendered="#{pubmMB.APP && pubmMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{pubmMB.approveVouch}" id="submitMBut"
								reRender="showHeadButton,renderArea,output,detailButton,showHead"
								oncomplete="endApp();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" onclick="unApp();"
								rendered="#{pubmMB.APP && !pubmMB.commitStatus}"
								styleClass="a4j_but1" value="反审单据" type="button"
								action="#{pubmMB.unApproveVouch}" id="unSubmitMBut"
								reRender="showHeadButton,renderArea,output,detailButton,showHead"
								oncomplete="endUnApp();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" onclick="selAllBar();"
								styleClass="a4j_but1"
								rendered="#{pubmMB.LST && !pubmMB.commitStatus&& false}" value="查看全部条码"
								type="button" action=""
								reRender="showHeadButton,renderArea,output,detailButton"
								requestDelay="50" />
							<a4j:commandButton type="button" value="打印条码"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{pubmMB.printCode}"
								rendered="#{pubmMB.PRN && !pubmMB.commitStatus&& false}"
								styleClass="a4j_but1" onclick="if(!print()){return false};"
								oncomplete="lookPrint();" reRender="renderArea,outTable"
								requestDelay="1000" />
							<a4j:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{pubmMB.printReport}"
								rendered="#{pubmMB.PRN && !pubmMB.commitStatus&& false}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output" requestDelay="1000" />

							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="excel" value="导出EXCEL" type="button"
								action="#{pubmMB.exportProcedureProduct}"
								reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
								oncomplete="excelios_end();" requestDelay="50" />
							<a4j:commandButton id="anewPurchase" value="不合格品预约"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" onclick="addDiv();" requestDelay="50" 
								rendered="#{pubmMB.PRN && !pubmMB.commitStatus&& false}"/>

							<a4j:commandButton id="copyPo" value="复制订单"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" rendered="#{pubmMB.APP && !pubmMB.commitStatus}"
								onclick="startDo();" requestDelay="50"
								action="#{pubmMB.copyPooder}" reRender="renderArea,biid"
								oncomplete="endCopyPo();" />

							<a4j:commandButton value="关闭单据"
								onmouseover="this.className='a4j_over1'"
								action="#{pubmMB.closeVoucher}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="if(!doClose()){return false};"
								rendered="#{pubmMB.SPE && !pubmMB.commitStatus}"
								oncomplete="endDoClose();"
								reRender="renderArea,output,showHead,showHeadButton" />
						</a4j:outputPanel>
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="showHead">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="采购订单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{pubmMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="采购类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="buty" value="#{pubmMB.mbean.buty}"
											disabled="#{!pubmMB.commitStatus}">
											<f:selectItems value="#{pubmMB.butys}" />
										</h:selectOneMenu>
									</td>
									<td>
										组织架构:
									</td>
									<td>
										<h:selectOneMenu id="orna" value="#{pubmMB.mbean.orid}"
											disabled="#{!pubmMB.commitStatus}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
									<td>
										是否紧急:
									</td>
									<td>
										<h:selectOneMenu id="tale" value="#{pubmMB.mbean.tale}"
											disabled="#{!pubmMB.commitStatus}" styleClass="selectItem">
											<f:selectItem itemLabel="普通" itemValue="20" />
											<f:selectItem itemLabel="紧急" itemValue="10" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="来源单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="soco" styleClass="datetime"
											value="#{pubmMB.mbean.soco}" />
									</td>
									<td>
										<h:outputText value="供应商名称:"></h:outputText>
									</td>
									<td>
										<h:inputText id="suna" styleClass="datetime"
											disabled="#{!pubmMB.commitStatus}"
											value="#{pubmMB.mbean.suna}" />
										<h:inputHidden id="suid" value="#{pubmMB.mbean.suid}" />
										<a4j:outputPanel rendered="#{pubmMB.commitStatus}">
											<img id="invcode_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectSuin();" />
										</a4j:outputPanel>
									</td>
									<td>
										<h:outputText value="采购时间:"></h:outputText>
									</td>
									<td>
										<h:inputText id="pudt" styleClass="datetime"
											disabled="#{!pubmMB.commitStatus}"
											value="#{pubmMB.mbean.pudt}"
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" />
									</td>
									<td>
										<h:outputText value="预计到货时间:"></h:outputText>
									</td>
									<td>
										<h:inputText id="indt" styleClass="datetime"
											disabled="#{!pubmMB.commitStatus}"
											value="#{pubmMB.mbean.indt}"
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" />
									</td>
								</tr>
								<tr>
								<!-- 
									<td>
										预售发货时间:
									</td>
									<td>
										<h:inputText id="psdt" styleClass="datetime"
											disabled="#{!pubmMB.commitStatus}"
											value="#{pubmMB.mbean.psdt}"
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" />
									</td>
									<td>
										虚拟仓库:
									</td>
									<td>
										<h:selectOneMenu id="whid" value="#{pubmMB.mbean.whid}"
											disabled="#{!pubmMB.commitStatus}" styleClass="selectItem">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{pubmMB.warelistVir}" />
										</h:selectOneMenu>
									</td>
									 -->
									<td>
										<h:outputText value="制单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="outo" styleClass="datetime"
											value="#{pubmMB.mbean.outo}" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!pubmMB.commitStatus}"
											value="#{pubmMB.mbean.rema}" size="100" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>

					<div>
						<a4j:outputPanel id="detailButton">
							<div id="mmain_opt">
								<a4j:commandButton id="addDButs" value="添加明細"
									onclick="showAddDetail();"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" reRender="renderArea,output"
									rendered="#{pubmMB.ADD && pubmMB.commitStatus}"
									requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{pubmMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,countPage"
									rendered="#{pubmMB.MOD && pubmMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{pubmMB.MOD && pubmMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{pubmMB.updateDetail}"
									reRender="renderArea,output,countPage"
									oncomplete="endUpdateDetail();" requestDelay="50" />
								<a4j:commandButton id="createBar" value="生成条码"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!createBar()){return false};" type="button"
									action="#{pubmMB.createBar}" reRender="renderArea,output"
									oncomplete="endCreateBar();" requestDelay="50"
									rendered="#{pubmMB.MOD && !pubmMB.commitStatus&& false}" />
								<gw:GAjaxButton id="impDBut" value="导入明细" theme="b_theme"
									rendered="#{pubmMB.IMP && pubmMB.commitStatus}"
									onclick="showImport()" type="button" />
							</div>
							<a4j:outputPanel
								rendered="#{pubmMB.MOD && pubmMB.commitStatus && false}">
								<div id="mmain_cnd">
									<table>
										<tr>
											<td>
												<h:outputText value="商品编码:"></h:outputText>
											</td>
											<td>
												<h:inputText id="inco" value="#{pubmMB.dbean.inco}"
													styleClass="datetime" size="16" onkeypress="clickInve();" />
												<img id="invcode_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectInveAdd();" />
											</td>
											<td>
												<h:outputText value="数量:"></h:outputText>
											</td>
											<td>
												<h:inputText id="qty" value="#{pubmMB.dbean.qty}"
													styleClass="datetime" size="16" />
											</td>
										</tr>
									</table>
								</div>
							</a4j:outputPanel>
						</a4j:outputPanel>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="select a.did,a.roid,a.inco,b.inna,b.colo,b.inse,a.qty,a.dqty,(select sum(bb.qty) from ckma aa join ckbd bb on aa.biid=bb.biid where aa.flag='11' and aa.soco=a.biid and bb.inco=a.inco and bb.chre<>'D' group by bb.inco)
											-(select sum(bb.qty) from psma aa join psde bb on aa.biid=bb.biid where aa.flag='11' and aa.soco=a.biid and bb.inco=a.inco group by bb.inco)
											as zcqty,a.rqty,CASE WHEN (a.dqty-a.rqty) <= 0 THEN 0 ELSE (a.dqty-a.rqty) END as wqty
											
											from pubd a left join inve b on a.inco = b.inco  
											Where a.biid = '#{pubmMB.mbean.biid}' "
								gpage="(pagesize = -1)" gversion="2"
								gupdate="(table = {pubd},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = checkbox);
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = roid(headtext = 行项目,name = roid,width = 100,align = left,type = text,headtype = hidden ,datatype = string);
									gcid = -1(headtext = 操作,value = 查看条码,name = opt,width = 60,align = center,type = text,headtype =hidden,datatype = string,gscript={onclick=setInco('gcolumn[inco]')},gstyle={gopt});
									gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 商品名称,name = inna,width = 140,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 规格码,name = inse,width = 50,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext =  采购数量,name = qty,width = 70,align = right,type = #{pubmMB.commitStatus ? 'input' : 'text' },headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
									gcid = dqty(headtext =  实际到货数,name = dqty,width = 70,align = right,type = text,headtype= #{pubmMB.commitStatus ? 'hidden' : 'sort' }, datatype =number,dataformat=0.###{pubmMB.commitStatus ? '' : ',summary=this' });
									gcid = zcqty(headtext =  在检数,name = zcqty,width = 60,align = right,type =  hidden,headtype= #{pubmMB.commitStatus ? 'hidden' : 'sort' }, datatype =number,dataformat=0.###);
									gcid = rqty(headtext =  已入库数,name = rqty,width = 70,align = right,type = text,headtype= #{pubmMB.commitStatus ? 'hidden' : 'sort' }, datatype =number,dataformat=0.###{pubmMB.commitStatus ? '' : ',summary=this' });
									gcid = wqty(headtext =  待入库数,name = wqty,width = 70,align = right,type = text,headtype= #{pubmMB.commitStatus ? 'hidden' : 'sort' }, datatype =number,dataformat=0.###{pubmMB.commitStatus ? '' : ',summary=this' });
									" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{pubmMB.msg}" />
							<h:inputHidden id="roids" value="#{pubmMB.roids}" />
							<h:inputHidden id="sellist" value="#{pubmMB.sellist}" />
							<h:inputHidden id="filename" value="#{pubmMB.fileName}" />
							<h:inputHidden id="updatedata" value="#{pubmMB.updatedata}" />
							<h:inputHidden id="sk_inco" value="#{pubmMB.sk_inco}" />
							<h:inputHidden id="gsql" value="#{pubmMB.gsql}" />
							<h:inputHidden id="outPutFileName" value="#{pubmMB.outPutFileName}" />
							<a4j:commandButton id="searchBar" value="查询" type="button"
								action="#{pubmMB.searchBar}" requestDelay="50"
								oncomplete="showBar();" />

							<a4j:commandButton id="refreshBut" value="刷新明细" type="button"
								reRender="output" />

							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="查询商品信息" type="button" action="#{pubmMB.selInveBut}"
								id="selInveBut" onclick="if(!selInveBut()){return false};"
								reRender="detailButton" oncomplete="endSelInveBut();"
								requestDelay="50" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>

			<div id="import" style="display: none" align="left">
				<h:form id="file" enctype="multipart/form-data">
					<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
						value="#{pubmMB.myFile}" required="true" size="75" />
					<div id="mes"></div>
					<div align="center">
						<gw:GAjaxButton value="上传" onclick="return doImport();"
							id="import" theme="a_theme" />
						<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
							onclick="hideDiv()" type="button" />
					</div>
					<div style="display: none;">
						<h:commandButton value="上传" id="importBut"
							action="#{pubmMB.uploadFile}" />
					</div>
				</h:form>
			</div>

			<div id="editEx" style="display: none">
				<h:form id="editEx">
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									预约到货时间：
								</td>
								<td>
									<h:inputText id="anewPurchaseDate" styleClass="datetime"
										value="#{pubmMB.anewPurchaseDate}"
										onfocus="#{gmanage.datePicker}" />
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">
									<a4j:commandButton id="saveid" action="#{pubmMB.anewPurchase}"
										value="保存" reRender="msg"
										onclick="if(!formCheck()){return false};"
										oncomplete="endAnewPurchase();"
										onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
									<a4j:commandButton onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										value="返回" onclick="hideDivEx();" />
								</td>
							</tr>
						</table>
					</a4j:outputPanel>
				</h:form>
			</div>
		</body>
	</f:view>
</html>