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
		<title>物料价格供应商维护界面</title>
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
		if(request.getParameter("suid")!=null){
			ai.setSuid(request.getParameter("suid"));
		}
	%>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="更新" type="button" action="#{suinCOM.updateRici}" onclick="if(!update()){return false};"
							reRender="output,msg" requestDelay="50" oncomplete="endUpdate()"/>
						<a4j:commandButton type="button" value="关闭" onclick="closeWin();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="物料编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{suinCOM.inco}"  disabled="true"/>
						<h:outputText value="供应商编码:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15" disabled="true"
							value="#{suinCOM.suid}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="
select a.id,a.coid,c.cuid,d.suna,e.colo,f.cona,b.colo as suco,c.cono,a.sipr,a.puni from rici a 
left join colo b on a.coid = b.id
left join cono c on b.skid = c.id
left join suin d on c.cuid = d.suid
left join inve e on a.inco = e.inco
left join colo f on e.colo = f.id
where a.inco in (select left(inco,len(inco)-4) as inco from inve where upco in (select upco from inve where inco like '#{suinCOM.inco}%'))
and c.cuid='#{suinCOM.suid}'
 "
gwidth="550" gpage="(pagesize = 20)" gdebug="true"
gupdate="(table = {rici},tablepk = {id})"
gcolumn="gcid = id(headtext = selall,name = id,width = 30,type = text,headtype = hidden);
	gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
	gcid = colo(headtext = 规格,name = colo,width = 100,headtype = hidden,align = left,type = text,datatype=string);
	gcid = cona(headtext = 规格,name = cona,width = 100,headtype = sort,align = left,type = text,datatype=string);
	gcid = cono(headtext = 供应商色卡号,name = cono,width = 100,headtype = sort,align = left,type = text,datatype=string);
	gcid = suco(headtext = 供应商色号,name = suco,width = 100,headtype = sort,align = left,type = text,datatype=string);
	gcid = sipr(headtext = 采购单价,name = sipr,width = 120,headtype = text,align = right,type = input,update=edit,datatype =number,dataformat=0.##,summary=this);
	gcid = puni(headtext = 采购单位,name = puni,width = 100,headtype = text,align = left,type = input,datatype=string,update=edit);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{suinCOM.retid}" />
						<h:inputHidden id="retname" value="#{suinCOM.retname}" />
						<h:inputHidden id="retsuco" value="#{suinCOM.retsuco}" />
						<h:inputHidden id="retsucoid" value="#{suinCOM.retsucoid}" />
						<h:inputHidden id="retnum" value="#{suinCOM.retnum}" />
						<h:inputHidden id="retunit" value="#{suinCOM.retunit}" />
						<h:inputHidden id="retsipr" value="#{suinCOM.retsipr}" />
						<a4j:commandButton id="refBut" reRender="output"></a4j:commandButton>
						<h:inputHidden id="updatedata" value="#{suinCOM.updatedata}" />
						<h:inputHidden id="msg" value="#{suinCOM.msg}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>