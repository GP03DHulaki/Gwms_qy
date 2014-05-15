<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.view.ChangeBacoMB"%>
<%@ include file="../../include/include_imp.jsp"%>

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
		ChangeBacoMB ai = (ChangeBacoMB) MBUtil
				.getManageBean("#{changeBacoMB}");
		if (request.getParameter("time") != null) {
			ai.setSql("");
			ai.setAmaterials("");
			ai.setName("");
		}
		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}
		if (request.getParameter("retname") != null) {
			ai.setRetid(request.getParameter("retname"));
		}
		if (request.getParameter("pwid1") != null) {
			ai.setPwid1(request.getParameter("pwid1"));
		}
	%>
	<body id=mmain_body onload="clearMaterials2();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button"
							action="#{changeBacoMB.searchAfterChange}" reRender="output"
							requestDelay="50" />
						<a4j:commandButton type="button" value="重置"
							onclick="clearMaterials2();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="商品编码:" />
						<h:inputText id="amaterials" styleClass="inputtextedit" size="15"
							value="#{changeBacoMB.amaterials}"
							onkeypress="formsubmit(event);" />
						<h:outputText value="商品名称:" />
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{changeBacoMB.name}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2" gsort="inco"
								gsortmethod="ASC"
								gselectsql="select a.baco,a.inco,b.inna from nwba a left join inve b on a.inco=b.inco where moid='printpackbox'"
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								growclick="selectThis('gcolumn[baco]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
								gcid = inco(headtext = 商品编码,name = inco,width = 220,headtype = sort,align = left,type = text,datatype=string);
								gcid = inna(headtext = 商品名称,name = inna,width = 200,headtype = sort,align = left,type = text,datatype=string);
								gcid = baco(headtext = 条码,name = baco,width = 220,headtype = sort,align = left,type = text,datatype=string);
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