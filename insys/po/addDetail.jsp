<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.PubmMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>商品信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='po.js'></script>
	</head>

	<%
		PubmMB ai = (PubmMB) MBUtil.getManageBean("#{pubmMB}");
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
							type="button" action="#{pubmMB.addDetails}"
							reRender="renderArea,output" rendered="#{pubmMB.MOD && pubmMB.commitStatus}"
							oncomplete="endAddDetails();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" 
							onclick="search();" oncomplete="endSearch();"
							id="sid" value="查询" type="button" action="#{pubmMB.addDetailSearch}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="商品条码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{pubmMB.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{pubmMB.na}" onkeypress="formsubmit(event);" />
						规格:
						<h:inputText id="colo" styleClass="inputtextedit" size="15"
							value="#{pubmMB.colo}" onkeypress="formsubmit(event);" />
						规格码:
						<h:inputText id="inst" value="#{pubmMB.inst}"
							styleClass="inputtextedit" />
						<br>
						<%-- 
						类别:
							<h:inputText id="tyna" value="#{pubmMB.tyna}"
								styleClass="inputtextedit" />
							<img id="tyna_img" style="cursor: pointer"
								src="../../images/find.gif" onclick="selectSK_Inty();" />
						--%>
						
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select a.id,a.inco,a.inna,a.colo,a.inse,b.tyna,c.brde,a.inpr,a.inpa as qty 
											from inve a left join prty b on a.inty = b.inty left join brin c on a.bran = c.bran  
											where 1=1 #{pubmMB.sql} "
								gwidth="550" gpage="(pagesize = 18)" gdebug="false" gsort="inco" gsortmethod="asc"
								gcolumn="gcid = id(headtext = selall,name = id,width = 30,align = center,type = checkbox ,headtype = checkbox);
									gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 110,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 规格,name = colo,width = 150,headtype = sort,align = left,type = text,datatype=string);
									gcid = inse(headtext = 规格码,name = inse,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = tyna(headtext = 类别,name = tyna,width = 80,headtype = sort,align = center , type = text, datatype = string);
									gcid = qty(headtext =  采购数量,name = qty,width = 60,align = right,type = input,headtype= sort, datatype =number,dataformat=0.##,update=edit,gscript={onkeypress=return isInteger(event),selectCheckBox(this),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{pubmMB.msg}" />
							<h:inputHidden id="sellist" value="#{pubmMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>