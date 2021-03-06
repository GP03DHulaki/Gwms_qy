<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.common.WahoCOM"%>
<%@ include file="../../../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>库位信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='waho.js'></script>
	</head>

	<%
		WahoCOM ai = (WahoCOM) MBUtil.getManageBean("#{wahoCOM}");
		if (request.getParameter("time") != null) {
			ai.setId("");
			ai.setNa("");
			ai.setSql("");
		}
		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}
		if (request.getParameter("retname") != null) {
			ai.setRetname(request.getParameter("retname"));
		}
		
		if (request.getParameter("chie") != null) {
			ai.setChie(request.getParameter("chie"));
		}
		if (request.getParameter("addr") != null) {
			ai.setAddr(request.getParameter("addr"));
		}
		
		
		if (request.getParameter("orid") != null) {
			ai.setOrid(request.getParameter("orid"));
		}
		 
	%>
	<body id=mmain_body onload="init()">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="Gwallwin.winShowmask('TRUE');"
							oncomplete="Gwallwin.winShowmask('FALSE');"
							id="sid" value="查询" type="button" action="#{wahoCOM.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="仓库编码:"></h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{wahoCOM.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="仓库名称:"></h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{wahoCOM.na}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2" gsort="whid"
								gsortmethod="ASC"
								gselectsql="
									SELECT whid,whna,chie,addr FROM waho 
									WHERE whty=1  AND  orid like '#{wahoCOM.orid}'  
									 #{wahoCOM.sql} "
								gwidth="550" gpage="(pagesize = 12)" gdebug="false"
								growclick="selectThis('gcolumn[whid]','gcolumn[whna]','gcolumn[chie]','gcolumn[addr]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = whid(headtext = 仓库编码,name = whid,width = 60,headtype = sort,align = left,type = text,datatype=string);
									gcid = whna(headtext = 仓库名称,name = whna,width = 120,headtype = sort,align = left,type = text,datatype=string);
									gcid = chie(headtext = 联系人,name = chie,width = 70,headtype = sort,align = left,type = text,datatype=string);
									gcid = addr(headtext = 地址,name = addr,width = 220,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{wahoCOM.retid}" />
						<h:inputHidden id="retname" value="#{wahoCOM.retname}" />
						<h:inputHidden id="chie" value="#{wahoCOM.chie}" />
						<h:inputHidden id="addr" value="#{wahoCOM.addr}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>