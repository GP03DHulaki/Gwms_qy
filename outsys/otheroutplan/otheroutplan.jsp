<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.gwall.view.OtherOutPlanMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	OtherOutPlanMB ai = (OtherOutPlanMB) MBUtil.getManageBean("#{otherOutPlanMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<html>
	<head>
		<title>其它出库</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="其它出库">
		<script type="text/javascript" src="otheroutplan.js"></script>
	</head>

	<body id='mmain_body'>
		<div id="mmain_nav">
			<font color="#000000">出库处理&gt;&gt;</font><b>其它出库计划</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							action="#{otherOutPlanMB.search}" requestDelay="50"
							onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
							rendered="#{otherOutPlanMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearData();" rendered="#{otherOutPlanMB.LST}" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="制单日期从:">
						</h:outputText>
						<h:inputText id="sk_start_date" styleClass="datetime" size="12"
							value="#{otherOutPlanMB.sk_start_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="12"
							value="#{otherOutPlanMB.sk_end_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="审单日期:">
						</h:outputText>
						<h:inputText id="ch_start_date" styleClass="datetime" size="12"
							value="#{otherOutPlanMB.ch_start_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sh_end_date" styleClass="datetime" size="12"
							value="#{otherOutPlanMB.ch_end_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="计划送达日期从:">
						</h:outputText>
						<h:inputText id="sd_start_date" styleClass="datetime" size="12"
							value="#{otherOutPlanMB.sd_start_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sd_end_date" styleClass="datetime" size="12"
							value="#{otherOutPlanMB.sd_end_date}"
							onfocus="#{gmanage.datePicker}" />
						<br/>
						<h:outputText value="其它出库计划单号:">
						</h:outputText>
						<h:inputText id="sk_biid" styleClass="datetime" size="20"
							value="#{otherOutPlanMB.biid}" onkeypress="formsubmit(event);" />
						
						<h:outputText value="组织架构:">
						</h:outputText>
						<h:selectOneMenu id="orid" value="#{otherOutPlanMB.orid}"
							onchange="doSearch();">
							<f:selectItem itemLabel="" itemValue="" />
							<f:selectItems value="#{OrgaMB.subList}" />
						</h:selectOneMenu>
						<h:outputText value="仓库:" ></h:outputText>
						<h:selectOneMenu id="sk_whid" value="#{otherOutPlanMB.whid}"
							style="width:130px;">
							<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
						</h:selectOneMenu>
						<h:outputText value="是否已经回写瑞雪:">
						</h:outputText>
						<h:selectOneMenu id="sk_flag" value="#{otherOutPlanMB.stat}"
							>
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItem itemLabel="是" itemValue="1" />
							<f:selectItem itemLabel="否" itemValue="0" />
						</h:selectOneMenu>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="select  a.OtherOutNumber,a.PlanOutTime,a.CreateTime,a.CheckTime,a.StoreCode,case when a.stat='0' then '未回写' else '已回写' end as stat,a.OtherOutReason  from tb_otherout a where 1=1  #{otherOutPlanMB.searchSQL }"
							gpage="(pagesize = 20)" gversion="2" gdebug="true"
							gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
								gcid = OtherOutNumber(headtext = 其它出库计划单,name = OtherOutNumber,width = 130,align = left,type = link,headtype = sort,datatype = string,linktype = script,typevalue = otheroutplan_detail.jsf?pid=gcolumn[OtherOutNumber]);
								gcid = StoreCode(headtext = 出库仓库,name = StoreCode,width = 110,align = left,type = text,headtype = sort,datatype = string);
								gcid = PlanOutTime(headtext = 计划送达时间,name = PlanOutTime,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = CreateTime(headtext = 制单时间,name = CreateTime,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = CheckTime(headtext = 审核时间,name = CheckTime,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = stat(headtext = 回写状态,name = stat,width = 60,headtype = sort,align = center,type = text,datatype=string,bgcolor={gcolumn[whfl]=未回写:#66FF00});
											
								
								gcid = OtherOutReason(headtext = 备注,name = OtherOutReason,width = 115,align = left,type = text,headtype = sort,datatype = string);
							" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{otherOutPlanMB.msg}" />
							<h:inputHidden id="sellist" value="#{otherOutPlanMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
