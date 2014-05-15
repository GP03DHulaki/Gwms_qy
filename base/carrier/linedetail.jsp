<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>物流商路线</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="物流商路线">
		<meta http-equiv="description" content="物流商路线">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/gwall/all.js"></script>
		<script type="text/javascript" src="carrier.js"></script>
	</head>
	<body id='mmain_body'>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="updateId" value="添加路线" type="button"
							onclick="if(!showLines()){return false};" reRender="show"
							rendered="#{carrierMB.MOD}" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="delId" value="删除路线" type="button"
							action="#{carrierMB.deleteLines}"
							onclick="if(!deleteLines()){return false;}"
							reRender="show,renderArea" oncomplete="endDeleteLines();"
							requestDelay="50" rendered="#{carrierMB.DEL}" />
					</div>
					<a4j:outputPanel id="show">
						<g:GTable gid="gtable2" gtype="grid" gversion="2" gdebug="false"
							gselectsql="Select a.lico,b.lina,b.stat From lpli a JOIN liin b
								ON a.lico=b.lico Where a.lpco='#{carrierMB.bean.lpco}'
							"
							gpage="(pagesize = -1)"
							gcolumn="gcid = lico(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
								gcid = 0(headtext = 序号,name = rowid,width = 40,headtype = text,align = center,type = text,datatype=string);
							    gcid = lico(headtext = 路线编码,name = lico,width = 150,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = lina(headtext = 路线名称,name = lina,width = 150,headtype = sort,align = left,type = text,datatype=string);
						        gcid = stat(headtext = 状态 ,name = stat,width = 80,headtype = sort,align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string); 
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="lpco" value="#{carrierMB.bean.lpco}" />
						<h:inputHidden id="licos" value="#{carrierMB.licos}" />
						<h:inputHidden id="msg" value="#{carrierMB.msg}" />
					</a4j:outputPanel>
					<div style="display:none;" >
						<a4j:commandButton id="addLines" oncomplete="window.location.reload();"
							reRender="renderArea" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>