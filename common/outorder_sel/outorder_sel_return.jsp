<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.common.OutOrderCOM"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>出库订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
		<script type="text/javascript" src='outorder_sel.js'></script>
	</head>
 
	<%
		OutOrderCOM ai = (OutOrderCOM) MBUtil.getManageBean("#{outOrderCOM}");
		if (request.getParameter("time") != null) {
			ai.initSK();
		}
		if (request.getParameter("retvid") != null) {
			ai.setRetvid(request.getParameter("retvid"));
		}
		if (request.getParameter("retorid") != null) {
			ai.setRetorid(request.getParameter("retorid"));
		}
	%>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{outOrderCOM.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="出库订单:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{outOrderCOM.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="客户名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{outOrderCOM.na}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="SELECT a.biid,a.orid,b.cuna,b.cuid FROM obma a LEFT JOIN cuin b ON a.cuid=b.cuid
									 where a.flag in ('21','31') AND a.orid like '#{sessionScope['orid']==''?'#':sessionScope['orid']}%' 
									 #{outOrderCOM.sql} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								growclick="selectThis('gcolumn[biid]','gcolumn[orid]','gcolumn[cuna]','gcolumn[cuid]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = biid(headtext = 出库订单,name = biid,width = 200,headtype = sort,align = left,type = text,datatype=string);
									gcid = cuid(headtext = 客户编码,name = cuid,width = 220,headtype = hidden,align = left,type = text,datatype=string);
									gcid = cuna(headtext = 客户名称,name = cuna,width = 220,headtype = sort,align = left,type = text,datatype=string);
									gcid = orid(headtext = 组织编码,name = orid,width = 0,headtype = hidden,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retvid" value="#{outOrderCOM.retvid}" />
						<h:inputHidden id="retorid" value="#{outOrderCOM.retorid}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>