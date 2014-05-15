<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.common.InveCOM"%>
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
		<title>物料信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
		<script type="text/javascript" src='inve.js'></script>
	</head>

	<%
		InveCOM ai = (InveCOM) MBUtil.getManageBean("#{inveCOM}");
		if (request.getParameter("time") != null) {
			ai.initSK();
		}
		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}
		if (request.getParameter("retname") != null) {
			ai.setRetname(request.getParameter("retname"));
		}
		if (request.getParameter("retbar") != null) {
			ai.setRetbar(request.getParameter("retbar"));
		}
		//设置物料属性S:半成品/ P:产品/ M:物料
		if (request.getParameter("inpr") != null) {
			ai.setInpr(request.getParameter("inpr"));
		}
		//设置返回物料规格
		if (request.getParameter("retcolor") != null) {
			ai.setRetcolor(request.getParameter("retcolor"));
		}
		if (request.getParameter("leve") != null) {
			ai.setLeve(request.getParameter("leve")); 
		}
		if (request.getParameter("upco") != null) {
			ai.setUpco(request.getParameter("upco")); 
		}
	%>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{inveCOM.scmSearch}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
						<a4j:commandButton type="button" value="添加" onclick="openbase()"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
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
								gselectsql="select case
when a.leve='1' then left(a.inco,len(a.inco)-4) 
when a.leve='0' then a.inco end as inco
,a.inna,a.inba,a.colo,b.cona from inve a
								left join colo b on a.colo = b.id  where inpr='M' #{inveCOM.leve} #{inveCOM.upco} #{inveCOM.sql} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="true"
								growclick="selectThis('gcolumn[1]','gcolumn[2]','gcolumn[3]','gcolumn[cona]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = inco(headtext = 物料编码,name = inco,width = 150,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 物料名称,name = inna,width = 200,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 规格,name = colo,width = 80,headtype = hidden,align = left,type = text,datatype=string);
									gcid = cona(headtext = 规格,name = cona,width = 80,headtype = sort,align = left,type = text,datatype=string);
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