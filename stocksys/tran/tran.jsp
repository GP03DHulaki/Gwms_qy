<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.TranPlanMB"%>
<%@ include file="../../include/include_imp.jsp" %>
<%
	TranPlanMB ai = (TranPlanMB) MBUtil.getManageBean("#{tranPlanMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>调拨计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="调拨计划">
		<script type="text/javascript" src="tran.js"></script>
	</head>

	<body id='mmain_body'>
		<div id='mmain_nav'>
			<font color="#000000">库内处理&gt;&gt;调拨&gt;&gt;</font><b>调拨计划</b>
			<br>
		</div>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id='mmain_opt'>
						<gw:GAjaxButton value="添加单据" theme="b_theme"
							action="#{tranPlanMB.clearMBean}" oncomplete="addNew();"
							id="addHead" rendered="#{tranPlanMB.ADD}" />

						<gw:GAjaxButton value="删除单据" theme="b_theme"
							action="#{tranPlanMB.deleteHead}" 
							id="deleteId" onclick="if(!deleteHeadAll(gtable)){return false};"
							reRender="output,renderArea" oncomplete="endDeleteHeadAll();"
							requestDelay="50" rendered="#{tranPlanMB.DEL}" />

						<a4j:outputPanel id="queryButs" rendered="#{tranPlanMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{tranPlanMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="clearData();" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>

						<a4j:commandButton value="生成计划" id="creatPTask"
							onclick="if(!checkVoucher()){return false}"
							oncomplete="GotoNext();" onmouseover="this.className='a4j_over1'"
							rendered="false" reRender="renderArea,output"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />

					</div>


					<a4j:outputPanel id="queryForm" rendered="#{tranPlanMB.LST}">
						<div id="mmain_cnd">
							单据日期从:
							<h:inputText id="start_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{tranPlanMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{tranPlanMB.sk_end_date}" />
							调拨单号:
							<h:inputText id="sk_biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{tranPlanMB.sk_obj.biid}" />
							调出仓库:
							<h:inputText id="outwhna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{tranPlanMB.sk_obj.outwhna}" />
							调入仓库:
							<h:inputText id="inwhna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{tranPlanMB.sk_obj.inwhna}" />
							<br>
							<h:outputText value="调拨类型:" rendered="true" />
							<h:selectOneMenu id="ifib" value="#{tranPlanMB.sk_obj.ifib}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="普通调拨" itemValue="0" />
								<f:selectItem itemLabel="专柜调拨" itemValue="1" />
								<f:selectItem itemLabel="上线间调拨" itemValue="2" />
							</h:selectOneMenu>&nbsp;&nbsp;
							<h:outputText value="状态:" rendered="true" />
							<h:selectOneMenu id="sk_flag" value="#{tranPlanMB.sk_obj.flag}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="制作之中" itemValue="01" />
								<f:selectItem itemLabel="文员审核" itemValue="08" />
								<f:selectItem itemLabel="正式单据" itemValue="11" />
								<f:selectItem itemLabel="计划装车" itemValue="15" />
								<f:selectItem itemLabel="分拣中" itemValue="16" />
								<f:selectItem itemLabel="分拣完成" itemValue="17" />
								<f:selectItem itemLabel="装车中" itemValue="19" />
								<f:selectItem itemLabel="已出库" itemValue="21" />
								<f:selectItem itemLabel="已完成" itemValue="31" />
								<f:selectItem itemLabel="已关闭" itemValue="100" />
							</h:selectOneMenu>&nbsp;&nbsp;
							组织架构:
							<h:selectOneMenu id="orid" value="#{tranPlanMB.orid}" onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
							<h:outputText value="商品编码:" />
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{tranPlanMB.sk_inco}" />
								<h:outputText value="规格码:" />
							<h:inputText id="inse" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{tranPlanMB.sk_inse}" />
						</div>
					</a4j:outputPanel>

					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gselectsql="
											Select distinct a.id,a.biid,a.buty,a.flag,a.pfwh,a.powh,a.crus,a.crna,a.crdt,a.chus,a.chna,a.chdt,
											a.opna,a.orid,a.rema,b.whna AS outwhna,c.whna AS inwhna,d.orna,a.ifib,a.soty From ppma a
											LEFT JOIN waho b ON a.pfwh = b.whid
											LEFT JOIN waho c on a.powh = c.whid
											join orga d on d.orid=a.orid
											join ppde e on e.biid=a.biid
											join inve f on e.inco=f.inco
											WHERE a.#{tranPlanMB.gorgaSql} #{tranPlanMB.searchSQL}"
										gpage="(pagesize = 18)"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 调拨计划,name = hid_biid,width = 0,headtype = hidden,align = left,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = biid(headtext = 调拨计划,name = biid,width = 100,headtype = sort,align = left,type = link,datatype=string,linktype = script,typevalue = javascript:Edit('gcolumn[biid]'));
											gcid = ifib(headtext = 调拨类型,name = ifib,width = 80,align = center,type = mask,typevalue=0:普通调拨/1:专柜调拨/2:上线间调拨,headtype = sort,datatype = string);
											gcid = soty(headtext = 商品类型,name = soty,width = 80,align = center,type = mask,typevalue=0:普通/1:损耗/2:残品,headtype = sort,datatype = string);
											gcid = flag(headtext = 状态,name = flag,width = 60,align = center,type = mask,typevalue=01:制作之中/08:文员审核/11:正式单据/21:已出库/15:计划装车/16:分拣中/17:分拣完成/31:已完成/19:装车中/100:已关闭,headtype = sort,datatype = string);
											gcid = outwhna(headtext = 调出仓库,name = outwhna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = inwhna(headtext = 调入仓库,name = inwhna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 创建时间,name = crdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = chna(headtext = 审核人,name = chna,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = rema(headtext = 备注,name = rema,width = 180,headtype = sort,align = left,type = text,datatype=string);
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
							<h:inputHidden id="msg" value="#{tranPlanMB.msg}" />
							<h:inputHidden id="sellist" value="#{tranPlanMB.sellist}" />
							<h:inputHidden id="biid" value="#{tranPlanMB.mbean.biid}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();" oncomplete="javascript:window.location.href='tran_edit.jsf'"
							style="display:none;" />
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