<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.ExpressMB"%>
<%@page import="com.gwall.pojo.base.ExpressBean"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
	ExpressMB ai = (ExpressMB) MBUtil.getManageBean("#{expressMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSearchKey(new ExpressBean());
	}
%>
<html>
	<head>
		<title>物流单号状态</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="express.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>
	<f:view>
		<body id=mmain_body>
			<div id=mmain>
				<h:form id="list">
				
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="select l.lpco,l.lpna,COUNT(e.stat) as num from expr e left join lpin l on e.lpco = l.lpco where e.stat = 1  group by l.lpna,e.stat,l.lpco"
							gpage="(pagesize = 18)"
							gcolumn="gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							    gcid = lpco(headtext = 物流商编码,name = lpco,width = 100,headtype = sort,align = left,type = text,datatype=string);
							    gcid = lpna(headtext = 物流商名称,name = lpna,width = 100,headtype = sort,align = left,type = text,datatype=string);
						        gcid = num(headtext = 可用数量 ,name = stat,width = 150,headtype = sort , align = center ,type=text,datatype = string); 
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{expressMB.sellist}" />
						<h:inputHidden id="msg" value="#{expressMB.msg}" />
						<h:inputHidden id="lpco" value="#{expressMB.bean.lpco}" />
						<a4j:commandButton id="hidBut" style="display:none;"
							oncomplete="iframe_linedetail.window.location.reload();" />
					</a4j:outputPanel>
				</h:form>
			</div>
		</body>
	</f:view>
</html>