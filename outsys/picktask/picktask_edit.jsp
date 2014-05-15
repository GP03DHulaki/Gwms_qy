<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.view.PickTaskMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	String id = "";
	PickTaskMB ai = (PickTaskMB) MBUtil.getManageBean("#{pickTaskMB}");
	if (request.getParameter("pid") != null) {
		id = request.getParameter("pid");
		ai.getMbean().setBiid(id);
	}
	ai.getVouch();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>备货任务</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="备货任务">
		<script type="text/javascript" src="picktask.js"></script>
	</head>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<div id="mmain_nav">
					<font color="#000000">出库处理&gt;&gt;<a href="picktask.jsf"
						color="blue">备货处理</a>&gt;&gt;</font><b>编辑备货任务</b>
					<br>
				</div>
				<h:form id="edit">
					<div id="mmain">
						<div id=mmain_opt>
							<a4j:outputPanel id="output">
								<a4j:commandButton value="添加单据"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="addNew();" rendered="#{pickTaskMB.ADD}" />
								<a4j:commandButton onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									id="updateId" value="保存单据" type="button"
									action="#{pickTaskMB.updateHead}"
									onclick="if(!updateHead()){return false};"
									reRender="output,renderArea,head" requestDelay="50"
									rendered="#{pickTaskMB.MOD && pickTaskMB.commitStatus}"
									oncomplete="endUpdateHead();" />
								<a4j:commandButton onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									id="delId" value="删除单据" type="button"
									action="#{pickTaskMB.deleteHead}"
									onclick="if(!deleteHead()){return false;}"
									reRender="output,renderArea" oncomplete="endDeleteHead();"
									requestDelay="50"
									rendered="#{pickTaskMB.DEL && pickTaskMB.commitStatus}" />
								<a4j:commandButton onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" onclick="app();"
									rendered="#{pickTaskMB.APP && pickTaskMB.commitStatus}"
									styleClass="a4j_but1" value="审核单据" type="button"
									action="#{pickTaskMB.approveVouch}" id="submitMBut"
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
								<a4j:commandButton type="button" value="打印单据"
									onmouseover="this.className='a4j_over1'" action="#{pickTaskMB.printVouch}"
									onmouseout="this.className='a4j_buton1'" rendered="#{pickTaskMB.PRN && !pickTaskMB.commitStatus}"
									onclick="printbill();" oncomplete="endprintbill();" reRender="renderArea"
									styleClass="a4j_but1" />
								<a4j:commandButton value="拣货路径"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="showPath();"
									rendered="#{pickTaskMB.LST && !pickTaskMB.commitStatus}" />
								<a4j:commandButton value="修改执行人"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="modifysius();" rendered="#{pickTaskMB.ADD}"
									oncomplete="Gwallwin.winShowmask('FALSE');" />
							</a4j:outputPanel>
						</div>

						<div id=mmain_cnd>
							<a4j:outputPanel id="head">
								<table border="0" cellspacing="0" cellpadding="3">
									<tr>
										<td>
											<h:outputText value="备货任务单:"></h:outputText>
										</td>
										<td>
											<h:inputText id="biid" styleClass="datetime"
												value="#{pickTaskMB.mbean.biid}" disabled="true" />
										</td>
										<td>
											来源类型:
										</td>
										<td>
											<h:selectOneMenu id="soty" value="#{pickTaskMB.mbean.soty}"
												style="width:130px;" disabled="true">
												<f:selectItem itemLabel="备货计划" itemValue="ENTRUCKPLAN" />
											</h:selectOneMenu>
										</td>
										<td>
											来源单号:
										</td>
										<td>
											<h:inputText id="soco" size="20" styleClass="inputtext"
												value="#{pickTaskMB.mbean.soco}"
												style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
											<!--<img id="suid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectFrom();" />
								-->
										</td>
									</tr>
									<tr>
										<td>
											<h:outputText value="任务优先级:"></h:outputText>
										</td>
										<td>
											<h:selectOneMenu id="tale" value="#{pickTaskMB.mbean.tale}"
												disabled="#{!pickTaskMB.commitStatus}">
												<f:selectItems value="#{pickTaskMB.tales}" />
											</h:selectOneMenu>
										</td>
										<td>
											<h:outputText value="任务执行人:"></h:outputText>
										</td>
										<td>
											<h:inputText id="sina" styleClass="datetime"
												value="#{pickTaskMB.mbean.sina}" />
											<h:inputHidden id="sius" value="#{pickTaskMB.mbean.sius}" />
											<h:inputHidden id="siun" value="#{pickTaskMB.mbean.sina}" />
											<a4j:outputPanel rendered="#{pickTaskMB.commitStatus}">
												<img id="orid_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectUser();" />
											</a4j:outputPanel>
										</td>
										<td>
											<h:outputText value="仓库:"></h:outputText>
										</td>
										<td>
											<a4j:outputPanel id="showWaho">
												<h:selectOneMenu id="whid" value="#{pickTaskMB.mbean.whid}"
													disabled="#{!pickTaskMB.commitStatus}">
													<f:selectItems value="#{pickTaskMB.whidlist }" />
												</h:selectOneMenu>
											</a4j:outputPanel>
										</td>
									</tr>
									<tr>
										<td>
											<h:outputText value="备注:"></h:outputText>
										</td>
										<td colspan="3">
											<h:inputText id="rema" styleClass="datetime"
												disabled="#{!pickTaskMB.commitStatus}"
												value="#{pickTaskMB.mbean.rema}" size="80" />
										</td>
									</tr>
								</table>
							</a4j:outputPanel>
						</div>
						<div id=mmain_opt>
							<a4j:outputPanel id="detailbutton">
								<a4j:outputPanel
									rendered="#{pickTaskMB.MOD && pickTaskMB.commitStatus}">
									<a4j:commandButton id="addDBut" value="添加明細"
										onclick="showAddDetail();"
										onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										type="button" reRender="tableid,renderArea,output"
										rendered="#{pickTaskMB.ADD && pickTaskMB.commitStatus}"
										requestDelay="50" />
									<a4j:commandButton id="saveDBut" value="保存明细"
										onmouseover="this.className='a4j_over1'"
										rendered="#{pickTaskMB.MOD && pickTaskMB.commitStatus}"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										onclick="if(!updateDetail()){return false};" type="button"
										action="#{pickTaskMB.updateDetail}"
										reRender="renderArea,output,tableid"
										oncomplete="endUpdateDetail();" requestDelay="50" />
									<a4j:commandButton id="deleteDBut" value="刪除明細"
										onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										type="button" action="#{pickTaskMB.deleteDetail}"
										onclick="if(!delDetail(gtable)){return false};"
										reRender="renderArea,output,tableid"
										rendered="#{pickTaskMB.DEL && pickTaskMB.commitStatus}"
										oncomplete="endDelDetail();" requestDelay="50" />
									<a4j:commandButton id="delete0row" value="清除0数据行"
										onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										type="button" action="#{pickTaskMB.clearDetail}"
										onclick="if(!clearDetail()){return false};"
										reRender="renderArea,output,tableid"
										rendered="#{pickTaskMB.MOD && pickTaskMB.commitStatus}"
										oncomplete="endClearDetail();" requestDelay="50" />
									<a4j:commandButton id="refrechQty" value="刷为可备数量"
										onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										type="button" action="#{pickTaskMB.refrechQty}"
										onclick="if(!refrechQty()){return false};"
										reRender="renderArea,output,tableid"
										rendered="#{pickTaskMB.MOD && pickTaskMB.commitStatus}"
										oncomplete="endRefrechQty();" requestDelay="50" />
								</a4j:outputPanel>
							</a4j:outputPanel>
						</div>
						<!--
					<div id=mmain_cnd>
					<a4j:outputPanel id="input" >
						<a4j:outputPanel rendered="#{pickTaskMB.MOD && pickTaskMB.commitStatus}">
							<table>
								<tr>
									<td>
										<h:outputText value="商品属性:"></h:outputText>
									</td>
									<td width = "130px;">
										<h:selectOneRadio id="ch_dflag" value="01"  
											layout="lineDirection" onclick = "tobarcode();">
											<f:selectItem itemLabel="正品" itemValue="01" />
											<f:selectItem itemLabel="残品" itemValue="02" />
										</h:selectOneRadio>
									</td>
									<td>
										<h:outputText value="商品编码:"></h:outputText>
									</td>
									<td>
										<h:inputText id="inco"
										value="#{pickTaskMB.dbean.inco}" styleClass="datetime"
										size="16" onkeypress="clickInve();" />
										<img id="invcode_img" style="cursor: pointer" 
										src="../../images/find.gif" onclick="selectInveAdd();" />
									</td>
									<td>
										<h:outputText value="数量:"></h:outputText>
									</td>
									<td>
										<h:inputText id="qty" value="#{pickTaskMB.dbean.qty}"
											styleClass="datetime" size="16" />
									</td>
									<td>
										<h:outputText value="库位编码:"></h:outputText>
									</td>
									<td>
										<h:inputText id="dwhna" styleClass="datetime"
											value="#{pickTaskMB.dbean.whna}" disabled="false"/>
										<h:inputHidden id="dwhid" value="#{pickTaskMB.dbean.whid}"/>	
										<img id="whid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectWahod();" />		
									</td>
									</tr>
							</table>
						</a4j:outputPanel>
					</a4j:outputPanel>
					</div>
					-->
						<div>
							<a4j:outputPanel id="tableid">
								<g:GTable gid="gtable" gtype="grid" gdebug="true"
									gselectsql="select a.did,a.inco,case when k.qty is null then a.qty when k.qty is not null then k.qty end as qty,k.fqty,j.dqty,b.inna,b.inse,b.colo,k.whid     
											from ptde a left join inve b on a.inco = b.inco 
											left join (select h.inco,(h.qty-h.fqty-ISNULL(i.qty,0)) as dqty from ltdb h left join 
													(select g.inco,sum(qty) as qty from ptma f join ptde g on f.biid = g.biid 
													where f.soco = '#{pickTaskMB.mbean.soco}' and f.flag = '01' group by g.inco) i on h.inco = i.inco 
													where h.biid = '#{pickTaskMB.mbean.soco}') j on a.inco = j.inco
													left join pkln k on a.biid = k.biid and a.inco = k.inco
											Where a.biid = '#{pickTaskMB.mbean.biid}' "
									gpage="(pagesize = -1)" gversion="2"
									gupdate="(table = {ptde},tablepk = {did})"
									gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = checkbox);
										gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
										gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inna(headtext = 商品名称,name = inna,width = 170,align = left,type = text,headtype = sort ,datatype = string);
										gcid = colo(headtext = 规格,name = colo,width = 110,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inse(headtext = 规格码,name = inse,width = 90,align = left,type = text,headtype = sort ,datatype = string);
										gcid = qty(headtext = 数量,name = qty,width = 80,align = right,type = #{pickTaskMB.commitStatus ? 'input' : 'text' },headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event)&&onchange=textChange(this)});
										gcid = dqty(headtext =  待分配数量,name = dqty,width = 80,align = right,type = #{pickTaskMB.commitStatus ? 'text' : 'hidden' },headtype= sort, datatype =number,dataformat=0.##);
										gcid = fqty(headtext =  已完成数量,name = fqty,width = 80,align = right,type = #{pickTaskMB.commitStatus ? 'hidden' : 'text' },headtype= sort, datatype =number,dataformat=0.##);
										gcid = whid(headtext = 商品库位,name = whid,width = 90,align = left,type = text,headtype = sort ,datatype = string);
									" />
							</a4j:outputPanel>
						</div>
						<div style="display: none;">
							<a4j:outputPanel id="renderArea">
								<h:inputHidden id="msg" value="#{pickTaskMB.msg}" />
								<h:inputHidden id="roids" value="#{pickTaskMB.roids}" />
								<h:inputHidden id="filename" value="#{pickTaskMB.fileName}" />
								<h:inputHidden id="sellist" value="#{pickTaskMB.sellist}" />
								<h:inputHidden id="updatedata" value="#{pickTaskMB.updatedata}" />
								<a4j:commandButton id="refBut" value="刷新列表"
									style="display:none;" reRender="tableid,outdetail,head" />
								<a4j:commandButton id="showRe" value="刷新全部"
									style="display:none;" reRender="tableid,outdetail,head" />
								<a4j:commandButton onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									value="查询商品信息" type="button" action="#{pickTaskMB.selInveBut}"
									id="selInveBut" onclick="if(!selInveBut()){return false};"
									reRender="detailButton" oncomplete="endSelInveBut();"
									requestDelay="50" />
							</a4j:outputPanel>
						</div>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>