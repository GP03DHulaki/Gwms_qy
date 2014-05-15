<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.OutOrderMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
	OutOrderMB ai = (OutOrderMB) MBUtil.getManageBean("#{outOrderMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>出库订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="出库订单">
		<script type="text/javascript" src="outorder.js"></script>
	</head>
	<body id='mmain_body' onload='clearSearchKey();'>
		<div id='mmain_nav'>
			<font color="#000000">出库处理&gt;&gt;</font><font color="#000000"><a href="outorder.jsf"><b>出库订单</b></a></font>&gt;&gt;<b>合并订单</b>
			<br>
		</div>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id='mmain_opt'>
					<a4j:outputPanel id="queryButs" rendered="#{outOrderMB.LST}">
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
							reRender="output" action="#{outOrderMB.search}" />
						<a4j:commandButton type="button" value="重置" onclick="clearSearchKey();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
						    value="合并" type="button" onclick="if(!merger('gtable')){return false};"
						   oncomplete="finishMergerOrder();"
						    rendered="#{outOrderMB.SPE}"
						    action="#{outOrderMB.mergerorder}"
							reRender="output,renderArea,msg" requestDelay="50" />
					</a4j:outputPanel>	
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{outOrderMB.LST}">
						<div id="mmain_cnd">
							订单日期从:
							<h:inputText id="start_date" styleClass="datetime" size="10"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{outOrderMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="10"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{outOrderMB.sk_end_date}" />
							审核日期从:
							<h:inputText id="sk_chdt_start" styleClass="datetime" size="10"
								value="#{outOrderMB.sk_chdt_start}" onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_chdt_end" styleClass="datetime" size="10"
							value="#{outOrderMB.sk_chdt_end}" onfocus="#{gmanage.datePicker}" />
							出库单号:
							<h:inputText id="sk_biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{outOrderMB.sk_obj.biid}" />
							来源单号:
							<h:inputText id="sk_soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{outOrderMB.sk_obj.soco}" />
							<br>
							客户名称:
							<h:inputText id="sk_cuid" styleClass="inputtext" size="12"
								onkeypress="formsubmit(event);"
								value="#{outOrderMB.sk_obj.cuna}" />
							
							<h:outputText value="制单人:">
							</h:outputText>
							<h:inputText id="crna" styleClass="inputtext" size="15"
									onkeypress="formsubmit(event);" value="#{outOrderMB.sk_obj.crna}" />
							<h:outputText value="组织架构:" >
							</h:outputText>
							<h:selectOneMenu id="orid" value="#{outOrderMB.sk_obj.orid}" onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>	
							<h:outputText value="状态:" rendered="true" />
							<h:selectOneMenu id="sk_flag" value="#{outOrderMB.sk_obj.flag}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="制作之中" itemValue="01" />
								<f:selectItem itemLabel="文员审核" itemValue="08" />
								<f:selectItem itemLabel="正式单据" itemValue="11" />
								<f:selectItem itemLabel="计划装车" itemValue="15" />
								<f:selectItem itemLabel="分拣中" itemValue="16" />
								<f:selectItem itemLabel="分拣完成" itemValue="17" />
								<f:selectItem itemLabel="装车中" itemValue="19" />
								<f:selectItem itemLabel="出库中" itemValue="21" />
								<f:selectItem itemLabel="已完成" itemValue="31" />
								<f:selectItem itemLabel="已关闭" itemValue="100" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false" gsort="rena" gsortmethod="desc"
										gselectsql="
											SELECT a.id,d.orna,a.bity,a.biid,a.soco,b.cuna,a.cbid,a.crna,a.crdt,a.chna,a.chdt,a.flag,m.cuna as finna,
											a.rema, n.rena,n.rsad FROM obma a LEFT JOIN cuin b ON a.cuid=b.cuid left join cuin m on m.cuid = a.fina
											join noin n on n.biid= a.biid
											right join  
											(SELECT  rena,rsad FROM noin where isnull(ised,'0')< '1'  GROUP BY rena,rsad HAVING COUNT(rena) >1) c ON n.rena = c.rena AND n.rsad = c.rsad
											left join orga d on a.orid=d.orid where a.flag in('01','11') and a.bity IN ('EBUS','import') and a.#{outOrderMB.gorgaSql} #{outOrderMB.searchSQL}"
										gpage="(pagesize = 20)"
										gcolumn="gcid = biid(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = biid(headtext = 出库订单,name = biid,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = bity(headtext = 订单类型,name = flag,width = 60,align = center,type = mask,typevalue=import:Excel导入/EBUS:淘宝下载,headtype = sort,datatype = string);
											gcid = soco(headtext = 来源单据,name = soco,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = cuna(headtext = 客户名称,name = cuna,width = 150,headtype = sort,align = left,type = text,datatype=string);
											gcid = finna(headtext = 最终客户,name = cuna,width = 150,headtype = sort,align = left,type = text,datatype=string);
											gcid = crna(headtext = 制单人,name = crna,width = 50,headtype = sort,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 订单时间,name = crdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = chna(headtext = 审核人,name = chna,width = 50,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = rena(headtext = 收件人,name = rema,width = 50,headtype = sort,align = left,type = text,datatype=string);
											gcid = rsad(headtext = 收件人地址,name = rsad,width = 130,headtype = sort,align = left,type = text,datatype=string);
											gcid = flag(headtext = 状态,name = flag,width = 60,align = center,type = mask,typevalue=01:制作之中/08:文员审核/11:正式单据/21:出库中/15:计划装车/16:分拣中/17:分拣完成/31:已完成/19:装车中/100:已关闭,headtype = sort,datatype = string);
											gcid = rema(headtext = 备注,name = rema,width = 130,headtype = sort,align = left,type = text,datatype=string);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{outOrderMB.msg}" />
							<h:inputHidden id="orderlist" value="#{outOrderMB.orderlist}" />
							<h:inputHidden id="biid" value="#{outOrderMB.mbean.biid}" />
							<h:inputHidden id="gsql" value="#{outOrderMB.gsql}" />
							<h:inputHidden id="outPutFileName" value="#{outOrderMB.outPutFileName}" />
						</a4j:outputPanel>
					</div>
				</h:form>

				<div id="errmsg" style="display: none">
					<div id=mmain_cnd>
						<span id="mes"></span>
						<div align="center">
							<button type="button" onclick="Gwallwin.winClose();"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" class="a4j_but">
								关闭
							</button>
						</div>
					</div>
				</div>

			</f:view>
		</div>
	</body>
</html>