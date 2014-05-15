<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@	page import="com.gwall.util.MBUtil"%>
<%@ page import="com.gwall.view.MoPlanMB"%>
<%
	MoPlanMB ai = (MoPlanMB) MBUtil.getManageBean("#{moPlanMB}");
	ai.getVouch();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>生产包装计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="生产包装计划">
		<meta http-equiv="description" content="生产包装计划">
		<script type="text/javascript" src="moplan.js"></script>
	</head>
	<body id="mmain_body" onload="initEdit();">
		<div id=mmain_nav>
			<a id="linkid" href="moplan.jsf" class="return" title="返回">入库处理</a>&gt;&gt;
			<b>编辑生产包装计划</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id=mmain_opt>
						<a4j:outputPanel id="showHeadButton">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								action="#{moPlanMB.clearMBean}" oncomplete="addNew();"
								id="addHead" rendered="#{moPlanMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{moPlanMB.updateHead}"
								onclick="if(!addHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{moPlanMB.MOD && moPlanMB.commitStatus}"
								oncomplete="endDo();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{moPlanMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50"
								rendered="#{moPlanMB.DEL && moPlanMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="if(!checkApp()){return false};" value="审核单据"
								rendered="#{moPlanMB.APP && moPlanMB.commitStatus}"
								action="#{moPlanMB.approveVouch}" id="submitMBut"
								reRender="showHeadButton,renderArea,output,detailButton,showHead"
								oncomplete="endApp();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" onclick="unApp();"
								rendered="#{moPlanMB.APP && !moPlanMB.commitStatus && false}"
								styleClass="a4j_but1" value="反审单据" type="button"
								action="#{moPlanMB.unApproveVouch}" id="unSubmitMBut"
								reRender="showHeadButton,renderArea,output,detailButton,showHead"
								oncomplete="endUnApp();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" onclick="selAllBar();"
								styleClass="a4j_but1"
								rendered="#{moPlanMB.LST && !moPlanMB.commitStatus && false}"
								value="查看全部条码" type="button" action=""
								reRender="showHeadButton,renderArea,output,detailButton"
								requestDelay="50" />
							<a4j:commandButton type="button" value="打印条码"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{moPlanMB.printCode}"
								rendered="#{moPlanMB.PRN && !moPlanMB.commitStatus}"
								styleClass="a4j_but1" onclick="if(!print()){return false};"
								oncomplete="lookPrint();" reRender="renderArea,outTable,output"
								requestDelay="1000" />
							<a4j:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{moPlanMB.printReport}"
								rendered="#{moPlanMB.PRN && !moPlanMB.commitStatus}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output" requestDelay="1000" />
						</a4j:outputPanel>
					</div>
					<div id='mmain_cnd'>
						<a4j:outputPanel id="showHead">
							<table border="0" cellspacing="0" cellpadding="1">
								<tr>
									<td>
										<h:outputText value="单据编号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime" size="15"
											value="#{moPlanMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="业务类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="dety" value="#{moPlanMB.mbean.dety}"
											disabled="#{!moPlanMB.commitStatus}">
											<f:selectItems value="#{moPlanMB.butys}" />
										</h:selectOneMenu>
									</td>
									<td>
										组织架构:
									</td>
									<td>
										<h:selectOneMenu id="orna" value="#{moPlanMB.mbean.orid}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="经手人:"></h:outputText>
									</td>
									<td>
										<h:inputText id="opna" styleClass="datetime"
											disabled="#{!moPlanMB.commitStatus}" size="15"
											value="#{moPlanMB.mbean.opna}" />
									</td>
									<td>
										<h:outputText value="入库仓库:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whna" styleClass="datetime"
											value="#{moPlanMB.mbean.whna}" disabled="true" />
										<h:inputHidden id="whid" value="#{moPlanMB.mbean.whid}" />
										<a4j:outputPanel rendered="#{moPlanMB.commitStatus}">
											<img id="whid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectWaho();" />
										</a4j:outputPanel>
									</td>
									<td>
										部&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门:
									</td>
									<td>
										<h:inputText id="dpna" styleClass="datetime"
											value="#{moPlanMB.mbean.dpna}" disabled="true" />
										<h:inputHidden id="dpid" value="#{moPlanMB.mbean.dpid}" />
										<a4j:outputPanel rendered="#{moPlanMB.commitStatus}">
											<img id="whid_img" style="cursor: hand"
												src="../../images/find.gif" onclick="selectDept();" />
										</a4j:outputPanel>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!moPlanMB.commitStatus}"
											value="#{moPlanMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div>
						<a4j:outputPanel id="detailButton">

							<div id="mmain_opt">
								<a4j:commandButton id="addDBut" value="添加明細"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{moPlanMB.addDetail}"
									reRender="renderArea,output"
									rendered="#{moPlanMB.ADD && moPlanMB.commitStatus && false}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="addDButs" value="添加明細"
									onclick="showAddDetail();window.reload;"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" reRender="renderArea,output"
									rendered="#{moPlanMB.ADD && moPlanMB.commitStatus}"
									requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{moPlanMB.MOD && moPlanMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{moPlanMB.updateDetail}" reRender="renderArea,output"
									oncomplete="endUpdateDetail();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{moPlanMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output"
									rendered="#{moPlanMB.DEL && moPlanMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<a4j:commandButton id="createBar" value="生成条码"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!createBar()){return false};" type="button"
									action="#{moPlanMB.createBar}" reRender="renderArea,output"
									oncomplete="endCreateBar();" requestDelay="50"
									rendered="#{moPlanMB.MOD && !moPlanMB.commitStatus && false}" />
								<a4j:commandButton id="delete0row" value="清除0数据行"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{moPlanMB.clearDetail}"
									onclick="if(!clearDetail()){return false};"
									reRender="renderArea,output,tableid"
									rendered="#{moPlanMB.MOD && moPlanMB.commitStatus}"
									oncomplete="endClearDetail();" requestDelay="50" />
								<gw:GAjaxButton id="impDBut" value="导入明细" theme="b_theme" 
									rendered="#{moPlanMB.IMP && moPlanMB.commitStatus}"
									onclick="showImport()" type="button" />
								<gw:GAjaxButton id="otpDBut" value="导出明细" theme="b_theme"
									onclick="showOutput('gtable','did')" type="button" 
									rendered="#{moPlanMB.EXP && moPlanMB.commitStatus}"
									reRender="output"/>
							</div>
							<!--<a4j:outputPanel rendered="#{moPlanMB.MOD && moPlanMB.commitStatus}">
								<div id="mmain_cnd">
								<table>
									<tr>
										<td>
											<h:outputText value="商品编码:"></h:outputText>
										</td>
										<td>
											<h:inputText id="inco"
											value="#{moPlanMB.dbean.inco}" styleClass="datetime"
											size="16" onkeypress="clickInve();" />
											<img id="invcode_img" style="cursor: pointer" 
											src="../../images/find.gif" onclick="selectInve();" />
										</td>
										<td>
											<h:outputText value="数量:"></h:outputText>
										</td>
										<td>
											<h:inputText id="qty" value="#{moPlanMB.dbean.qty}"
												onkeypress="addDetailKey();return isInteger(event)"
												onchange="textChange(this)"
												styleClass="datetime" size="16" />
										</td>
									</tr>
								</table>
								</div>
							</a4j:outputPanel>
						-->
						</a4j:outputPanel>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="select a.did,a.inco,a.qty,a.inpa,ISNULL(a.pqty,0) as pqty,(ceiling(a.qty/a.inpa)+pqty) as barnum,ISNULL(a.fqty,0) as fqty,b.inna,b.inty,b.inst,b.volu,b.newe,b.inpr,b.colo,
											ISNULL(a.stat,0) as stat,a.rema          
											from ctde a left join inve b on a.inco = b.inco  
											 Where a.biid = '#{moPlanMB.mbean.biid}' "
								gpage="(pagesize = -1)" gversion="2"
								gupdate="(table = {ctde},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox ,headtype = checkbox);
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 商品名称,name = inna,width = 150,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 花色,name = colo,width = 150,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inst(headtext = 规格,name = inst,width = 90,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext =  计划数量,name = qty,width = 70,align = right,type = #{moPlanMB.commitStatus ? 'input' : 'text' },headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event)&&onchange=textChange(this)});
									gcid = inpa(headtext = 包装方式,name = inpa,width = 70,align = right,type = #{moPlanMB.commitStatus ? 'input' : 'text' },headtype= sort, datatype =number,dataformat=0.##,update=edit,gscript={onkeypress=return isInteger(event)&&onchange=textChange(this)});
									gcid = pqty(headtext = 备用条码数量,name = pqty,width = 80,align = right,type = #{moPlanMB.commitStatus ? 'input' : 'text' },headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event)&&onchange=textChange(this)});
									gcid = barnum(headtext = 条码数量,name = barnum,width = 70,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,summary=this);
									gcid = fqty(headtext = 已入库数量,name = fqty,width = 70,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,summary=this);
									gcid = rema(headtext = 备注,name = rema,width = 130,align = left,type = #{moPlanMB.commitStatus ? 'input' : 'text' },headtype = sort ,datatype = string,update=edit);
									gcid = inpr(headtext = 属性,name = inpr,width = 90,align = left,type = mask,typevalue=P:成品/S:半成品,headtype = sort ,datatype = string);
									gcid = inty(headtext = 商品品类,name = inty,width = 90,align = left,type = hidden,headtype = sort ,datatype = string);
									gcid = volu(headtext = 体积,name = volu,width = 80,align = right,type = hidden,headtype = sort ,datatype = number,dataformat=0.00);
									gcid = newe(headtext = 重量,name = newe,width = 80,align = right,type = hidden,headtype = sort ,datatype = number,dataformat=0.00);
									gcid = stat(headtext = 打印次数,name = statnum,width = 60,align = center,type = text,headtype = hidden,datatype = string);
									gcid = stat(headtext = 打印次数,name = stat,width = 60,align = center,type = mask,typevalue=0:未打印/1:已打印,headtype = sort,datatype = string,bgcolor={gcolumn[stat]>0:#ff4747});
										" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{moPlanMB.msg}" />
							<h:inputHidden id="roids" value="#{moPlanMB.roids}" />
							<h:inputHidden id="sellist" value="#{moPlanMB.sellist}" />
							<h:inputHidden id="selqtys" value="#{moPlanMB.selqtys}" />
							<h:inputHidden id="filename" value="#{moPlanMB.fileName}" />
							<h:inputHidden id="updatedata" value="#{moPlanMB.updatedata}" />

							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="查询商品信息" type="button" action="#{moPlanMB.selInveBut}"
								id="selInveBut" onclick="if(!selInveBut()){return false};"
								reRender="detailButton" oncomplete="endSelInveBut();"
								requestDelay="50" />
							<!--<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="刷新" type="button" 
								id="showTable" reRender="output" 
								requestDelay="50" />
						--></a4j:outputPanel>
					</div>
				</div>
			</h:form>
			<div id="import" style="display: none" align="left">
				<h:form id="file" enctype="multipart/form-data">
					<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
						value="#{moPlanMB.myFile}" required="true" size="75" />
					<div id="mes"></div>
					<div align="center">
						<gw:GAjaxButton value="上传" onclick="return doImport();"
							id="import" theme="a_theme" />
						<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
							onclick="hideDiv()" type="button" />
					</div>
					<div style="display: none;">
						<h:commandButton value="上传" id="importBut"
							action="#{moPlanMB.uploadFile}" />
					</div>
				</h:form>
			</div>

		</f:view>
	</body>
</html>