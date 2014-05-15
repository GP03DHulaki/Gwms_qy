<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@ page import="com.gwall.view.stock.ShelvesTaskMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title>补货任务</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="补货任务">
		<meta http-equiv="description" content="补货任务">
		<link href="../../css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="shelvestask.js"></script>
	</head>
	<%
	    ShelvesTaskMB ai = (ShelvesTaskMB) MBUtil
	            .getManageBean("#{shelvestaskMB}");
	    if (request.getParameter("isAll") != null) {
	        ai.initSK();
	    }
	%>
	<body id="mmain_body">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;</font><b>补货任务</b>
			<br>
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id="mmain_opt">
						<%-- 
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'" rendered="#{pubmMB.ADD}"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll()){return false};"
							rendered="#{pubmMB.DEL}" reRender="output,renderArea"
							action="#{pubmMB.deleteHead}" oncomplete="endDeleteHeadAll();"
							requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="同步" type="button" reRender="output,renderArea" action=""
							requestDelay="50" onclick="syn();" rendered="false"
							oncomplete="endSyn();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="导出Excel" type="button" action="" id="excelMBut"
							onclick="Gwallwin.winShowmask('TRUE');"
							reRender="outPutFileName,msg" oncomplete="endDot();"
							requestDelay="50" rendered="false" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="同步订单" type="button" action="#{pubmMB.synVoucher}"
							id="synBut" onclick="Gwallwin.winShowmask('TRUE');"
							reRender="output,msg" oncomplete="endDot();" requestDelay="50"
							rendered="TRUE" />
							--%>
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							value="查询" type="button" reRender="output" id="sid"
							action="#{shelvestaskMB.search}" requestDelay="50"
							onclick="if(!search()){return false};" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							onclick="clearData();" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							onclick="reportExcel('gtable')" type="button" />
						<!--<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					value="导出Excel1" type="button" action=""
					id="excelMButTest" onclick="openExcel();"
					reRender="outPutFileName,msg" oncomplete=""
					requestDelay="50" rendered="true" />
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					value="导出Excel2" type="button" action=""
					id="excelMButTest1" onclick="openExcel2();"
					reRender="outPutFileName,msg" oncomplete=""
					requestDelay="50" rendered="true" />
			-->
					</div>
					<div id=mmain_cnd>
						<h:outputText value="创建日期从:">
						</h:outputText>
						<h:inputText id="sk_start_date" styleClass="datetime" size="12"
							value="#{shelvestaskMB.sk_start_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="12"
							value="#{shelvestaskMB.sk_end_date}"
							onfocus="#{gmanage.datePicker}" />
							
						<h:outputText value="审核日期从:">
						</h:outputText>
						<h:inputText id="ch_start_date" styleClass="datetime" size="12"
							value="#{shelvestaskMB.ch_start_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="ch_end_date" styleClass="datetime" size="12"
							value="#{shelvestaskMB.ch_end_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="任务单号:">
						</h:outputText>
						<h:inputText id="sk_biid" styleClass="datetime" size="15"
							value="#{shelvestaskMB.sk_obj.biid}"
							onkeypress="formsubmit(event);" />
						<br/>	
						<h:outputText value="创建人:">
						</h:outputText>
						<h:inputText id="crna" styleClass="datetime" size="15"
							value="#{shelvestaskMB.crna}" />
							
							<h:outputText value="审核人:">
						</h:outputText>
						<h:inputText id="chna" styleClass="datetime" size="15"
							value="#{shelvestaskMB.chna}" />
							
							<h:outputText value="执行人:">
						</h:outputText>
						<h:inputText id="usna" styleClass="datetime" size="15"
							value="#{shelvestaskMB.usna}" />
						<h:outputText value="单据状态:">
						</h:outputText>
						<h:selectOneMenu id="sk_flag" value="#{shelvestaskMB.sk_obj.flag}">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItems value="#{shelvestaskMB.flags}" />
						</h:selectOneMenu>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gdebug="true"
							gselectsql="SELECT a.id,a.biid,a.crdt,a.flag,a.crna,a.chna,a.chdt,a.orid,a.rema,d.usna FROM stma a 
								left join orga c on a.orid=c.orid
								left join usin d on a.sius=d.usid
								WHERE 1=1 #{shelvestaskMB.searchSQL} "
							gpage="(pagesize = 20)" gversion="2"
							gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
								gcid = biid(headtext = 任务单号,name = biids,width = 110,align = left,type = text,headtype = hidden,datatype = string);
								gcid = biid(headtext = 补货任务单号,name = biid,width = 110,align = left,type = link,headtype = sort,datatype = string,linktype = script,typevalue = shelvestask_edit.jsf?pid=gcolumn[biid]);
								gcid = flag(headtext = 状态,name = flag,width = 80,align = center,type = mask,typevalue=01:制作之中/11:正式单据/51:已完成/21:拣货中/30:异常完成/31:拣货完成/41:已关闭/61:上架中,headtype = sort,datatype = string);
								gcid = crna(headtext = 制单人,name = crna,width = 100,align = left,type = text,headtype = sort,datatype = string);
								gcid = crdt(headtext = 制单时间,name = crdt,width = 100,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = chna(headtext = 审核人,name = chna,width = 100,align = left,type = text,headtype = sort,datatype = string);
								gcid = chdt(headtext = 审核时间,name = chdt,width = 100,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = usna(headtext = 执行人,name = sina,width = 100,align = right,type = text,headtype = sort,datatype=string);
								gcid = rema(headtext = 备注,name = rema,width = 200,align = left,type = text,headtype = sort,datatype = string);
							
								" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{shelvestaskMB.msg}" />
							<h:inputHidden id="sellist" value="#{shelvestaskMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>