<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.view.ChangeBacoMB"%>
<%@ include file="../../include/include_imp.jsp" %>

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
		<script type="text/javascript" src='changebaco.js'></script>
	</head>

	<%
		ChangeBacoMB ai = (ChangeBacoMB) MBUtil.getManageBean("#{changeBacoMB}");
		if (request.getParameter("time") != null) {
			ai.setSql("");
		}

		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}
	%>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" 
							reRender="output" 
							action="#{changeBacoMB.select}"
							requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="商品编码:">
						</h:outputText>
						<h:inputText id="inco" styleClass="inputtextedit" size="15"
							value="#{changeBacoMB.inco}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品名称:">
						</h:outputText>
						<h:inputText id="inna" styleClass="inputtextedit" size="15"
							value="#{changeBacoMB.inna}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select a.id,a.inco,a.inna,a.inse,a.colo from inve a where 1= 1 #{changeBacoMB.sql} "
								gwidth="550" gpage="(pagesize = 50)" gdebug="false" gsort="inco" gsortmethod="asc"
								growclick="selectThis('gcolumn[inco]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 110,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 180,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
									gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{changeBacoMB.retid}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>