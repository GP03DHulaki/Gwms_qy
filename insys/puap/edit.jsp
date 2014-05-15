<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.PurchaseMB"%><%@ include
	file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>更新预约</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="添加预约">
		<script type="text/javascript" src="purchase.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
	</head>
	<%
	    PurchaseMB ai = (PurchaseMB) MBUtil.getManageBean("#{purchaseMB}");
	    ai.initMbean();
	%>
	<body id="mmain_body" onload="initEdit();">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;<a href="purchase.jsf"
				class="return" title="返回">采购预约</a>&gt;&gt;</font><b>更新采购预约</b>
			<br>
		</div>
		<div id="mmain">
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="showHeadButton">
							<a4j:commandButton value="添加预约" type="button"
								onmouseover="this.className='a4j_over1'"
								rendered="#{purchaseMB.ADD}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								oncomplete="addNew();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								rendered="#{purchaseMB.MOD&& purchaseMB.commitStatus}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="addId" value="保存单据" type="button"
								action="#{purchaseMB.updateHead}" reRender="msg,showHead"
								onclick="if(!addHead()){return false};"
								oncomplete="endAddHead();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{purchaseMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50"
								rendered="#{purchaseMB.DEL && purchaseMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								rendered="#{purchaseMB.APP&& purchaseMB.commitStatus}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="approve" value="审核单据" type="button"
								action="#{purchaseMB.approveVouch}"
								reRender="msg,showHead,showHeadButton,renderArea,detailButton"
								onclick="if(!approveAddHead()){return false};"
								oncomplete="approveEndAddHead();" requestDelay="50" />
							<a4j:commandButton rendered="#{purchaseMB.MOD}" id="search"
								action="#{purchaseMB.searchAppoint}" style="display:none;"
								onclick="startDo();" reRender="msg,output" requestDelay="50"
								oncomplete="searchComplete()" />
							<a4j:commandButton
								rendered="#{purchaseMB.MOD&&!purchaseMB.commitStatus && false }"
								id="complete" value="预约完成" action="#{purchaseMB.complete}"
								onclick="if(!comPur()){return false};" oncomplete="endComPur();"
								styleClass="a4j_but1" reRender="msg,output" requestDelay="50" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
							<a4j:commandButton id="closeDBut" value="预约单关闭"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" type="button"
									action="#{purchaseMB.closeOrder}"
									reRender="renderArea,output" oncomplete="endDeleteHead();"
									requestDelay="50" />	
						</a4j:outputPanel>
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="showHead">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="预约单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{purchaseMB.mbean.biid}" disabled="true" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="供应商名称:"></h:outputText>
									</td>
									<td>
										<h:inputText id="suna" styleClass="datetime"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;"
											value="#{purchaseMB.mbean.ceve}" />
										<h:inputHidden id="suid" value="#{purchaseMB.mbean.suid}" />
									</td>
									<td>
										<h:outputText value="预约到货时间:"></h:outputText>
									</td>
									<td>
										<h:inputText id="pcdt" styleClass="datetime" size="15"
											value="#{purchaseMB.mbean.pcdt}"
											onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH'});" />
										时
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											value="#{purchaseMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
						<div>
							<a4j:outputPanel id="detailButton">
								<a4j:commandButton id="addDButs" value="添加明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" reRender="renderArea,output,detailButton"
									onclick="openDetail();" oncomplete="closeDetail();"
									action="#{purchaseMB.clearList}"
									rendered="#{purchaseMB.ADD && purchaseMB.commitStatus}"
									requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除明細"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{purchaseMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,detailButton"
									rendered="#{purchaseMB.MOD && purchaseMB.commitStatus}"
									oncomplete="endDelDetail();" requestDelay="50" />
								<a4j:commandButton id="saveDBut" value="保存明细"
									onmouseover="this.className='a4j_over1'"
									rendered="#{purchaseMB.MOD && purchaseMB.commitStatus}"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!updateDetail()){return false};" type="button"
									action="#{purchaseMB.updateDetail}"
									reRender="renderArea,output" oncomplete="endUpdateDetail();"
									requestDelay="50" />									
								<a4j:commandButton id="createBar" value="生成条码"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									onclick="if(!createBar()){return false};" type="button"
									action="#{purchaseMB.createBar}" reRender="renderArea,output"
									oncomplete="endCreateBar();" requestDelay="50"
									rendered="#{purchaseMB.MOD && !purchaseMB.commitStatus && false}" />
							</a4j:outputPanel>
							<a4j:outputPanel id="output">
								<%
								    //可预约数=总数-到货数量(单据状态为31：已添加完成)，-已预约数量(<31)+本次已预约数量
								%><g:GTable gid="gtable" gtype="grid"
									gselectsql=" 
										select e.colo,e.inse,d.did,d.roid,a.biid AS soco,c.ceve,a.inco,b.pudt,ISNULL(a.qty,0) AS bqty,a.yqty,a.dqty,a.rqty,d.qty
										,case when a.rqty>0 and a.dqty=0 then a.qty-a.rqty
										when a.rqty=0 and a.dqty>0 then a.qty-a.dqty
										when a.rqty>0 and a.dqty>0 then a.qty-a.dqty
										when a.rqty=0 and a.dqty=0 then a.qty-a.yqty
										else a.qty end as UYqty
										,b.rema
										from pubd a 
										join cpbd d ON a.biid=d.soco and LTRIM(RTRIM(a.inco)) = LTRIM(RTRIM(d.inco))
										join pubm b on a.biid=b.biid 
										join suin c on b.suid=c.suid		
										join inve e on a.inco = e.inco
										where d.biid='#{purchaseMB.mbean.biid}'										
										"
									gupdate="(table = {cpbd},tablepk = {did})"
									gpage="(pagesize = 20)" gversion="2" gdebug="false"
									gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = checkbox);
									gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
									gcid = roid(headtext = 行,name = roid,type = text,headtype = hidden,datatype = string);
									gcid = soco(headtext = 采购订单号,name = biids,width = 0,align = left,type = text,headtype = hidden,datatype = string);
									gcid = soco(headtext = 采购订单号,name = biid,width = 110,align = left,type = text,headtype = sort,datatype = string,update=edit);
									gcid = ceve(headtext = 供应商名称,name = ceve,width = 140,align = left,type = text,headtype = hidden,datatype = string);
									gcid = inco(headtext = 商品编码,name = inco,width = 110,align = left,type = text,datatype = string,update=edit,headtype = sort);
									gcid = colo(headtext = 规格,name = colo,width = 60,align = left,type = text,headtype = sort,datatype = string);
									gcid = inse(headtext = 规格码,name = inseo,width = 50,align = left,type = text,headtype = sort,datatype = string);
									gcid = pudt(headtext = 采购时间,name = pudt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
									gcid = bqty(headtext =  计划数量,name = aqty,width = 70,align = right,type =text,headtype= sort, datatype =number,dataformat=0.##);
									gcid = dqty(headtext =  已到货,name = dqty,width = 70,align = right,type =text,headtype= sort, datatype =number,dataformat=0.##);
									gcid = rqty(headtext =  已入库,name = rqty,width = 70,align = right,type =text,headtype= sort, datatype =number,dataformat=0.##);
									gcid = yqty(headtext =  已预约,name = yqty,width = 70,align = right,type =text,headtype= sort, datatype =number,dataformat=0.##);
									gcid = UYqty(headtext =  可预约数,name = UYqty,width = 70,align = right,type =text,headtype= sort, datatype =number,dataformat=0.##);
									gcid = qty(headtext =  预约到货,name = qty,width = 70,align = right,type =input,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
									gcid = rema(headtext = 备注,name = rema,width = 120,align = left,type = text,headtype = sort,datatype = string);
								" />
							</a4j:outputPanel>
						</div>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{purchaseMB.msg}" />
							<h:inputHidden id="roids" value="#{purchaseMB.roids}" />
							<h:inputHidden id="sellist" value="#{purchaseMB.sellist}" />
							<h:inputHidden id="updatedata" value="#{purchaseMB.updatedata}" />
							<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
								reRender="output" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>