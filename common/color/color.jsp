<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.common.ColoCOM"%>
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
		<title>选择规格</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript" src='color.js'></script>
	</head>

	<%

		ColoCOM ai = (ColoCOM) MBUtil.getManageBean("#{coloCOM}");
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
								id="sid" value="查询" type="button" action="#{coloCOM.search}"
								reRender="output" requestDelay="50" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="cleartext();" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="色卡名称:">
						</h:outputText>
						<h:inputText id="skna" styleClass="inputtextedit" size="15"
							value="#{coloCOM.skna}" onkeypress="formsubmit(event);" />
						<h:outputText value="色号:">
						</h:outputText>
						<h:inputText id="colo" styleClass="inputtextedit" size="15"
							value="#{coloCOM.colo}" onkeypress="formsubmit(event);" /><br/>
						<h:outputText value="规格:">
						</h:outputText>
						<h:inputText id="cona" styleClass="inputtextedit" size="15"
							value="#{coloCOM.cona}" onkeypress="formsubmit(event);" />
						<h:outputText value="供应商名称:">
						</h:outputText>
						<h:inputText id="ceve" styleClass="inputtextedit" size="15"
							value="#{coloCOM.ceve}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">	
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select a.id,a.colo,a.cona,a.rema,
											b.cona as skna,c.ceve
											from colo a join cono b on a.skid=b.id join suin c on b.cuid=c.suid
											where a.stat=1 #{coloCOM.sql}"
								gwidth="550" gpage="(pagesize = 10)" gdebug="false"
								growclick="selectThis('gcolumn[1]','gcolumn[2]')"
								gcolumn="
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = ceve(headtext = 供应商名称,name = ceve,width = 160,align = left,type = text,headtype = sort ,datatype = string);
									gcid = skna(headtext = 色卡名称,name = skna,width = 80,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 色号,name = coid,width = 80,align = left,type = text,headtype = sort ,datatype = string);
									gcid = cona(headtext = 规格,name = cona,width = 80,align = left,type = text,headtype = sort ,datatype = string);
									gcid = rema(headtext = 备注,name = rema,width = 200,align = left,type = text,headtype = sort ,datatype = string);
								" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{coloCOM.retid}" />
						<h:inputHidden id="retname" value="#{coloCOM.retname}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>