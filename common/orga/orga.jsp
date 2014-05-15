<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.common.OrgaCOM"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<jsp:directive.page import="javax.faces.context.FacesContext" />
<jsp:directive.page import="javax.faces.el.ValueBinding" />
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>组织架构</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
		<script type="text/javascript" src='orga.js'></script>
	</head>

	<%
		FacesContext context = FacesContext.getCurrentInstance();
		ValueBinding binding = context.getApplication().createValueBinding("#{orgaCOM}");
		OrgaCOM ai = (OrgaCOM) binding.getValue(context);
		if (request.getParameter("time") != null) {
			ai = new OrgaCOM();
			binding.setValue(context,ai);
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
							id="sid" value="查询" type="button" action="#{orgaCOM.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="组织架构编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{orgaCOM.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="组织架构名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{orgaCOM.na}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select orid,orna from orga where 1=1 #{orgaCOM.sql} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="true"
								growclick="selectThis('gcolumn[1]','gcolumn[2]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = orid(headtext = 组织架构编码,name = orid,width = 200,headtype = sort,align = left,type = text,datatype=string);
									gcid = orna(headtext = 组织架构名称,name = orna,width = 220,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{orgaCOM.retid}" />
						<h:inputHidden id="retname" value="#{orgaCOM.retname}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>