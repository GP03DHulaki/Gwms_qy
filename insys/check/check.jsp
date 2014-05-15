<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.CheckMB"%>
<%
		CheckMB ai = (CheckMB) MBUtil
	            .getManageBean("#{checkMB}");
	    if (null != request.getParameter("isAll")) {
	        ai.initSK();
	    }
	%>

<html>
	<head>
		<title>检验单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="检验单">
		<script type="text/javascript" src="check.js"></script>
	</head>

	<body id="mmain_body" onload="clearSearchKey();">
		<div id=mmain_nav>
			<font color="#000000">入库处理&gt;&gt;</font>
			<b>检验单</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							rendered="#{checkMB.ADD}" onclick="addNew();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" action="#{checkMB.deleteHeadAll}"
							onclick="if(!doDeleteHeadAll(gtable)){return false};"
							rendered="#{checkMB.DEL}" reRender="msg,output,renderArea"
							oncomplete="endDoList();" requestDelay="50" />
						<a4j:commandButton id="sid" value="查询"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							action="#{checkMB.search}" type="button" reRender="output"
							rendered="#{checkMB.LST}" requestDelay="50" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearSearchKey();" rendered="#{checkMB.LST}" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							onclick="reportExcel('gtable')" type="button" />
						<!--
						<a4j:commandButton id="test" value="测试"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							action="#{checkMB.test}" type="button" reRender="output"
							requestDelay="50" />
						  -->
					</div>
					<div id=mmain_cnd>
						<div>
							创建日期从:
							<h:inputText id="start_date" styleClass="datetime" size="16"
								value="#{checkMB.sk_start_date}" onfocus="#{gmanage.datePicker}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="16"
								value="#{checkMB.sk_end_date}" onfocus="#{gmanage.datePicker}" />
							单据单号:
							<h:inputText id="voucherid" styleClass="inputtext" size="12"
								value="#{checkMB.mbean.biid}" onkeypress="formsubmit(event);" />
							来源单号:
							<h:inputText id="socoid" styleClass="inputtext" size="12"
								value="#{checkMB.mbean.soco}" onkeypress="formsubmit(event);" />
							制单人:
							<h:inputText id="creatorname" styleClass="inputtext" size="12"
								value="#{checkMB.mbean.crna}" onkeypress="formsubmit(event);" />
							检验员:
							<h:inputText id="checkusername" styleClass="inputtext" size="12"
								value="#{checkMB.mbean.opna}" onkeypress="formsubmit(event);" />
							<h:outputText value="商品名称:">
							</h:outputText>
							<h:inputText id="sk_inna" styleClass="datetime" size="15"
								value="#{checkMB.sk_inna}" onkeypress="formsubmit(event);" />
							<h:outputText value="供应商名称:">
							</h:outputText>
							<h:inputText id="sk_suna" styleClass="datetime" size="15"
								value="#{checkMB.sk_suna}" onkeypress="formsubmit(event);" />
							单据状态:
							<h:selectOneMenu id="flag" value="#{checkMB.mbean.flag}">
								<f:selectItem itemLabel="---全部---" itemValue="" />
								<f:selectItems value="#{checkMB.flags}" />
								<a4j:support event="onchange"
									onsubmit="Gwallwin.winShowmask('TRUE');"
									action="#{checkMB.search}"
									oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"></a4j:support>
							</h:selectOneMenu>
						</div>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gversion="2" gtype="grid" gdebug="false"							gselectsql="
							SELECT DISTINCT a.id,a.biid,a.owid,a.soco,a.soty,a.whid,a.crdt,a.crna,a.eddt,a.chna,a.flag,a.rema,
								qty = (select sum(qty) from dbo.F_GetCheckInfo(a.biid)),
								qtyOk = (select sum(aqty) from dbo.F_GetCheckInfo(a.biid)),
								qtyBa = (select sum(bqty) from dbo.F_GetCheckInfo(a.biid)),
								qtyNo = (select sum(cqty) from dbo.F_GetCheckInfo(a.biid)),
								whidOk =(select  top 1 whid from ckbd where biid = a.biid and chre != 'D'),
								whidNo =(select  top 1 whid from ckbd where biid = a.biid and chre = 'D'),
								c.suna,
								(select top 1 bb.inna from ckde aa join inve bb on aa.inco=bb.inco and aa.biid=a.biid) as inna
								FROM ckma a left join pubm b on a.soco=b.biid left join suin c ON b.suid = c.suid left join ckde d on a.biid= d.biid
								where 1=1 #{checkMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="
							gcid = biid(headtext = selcheckbox,name = selcheckbox,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = biid(headtext = 单据单号,name = biid,width = 100,headtype = sort,align = left,type = link,linktype = script,datatype=string,typevalue = javascript:Edit('gcolumn[2]'));
							gcid = soco(headtext = 来源单号,name = soco,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = suna(headtext = 供应商名称,name = suna,width = 140,align = left,type = text,headtype = sort,datatype = string);
							gcid = owid(headtext = 货主,name = owid,width = 120,align = left,type = text,headtype = sort,datatype=string);
							gcid = soty(headtext = 检验类型,name = soty,width = 80,align = center,type = mask,typevalue=PO:采购订单/RETURNPLAN:退货计划单号/ARRIVE:采购到货单,headtype = sort,datatype = string);
							gcid = inna(headtext = 商品名称,name = inna,width = 60,align = left,type = text,headtype = sort,datatype=string);
							gcid = qty(headtext = 待检数量,name = cqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat=0,summary=this);
							gcid = qtyOk(headtext = 合格数量,name = cqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat=0,summary=this);
							gcid = qtyBa(headtext = 不合格数量,name = bqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat=0,summary=this);
							gcid = qtyNo(headtext = 次品数量,name = dqty,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat=0,summary=this);
							gcid = crdt(headtext = 创建时间,name = crdt,width = 100,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = crna(headtext = 创建人,name = crna,width = 50,align = left,type = text,headtype = sort,datatype=string);
							gcid = eddt(headtext = 审核时间,name = eddt,width = 100,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = chna(headtext = 审核人,name = chna,width = 50,align = left,type = text,headtype = sort,datatype=string);
							gcid = flag(headtext = 单据状态,name = flag,width = 60,headtype = sort,align = center,type = mask,datatype=string,typevalue=01:未确认/05:待检验/11:己检验);
							gcid = rema(headtext = 备注,name = rema,width = 150,headtype = sort,align = left,type = text,datatype=string);
						" />
					</a4j:outputPanel>

					<a4j:outputPanel id="renderCheck">
						<h:inputHidden id="msg" value="#{checkMB.msg}" />
						<a4j:commandButton id="editbut"
							oncomplete="javascript:window.location.href='check_edit.jsf'"
							style="display:none;" />
						<h:inputHidden id="item" value="#{checkMB.item}" />
					</a4j:outputPanel>
				</h:form>
			</f:view>
		</div>
	</body>
</html>