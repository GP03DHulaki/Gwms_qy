<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.PickDownMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>拣货下架</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="拣货下架">
		<script type="text/javascript" src="pickdown.js"></script>
	</head>
	<%
		PickDownMB ai = (PickDownMB) MBUtil.getManageBean("#{pickDownMB}");
		if (request.getParameter("isAll") != null) {
			ai.initSK();
		}
	%>
	<body id=mmain_body>
		<div id=mmain_nav><font color="#000000" >出库处理&gt;&gt;备货处理&gt;&gt;</font><b>拣货下架</b><br></div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'" rendered="#{pickDownMB.ADD}"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();"/>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll()){return false};"
							rendered="#{pickDownMB.DEL}" reRender="output,renderArea"
							action="#{pickDownMB.deleteHead}"
							oncomplete="endDeleteHeadAll();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							action="#{pickDownMB.search}" requestDelay="50" onclick="if(!search()){return false};"
							oncomplete="Gwallwin.winShowmask('false');"
							rendered="#{pickDownMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearData();" rendered="#{pickDownMB.LST}" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="excel" value="导出EXCEL" type="button"
								action="#{pickDownMB.export}"
								reRender="msg,outPutFileName,renderArea,gsql" onclick="excelios_begin('gtable');"
								oncomplete="excelios_end();" requestDelay="50" />
					<%-- 		
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="pickdownId" value="批量复核" type="button"
							onclick="if(!pickdown_oqc_batch()){return false};"
							rendered="#{pickTaskMB.LST}" reRender="output,renderArea"
							action="#{pickDownMB.oqcBatch}"
							oncomplete="endpickdown_oqc_batch();" requestDelay="50" />
					--%>
					</div>
					<a4j:outputPanel id="queryForm" >
					<div id=mmain_cnd>
						<h:outputText value="创建日期从:">
						</h:outputText>
						<h:inputText id="sk_start_date" styleClass="datetime" size="12"
							value="#{pickDownMB.sk_start_date}" onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="12"
							value="#{pickDownMB.sk_end_date}" onfocus="#{gmanage.datePicker}" />
						<h:outputText value="拣货下架单:">
						</h:outputText>
						<h:inputText id="sk_biid" styleClass="datetime" size="15"
							value="#{pickDownMB.sk_obj.biid}" onkeypress="formsubmit(event);" />	
						<h:outputText value="备货任务单:">
						</h:outputText>
						<h:inputText id="sk_soco" styleClass="datetime" size="15"
							value="#{pickDownMB.sk_obj.soco}" onkeypress="formsubmit(event);" />
						<h:outputText value="销售出库单:">
						</h:outputText>
						<h:inputText id="sk_SaleSoco" styleClass="datetime" size="15"
							value="#{pickDownMB.sk_SaleSoco}"
							onkeypress="formsubmit(event);" />
						<h:outputText value="单据标志:" rendered="true">
						</h:outputText>
						<h:selectOneMenu id="sk_flag" rendered="true" value="#{pickDownMB.sk_obj.flag}" onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItems value="#{pickDownMB.flags}"/>
						</h:selectOneMenu>
					</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="select a.id,c.orna,a.biid,a.soco,
								a.crna,a.crdt,a.chna,a.chdt,a.flag,b.whna,a.rema
								From pkma a left join waho b on a.whid = b.whid join orga c on c.orid=a.orid
								WHERE a.#{pickDownMB.gorgaSql} #{pickDownMB.searchSQL}"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = id(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = text,datatype = string);
								gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
								gcid = biid(headtext = 拣货下架单,name = biid,width = 120,align = left,type = link,headtype = sort,datatype = string,linktype = script,typevalue = pickdown_edit.jsf?pid=gcolumn[biid]);
								gcid = soco(headtext = 备货任务单,name = soco,width = 120,align = left,type = text,headtype = sort,datatype = string);
								gcid = crna(headtext = 拣货人,name = sina,width = 110,align = left,type = text,headtype = sort,datatype= string);
								gcid = crdt(headtext = 拣货时间,name = sina,width = 120,align = left,type = text,headtype = sort,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = whna(headtext = 拣货仓库,name = whna,width = 110,align = left,type = text,headtype = sort,datatype = string);
								gcid = flag(headtext = 单据标志,name = flag,width = 80,align = center,type = mask,typevalue=01:正在拣货/11:完成拣货/21:二次分拣中/31:分拣完成/100:关闭单据,headtype = sort,datatype = string);
								gcid = chna(headtext = 审核人,name = chna,width = 110,align = left,type = text,headtype = sort,datatype = string);
								gcid = chdt(headtext = 审核时间,name = chdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = rema(headtext = 备注,name = rema,width = 220,align = left,type = text,headtype = sort,datatype = string);
							" />
					</a4j:outputPanel>
					<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{pickDownMB.msg}" />
						<h:inputHidden id="sellist" value="#{pickDownMB.sellist}" />
						<h:inputHidden id="gsql" value="#{pickDownMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{pickDownMB.outPutFileName}" />
					</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>