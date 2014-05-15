<%@ include file="../../include/include_imp.jsp"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.stock.CancelBackMB"%>

<%
    CancelBackMB ai = (CancelBackMB) MBUtil
            .getManageBean("#{cancelBackMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSK();
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>取消订单上架</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="取消订单上架">
		<script type="text/javascript" src="cancelback.js"></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">库内处理&gt;&gt;</font><b>取消订单上架</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<gw:GAjaxButton value="添加单据" theme="b_theme"
							action="#{cancelBackMB.clearMBean}" oncomplete="addNew();"
							id="addHead" rendered="#{cancelBackMB.ADD}" />

						<gw:GAjaxButton value="删除单据" theme="b_theme"
							action="#{cancelBackMB.deleteHead}" id="deleteId"
							onclick="if(!deleteHeadAll(gtable)){return false};"
							reRender="output,renderArea" oncomplete="endDeleteHeadAll();"
							requestDelay="50" rendered="#{cancelBackMB.DEL}" />

						<a4j:outputPanel id="queryButs" rendered="#{cancelBackMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{cancelBackMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','sk_biid,sk_soco,sk_flag,start_date,end_date,crna,orid,cuna');" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{cancelBackMB.LST}">
						<div id="mmain_cnd">
							单据日期从:
							<h:inputText id="start_date" styleClass="datetime" size="15"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{cancelBackMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="15"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{cancelBackMB.sk_end_date}" />
							<h:outputText value="制单人：">
							</h:outputText>
							<h:inputText id="crna" styleClass="inputtext" size="12"
								onkeypress="formsubmit(event);"
								value="#{cancelBackMB.sk_obj.crna}" />
							<h:outputText value="移动库位：">
							</h:outputText>
							<h:inputText id="owid" styleClass="inputtext" size="12"
								onkeypress="formsubmit(event);"
								value="#{cancelBackMB.sk_obj.owid}" />
							<h:outputText value="状态：" rendered="true" />
							<h:selectOneMenu id="sk_flag" value="#{cancelBackMB.sk_obj.flag}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="制作之中" itemValue="01" />
								<f:selectItem itemLabel="正式单据" itemValue="11" />
							</h:selectOneMenu>
							<h:outputText value="组织架构：" rendered="true" />
							<h:selectOneMenu id="orid" value="#{cancelBackMB.orid}"
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
											SELECT a.id,a.biid,a.flag,a.crus,a.crna,a.chus,a.chna,
											a.crdt,a.chdt,a.orid,a.soty,a.stat,a.rema,a.soco,b.orna,a.owid
											FROM cbma a join orga b on b.orid=a.orid
											WHERE a.#{cancelBackMB.gorgaSql} #{cancelBackMB.searchSQL}
											"
										gpage="(pagesize = 20)"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 单据单号,name = hid_biid,width = 0,headtype = hidden,align = left,type = text,datatype=string);
											gcid = biid(headtext = 单据单号,name = biid,width = 110,headtype = sort,align = left,type = link,datatype=string,linktype = script,typevalue = javascript:Edit('gcolumn[biid]'));
											gcid = orna(headtext = 组织架构,name = orna,width = 90,headtype = sort,align = left,type = text,datatype=string);
											gcid = owid(headtext = 移动库位,name = owid,width = 110,align = left,type = text,headtype = sort,datatype = string);
											gcid = flag(headtext = 状态,name = flag,width = 65,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:关闭单据,headtype = sort,datatype = string);
											gcid = crna(headtext = 创建人,name = crna,width = 60,align = left,type = text,headtype = sort,datatype = string);
											gcid = crdt(headtext = 创建时间,name = crdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = chna(headtext = 审核人,name = chna,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = rema(headtext = 备注,name = rema,width = 300,headtype = sort,align = left,type = text,datatype=string);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{cancelBackMB.msg}" />
							<h:inputHidden id="sellist" value="#{cancelBackMB.sellist}" />
							<h:inputHidden id="biid" value="#{cancelBackMB.mbean.biid}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='cancelback_edit.jsf'"
							style="display:none;" />
					</div>
				</h:form>

			</f:view>
		</div>
	</body>
</html>