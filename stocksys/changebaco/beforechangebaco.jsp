<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@ page import="com.gwall.view.ChangeBacoMB"%>

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
		<script type="text/javascript" src='changebaco.js'></script>
	</head>
	<%
		ChangeBacoMB ai = (ChangeBacoMB) MBUtil.getManageBean("#{changeBacoMB}");
		if (request.getParameter("time") != null) {
			ai.setSql("");
			ai.setMaterials("");
			ai.setLibrary("");
		}
		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}
		if (request.getParameter("retname") != null) {
			ai.setRetid(request.getParameter("retname"));
		}
		if (request.getParameter("pwid") != null) {
			ai.setPwid(request.getParameter("pwid"));
		}
	%>
	<body id=mmain_body onload="clearMaterials1();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{changeBacoMB.searchBeforeChange}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="clearMaterials1();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="商品编码:">
						</h:outputText>
						<h:inputText id="materials" styleClass="inputtextedit" size="15"
							value="#{changeBacoMB.materials}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2" gsort="whid" gsortmethod="ASC"
								gselectsql="select id,baco,whid,uqty from stnu where whid= '#{changeBacoMB.pwid}' and 1=1 #{changeBacoMB.sql} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								growclick="selectThis('gcolumn[baco]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = whid(headtext = 库位编码,name = whid,width = 180,headtype = sort,align = left,type = text,datatype=string);
									gcid = baco(headtext = 商品条码,name = baco,width = 180,headtype = sort,align = left,type = text,datatype=string);
									gcid = uqty(headtext = 可用数量,name = uqty,width = 80,headtype = sort,align = right,type = text,datatype =number,dataformat=0.##);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{changeBacoMB.retid}" />
						<h:inputHidden id="retname" value="#{changeBacoMB.retname}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>