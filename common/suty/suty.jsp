<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.common.InvclassCOM"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.common.GeinCOM"%>
<%@page import="com.gwall.common.SutyCOM"%>
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
		<title>选择供应商分类</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript" src='suty.js'></script>
	</head>

	<%
		SutyCOM ai = (SutyCOM) MBUtil.getManageBean("#{sutyCOM}");
		if (request.getParameter("time") != null) {
			ai.initSK();
		}
		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}
		if (request.getParameter("retname") != null) {
			ai.setRetname(request.getParameter("retname"));
		}
	%>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{sutyCOM.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="供应商分类编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{sutyCOM.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="供应商分类名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{sutyCOM.na}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="SELECT stco,tyna FROM suty where 1=1 #{sutyCOM.sql} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								growclick="selectThis('gcolumn[1]','gcolumn[2]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = stco(headtext = 供应商分类编码,name = inty,width = 200,headtype = sort,align = left,type = text,datatype=string);
									gcid = tyna(headtext = 供应商分类名称,name = tyna,width = 220,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{sutyCOM.retid}" />
						<h:inputHidden id="retname" value="#{sutyCOM.retname}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>