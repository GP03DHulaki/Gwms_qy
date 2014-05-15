<%@ include file="../../include/include_imp.jsp" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.StockOutMB"%>

<%
	StockOutMB ai = (StockOutMB) MBUtil.getManageBean("#{stockOutMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>出库单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="出库单">
		<script type="text/javascript" src="stockout.js"></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">出库处理&gt;&gt;</font><b>出库单</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<gw:GAjaxButton value="添加单据" theme="b_theme"
							action="#{stockOutMB.clearMBean}" oncomplete="addNew();"
							id="addHead" rendered="#{stockOutMB.ADD}" />

						<gw:GAjaxButton value="删除单据" theme="b_theme"
							action="#{stockOutMB.deleteHead}" id="deleteId"
							onclick="if(!deleteHeadAll(gtable)){return false};"
							reRender="output,renderArea" oncomplete="endDeleteHeadAll();"
							requestDelay="50" rendered="#{stockOutMB.DEL}" />

						<a4j:outputPanel id="queryButs" rendered="#{stockOutMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{stockOutMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','sk_biid,sk_soco,sk_flag,start_date,sk_inco,end_date,crna,orid,cuna,ck_start_date,ck_end_date');" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{stockOutMB.LST}">
						<div id="mmain_cnd">
							订单日期从:
							<h:inputText id="start_date" styleClass="datetime" size="15"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{stockOutMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="15"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{stockOutMB.sk_end_date}" />
							审核时间:
							<h:inputText id="ck_start_date" styleClass="datetime" size="15"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{stockOutMB.ck_start_date}" />
							至:
							<h:inputText id="ck_end_date" styleClass="datetime" size="15"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{stockOutMB.ck_end_date}" />
							出库单号:
							<h:inputText id="sk_biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{stockOutMB.sk_obj.biid}" />
							来源单号:
							<h:inputText id="sk_soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{stockOutMB.sk_obj.soco}" />
							<h:outputText value="物料编码:">
							</h:outputText>
							<h:inputText id="sk_inco" styleClass="datetime" size="15"
								value="#{stockOutMB.sk_inco}" onkeypress="formsubmit(event);" /><br>
								<!-- 客户名称:
							<h:inputText id="cuna" styleClass="inputtext" size="20"
								onkeypress="formsubmit(event);" value="#{stockOutMB.cuna}" /> -->
							
							<h:outputText value="状态:" rendered="true" />
							<h:selectOneMenu id="sk_flag" value="#{stockOutMB.sk_obj.flag}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{stockOutMB.flags}" />
							</h:selectOneMenu>							
							<h:outputText value="制单人:">
							</h:outputText>
							<h:inputText id="crna" styleClass="inputtext" size="12"
								onkeypress="formsubmit(event);"
								value="#{stockOutMB.sk_obj.crna}" />
							组织架构:
							<h:selectOneMenu id="orid" value="#{stockOutMB.orid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
							<h:outputText value="仓库:" ></h:outputText>
							<h:selectOneMenu id="sk_whid" value="#{stockOutMB.sk_obj.whid}"
								style="width:130px;">
								<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT a.id,a.biid,a.flag,a.crus,a.crna,a.chus,a.chna,a.prnm,
											a.crdt,a.chdt,a.orid,c.whna,a.soty,a.stat,a.rema,u.cuna,a.soco,b.orna,
											(select top 1 inco from olde where biid=a.biid) as inco,a.gddt
											 FROM olma a
											join orga b on b.orid=a.orid
											 left join obma m on m.biid = a.soco
											 left join cuin u on u.cuid = m.cuid
											 LEFT JOIN waho c ON a.whid = c.whid
											WHERE a.#{stockOutMB.gorgaSql} #{stockOutMB.searchSQL}
											"
										gpage="(pagesize = 20)"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 出库单号,name = hid_biid,width = 0,headtype = hidden,align = left,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 90,headtype = sort,align = left,type = text,datatype=string);
											gcid = whna(headtext = 出库仓库,name = whna,width = 110,align = left,type = text,headtype = sort,datatype = string);
											gcid = biid(headtext = 出库单号,name = biid,width = 110,headtype = sort,align = left,type = link,datatype=string,linktype = script,typevalue = javascript:Edit('gcolumn[biid]'));
											gcid = flag(headtext = 状态,name = flag,width = 65,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:关闭单据,headtype = sort,datatype = string);
											gcid = soty(headtext = 来源类型,name = soty,width = 70,align = center,type = mask,typevalue=OUTORDER:出库订单/ENTRUCKPLAN:备货计划,headtype = sort,datatype = string);
											gcid = soco(headtext = 来源单号,name = soco,width = 150,headtype = sort,align = left,type = text,datatype=string);
											gcid = inco(headtext = 物料编码,name = inco,width = 110,headtype = sort,align = left,type = text,datatype=string);
											gcid = cuna(headtext = 客户名称,name = cuna,width = 110,headtype = hidden,align = left,type = text,datatype=string);
											gcid = crna(headtext = 创建人,name = crna,width = 60,align = left,type = text,headtype = sort,datatype = string);
											gcid = gddt(headtext = 过账时间,name = gddt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = crdt(headtext = 创建时间,name = crdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = chna(headtext = 审核人,name = chna,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = rema(headtext = 备注,name = rema,width = 150,headtype = sort,align = left,type = text,datatype=string);
											gcid = prnm(headtext = 打印次数,name = prnm,width = 50,headtype = hidden,align = center,type = text,datatype=number,dataformat={0},bgcolor={gcolumn[prnm]>0:#ffff00});
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{stockOutMB.msg}" />
							<h:inputHidden id="sellist" value="#{stockOutMB.sellist}" />
							<h:inputHidden id="biid" value="#{stockOutMB.mbean.biid}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='stockout_edit.jsf'"
							style="display:none;" />
					</div>
				</h:form>

			</f:view>
		</div>
	</body>
</html>