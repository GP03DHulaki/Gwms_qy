<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.util.MBUtil"%>
<%@ page import="com.gwall.view.PackagingMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
	PackagingMB ai = (PackagingMB) MBUtil.getManageBean("#{packagingMB}");
	ai.getVouch();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>打包</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="打包">
		<meta http-equiv="description" content="打包">
		<script type="text/javascript" src="packaging.js"></script>
	</head>
	<body id="mmain_body" onload="initEdit();">
	<f:view> 
		<div id=mmain_nav>
			<a id="linkid" href="packaging.jsf" class="return" title="返回">出库处理</a>&gt;&gt;
			<b>编辑打包单</b>
			<br>
		</div>
		
			<h:form id="edit">
				<div id="mmain">
					<div id=mmain_opt>
						<a4j:outputPanel id="showHeadButton">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								oncomplete="addNew();" action="#{packagingMB.clearMBean}"
								id="addHead" rendered="#{packagingMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{packagingMB.updateHead}"
								onclick="if(!addHead()){return false};"
								reRender="output,renderArea,orderTable,head" requestDelay="50"
								rendered="#{packagingMB.MOD&& packagingMB.commitStatus}"
								oncomplete="endDo();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{packagingMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								reRender="output,renderArea" oncomplete="endDeleteHead();"
								requestDelay="50"
								rendered="#{packagingMB.DEL&& packagingMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="if(!checkApp()){return false};" value="审核单据"
								rendered="#{packagingMB.APP&& packagingMB.commitStatus}"
								action="#{packagingMB.approveVouch}" id="submitMBut"
								reRender="showHeadButton,renderArea,output,orderTable,detailButton,showHead"
								oncomplete="endApp();" requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="headmain">
							<table cellpadding="3" cellspacing="0" border="0">
								<tr>
									<td>
										<h:outputText value="单据单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime" size="15"
											value="#{packagingMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="业务类型:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="soty" value="#{packagingMB.mbean.soty}"
											>
											<f:selectItem itemLabel="出库订单" itemValue="OUTORDER" />
										</h:selectOneMenu>
									</td>
									<td>
										来源单号:
									</td>
									<td>
										<h:inputText id="soco" styleClass="inputtext" size="15"
											value="#{packagingMB.mbean.soco}" disabled="true" />

									</td>
								</tr>
								<tr>
									<td>
										创建人编码:
									</td>
									<td>
										<h:inputText id="crus" styleClass="inputtext" size="15"
											value="#{packagingMB.mbean.crus}"
											disabled="#{packagingMB.commitStatus}" />
									</td>
									<td>
										经手人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="15"
											value="#{packagingMB.mbean.opna}" />
									</td>
									<td>
										创建人姓名:
									</td>
									<td>
										<h:inputText id="crna" styleClass="inputtext" size="15"
											value="#{packagingMB.mbean.crna}"
											disabled="#{packagingMB.commitStatus}" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="datetime"
											value="#{packagingMB.mbean.rema}" size="80" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="vertical-align: top;"></div>
					<SPAN ID="detail_ctrl" class="ctrl_show"
						onclick="JS_ExtraFunction();"></SPAN>
					<font color="#4990dd" style="font-weight: bolder; cursor: pointer"
						onclick="JS_ExtraFunction();">订单列表:</font>
					<div id="ExtraFunction" style="display: none;">
						<a4j:outputPanel id="countPage">
							<iframe frameborder="0" src="materiallist.jsf" width="100%">
							</iframe>
						</a4j:outputPanel>
					</div>
					<div id=mmain_cnd>
						<font color="#4990dd" style="font-weight: bolder; cursor: hand">打包单明细:</font>
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
							<a4j:outputPanel id="detailButton">
							<div id="mmain_opt">
								<a4j:commandButton id="addDBut" value="添加包明细"
									onclick="if(!addDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{packagingMB.addDetail}"
									reRender="renderArea,output,orderTable"
									rendered="#{packagingMB.MOD && packagingMB.commitStatus && false}"
									oncomplete="endAddDetail();" requestDelay="50" />
								<a4j:commandButton id="addDButs" value="添加包明细"
									onclick="showAddDetail();window.reload;"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" reRender="renderArea,output,orderTable"
									rendered="#{packagingMB.MOD && packagingMB.commitStatus}"
									requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除包明细"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{packagingMB.deleteDetail}"
									onclick="if(!delDetail(gtable)){return false};"
									reRender="renderArea,output,orderTable"
									rendered="#{packagingMB.DEL && packagingMB.commitStatus}"
									oncomplete="endDeleleDetail();" requestDelay="50" />
						
							</div>
						</a4j:outputPanel>
							<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql=" SELECT a.did,a.biid,a.boco,a.inco,a.qty,a.stat,i.inna,i.colo,i.inst
	    							FROM gpad a  join inve i on a.inco = i.inco   WHERE (a.boco  is not null) and  a.biid = '#{packagingMB.mbean.biid}' "
								gpage="(pagesize = -1)" gversion="2"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox ,headtype = checkbox);
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = boco(headtext = 包编号,name = boco,width = 150,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inco(headtext = 物料编码,name = inco,width = 150,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inna(headtext = 物料名称,name = inna,width = 200,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inst(headtext = 规格,name = inst,width = 100,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext =  打包数量,name = qty,width = 70,align = right,type ='text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
									gcid = stat(headtext = 包装方式,name = stat,width = 70,headtype= hidden,align = center,type = mask,typevalue=1:大纸箱/2:中纸箱/3:小纸箱/4:大编织袋/5:中编织袋/6:小编织袋/7:其他大件/8:其他中件/9:其他小件,headtype = sort,datatype = string);
								" />
						</a4j:outputPanel>
					</div>
						</td>
						
					</tr>
				</table>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{packagingMB.msg}" />
							<h:inputHidden id="sellist" value="#{packagingMB.sellist}" />
							<h:inputHidden id="selqtys" value="#{packagingMB.selqtys}" />
							<h:inputHidden id="filename" value="#{packagingMB.fileName}" />
							<h:inputHidden id="updatedata" value="#{packagingMB.updatedata}" />
							<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
							reRender="orderTable" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="查询物料信息" type="button" action="#{packagingMB.selInveBut}"
								id="selInveBut" onclick="if(!selInveBut()){return false};"
								reRender="detailButton" oncomplete="endSelInveBut();"
								requestDelay="50" />
							
					</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>