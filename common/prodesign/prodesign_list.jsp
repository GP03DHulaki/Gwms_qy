<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.scm.ProdesignMB"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%
ProdesignMB ai = (ProdesignMB) MBUtil.getManageBean("#{prodesignMB}");
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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="search" />
		<title>选择款号</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript" src='prodesign_list.js'></script>
	</head>

	<body id=mmain_body onload="cleartext();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="sid" value="查询" type="button" action="#{prodesignMB.search}"
							reRender="C01,C02,C03" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="款号:" />
						<h:inputText id="id" styleClass="inputtextedit" size="42" onkeyup="$('edit:sid').click()"
							value="#{prodesignMB.id}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gtype="grid" gversion="2"
								gselectsql="select did,biid,stno from dstd where flag>='11' #{prodesignMB.searchSQL}"
								gwidth="550" gpage="(pagesize = 20)" gdebug="true"
								growclick="selectThis('gcolumn[biid]','gcolumn[stno]');"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = biid(headtext = 登记单号,name = biid,width = 250,headtype = sort,align = left,type = text,datatype=string);
									gcid = stno(headtext = 款号,name = biid,width = 250,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{prodesignMB.retid}" />
						<h:inputHidden id="retname" value="#{prodesignMB.retname}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>