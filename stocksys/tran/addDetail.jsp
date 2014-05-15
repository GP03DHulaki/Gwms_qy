<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.TranPlanMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>商品信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='tran.js'></script>
	</head>

	<%
		TranPlanMB ai = (TranPlanMB) MBUtil.getManageBean("#{tranPlanMB}");
		if (request.getParameter("time") != null) {
			//ai.setSql("");
		}
	%>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton id="addDBut" value="添加明細"
							onclick="if(!addDetails()){return false};"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							type="button" action="#{tranPlanMB.addDetails}"
							reRender="renderArea,output" rendered="#{tranPlanMB.MOD && tranPlanMB.commitStatus}"
							oncomplete="endAddDetails();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" 
							onclick="search();" oncomplete="endSearch();"
							id="sid" value="查询" type="button" action="#{tranPlanMB.addDetailSearch}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="商品编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{tranPlanMB.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{tranPlanMB.na}" onkeypress="formsubmit(event);" />
						<h:outputText value="规格:">
						</h:outputText>
						<h:inputText id="colo" styleClass="inputtextedit" size="15"
							value="#{tranPlanMB.colo}" onkeypress="formsubmit(event);" />
						规格码:
						<h:inputText id="inst" value="#{tranPlanMB.inst}"
							styleClass="inputtextedit" />
						<br>
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
								gselectsql="select a.id,a.inco,a.inna,a.colo,a.inse,ISNULL(s.uqty,0) AS uqty     
											from inve a LEFT JOIN f_stock_uqty('#{tranPlanMB.mbean.pfwh}') s ON a.inco=s.inco
											where s.uqty>0 #{tranPlanMB.sql} "
								gwidth="550" gpage="(pagesize = 20)"  gsort="inco" gsortmethod="asc"
								gcolumn="gcid = id(headtext = selall,name = id,width = 30,align = center,type = checkbox ,headtype = checkbox);
									gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 150,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 规格,name = colo,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = inse(headtext = 规格码,name = inse,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = uqty(headtext =  可用库存,name = uqty,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{tranPlanMB.msg}" />
							<h:inputHidden id="sellist" value="#{tranPlanMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>