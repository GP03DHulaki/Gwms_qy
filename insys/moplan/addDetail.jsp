<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.MoPlanMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>商品信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='moplan.js'></script>
	</head>

	<%
		MoPlanMB ai = (MoPlanMB) MBUtil.getManageBean("#{moPlanMB}");
		if (request.getParameter("time") != null) {
			//ai.setSql("");
		}
	%>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton id="addDBut" value="添加明細"
							onclick="if(!addDetails()){return false};"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							type="button" action="#{moPlanMB.addDetails}"
							reRender="renderArea,output" rendered="#{moPlanMB.MOD && moPlanMB.commitStatus}"
							oncomplete="endAddDetails();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" 
							onclick="search();" oncomplete="endSearch();"
							id="sid" value="查询" type="button" action="#{moPlanMB.addDetailSearch}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="商品编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{moPlanMB.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{moPlanMB.na}" onkeypress="formsubmit(event);" />
					
						<h:outputText value="花号:">
						</h:outputText>
						<h:inputText id="colo" styleClass="inputtextedit" size="15"
							value="#{moPlanMB.colo}" onkeypress="formsubmit(event);" />
						商品规格:
						<h:inputText id="inst" value="#{moPlanMB.inst}"
							styleClass="inputtextedit" />
						<br>
						商品类别:
						<h:inputText id="tyna" value="#{moPlanMB.tyna}"
							styleClass="inputtextedit" />
						<img id="tyna_img" style="cursor: pointer"
							src="../../images/find.gif" onclick="selectSK_Inty();" />
						品牌/系统:
						<h:inputText id="brde" value="#{moPlanMB.brde}"
							styleClass="inputtextedit" />
						<img id="brde_img" style="cursor: pointer"
							src="../../images/find.gif" onclick="selectSK_Bran();" />
						属性:
						<h:selectOneMenu id="inpr" value="#{moPlanMB.inpr}" style="width:130ps;">
							<f:selectItem itemLabel="全部" itemValue="0"/>
							<f:selectItem itemLabel="成品" itemValue="P"/>
							<f:selectItem itemLabel="半成品" itemValue="S"/>
						</h:selectOneMenu>
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select a.id,a.inco,a.inna,a.colo,a.inst,b.tyna,c.brde,a.inpr   
											from inve a left join prty b on a.inty = b.inty left join brin c on a.bran = c.bran  
											where 1=1 #{moPlanMB.sql} "
								gwidth="550" gpage="(pagesize = 50)" gdebug="false" gsort="inco" gsortmethod="asc"
								gcolumn="gcid = id(headtext = selall,name = id,width = 30,align = center,type = checkbox ,headtype = checkbox);
									gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 110,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 180,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 花号,name = colo,width = 150,headtype = sort,align = left,type = text,datatype=string);
									gcid = inst(headtext = 规格,name = inst,width = 80,headtype = sort,align = left,type = text,datatype=string);
									gcid = tyna(headtext = 商品类别,name = tyna,width = 80,headtype = sort,align = center , type = text, datatype = string);
									gcid = brde(headtext = 品牌/系统,name = brde,width = 80,headtype = sort,align = center , type = text, datatype = string);
									gcid = inpr(headtext = 商品属性 ,name = inpr,width = 60,headtype =sort , align = center , type = mask,typevalue={S:半成品/P:产品/M:商品} , datatype = string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{moPlanMB.msg}" />
							<h:inputHidden id="sellist" value="#{moPlanMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>