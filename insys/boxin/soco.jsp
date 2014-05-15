<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.PubmMB"%>
<%@page import="com.gwall.pojo.stockin.PubmMBean"%>
<%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>采购订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='soco.js'></script>
	</head>

	<%
		PubmMB ai = (PubmMB) MBUtil.getManageBean("#{pubmMB}");
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
							id="sid" value="查询" type="button" action="#{pubmMB.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="单号：">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{pubmMB.sk_obj.biid}" onkeypress="formsubmit(event);" />
						
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2" gsort="biid"
								gselectsql="SELECT a.biid,b.suna,a.rema from pubm a left join
									suin b on a.suid=b.suid where a.flag>='11' #{pubmMB.searchSQL} "
								gwidth="550" gpage="(pagesize = 15)" gdebug="false"
								growclick="selectThis('gcolumn[biid]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = biid(headtext = 单号,name = biid,width = 160,headtype = sort,align = left,type = text,datatype=string);
									gcid = suna(headtext = 供应商,name = suna,width = 160,headtype = sort,align = left,type = text,datatype=string);
									gcid = rema(headtext = 备注,name = rema,width = 160,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{pubmMB.retid}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>