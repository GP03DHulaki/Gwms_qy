<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.TranOutMB"%>
<%@ include file="../../include/include_imp.jsp" %>

<%
	TranOutMB ai = (TranOutMB) MBUtil.getManageBean("#{tranOutMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>调拨出库单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="调拨出库单">
		<script type="text/javascript" src="tranout.js"></script>
	</head>
	<body id=mmain_body >
		<div id=mmain_nav>
			<font color="#000000">库内处理&gt;&gt;调拨&gt;&gt;</font><b>调拨出库</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<gw:GAjaxButton value="添加单据" theme="b_theme"
							action="#{tranOutMB.clearMBean}" oncomplete="addNew();"
							id="addHead" rendered="#{tranOutMB.ADD}" />

						<gw:GAjaxButton value="删除单据" theme="b_theme"
							action="#{tranOutMB.deleteHead}" 
							id="deleteId" onclick="if(!deleteHeadAll(gtable)){return false};"
							reRender="output,renderArea" oncomplete="endDeleteHeadAll();"
							requestDelay="50" rendered="#{tranOutMB.DEL}" />

						<a4j:outputPanel id="queryButs" rendered="#{tranOutMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{tranOutMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','sk_biid,sk_soco,sk_flag,start_date,end_date,owna,fwna,crna,orid');" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{tranOutMB.LST}">
						<div id="mmain_cnd">
							创建日期从:
							<h:inputText id="start_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{tranOutMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{tranOutMB.sk_end_date}" />
							调拨出库单:
							<h:inputText id="sk_biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{tranOutMB.sk_obj.biid}" />
							来源单号:
							<h:inputText id="sk_soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{tranOutMB.sk_obj.soco}" />
							<h:outputText value="状态:" rendered="true" />
							<h:selectOneMenu id="sk_flag" value="#{tranOutMB.sk_obj.flag}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="制作之中" itemValue="01" />
								<f:selectItem itemLabel="正式单据" itemValue="11" />
								<f:selectItem itemLabel="入库中" itemValue="21" />
								<f:selectItem itemLabel="完成入库" itemValue="31" />
								<f:selectItem itemLabel="已关闭" itemValue="100" />
							</h:selectOneMenu>
							<br>
							出库仓库:
							<h:inputText id="owna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{tranOutMB.sk_obj.owna}" />
							入库仓库:
							<h:inputText id="fwna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{tranOutMB.sk_obj.fwna}" />&nbsp;
							<h:outputText value="制单人:"> 
							</h:outputText>
							<h:inputText id="crna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{tranOutMB.sk_obj.crna}" />&nbsp;
							组织架构:
							<h:selectOneMenu id="orid" value="#{tranOutMB.orid}" onchange="doSearch();">
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
											SELECT a.id,a.biid,a.flag,a.crus,a.crna,a.chus,a.chna,a.crdt,a.chdt,a.orid,d.whna as iwhna,a.gddt,
											Case a.soty WHEN '' THEN 'NOFROM' ELSE a.soty END AS soty,a.stat,a.rema,a.soco,b.whna,c.orna 
											FROM pbma a Left Join waho b on a.pfwh=b.whid Left Join waho d on a.powh=d.whid 
											join orga c on c.orid=a.orid
											WHERE a.#{tranOutMB.gorgaSql} #{tranOutMB.searchSQL}
											"
										gpage="(pagesize = 20)"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = biid(headtext = 调拨出库单号,name = hid_biid,width = 0,headtype = hidden,align = left,type = text,datatype=string);
											gcid = biid(headtext = 调拨出库单,name = biid,width = 110,headtype = sort,align = left,type = link,datatype=string,linktype = script,typevalue = javascript:Edit('gcolumn[biid]'));
											gcid = flag(headtext = 状态,name = flag,width = 65,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:入库中/31:完成入库/100:已关闭,headtype = sort,datatype = string);
											gcid = whna(headtext = 出库仓库,name = whna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = iwhna(headtext = 入库仓库,name = iwhna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = soty(headtext = 来源类型,name = soty,width = 65,align = center,type = mask,typevalue=TRANPLAN:调拨计划/NOFROM:无来源,headtype = sort,datatype = string);
											gcid = soco(headtext = 来源单号,name = soco,width = 110,headtype = sort,align = left,type = text,datatype=string);
											gcid = crna(headtext = 制单人,name = crna,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = gddt(headtext = 过账时间,name = gddt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = crdt(headtext = 创建时间,name = crdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = chna(headtext = 审核人,name = chna,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = rema(headtext = 备注,name = rema,width = 150,headtype = sort,align = left,type = text,datatype=string);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{tranOutMB.msg}" />
							<h:inputHidden id="sellist" value="#{tranOutMB.sellist}" />
							<h:inputHidden id="biid" value="#{tranOutMB.mbean.biid}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();" oncomplete="javascript:window.location.href='tranout_edit.jsf'"
							style="display:none;" />
					</div>
				</h:form>

			</f:view>
		</div>
	</body>
</html>