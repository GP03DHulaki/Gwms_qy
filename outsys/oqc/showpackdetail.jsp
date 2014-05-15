<%@page import="com.gwall.util.SimpleDateUtils"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.ReviewLibraryMB"%>
<%
    String srcPath = request.getContextPath();
    String crdt = request.getParameter("crdt");
    String boid = request.getParameter("boid");
    crdt = SimpleDateUtils.convertDateToStirng("yyyy-MM-dd HH:mm:ss",
            crdt);
    ReviewLibraryMB ai = (ReviewLibraryMB) MBUtil
            .getManageBean("#{reviewLibraryMB}");
    ai.setBoid(boid);
%>
<%@ page language="java" pageEncoding="utf-8"%>
<html>
	<head>
		<title>封箱商品明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="封箱商品明细">
		<script type="text/javascript" src="oqc.js"></script>
		<script type='text/javascript' src='<%=srcPath%>/gwall/all.js'></script>
		<link rel="stylesheet" type="text/css"
			href="<%=srcPath%>/gwall/all.css">
		<script type="text/javascript">
			function init(){
				if(parent.Gskin){
					parent.Gskin.setSkinCss(document);
				}
			}
		</script>
	</head>
	<body id="mmain_body" onload="init();">
		<f:view>
			<h:form id="edit">
				<table>
					<tbody>
						<tr>
							<td>
								箱号：
							</td>
							<td id='boid'>
								<b><%=boid%></b>
							</td>
							<td>
								&nbsp;&nbsp;
							</td>
							<td>
								封箱时间：
							</td>
							<td id='crdt'>
								<b><%=crdt%></b>
							</td>
						</tr>
					</tbody>
				</table>
				<a4j:outputPanel id="output2">
					<g:GTable gid="gtable3" gtype="grid" gversion="2" gdebug="false"
						gsort="crdt" gsortmethod="DESC"
						gselectsql="
							SELECT a.boid,a.qty,a.crdt,a.inco,b.inna,b.colo,b.inse FROM sobx a 
							LEFT JOIN inve b on a.inco=b.inco 
							WHERE a.biid='#{reviewLibraryMB.mbean.biid}' AND a.boid=#{reviewLibraryMB.boid} and a.qty>0 
						"
						gcolumn="
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = inco(headtext = 商品编码,name = inco,width = 150,align = left,type = text,headtype = text ,datatype = string);
							gcid = inna(headtext = 商品名称,name = inna,width = 115,align = left,type = text,headtype = text ,datatype = string);
							gcid = colo(headtext = 规格,name = colo,width = 90,align = left,type = text,headtype = text ,datatype = string);
							gcid = inse(headtext = 规格码,name = inse,width = 90,align = left,type = text,headtype = text ,datatype = string);
							gcid = qty(headtext = 数量,name = qty,width = 80,headtype = text,align = right,type = number,datatype=number,dataformat={0},summary=this);
						" />
					<!-- gpage="(pagesize = 20)" -->
				</a4j:outputPanel>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="item" value="#{reviewLibraryMB.sellist}" />
						<h:inputHidden id="msg" value="#{reviewLibraryMB.msg}" />
					</a4j:outputPanel>
				</div>
			</h:form>
		</f:view>
	</body>
</html>