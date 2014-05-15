<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.common.InveCOM"%>
<%@page import="com.gwall.view.BoxInMB"%>
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
		<title>商品信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
		<script type="text/javascript" src='soco.js'></script>
	</head>

	<%
		InveCOM ai = (InveCOM) MBUtil.getManageBean("#{inveCOM}");
		BoxInMB bi = (BoxInMB) MBUtil.getManageBean("#{boxInMB}");
		if (request.getParameter("time") != null) {
			ai.initSK();
		}
		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}
		if (request.getParameter("retname") != null) {
			ai.setRetname(request.getParameter("retname"));
		}
		if (request.getParameter("soco") != null) {
			bi.getMbean().setSoco(request.getParameter("soco"));
		}
	
		
	%>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{inveCOM.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="商品编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{inveCOM.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{inveCOM.na}" onkeypress="formsubmit(event);" />
						<!--<h:outputText value="商品条码:">
						</h:outputText>
						<h:inputText id="bar" styleClass="inputtextedit" size="15"
							value="#{inveCOM.bar}" onkeypress="formsubmit(event);" />
						-->
						<h:outputText value="规格:">
						</h:outputText>
						<h:inputText id="colo" styleClass="inputtextedit" size="15"
							value="#{inveCOM.colo}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select inco,inna,inba,colo,inse from inve  where inco in 
								(select inco from pubd where biid='#{boxInMB.mbean.soco}')   #{inveCOM.sql}"  
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								growclick="selectThis('gcolumn[1]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 150,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 200,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 规格,name = colo,width = 80,headtype = sort,align = left,type = text,datatype=string);
									gcid = inse(headtext = 规格码,name = inse,width = 80,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{inveCOM.retid}" />
						<h:inputHidden id="retname" value="#{inveCOM.retname}" />
						<h:inputHidden id="retbar" value="#{inveCOM.retbar}" />
						<h:inputHidden id="retcolor" value="#{inveCOM.retcolor}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>