<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.view.PickTaskMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	PickTaskMB ai = (PickTaskMB) MBUtil.getManageBean("#{pickTaskMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>备货任务</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="备货任务">
		<script type="text/javascript" src="picktask.js"></script>
	</head>

	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">出库处理&gt;&gt;备货处理&gt;&gt;</font><b>备货任务</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'"
							rendered="#{pickTaskMB.ADD}"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll()){return false};"
							rendered="#{pickTaskMB.DEL}" reRender="output,renderArea"
							action="#{pickTaskMB.deleteHead}"
							oncomplete="endDeleteHeadAll();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							value="查询" type="button" reRender="output" id="sid"
							action="#{pickTaskMB.search}" requestDelay="50"
							onclick="if(!search()){return false};"
							rendered="#{pickTaskMB.LST}"
							oncomplete="Gwallwin.winShowmask('FALSE');" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							onclick="clearData();" rendered="#{pickTaskMB.LST}" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="pickdownId" value="批量下架" type="button"
							onclick="if(!pickdown_batch()){return false};"
							rendered="#{pickTaskMB.LST}" reRender="output,renderArea"
							action="#{pickTaskMB.pickdownBatch}"
							oncomplete="endpickdown_batch();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="oqcId" value="批量复核" type="button"
							onclick="if(!pickdown_oqc_batch()){return false};"
							rendered="#{pickTaskMB.LST}" reRender="output,renderArea"
							action="#{pickTaskMB.oqcBatch}"
							oncomplete="endpickdown_oqc_batch();" requestDelay="50" />
					</div>
					<a4j:outputPanel id="queryForm">
						<div id=mmain_cnd>
							<h:outputText value="创建日期从:">
							</h:outputText>
							<h:inputText id="sk_start_date" styleClass="datetime" size="12"
								value="#{pickTaskMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="12"
								value="#{pickTaskMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="备货任务单:">
							</h:outputText>
							<h:inputText id="sk_biid" styleClass="datetime" size="15"
								value="#{pickTaskMB.sk_obj.biid}"
								onkeypress="formsubmit(event);" />
							<h:outputText value="备货计划单:">
							</h:outputText>
							<h:inputText id="sk_soco" styleClass="datetime" size="15"
								value="#{pickTaskMB.sk_obj.soco}"
								onkeypress="formsubmit(event);" />
							<h:outputText value="销售出库单:">
							</h:outputText>
							<h:inputText id="sk_SaleSoco" styleClass="datetime" size="15"
								value="#{pickTaskMB.sk_SaleSoco}"
								onkeypress="formsubmit(event);" />
							<h:outputText value="制单人:">
							</h:outputText>
							<h:inputText id="crna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{pickTaskMB.sk_obj.crna}" />
							<br/>
							<h:outputText value="任务执行人:">
							</h:outputText>
							<h:inputText id="sina" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{pickTaskMB.sk_obj.sina}" />
							<h:outputText value="组织架构:">
							</h:outputText>
							<h:selectOneMenu id="orid" value="#{pickTaskMB.sk_obj.orid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
							<h:outputText value="单据标志:">
							</h:outputText>
							<h:selectOneMenu id="sk_flag" value="#{pickTaskMB.sk_obj.flag}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{pickTaskMB.flags}" />
							</h:selectOneMenu>
							<h:outputText value="是否打印:" />
							<h:selectOneMenu id="sk_stat" value="#{pickTaskMB.sk_obj.stat}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="已打印" itemValue="1" />
								<f:selectItem itemLabel="未打印" itemValue="0" />
							</h:selectOneMenu>
							仓库：
							<h:selectOneMenu id="whid" value="#{pickTaskMB.sk_obj.whid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="所有集团仓" itemValue="allwhid"/>
								<f:selectItems value="#{warehouseMB.wareList}" />
							</h:selectOneMenu>
							完成进度：
							<h:selectOneMenu id="stus" value="#{pickTaskMB.sk_obj.stus}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="未批量下架" itemValue="0" />
								<f:selectItem itemLabel="已批量下架" itemValue="1" />
								<f:selectItem itemLabel="已批量复核" itemValue="2" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="Select a.id,a.biid,a.buty,a.aity,a.aico,a.soty,a.soco,a.infl,a.flag,
										a.crus,a.crna,a.crdt,a.edus,a.edna,a.eddt,a.chus,a.chna,a.chdt,a.fsdt,a.tale,
										a.sius,a.sina,a.opna,a.whid,b.whna,a.orid,a.rema,a.dety,c.orna,a.inty,stus 
										,d.waid,d.stat
										From ptma a left join waho b on a.whid = b.whid join orga c on c.orid=a.orid
										left join ltma d on a.soco=d.biid
										WHERE a.#{pickTaskMB.gorgaSql} #{pickTaskMB.searchSQL}"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = id(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = text,datatype = string);
								gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
								gcid = biid(headtext = 备货任务单,name = biids,width = 100,align = left,type = text,headtype = hidden,datatype = string);
								gcid = biid(headtext = 备货任务单,name = biid,width = 100,align = left,type = link,headtype = sort,datatype = string,linktype = script,typevalue = picktask_edit.jsf?pid=gcolumn[biid]);
								gcid = inty(headtext = 是否单品,name = inty,width = 60,align = center,type = mask,typevalue=M:一单多货/O:一单多货/S:一单一货,headtype = sort,datatype = string);
								gcid = soco(headtext = 备货计划单,name = soco,width = 100,align = left,type = text,headtype = sort,datatype = string);
								gcid = tale(headtext = 任务优先级,name = tale,width = 80,align = left,type = mask,typevalue = 0:普通任务/1:普通任务/5:紧急任务,headtype = sort,datatype = string,bgcolor={gcolumn[tale]=5:#ff7474});
								gcid = crna(headtext = 制单人,name = crna,width = 60,align = left,type = text,headtype = sort,datatype= string);
								gcid = sina(headtext = 执行人,name = sina,width = 60,align = left,type = text,headtype = sort,datatype= string);
								gcid = stat(headtext = 是否打印,name = stat,width = 60,align = left,type = mask,typevalue = 51:已打印/0:未打印/21:未打印/31:未打印,headtype = sort,datatype= string,bgcolor={gcolumn[stat]=51:#66FF00});
								gcid = waid(headtext = 任务栏位,name = waid,width = 60,align = center,type = text,headtype = sort,datatype= string);
								gcid = whna(headtext = 仓库,name = whna,width = 110,align = left,type = text,headtype = sort,datatype = string);
								gcid = flag(headtext = 单据标志,name = flag,width = 70,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:拣货中/30:异常完成/31:已完成/100:关闭单据,headtype = sort,datatype = string);
								gcid = stus(headtext = 任务优先级,name = stus,width = 80,align = left,type = mask,typevalue = 0:未批量下架/1:已批量下架/2:已批量复核,headtype = sort,datatype = string,bgcolor={gcolumn[stus]=5:#ff7474});
								gcid = chna(headtext = 审核人,name = chna,width = 50,align = left,type = text,headtype = sort,datatype = string);
								gcid = chdt(headtext = 审核时间,name = chdt,width = 120,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = rema(headtext = 备注,name = rema,width = 130,align = left,type = text,headtype = sort,datatype = string);
							" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{pickTaskMB.msg}" />
							<h:inputHidden id="sellist" value="#{pickTaskMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>