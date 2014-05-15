<%@ page language="java" pageEncoding="UTF-8"%><%@ include
	file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.BoxInMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>编辑入库装箱单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑入库装箱单">
		<meta http-equiv="description" content="编辑入库装箱单">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/TailHandler.js"></script>
		<script type="text/javascript" src="boxin.js"></script>
	</head>
	<%
	    String id = "";
	    BoxInMB ai = (BoxInMB) MBUtil.getManageBean("#{boxInMB}");
	    if (request.getParameter("pid") != null) {
	        id = request.getParameter("pid");
	        ai.getMbean().setBiid(id);
	    }
	    ai.getVouch();
	%>
	<body id="mmain_body" onload="initDetail();">

		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;<a href="boxin.jsf"
				title="返回" class="return">入库</a>&gt;&gt;</font><b>编辑入库装箱单</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id=mmain_opt>
						<a4j:outputPanel id="output">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" rendered="#{boxInMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{boxInMB.updateHead}"
								onclick="if(!updateHead()){return false};"
								reRender="output,renderArea,head" requestDelay="50"
								rendered="#{boxInMB.MOD && boxInMB.commitStatus}"
								oncomplete="endUpdate();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{boxInMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50"
								rendered="#{boxInMB.DEL && boxInMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" id="submitMBut"
								onclick="if(!app()){return false};"
								rendered="#{boxInMB.APP && boxInMB.commitStatus}"
								styleClass="a4j_but1" value="审核单据" type="button"
								action="#{boxInMB.approveVouch}"
								reRender="showHeadButton,renderArea,output,detailbutton,showHead,head,tableid,input"
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
							<a4j:commandButton type="button" value="打印箱码"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{boxInMB.printReport}"
								rendered="#{boxInMB.PRN && !boxInMB.commitStatus}"
								styleClass="a4j_but1" onclick="printReport();"
								oncomplete="endPrintReport();"
								reRender="renderArea,outTable,output" requestDelay="500" />
							</a4j:outputPanel>
					</div>

					<div id=mmain_cnd>
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="入库装箱单:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{boxInMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="来源单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="m_soco"  styleClass="datetime" disabled="#{!boxInMB.commitStatus }"
										 value="#{boxInMB.mbean.soco}"></h:inputText>
									<a4j:outputPanel rendered="#{boxInMB.MOD && boxInMB.commitStatus}">
										 <img id="soco_img"
											style="cursor: pointer" src="../../images/find.gif"
											onclick="selectMSoco();" />	
									</a4j:outputPanel>	
									</td>
									<td>
										<h:outputText value="物料编码:"></h:outputText>
									</td>
									<td>
										<h:inputText id="inco" styleClass="datetime" disabled="#{!boxInMB.commitStatus }" 
										 value="#{boxInMB.mbean.inco}"></h:inputText>
										 <a4j:outputPanel rendered="#{boxInMB.MOD && boxInMB.commitStatus}">
											 <img id="inco_img"
												style="cursor: pointer" src="../../images/find.gif"
												onclick="selectMInco();" />
										 </a4j:outputPanel>
									</td>
									
								</tr>
								
								<tr>
									<td>
										<h:outputText value="装箱数量:"></h:outputText>
									</td>
									<td>
										<h:inputText id="m_qty"  styleClass="datetime" disabled="#{!boxInMB.commitStatus }"
										 value="#{boxInMB.mbean.qty}"></h:inputText>
									</td>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="4">
										<h:inputText id="rema" styleClass="datetime"
											disabled="#{!boxInMB.commitStatus}"
											value="#{boxInMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div id=mmain_opt>
						<a4j:outputPanel id="detailbutton">
							<a4j:outputPanel
								rendered="#{boxInMB.MOD && boxInMB.commitStatus}">
								<a4j:commandButton id="addDBut" value="添加明细"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{boxInMB.addDetail}"
									reRender="renderArea,output,tableid"
									rendered="#{boxInMB.MOD && boxInMB.commitStatus}"
									oncomplete="endUpdate();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明细"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{boxInMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,tableid"
									rendered="#{boxInMB.MOD && boxInMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<!-- div style="display: none;">
						<a4j:commandButton id="setCode4DBean" requestDelay="50"
							action="#{boxInMB.setCode4DBean}" onclick="startDo();"
							oncomplete="endCode4DBean();" reRender="input,renderArea" />
					</div> -->
					<div id=mmain_cnd>
						<a4j:outputPanel id="input">
							<h:panelGroup layout="block"
								rendered="#{boxInMB.MOD && boxInMB.commitStatus}">
								<table border="0" cellpadding="0" cellspacing="0">
									<tbody>
										<tr>
											<td width="30px;">
												<h:outputText id="codeTitle" value="条码:"></h:outputText>
											</td>
											<td>
												<h:inputText id="baco" value="#{boxInMB.dbean.baco}"
													 onfocus="this.select();"
													styleClass="datetime" size="42"></h:inputText>
												<img id="invcode_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectCode();" />
											</td>
											<td width="30px;">
												<h:outputText value="数量:"></h:outputText>
											</td>
											<td oncontextmenu='return(false);' onpaste='return false'>
												<h:inputText id="qty" value="#{boxInMB.dbean.qty}"
													 styleClass="datetime"
													size="10" />
											</td>
										</tr>
									</tbody>
								</table>
							</h:panelGroup>
						</a4j:outputPanel>
					</div>
					<div>
						<a4j:outputPanel id="tableid">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="select a.did,a.baco,a.inco,b.inna,a.qty from bide a left join inve b on a.inco=b.inco Where a.biid = 
								'#{boxInMB.mbean.biid}' "
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {bide},tablepk = {did})"
								gcolumn="gcid = did(headtext = 选项,name = did,width = 30,align = left,type = checkbox,headtype = sort );
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = baco(headtext = 商品条码,name = baco,width = 130,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 商品名称,name = inna,width = 130,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext = 数量,name = qty,width = 130,align = left,type = text,headtype = sort ,datatype = number,dataformat=0.##,summary=this);
								" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{boxInMB.msg}" />
						<h:inputHidden id="roids" value="#{boxInMB.roids}" />
						<h:inputHidden id="sellist" value="#{boxInMB.sellist}" />
						<h:inputHidden id="filename" value="#{boxInMB.fileName}" />
						<h:inputHidden id="updatedata" value="#{boxInMB.updatedata}" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询商品信息" type="button" action="#{boxInMB.selInveBut}"
							id="selInveBut" onclick="if(!selInveBut()){return false};"
							reRender="detailButton" oncomplete="endSelInveBut();"
							requestDelay="50" />
					</div>

				</div>
			</h:form>
			
		</f:view>
	</body>
</html>