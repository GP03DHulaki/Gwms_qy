<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.OutOrderMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	OutOrderMB ai = (OutOrderMB) MBUtil.getManageBean("#{outOrderMB}");
	if (request.getParameter("time") != null) {
		ai.setSql("");
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>商品信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='outorder.js'></script>
	</head>


	<body id=mmain_body onload="cleartext();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton id="addDBut" value="添加明細"
							onclick="if(!addDetails()){return false};"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							type="button" action="#{outOrderMB.addDetails}"
							reRender="renderArea,output"
							rendered="#{outOrderMB.MOD && outOrderMB.commitStatus}"
							oncomplete="endAddDetails();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="search();" oncomplete="endSearch();" id="sid" value="查询"
							type="button" action="#{outOrderMB.addDetailSearch}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="商品编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{outOrderMB.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{outOrderMB.na}" onkeypress="formsubmit(event);" />

						<h:outputText value="花号:">
						</h:outputText>
						<h:inputText id="colo" styleClass="inputtextedit" size="15"
							value="#{outOrderMB.colo}" onkeypress="formsubmit(event);" />
						商品规格:
						<h:inputText id="inst" value="#{outOrderMB.inst}"
							styleClass="inputtextedit" />
						属性:
						<h:selectOneMenu id="inpr" value="#{outOrderMB.inpr}"
							styleClass="inputtextedit" style="width:130ps;" rendered="true"
							onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="0" />
							<f:selectItem itemLabel="成品" itemValue="P" />
							<f:selectItem itemLabel="半成品" itemValue="S" />
						</h:selectOneMenu>
						<br>
						<h:outputText value="ERP编码:">
						</h:outputText>
						<h:inputText id="asco" styleClass="inputtextedit" size="15"
							value="#{outOrderMB.asco}" onkeypress="formsubmit(event);" />
						<h:outputText value="POS编码:">
						</h:outputText>
						<h:inputText id="psco" styleClass="inputtextedit" size="15"
							value="#{outOrderMB.psco}" onkeypress="formsubmit(event);" />
						商品类别:
						<h:inputText id="tyna" value="#{outOrderMB.tyna}"
							styleClass="inputtextedit" />
						<img id="tyna_img" style="cursor: hand"
							src="../../images/find.gif" onclick="selectSK_Inty();" />
						品牌/系统:
						<h:inputText id="brde" value="#{outOrderMB.brde}"
							styleClass="inputtextedit" />
						<img id="brde_img" style="cursor: hand"
							src="../../images/find.gif" onclick="selectSK_Bran();" />

					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select a.id,a.inco,a.inna,a.colo,a.inse,b.tyna,c.brde,a.inpr,isnull(s.uqty,0) as uqty,a.asco,a.psco      
											from inve a left join prty b on a.inty = b.inty left join brin c on a.bran = c.bran 
											LEFT JOIN (select inco,SUM(uqty) AS uqty from stqu group by inco
											) s ON a.inco=s.inco 
											where 1=1 and s.uqty<>0 #{outOrderMB.sql}"
								gwidth="550" gpage="(pagesize = 50)" gdebug="true" gsort="inco"
								gsortmethod="asc"
								gcolumn="gcid = id(headtext = selall,name = id,width = 30,align = center,type = checkbox ,headtype = checkbox);
									gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 110,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 180,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 规格,name = colo,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = inse(headtext = 规格码,name = inse,width = 80,headtype = sort,align = left,type = text,datatype=string);
									gcid = uqty(headtext = 可用库存,name = uqty,width = 70,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##);
									gcid = tyna(headtext = 商品类别,name = tyna,width = 80,headtype = sort,align = center , type = text, datatype = string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{outOrderMB.msg}" />
							<h:inputHidden id="sellist" value="#{outOrderMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>