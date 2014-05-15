<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@page import="com.gwall.common.StinCOM"%>
<%@	page import="com.gwall.util.MBUtil"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>库存商品信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
		<script type="text/javascript" src='stin.js'></script>
	</head>

	<%
		StinCOM ai = (StinCOM) MBUtil.getManageBean("#{stinCOM}");
		if (request.getParameter("time") != null) {
			ai.initSK();
		}
		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}
		if (request.getParameter("retname") != null) {
			ai.setRetname(request.getParameter("retname"));
		}
		if (request.getParameter("whid") != null) {
			ai.setWhid(request.getParameter("whid"));
		}
	%>
	<body id=mmain_body onload="init();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{stinCOM.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="商品编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="40"
							value="#{stinCOM.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{stinCOM.na}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="SELECT a.baco,a.whid,a.Uqty,b.inna,b.inst,b.colo
								FROM stnu a LEFT JOIN inve b ON a.baco=b.inco WHERE a.uqty>0
								And a.whid='#{stinCOM.whid}' #{stinCOM.sql} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								growclick="selectThis('gcolumn[baco]','gcolumn[whid]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = baco(headtext = 商品编码,name = baco,width = 240,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 160,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 花号,name = colo,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = inst(headtext = 规格,name = inst,width = 80,headtype = sort,align = left,type = text,datatype=string);
									gcid = Uqty(headtext = 可用数量,name = Uqty,width = 60,headtype = sort,align = right,type = text,datatype =number,dataformat=0);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{stinCOM.retid}" />
						<h:inputHidden id="retname" value="#{stinCOM.retname}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>