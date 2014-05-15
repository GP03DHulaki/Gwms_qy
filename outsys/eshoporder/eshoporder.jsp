<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.view.EshopOrderMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title>电商未出订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="电商未出订单">
		<meta http-equiv="description" content="电商未出订单">
		<script type="text/javascript" src="eshoporder.js"></script>

	</head>
	<%
		EshopOrderMB ai = (EshopOrderMB) MBUtil.getManageBean("#{eshopOrderMB}");
		if (request.getParameter("isAll") != null) {
			ai.initSK();
		}
	%>
	<f:view>
		<body id="mmain_body">
			<h:form id="list">
				<div id="mmain_nav">
					<font color="#000000">出库处理&gt;&gt;</font><b>电商未出订单</b>
					<br>
				</div>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{eshopOrderMB.msg}" />
						<h:inputHidden id="sellist" value="#{eshopOrderMB.sellist}" />
						<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
							reRender="output" />
						<a4j:commandButton id="showRe" value="刷新全部" style="display:none;"
							reRender="output" />
					</a4j:outputPanel>
				</div>
				<div id="mmain">
					<div id="mmain_opt">
						<a4j:commandButton value="新增"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							action="#{eshopOrderMB.clearMBean}" onclick="addDiv();"
							id="addHead" rendered="#{eshopOrderMB.ADD}" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除" type="button"
							onclick="if(!deleteAll(gtable)){return false};"
							rendered="#{eshopOrderMB.DEL}" reRender="output,renderArea"
							action="#{eshopOrderMB.deleteHead}"
							oncomplete="endDeleteHeadAll();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							value="查询" type="button" reRender="output" id="sid"
							oncomplete="Gwallwin.winShowmask('FALSE');"
							action="#{eshopOrderMB.search}" requestDelay="50"
							onclick="startDo();" rendered="#{eshopOrderMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							onclick="clearSearchKey('0');" rendered="#{eshopOrderMB.LST}" />
					</div>
					<div id=mmain_cnd>
						创建日期从:
						<h:inputText id="sk_start_date" styleClass="datetime" size="10"
							value="#{eshopOrderMB.sk_start_date}"
							onfocus="#{gmanage.datePicker}"
							onkeypress="formsubmit(event);" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="10"
							value="#{eshopOrderMB.sk_end_date}"
							onfocus="#{gmanage.datePicker}"
							onkeypress="formsubmit(event);" />
						出库订单号:
						<h:inputText id="sk_soco" styleClass="datetime" size="15"
							value="#{eshopOrderMB.sk_obj.soco}"
							onkeypress="formsubmit(event);" />
						客户名称:
						<h:inputText id="cuna" styleClass="datetime" size="20"
							value="#{eshopOrderMB.cuna}" onkeypress="formsubmit(event);" />
						创建人:
						<h:inputText id="sk_crna" styleClass="datetime" size="12"
							value="#{eshopOrderMB.sk_obj.crna}"
							onkeypress="formsubmit(event);" />
						单据状态:
						<h:selectOneMenu id="sk_flag" value="#{eshopOrderMB.sk_obj.stat}"
							rendered="true" onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItems value="#{eshopOrderMB.flags}" />
						</h:selectOneMenu>
						组织架构:
						<h:selectOneMenu id="orid" value="#{eshopOrderMB.orid}"
							onchange="doSearch();">
							<f:selectItem itemLabel="" itemValue="" />
							<f:selectItems value="#{OrgaMB.subList}" />
						</h:selectOneMenu>

					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="SELECT a.id,a.soty,a.soco,a.cuid,u.cuna,a.orid,a.crus,a.crna,a.opna,a.crdt,a.chus,a.chna,g.orna,a.chdt,a.stat,a.rema
	 					 FROM obbm a left join orga g on g.orid = a.orid 
	 					 left join cuin u on u.cuid = a.cuid
	 					 WHERE 1 = 1 #{eshopOrderMB.searchSQL}"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 20,align = center,type = checkbox,headtype = checkbox);
						gcid = 0(headtext = 行号,name = rowid,width = 35,align = center,type = text,headtype = text,datatype = string);
						gcid = orna(headtext = 组织架构,name = orna,width = 110,headtype = sort,align = center,type = text,datatype=string);
						gcid = soty(headtext = 业务来源,name = soty,width = 80,align = center,type = mask,headtype = sort,datatype = string typevalue=OUTORDER:出库订单);
						gcid = soco(headtext = 订单编号,name = soco,width = 110,headtype = sort,align = center,type = text,datatype=string);
						gcid = cuna(headtext = 客户名称,name = cuna,width = 150,headtype = sort,align = center,type = text,datatype=string);
						gcid = crna(headtext = 创建人,name = crna,width = 90,align = center,type = text,headtype = sort,datatype = string);
						gcid = crdt(headtext = 创建时间,name = crdt,width = 120,align = center,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
						gcid = opna(headtext = 经手人,name = opna,width = 90,align = center,type = text,headtype = sort,datatype = string);
						gcid = stat(headtext = 状态,name = flag,width = 70,align = center,type = mask,typevalue=1:制作之中/11:正式单据,headtype = sort,datatype = string);
						gcid = rema(headtext = 备注,name = rema,width = 150,align = left,type = text,headtype = sort,datatype = string);
					" />
					</a4j:outputPanel>
			</h:form>
			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{eshopOrderMB.getVouch}" reRender="showHead"
							oncomplete="edit_show();" requestDelay="50" />
						<h:inputHidden id="selid" value="#{eshopOrderMB.selid}" />
						<h:inputHidden id="updateflag" value="#{eshopOrderMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="showHead">
						<table border="0" cellspacing="0" cellpadding="1">
							<tr>
								<td>
									&nbsp;&nbsp;
									<h:outputText value="业务类型:"></h:outputText>
								</td>
								<td>
									<h:selectOneMenu id="soty" value="#{eshopOrderMB.mbean.soty}">
										<f:selectItem itemLabel="出库订单" itemValue="OUTORDER" />
									</h:selectOneMenu>
								</td>
								<td>
									<h:outputText value="来源单号:"></h:outputText>
								</td>
								<td>
									<h:inputText id="soco" styleClass="inputtext" size="15"
										value="#{eshopOrderMB.mbean.soco}" />
									<h:inputHidden id="whid" value="#{eshopOrderMB.mbean.whid}" />
									<img id="whid_img" style="cursor: hand"
										src="../../images/find.gif" onclick="selectOrder();" />
								</td>
							</tr>
							<tr>
								<td>
									&nbsp;&nbsp;
									<h:outputText value="创建人编码:"></h:outputText>
								</td>
								<td>
									<h:inputText id="crus" styleClass="inputtext" size="15"
										value="#{eshopOrderMB.mbean.crus}" />
								</td>
								<td>
									<h:outputText value="经手人:"></h:outputText>
								</td>
								<td>
									<h:inputText id="opna" styleClass="inputtext" size="15"
										value="#{eshopOrderMB.mbean.opna}" />
								</td>
							</tr>
							<tr>
								<td>
									&nbsp;&nbsp;
									<h:outputText value="创建人姓名:"></h:outputText>
								</td>
								<td colspan="3">
									<h:inputText id="crna" styleClass="datetime"
										value="#{eshopOrderMB.mbean.crna}" size="60" />
								</td>
							</tr>
							<tr>
								<td>
									&nbsp;&nbsp;
									<h:outputText value="备注:"></h:outputText>
								</td>
								<td colspan="3">
									<h:inputText id="rema" styleClass="datetime"
										value="#{eshopOrderMB.mbean.rema}" size="60" />
								</td>
							</tr>
							<tr>
								<td>
									&nbsp;&nbsp;
									<a4j:commandButton onmouseover="this.className='a4j_over'"
										rendered="#{eshopOrderMB.ADD}"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										id="addId" value="保存" type="button"
										action="#{eshopOrderMB.addHead}"
										reRender="msg,renderArea,output"
										onclick="if(!addHead()){return false};"
										oncomplete="endHeadAdd();" requestDelay="50" />
								</td>

							</tr>
						</table>
					</a4j:outputPanel>
					<div style="display: none;">
					</div>
				</h:form>
			</div>
		</body>
	</f:view>
</html>