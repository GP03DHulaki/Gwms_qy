<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.CarrierMB"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.pojo.base.CarrierBean"%>
<%@page import="com.gwall.view.CarrierMB"%>
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
		<title>选择物流商</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript" src='carrier.js'></script>
	</head>

	<%
		CarrierMB ai = (CarrierMB) MBUtil.getManageBean("#{carrierMB}");
		ai.initSearchKey(new CarrierBean());
		 if (request.getParameter("retid") != null) {
			//ai.setRetid(request.getParameter("retid"));
   		 }
	%>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{carrierMB.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="快递公司编码:">
						</h:outputText>
						<h:inputText id="lpco" styleClass="inputtextedit" size="15"
							value="#{carrierMB.sk_obj.lpco}" onkeypress="formsubmit(event);" />
						<h:outputText value="快递公司名称:">
						</h:outputText>
						<h:inputText id="lpna" styleClass="inputtextedit" size="15"
							value="#{carrierMB.sk_obj.lpna}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select lpco,lpna from lpin where 1=1 #{carrierMB.searchSQL } "
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								growclick="selectThis('gcolumn[1]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = lpco(headtext = 快递公司编号,name = lpco,width = 200,headtype = sort,align = left,type = text,datatype=string);
									gcid = lpna(headtext = 快递公司名称,name = lpna,width = 220,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{carrierMB.retid}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>