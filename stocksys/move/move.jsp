<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.ShiftLibraryMB"%>
<%
    ShiftLibraryMB ai = (ShiftLibraryMB) MBUtil
            .getManageBean("#{shiftLibraryMB}");
    if (null != request.getParameter("isAll")) {
        ai.initSK();
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>移库</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="移库">
		<meta http-equiv="description" content="移库">
		<script type="text/javascript" src="move.js"></script>
	</head>

	<body id="mmain_body">
		<div id="mmain_nav">
			<FONT color="#000000">库内处理</FONT>&gt;&gt;
			<B>移库</B>
		</div>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<gw:GAjaxButton value="添加单据" theme="b_theme" action=""
							rendered="#{shiftLibraryMB.ADD}" oncomplete="addNew();"
							id="addHead" />
						<gw:GAjaxButton value="删除单据" theme="b_theme"
							action="#{shiftLibraryMB.deleteHead}" id="deleteId"
							onclick="if(!deleteHeadAll(gtable)){return false};"
							reRender="output,renderArea" oncomplete="endDeleteHeadAll();"
							requestDelay="50" rendered="#{shiftLibraryMB.DEL}" />
						<a4j:outputPanel id="queryButs">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{shiftLibraryMB.search}"
								rendered="#{shiftLibraryMB.LST}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="clearSearchKey();" rendered="#{shiftLibraryMB.LST}" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>


					<a4j:outputPanel id="queryForm">
						<div id="mmain_cnd">
							单据日期从:
							<h:inputText id="start_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{shiftLibraryMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{shiftLibraryMB.sk_end_date}" />
							移库单号:
							<h:inputText id="sk_biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{shiftLibraryMB.sk_obj.biid}" />
							<h:outputText value="商品编码:" />
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{shiftLibraryMB.sk_inco}" />
							<h:outputText value="状态:" rendered="true" />
							<h:selectOneMenu id="sk_flag"
								value="#{shiftLibraryMB.sk_obj.flag}" rendered="true"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{shiftLibraryMB.flags}" />
							</h:selectOneMenu>
							<h:outputText value="组织架构:" />
							<h:selectOneMenu id="orid" value="#{shiftLibraryMB.sk_obj.orid}"
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
											SELECT distinct a.id,a.biid,a.buty,a.infl,a.flag,a.Stat,a.crna,a.crdt,a.whid,a.orid,a.rema,a.chna,a.chdt,b.whna,c.orna FROM msma a
											LEFT JOIN waho b ON a.whid=b.whid 
											left join orga c on a.orid=c.orid
											left join msde d on a.biid=d.biid
											WHERE a.#{shiftLibraryMB.gorgaSql} AND b.whty=1 #{shiftLibraryMB.searchSQL}"
										gpage="(pagesize = 18)"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 移库单号,name = biids,width = 100,headtype = hidden,align = left,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = biid(headtext = 移库单号,name = biid,width = 110,headtype = sort,align = left,type = link,linktype=script,typevalue=move_edit.jsf?pid=gcolumn[biid], datatype=string);
											gcid = whna(headtext =移库仓库,name = whna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = crna(headtext = 创建人,name = crna,width = 82,headtype = sort,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 创建时间,name = crdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = chna(headtext = 审核人,name = chna,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = flag(headtext = 状态,name = flag,width = 80,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:出库中/31:已完成/100:已关闭,headtype = sort,datatype = string);
											gcid = rema(headtext = 备注,name = rema,width = 220,headtype = sort,align = left,type = text,datatype=string);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<%--
					gcid = -1(headtext = 操作,value=查看,name = opt,width = 30,headtype = #{saleOrderMB.colContral1},align = center,type = link,linktype = script,typevalue = javascript:Edit('gcolumn[vc_voucherid]'),datatype=string);
					--%>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{shiftLibraryMB.msg}" />
							<h:inputHidden id="sellist" value="#{shiftLibraryMB.sellist}" />
							<h:inputHidden id="biid" value="#{shiftLibraryMB.mbean.biid}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='move_edit.jsf'"
							style="display:none;" />
					</div>

					<div id="errmsg" style="display: none">
						<div id="mmain_cnd">
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
				</h:form>
			</f:view>
		</div>
	</body>
</html>