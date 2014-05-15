<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.common.ConoCOM"%>
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
		<title>选择色号</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript" src='cono.js'></script>
	</head>

	<%

		ConoCOM ai = (ConoCOM) MBUtil.getManageBean("#{conoCOM}");
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
	<body id=mmain_body onload="cleartext();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="sid" value="查询" type="button" action="#{conoCOM.search}"
								reRender="output" requestDelay="50" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="cleartext();" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="色卡编号:">
						</h:outputText>
						<h:inputText id="cono" styleClass="inputtextedit" size="15"
							value="#{conoCOM.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="色卡名称:">
						</h:outputText>
						<h:inputText id="cona" styleClass="inputtextedit" size="15"
							value="#{conoCOM.na}" onkeypress="formsubmit(event);" />
						<h:outputText value="供应商:">
						</h:outputText>
						<h:inputText id="suna" styleClass="inputtextedit" size="15"
							value="#{conoCOM.co}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
						<g:GTable gid="gtable2" gtype="grid"
							gselectsql="Select a.id,a.cono,a.cona,a.cuid,a.rema,b.suna From cono a
								join suin b on a.cuid=b.suid 
								Where a.stat='1' #{conoCOM.sql}"
							gpage="(pagesize = 10)" gversion="2" gdebug="false"
								growclick="selectThis('gcolumn[1]','gcolumn[2]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = cono(headtext = 色卡编号,name = cono,width = 80,headtype = sort,align = center,type = text,datatype=string);
									gcid = cona(headtext = 色卡名称,name = cona,width = 80,headtype = sort,align = center,type = text,datatype=string);							
									gcid = suna(headtext = 供应商,name = suna,width = 120,headtype = sort,align = center,type = text,datatype=string);							
									gcid = rema(headtext = 备注,name = rema,width = 120,headtype = sort,align = center,type = text,datatype=string);							
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{conoCOM.retid}" />
						<h:inputHidden id="retname" value="#{conoCOM.retname}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>