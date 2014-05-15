<%@ page language="java" pageEncoding="UTF-8"%><%@ include
	file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.PurchaseArriveMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>选择商品</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='arrive.js'></script>
	</head>

	<%
	    PurchaseArriveMB ai = (PurchaseArriveMB) MBUtil
	            .getManageBean("#{purchaseArrvicMB}");
	    if (request.getParameter("time") != null) {
	        ai.initDeSearKey();
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
							type="button" action="#{purchaseArrvicMB.addDetail}"
							reRender="renderArea,output"
							rendered="#{purchaseArrvicMB.MOD && purchaseArrvicMB.commitStatus}"
							oncomplete="endAddDetails();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="startDo()" oncomplete="endLoad()" id="sid" value="查询"
							type="button" action="#{purchaseArrvicMB.addDetailSearch}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置"
							onclick="clearDetailText();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						采购订单:
						<h:inputText id="poid" styleClass="inputtextedit" size="15"
							value="#{purchaseArrvicMB.poid}" onkeypress="formsubmit(event);" />
						商品编码:
						<h:inputText id="id" styleClass="inputtextedit" size="12"
							value="#{purchaseArrvicMB.id}" onkeypress="formsubmit(event);" />
						商品名称:
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{purchaseArrvicMB.na}" onkeypress="formsubmit(event);" />
						规格:
						<h:inputText id="colo" styleClass="inputtextedit" size="10"
							value="#{purchaseArrvicMB.colo}" onkeypress="formsubmit(event);" />
						规格码:
						<h:inputText id="inst" value="#{purchaseArrvicMB.inst}" size="10"
							styleClass="inputtextedit" />
						<br>
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="
									SELECT a.biid AS soco,a.inco,c.inna,c.colo,c.inse,a.aqty+ISNULL(b.dqty ,0) AS arqty,0 AS qty,a.qty-a.aqty-ISNULL(b.dqty ,0) AS upqty FROM nofd a LEFT JOIN (
										SELECT a.inco,SUM(a.qty) AS dqty FROM rgde a JOIN rgma b ON a.biid=b.biid WHERE b.soco='#{purchaseArrvicMB.mbean.soco}' AND b.flag='01' GROUP BY a.inco) b 
									ON a.inco=b.inco
									LEFT JOIN inve c ON a.inco=c.inco
									WHERE a.biid='#{purchaseArrvicMB.mbean.soco}' AND a.inco NOT IN (
									SELECT inco FROM rgde WHERE biid='#{purchaseArrvicMB.mbean.biid}')
									#{purchaseArrvicMB.sql} 
								"
								gwidth="550" gpage="(pagesize = -1)" gdebug="true" gsort="upqty"
								gsortmethod="DESC"
								gcolumn="gcid = soco(headtext = selall,name = soco,width = 20,align = center,type = checkbox ,headtype = checkbox);
									gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = soco(headtext = 采购订单,name = soco,width = 0,headtype = sort,align = left,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 110,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 120,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 规格,name = colo,width = 70,headtype = sort,align = left,type = text,datatype=string);
									gcid = inse(headtext = 规格码,name = inse,width = 70,headtype = sort,align = left,type = text,datatype=string);
									gcid = arqty(headtext = 已到货数量,name = arqty,width = 90,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
									gcid = qty(headtext = 本次到货数量,name = qty,width = 90,headtype = sort,align = right,type = input,datatype=number,dataformat={0},gscript={onkeypress=return isInteger(event),selectCheckBox(this),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
									gcid = upqty(headtext = 未到货数量,name = upqty,width = 90,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{purchaseArrvicMB.msg}" />
							<h:inputHidden id="sellist" value="#{purchaseArrvicMB.sellist}" />
							<h:inputHidden id="socos" value="#{purchaseArrvicMB.socos}" />
							<h:inputHidden id="incos" value="#{purchaseArrvicMB.incos}" />
							<h:inputHidden id="qtys" value="#{purchaseArrvicMB.qtys}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>