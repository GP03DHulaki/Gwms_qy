<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.ShiftLibraryMB"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="search" />
		<title>选择条码</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript" src='move.js'></script>
	</head>

	<%
		ShiftLibraryMB ai = (ShiftLibraryMB) MBUtil.getManageBean("#{shiftLibraryMB}");
		if (request.getParameter("time") != null) {
			ai.initSK();
		}
		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}
		//将箱码数量自动返回
		if (request.getParameter("retqty") != null) {
			ai.setRetqty(request.getParameter("retqty"));
		}
		else ai.setRetqty("");
		if (request.getParameter("dwhid") != null) {
			ai.setDwhid(request.getParameter("dwhid"));
			ai.setSk_whid(request.getParameter("dwhid"));
		}
		if (request.getParameter("whid") != null) {
			ai.setWhid(request.getParameter("whid"));
		}
		if (request.getParameter("stat") != null) {
			ai.setStat(request.getParameter("stat"));
		}
		if (request.getParameter("ctype") != null) {
			ai.setCtype(request.getParameter("ctype"));
		}
		
	%>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="sid" value="查询" type="button" action="#{shiftLibraryMB.search}"
							reRender="C01,C02,C03" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="条码:" />
						<h:inputText id="id" styleClass="inputtextedit" size="42" onkeyup="$('edit:sid').click()"
							value="#{shiftLibraryMB.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品编码:" />
						<h:inputText id="sk_inco" styleClass="inputtextedit" size="15" onkeyup="$('edit:sid').click()"
							value="#{shiftLibraryMB.sk_inco}" onkeypress="formsubmit(event);" />	
					</div>
					<div id=mmain_free>
						
						
						<a4j:outputPanel id="C02" rendered="#{shiftLibraryMB.ctype=='02' ? true : false}">
							<g:GTable gid="#{shiftLibraryMB.ctype}" gtype="grid" gversion="2"
								gselectsql="select distinct a.inco,a.baco as boco,a.whid,b.inna,b.colo,b.inse,
									(select sum(qty) from bain where inco=a.inco and bxfl='02' and whid='#{shiftLibraryMB.whid}') qty from bain a 
										left join inve b on a.inco=b.inco where a.bxfl ='02' and a.whid='#{shiftLibraryMB.whid}'
									  #{shiftLibraryMB.sql} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="true"
								growclick="selectThis('gcolumn[boco]','gcolumn[whid]','gcolumn[qty]');"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = boco(headtext = 箱码,name = boco,width = 220,headtype = sort,align = left,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 160,headtype = sort,align = left,type = text,datatype=string);
									gcid = whid(headtext = 库位编码,whid = inna,width = 120,headtype = hidden,align = left,type = text,datatype=string);
									gcid = qty(headtext = 数量,name = qty,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##});
							" />
						</a4j:outputPanel>
						<a4j:outputPanel id="C03" rendered="#{shiftLibraryMB.ctype=='04' ? true : false}">
							<g:GTable gid="#{shiftLibraryMB.ctype}" gtype="grid" gversion="2"
								gselectsql="select distinct a.inco, b.inna,b.colo,b.inse,
									(select sum(qty) from bain where inco=a.inco and bxfl='04' and whid='#{shiftLibraryMB.whid}') qty from bain a 
										left join inve b on a.inco=b.inco where a.bxfl ='04' and a.whid='#{shiftLibraryMB.whid}'
								"
								gwidth="550" gpage="(pagesize = 20)" gdebug="true"
								growclick="selectThis('gcolumn[inco]','','gcolumn[qty]');"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 130,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 120,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 规格,name = colo,width = 60,headtype = sort,align = left,type = text,datatype=string);
									gcid = inse(headtext = 规格码,name = inse,width = 60,headtype = sort,align = left,type = text,datatype=string);
									gcid = qty(headtext = 数量,name = qty,width = 30,headtype = text,align = right,type = text,datatype=number,dataformat=0.##);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{shiftLibraryMB.retid}" />
						<h:inputHidden id="dwhid" value="#{shiftLibraryMB.dwhid}" />
						<h:inputHidden id="retqty" value="#{shiftLibraryMB.retqty}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>