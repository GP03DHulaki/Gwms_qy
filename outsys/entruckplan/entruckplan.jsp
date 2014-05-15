<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.EntruckPlanMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	EntruckPlanMB ai = (EntruckPlanMB) MBUtil
			.getManageBean("#{entruckPlanMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>备货计划单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="备货计划单">
		<script type="text/javascript" src="entruckplan.js"></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">出库处理&gt;&gt;</font>装车处理&gt;&gt;
			<b>备货计划</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{entruckPlanMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{entruckPlanMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','sk_biid,sk_soco,sk_flag,start_date,end_date,orid');" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{entruckPlanMB.LST}">
						<div id="mmain_cnd">
							创建日期从:
							<h:inputText id="start_date" styleClass="datetime" size="10"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{entruckPlanMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="10"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{entruckPlanMB.sk_end_date}" />
							备货计划单:
							<h:inputText id="sk_biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{entruckPlanMB.sk_obj.biid}" />
							来源单号:
							<h:inputText id="sk_soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{entruckPlanMB.sk_obj.soco}" />
							<h:outputText value="状态:" rendered="true" />
							<h:selectOneMenu id="sk_flag"
								value="#{entruckPlanMB.sk_obj.flag}" rendered="true"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="制作之中" itemValue="01" />
								<f:selectItem itemLabel="正式单据" itemValue="11" />
								<f:selectItem itemLabel="备货调度中" itemValue="21" />
								<f:selectItem itemLabel="完成调度" itemValue="31" />
								<f:selectItem itemLabel="已关闭" itemValue="100" />
							</h:selectOneMenu>
							组织架构:
							<h:selectOneMenu id="orid" value="#{entruckPlanMB.sk_obj.orid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT a.biid,a.id,a.flag,a.crus,a.crna,a.chus,a.chna,a.crdt,a.tale,
											a.chdt,a.orid,a.soty,a.stat,a.rema,a.tavo,a.tawe,b.orna,a.lpco,c.lpna,
											(SELECT COUNT(DISTINCT oubi) FROM ltde WHERE biid=a.biid) AS vcount,  
											SUM(d.qty) AS sqty,a.inty,e.lina,a.bity
											FROM ltma a join orga b on b.orid=a.orid
											left join lpin c on a.lpco=c.lpco
											join ltde d on a.biid=d.biid
											LEFT JOIN liin e on a.lico=e.lico
											WHERE a.#{entruckPlanMB.gorgaSql} #{entruckPlanMB.searchSQL}
											group by a.biid,a.id,a.flag,a.crus,a.crna,a.chus,a.chna,a.crdt,
											a.chdt,a.orid,a.soty,a.stat,a.rema,a.tavo,a.tawe,b.orna,a.lpco,c.lpna,a.inty,e.lina,a.tale,a.bity
											"
										gpage="(pagesize = 20)"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 备货计划单,name = hid_biid,width = 0,headtype = hidden,align = left,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = biid(headtext = 备货计划单,name = biid,width = 110,headtype = sort,align = left,type = link,datatype=string,linktype = script,typevalue = javascript:Edit('gcolumn[biid]'));
											gcid = bity(headtext = 所属平台,name = bity,width = 60,align = center,type = mask,typevalue=H:非平台/5:京东/6:当当/12:凡客/E:跳过补货,headtype = sort,datatype = string);
											gcid = lpna(headtext = 承运商,name = lpna,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = lina(headtext = 发货地区,name = lina,width = 65,headtype = sort,align = left,type = text,datatype=string);
											gcid = inty(headtext = 是否单品,name = inty,width = 60,align = center,type = mask,typevalue=M:一单多货/O:一单多货/S:一单一货,headtype = sort,datatype = string);
											gcid = flag(headtext = 状态,name = flag,width = 65,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:备货调度中/31:完成调度/100:已关闭,headtype = sort,datatype = string);
											gcid = tale(headtext = 是否紧急,name = tale,width = 65,align = center,type = mask,typevalue=0:/1:紧急,headtype = sort,datatype = string);
											gcid = soty(headtext = 来源类型,name = soty,width = 60,align = center,type = mask,typevalue=OUTORDER:出库订单/PURCHASERETURNPLAN:采购退货/TRANPLAN:调拨计划,headtype = sort,datatype = string);
											gcid = tavo(headtext = 总体积,name = tavo,width = 60,headtype = hidden,align = left,type = text,datatype=number,dataformat={0.##});
											gcid = tawe(headtext = 总重量,name = tawe,width = 60,headtype = hidden,align = left,type = text,datatype=number,dataformat={0.##});
											gcid = vcount(headtext = 订单总数,name = vcount,width = 60,headtype = sort,align = left,type = text,datatype=number,dataformat={0});
											gcid = sqty(headtext = 商品总数,name = sqty,width = 60,headtype = sort,align = left,type = text,datatype=number,dataformat={0});
											gcid = crna(headtext = 创建人,name = crna,width = 65,headtype = hidden,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 创建时间,name = crdt,width = 105,headtype = hidden,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = chna(headtext = 审核人,name = chna,width = 65,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = rema(headtext = 备注,name = rema,width = 200,headtype = sort,align = left,type = text,datatype=string);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{entruckPlanMB.msg}" />
							<h:inputHidden id="sellist" value="#{entruckPlanMB.sellist}" />
							<h:inputHidden id="biid" value="#{entruckPlanMB.mbean.biid}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='entruckplan_edit.jsf'"
							style="display:none;" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>