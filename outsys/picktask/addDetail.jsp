<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.view.PickTaskMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	PickTaskMB ai = (PickTaskMB) MBUtil.getManageBean("#{pickTaskMB}");
	if (request.getParameter("time") != null) {
		//ai.setSql("");
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>备货计划明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='picktask.js'></script>
	</head>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton id="addDBut" value="添加明細"
							onclick="if(!addDetails()){return false};"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							type="button" action="#{pickTaskMB.addDetails}"
							reRender="renderArea,output"
							rendered="#{pickTaskMB.MOD && pickTaskMB.commitStatus}"
							oncomplete="endAddDetails();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="addSearch();" oncomplete="endAddSearch();" id="sid"
							value="查询" type="button" action="#{pickTaskMB.addDetailSearch}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="商品编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{pickTaskMB.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{pickTaskMB.na}" onkeypress="formsubmit(event);" />

						<h:outputText value="花号:">
						</h:outputText>
						<h:inputText id="colo" styleClass="inputtextedit" size="15"
							value="#{pickTaskMB.colo}" onkeypress="formsubmit(event);" />
						商品规格:
						<h:inputText id="inst" value="#{pickTaskMB.inst}"
							styleClass="inputtextedit" />
						<br>
						商品类别:
						<h:inputText id="tyna" value="#{pickTaskMB.tyna}"
							styleClass="inputtextedit" />
						<img id="tyna_img" style="cursor: pointer"
							src="../../images/find.gif" onclick="selectSK_Inty();" />
						品牌/系统:
						<h:inputText id="brde" value="#{pickTaskMB.brde}"
							styleClass="inputtextedit" />
						<img id="brde_img" style="cursor: pointer"
							src="../../images/find.gif" onclick="selectSK_Bran();" />
						属性:
						<h:selectOneMenu id="inpr" value="#{pickTaskMB.inpr}"
							style="width:130ps;">
							<f:selectItem itemLabel="全部" itemValue="0" />
							<f:selectItem itemLabel="成品" itemValue="P" />
							<f:selectItem itemLabel="半成品" itemValue="S" />
							<f:selectItem itemLabel="商品" itemValue="W" />
						</h:selectOneMenu>
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
								gselectsql="
								Select a.did,a.inco,(a.qty-a.fqty-ISNULL(e.qty,0)) as qty,b.inna,b.inty,c.tyna,b.inse,d.brde,b.inpr,b.colo 
								From ltdb a left join inve b On a.inco = b.inco  
								left join prty c on b.inty = c.inty left join brin d on b.bran = d.bran 
								left join (select g.inco,sum(qty) as qty from ptma f join ptde g on f.biid = g.biid 
								where f.soco = '#{pickTaskMB.mbean.soco}' and f.flag = '01' group by g.inco) e on a.inco = e.inco
								Where a.biid = '#{pickTaskMB.mbean.soco}' 
								And a.inco 	NOT IN (SELECT inco FROM ptde WHERE biid = '#{pickTaskMB.mbean.biid}') 
								And (a.qty-a.fqty-ISNULL(e.qty,0)) > 0 #{pickTaskMB.addsql }
								"
								gpage="(pagesize = -1)"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox ,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
								gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inna(headtext = 商品名称,name = inna,width = 170,align = left,type = text,headtype = sort ,datatype = string);
								gcid = colo(headtext = 规格,name = colo,width = 110,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inse(headtext = 规格码,name = inst,width = 90,align = left,type = text,headtype = sort ,datatype = string);
								gcid = tyna(headtext = 商品类别,name = tyna,width = 70,align = left,type = text,headtype = sort ,datatype = string);
								gcid = qty(headtext =  待分配数量,name = qty,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{pickTaskMB.msg}" />
							<h:inputHidden id="sellist" value="#{pickTaskMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>