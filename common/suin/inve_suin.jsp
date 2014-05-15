<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.common.SuinCOM"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<jsp:directive.page import="javax.faces.context.FacesContext" />
<jsp:directive.page import="javax.faces.el.ValueBinding" />
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="search" />
		<title>传入物料编码选择对应物料的供应商</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
		<script type="text/javascript" src='suin.js'></script>
	</head>

	<%
		FacesContext context = FacesContext.getCurrentInstance();
		ValueBinding binding = context.getApplication().createValueBinding("#{suinCOM}");
		SuinCOM ai = (SuinCOM) binding.getValue(context);
		if (request.getParameter("time") != null) {
			ai = new SuinCOM();
			binding.setValue(context,ai);
		}
		if (request.getParameter("inco") != null) {
			ai.setInco(request.getParameter("inco"));
		}
		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}
		if (request.getParameter("retname") != null) {
			ai.setRetname(request.getParameter("retname"));
		}
		
		if (request.getParameter("retsuco") != null) {
			ai.setRetsuco(request.getParameter("retsuco"));
		}
		if (request.getParameter("retsucoid") != null) {
			ai.setRetsucoid(request.getParameter("retsucoid"));
		}
		if (request.getParameter("retnum") != null) {
			ai.setRetnum(request.getParameter("retnum"));
		}
		if (request.getParameter("retunit") != null) {
			ai.setRetunit(request.getParameter("retunit"));
		}
		if (request.getParameter("retsipr") != null) {
			ai.setRetsipr(request.getParameter("retsipr"));
		}
	%>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{suinCOM.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
							<a4j:commandButton type="button" value="添加" onclick="openinve();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="供应商编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{suinCOM.suid}" onkeypress="formsubmit(event);" />
						<h:outputText value="供应商名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{suinCOM.suna}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="
select a.inco,a.coid,b.colo,c.id as skid,c.cuid,c.cona,c.cono,d.suna,a.sipr,a.puni from rici a 
left join colo b on a.coid = b.id
left join cono c on c.id = b.skid
left join suin d on c.cuid = d.suid
where a.stat='1' and a.inco = '#{suinCOM.inco}' #{suinCOM.sql} "
gwidth="550" gpage="(pagesize = 20)" gdebug="false"
growclick="selectSuin('gcolumn[cuid]','gcolumn[suna]','gcolumn[coid]','gcolumn[colo]','gcolumn[sipr]','gcolumn[puni]')"
gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
	gcid = cuid(headtext = 供应商编码,name = cuid,width = 100,headtype = sort,align = left,type = text,datatype=string);
	gcid = suna(headtext = 供应商名称,name = suna,width = 120,headtype = sort,align = left,type = text,datatype=string);
	gcid = skid(headtext = 色卡号ID,name = skid,width = 100,headtype = hidden,align = left,type = text,datatype=string);
	gcid = cono(headtext = 色卡号,name = cono,width = 100,headtype = sort,align = left,type = text,datatype=string);
	gcid = coid(headtext = 色号ID,name = coid,width = 100,headtype = hidden,align = left,type = text,datatype=string);
	gcid = colo(headtext = 色号,name = colo,width = 100,headtype = sort,align = left,type = text,datatype=string);
	gcid = sipr(headtext = 单价,name = suni,width = 100,headtype = sort,align = left,type = text,datatype=string);
	gcid = puni(headtext = 单位,name = puni,width = 100,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="inco" value="#{suinCOM.inco}" />
						<h:inputHidden id="retid" value="#{suinCOM.retid}" />
						<h:inputHidden id="retname" value="#{suinCOM.retname}" />
						<h:inputHidden id="retsuco" value="#{suinCOM.retsuco}" />
						<h:inputHidden id="retsucoid" value="#{suinCOM.retsucoid}" />
						<h:inputHidden id="retnum" value="#{suinCOM.retnum}" />
						<h:inputHidden id="retunit" value="#{suinCOM.retunit}" />
						<h:inputHidden id="retsipr" value="#{suinCOM.retsipr}" />
						<a4j:commandButton id="refBut" reRender="output"></a4j:commandButton>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>