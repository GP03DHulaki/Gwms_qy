<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.CheckTaskMB"%>
<%
		CheckTaskMB ai = (CheckTaskMB) MBUtil.getManageBean("#{checkTaskMB}");
	    if (null != request.getParameter("isAll")) {
	        ai.initSK();
	    }
	%>

<html>
	<head>
		<title>质检任务单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="检验单">
		<script type="text/javascript" src="checktask.js"></script>
	</head>

	<body id="mmain_body" onload="clearSearchKey();">
		<div id=mmain_nav>
			<font color="#000000">入库处理&gt;&gt;</font>
			<b>质检任务单</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" action="#{checkTaskMB.deleteHeadAll}"
							onclick="if(!doDeleteHeadAll(gtable)){return false};"
							rendered="#{false && checkTaskMB.DEL}" reRender="msg,output,renderArea"
							oncomplete="endDoList();" requestDelay="50" />
						<a4j:commandButton id="sid" value="查询"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							action="#{checkTaskMB.search}" type="button" reRender="output"
							rendered="#{checkTaskMB.LST}" requestDelay="50" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearSearchKey();" rendered="#{checkTaskMB.LST}" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="closeId" value="关闭单据" action="#{checkTaskMB.closeVouch}"
							onclick="if(!doCloseAll(gtable)){return false};"
							rendered="#{checkTaskMB.DEL}" reRender="msg,output,renderArea"
							oncomplete="endDoList();" requestDelay="50" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							onclick="reportExcel('gtable')" type="button" />
						<!--
						<a4j:commandButton id="test" value="测试"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							action="#{checkTaskMB.test}" type="button" reRender="output"
							requestDelay="50" />
						  -->
					</div>
					<div id=mmain_cnd>
						<div>
							创建日期从:
							<h:inputText id="start_date" styleClass="datetime" size="16"
								value="#{checkTaskMB.sk_start_date}" onfocus="#{gmanage.datePicker}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="16"
								value="#{checkTaskMB.sk_end_date}" onfocus="#{gmanage.datePicker}" />
							单据单号:
							<h:inputText id="voucherid" styleClass="inputtext" size="12"
								value="#{checkTaskMB.bean.biid}" onkeypress="formsubmit(event);" />
							来源单号:
							<h:inputText id="socoid" styleClass="inputtext" size="12"
								value="#{checkTaskMB.bean.soco}" onkeypress="formsubmit(event);" />
							制单人:
							<h:inputText id="creatorname" styleClass="inputtext" size="12"
								value="#{checkTaskMB.bean.crna}" onkeypress="formsubmit(event);" />
							<h:outputText value="商品名称:">
							</h:outputText>
							<h:inputText id="sk_inna" styleClass="datetime" size="15"
								value="#{checkTaskMB.sk_inna}" onkeypress="formsubmit(event);" />
							单据状态:
							<h:selectOneMenu id="flag" value="#{checkTaskMB.bean.stat}">
								<f:selectItem itemLabel="---全部---" itemValue="" />
								<f:selectItems value="#{checkTaskMB.flags}" />
								<a4j:support event="onchange"
									onsubmit="Gwallwin.winShowmask('TRUE');"
									action="#{checkTaskMB.search}"
									oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"></a4j:support>
							</h:selectOneMenu>
						</div>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gversion="2" gtype="grid" gdebug="false"							gselectsql="
							SELECT a.id,a.biid,a.soty,a.soco,a.inco,b.inna,a.qty,a.fqty,a.stat,a.crus,a.crna,a.crdt,a.rema
								from ckpk a join inve b on a.inco = b.inco
								where 1=1 #{checkTaskMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="
							gcid = id(headtext = selcheckbox,name = selcheckbox,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = biid(headtext = 单据单号,name = biid,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = soty(headtext = 来源类型,name = soty,width = 80,headtype = sort,align = left,type = mask,datatype=string,typevalue=NoticeOfArrive:到货通知单);
							gcid = soco(headtext = 来源单号,name = soco,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = inco(headtext = 商品编码,name = inna,width = 110,align = left,type = text,headtype = sort,datatype=string);
							gcid = inna(headtext = 商品名称,name = inna,width = 110,align = left,type = text,headtype = sort,datatype=string);
							gcid = qty(headtext = 数量,name = cqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat=0,summary=this);
							gcid = fqty(headtext = 完成数量,name = cqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat=0,summary=this);
							gcid = crdt(headtext = 创建日期,name = crdt,width = 100,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = crna(headtext = 创建人,name = crna,width = 50,align = left,type = text,headtype = sort,datatype=string);
							gcid = stat(headtext = 状态,name = stat,width = 60,headtype = sort,align = center,type = mask,datatype=string,typevalue=0:初始化/1:已完成/6:已关闭);
							gcid = rema(headtext = 备注,name = rema,width = 180,headtype = sort,align = left,type = text,datatype=string);
						" />
					</a4j:outputPanel>

					<a4j:outputPanel id="renderCheck">
						<h:inputHidden id="msg" value="#{checkTaskMB.msg}" />
						<a4j:commandButton id="editbut"
							oncomplete="javascript:window.location.href='check_edit.jsf'"
							style="display:none;" />
						<h:inputHidden id="item" value="#{checkTaskMB.item}" />
					</a4j:outputPanel>
				</h:form>
			</f:view>
		</div>
	</body>
</html>