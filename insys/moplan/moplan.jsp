<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.MoPlanMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>生产包装计划</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="生产包装计划">
	<meta http-equiv="description" content="生产包装计划">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="moplan.js"></script>
</head>
	<%
		MoPlanMB ai = (MoPlanMB) MBUtil.getManageBean("#{moPlanMB}");
		if (request.getParameter("isAll") != null) {
			ai.initSK();
		}
	%>
<body id="mmain_body">
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;</font><b>生产包装计划</b><br></div>
	<f:view>
	<div id="mmain">
		<h:form id="edit">
			<div id="mmain_opt">
				<a4j:commandButton value="添加单据" onmouseover="this.className='a4j_over1'" 
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					action="#{moPlanMB.clearMBean}" oncomplete="addNew();"
					id="addHead" rendered="#{moPlanMB.ADD}" />
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					id="deleteId" value="删除单据" type="button"
					onclick="if(!deleteHeadAll()){return false};"
					rendered="#{moPlanMB.DEL}" reRender="output,renderArea"
					action="#{moPlanMB.deleteHead}"
					oncomplete="endDeleteHeadAll();" requestDelay="50" />
				<a4j:commandButton onmouseover="this.className='a4j_over'"
					onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
					value="查询" type="button" reRender="output" id="sid" oncomplete="Gwallwin.winShowmask('FALSE');"
					action="#{moPlanMB.search}" requestDelay="50" onclick="startDo();"
					rendered="#{moPlanMB.LST}" />
				<a4j:commandButton value="重置"
					onmouseover="this.className='a4j_over'"
					onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
					onclick="clearSearchKey('0');" rendered="#{moPlanMB.LST}" />
			</div>
			<div id=mmain_cnd>
				创建日期从:
				<h:inputText id="sk_start_date" styleClass="datetime" size="10"
					value="#{moPlanMB.sk_start_date}" onfocus="#{gmanage.datePicker}" />
				<h:outputText value="至:">
				</h:outputText>
				<h:inputText id="sk_end_date" styleClass="datetime" size="10"
					value="#{moPlanMB.sk_end_date}" onfocus="#{gmanage.datePicker}" />
				生产包装计划单:
				<h:inputText id="sk_biid" styleClass="datetime" 
					size="12" value="#{moPlanMB.sk_obj.biid}"/>
				制单人:
				<h:inputText id="sk_crna" styleClass="datetime" 
					size="12" value="#{moPlanMB.sk_obj.crna}"/>
				单据状态:
				<h:selectOneMenu id="sk_flag" value="#{moPlanMB.sk_obj.flag}" rendered="true" onchange="doSearch();" >
					<f:selectItem itemLabel="全部" itemValue="" />
					<f:selectItems value="#{moPlanMB.flags}"/>
				</h:selectOneMenu>
				组织架构:
				<h:selectOneMenu id="orid" value="#{moPlanMB.orid}" onchange="doSearch();">
					<f:selectItem itemLabel="" itemValue="" />
					<f:selectItems value="#{OrgaMB.subList}" />
				</h:selectOneMenu>
				部门:
				<h:inputText id="dpna" styleClass="datetime"
					value="#{moPlanMB.dpna}"/>
				<h:inputHidden id="dpid" value="#{moPlanMB.dpid}"/>	
				<img id="whid_img" style="cursor: hand"
						src="../../images/find.gif" onclick="selectDept();" />		
							
			</div>
			<a4j:outputPanel id="output">
				<g:GTable gid="gtable" gtype="grid"
					gselectsql="SELECT a.id,a.biid,a.orid,a.crna,a.crdt,a.chna,a.chdt,a.flag,a.rema,b.orna,c.whna,p.dpna FROM ctma a
								left join orga b on a.orid=b.orid 
								left join waho c on a.whid =c.whid
								left join dept p on a.dpid = p.dpid
								WHERE a.#{moPlanMB.gorgaSql} #{moPlanMB.searchSQL}"
					gpage="(pagesize = 20)" gversion="2" gdebug = "false"
					gcolumn="gcid = biid(headtext = selall,name = pk,width = 20,align = center,type = checkbox,headtype = checkbox);
						gcid = 0(headtext = 行号,name = rowid,width = 35,align = center,type = text,headtype = text,datatype = string);
						gcid = orna(headtext = 组织架构,name = orna,width = 130,align = left,type = text,headtype = sort,datatype = string);
						gcid = biid(headtext = 生产包装计划单,name = hid_biid,width = 0,align = left,type = text,headtype = hidden,datatype = string);
						gcid = biid(headtext = 生产包装计划单,name = biid,width = 120,headtype = sort,align = left,type = link,datatype=string,linktype = script,typevalue = javascript:Edit('gcolumn[biid]'));
						gcid = whna(headtext = 入库仓库,name = whna,width = 90,align = left,type = text,headtype = sort,datatype = string);
						gcid = dpna(headtext = 部门,name = whna,width = 90,align = left,type = text,headtype = sort,datatype = string);
						gcid = crna(headtext = 制单人,name = crna,width = 50,align = left,type = text,headtype = sort,datatype = string);
						gcid = crdt(headtext = 创建时间,name = crdt,width = 120,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
						gcid = chna(headtext = 审核人,name = chna,width = 50,align = left,type = text,headtype = sort,datatype = string);
						gcid = chdt(headtext = 审核时间,name = chdt,width = 120,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
						gcid = flag(headtext = 状态,name = flag,width = 70,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:入库中/31:已完成/51:已关闭,headtype = sort,datatype = string);
						gcid = rema(headtext = 备注,name = rema,width = 150,align = left,type = text,headtype = sort,datatype = string);
					" />
			</a4j:outputPanel>
			<div style="display: none;">
			<a4j:outputPanel id="renderArea">
				<h:inputHidden id="msg" value="#{moPlanMB.msg}" />
				<h:inputHidden id="sellist" value="#{moPlanMB.sellist}" />
				<h:inputHidden id="biid" value="#{moPlanMB.mbean.biid}" />
				<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
					onclick="startDo();" oncomplete="javascript:window.location.href='moplan_edit.jsf'"
					style="display:none;" />
			</a4j:outputPanel>
			</div>
		</h:form>
	</div>
	</f:view>
</body>
</html>