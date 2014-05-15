<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.view.SecsortMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	SecsortMB ai = (SecsortMB) MBUtil.getManageBean("#{secsortMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>二次分拣</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="二次分拣">
		<meta http-equiv="description" content="二次分拣">
		<script type="text/javascript" src="secsort.js"></script>
	</head>

	<body id="mmain_body">
		<div id=mmain_nav>
			<font color="#000000">出库处理&gt;&gt;备货处理&gt;&gt;</font><b>二次分拣</b>
			<br>
		</div>
		<f:view>
			<div id=mmain>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'"
							rendered="#{secsortMB.ADD}"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll()){return false};"
							rendered="#{secsortMB.DEL}" reRender="output,renderArea"
							action="#{secsortMB.deleteHead}" oncomplete="endDeleteHeadAll();"
							requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							action="#{secsortMB.search}" requestDelay="50"
							onclick="if(!search()){return false};"
							oncomplete="Gwallwin.winShowmask('false');"
							rendered="#{secsortMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearData();" rendered="#{secsortMB.LST}" />
					</div>
					<a4j:outputPanel id="queryForm">
						<div id=mmain_cnd>
							<h:outputText value="创建日期从:">
							</h:outputText>
							<h:inputText id="sk_start_date" styleClass="datetime" size="12"
								value="#{secsortMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="12"
								value="#{secsortMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="二次分拣单:">
							</h:outputText>
							<h:inputText id="sk_biid" styleClass="datetime" size="15"
								value="#{secsortMB.sk_obj.biid}" onkeypress="formsubmit(event);" />
							<h:outputText value="拣货下架单:">
							</h:outputText>
							<h:inputText id="sk_soco" styleClass="datetime" size="15"
								value="#{secsortMB.sk_obj.soco}" onkeypress="formsubmit(event);" />
							<h:outputText value="分拣人:">
							</h:outputText>
							<h:inputText id="sk_crna" styleClass="datetime" size="15"
								value="#{secsortMB.sk_obj.crna}" onkeypress="formsubmit(event);" />
							<h:outputText value="单据标志:" rendered="true">
							</h:outputText>
							<h:selectOneMenu id="sk_flag" rendered="true"
								value="#{secsortMB.sk_obj.flag}" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{secsortMB.flags}" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="Select a.id,a.biid,a.buty,a.aity,a.aico,a.soty,a.soco,a.infl,a.flag,
						a.crus,a.crna,a.crdt,a.edus,a.edna,a.eddt,a.pkus,a.pkna,a.pkdt,a.chus,a.chna,
						a.chdt,a.opna,a.whid,b.whna,a.orid,a.stat,a.rema,a.dety,c.orna 
						From spma a left join waho b on a.whid = b.whid join orga c on c.orid=a.orid
						WHERE a.#{secsortMB.gorgaSql} #{secsortMB.searchSQL}"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = id(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
						gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = text,datatype = string);
						gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
						gcid = biid(headtext = 二次分拣单,name = biids,width = 120,align = left,type = text,headtype = hidden,datatype = string);
						gcid = biid(headtext = 二次分拣单,name = biid,width = 120,align = left,type = link,headtype = sort,datatype = string,linktype = script,typevalue = secsort_edit.jsf?pid=gcolumn[biid]);
						gcid = soco(headtext = 拣货下架单,name = soco,width = 120,align = left,type = text,headtype = sort,datatype = string);
						gcid = crna(headtext = 分拣人,name = sina,width = 110,align = left,type = text,headtype = sort,datatype= string);
						gcid = crdt(headtext = 分拣时间,name = sina,width = 120,align = left,type = text,headtype = sort,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
						gcid = whna(headtext = 来源仓库,name = whna,width = 110,align = left,type = text,headtype = sort,datatype = string);
						gcid = flag(headtext = 单据标志,name = flag,width = 80,align = center,type = mask,typevalue=01:分拣中/11:已完成/100:关闭单据,headtype = sort,datatype = string);
						gcid = chna(headtext = 审核人,name = chna,width = 110,align = left,type = text,headtype = sort,datatype = string);
						gcid = chdt(headtext = 审核时间,name = chdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
						gcid = rema(headtext = 备注,name = rema,width = 220,align = left,type = text,headtype = sort,datatype = string);
					" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{secsortMB.msg}" />
							<h:inputHidden id="sellist" value="#{secsortMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>