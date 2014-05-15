<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.common.UserCOM"%>
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
		<title>用户信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
		<script type="text/javascript" src='user.js'></script>
	</head>

	<%
		UserCOM ai = (UserCOM) MBUtil.getManageBean("#{userCOM}");
		if (request.getParameter("time") != null) {
			ai.initSK();
			ai.setSql("");
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
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="sid" value="查询" type="button" action="#{userCOM.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<a4j:commandButton id="addDBut" value="确定"
							onclick="if(!addDetails()){return false};"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							type="button" reRender="renderArea,output" requestDelay="50" />	
					</div>
					<div id=mmain_cnd>
						<h:outputText value="用户编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{userCOM.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="用户名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{userCOM.na}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select usid,usna from usin where 
								usid not in (select usid from usgr where grid='#{RoleMB.selroleid}')
								#{userCOM.sql} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								gcolumn="gcid = usid(headtext = selall,name = usid,width = 30,align = center,type = checkbox ,headtype = checkbox);
									gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = usid(headtext = 用户编码,name = usid,width = 200,headtype = sort,align = left,type = text,datatype=string);
									gcid = usna(headtext = 用户名称,name = usna,width = 200,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{userCOM.retid}" />
						<h:inputHidden id="retname" value="#{userCOM.retname}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>