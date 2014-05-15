<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.PoinMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
	<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/TailHandler.js"></script>
	<script type="text/javascript" src="poin.js"></script>
</head>
  <%
  		String id = "";
	    PoinMB ai = (PoinMB) MBUtil.getManageBean("#{poinMB}");
	    if (request.getParameter("pid") != null) {
	        id = request.getParameter("pid");
	        ai.getMbean().setBiid(id);
	    }
	    ai.getVouch();
	%>
<body>
<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton id="addDBut" value="添加明細"
							onclick="if(!addDetails()){return false};"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							type="button" action="#{poinMB.addDetail}"
							reRender="renderArea,output"
							rendered="#{poinMB.MOD && poinMB.commitStatus}"
							oncomplete="endAddDetails();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="startDo()" oncomplete="endLoad()" id="sid" value="查询"
							type="button" action="#{poinMB.addDetailSearch}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置"
							onclick="clearDetailText();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						商品编码:
						<h:inputText id="id" styleClass="inputtextedit" size="12"
							value="#{poinMB.id}" onkeypress="formsubmit(event);" />
						商品名称:
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{poinMB.na}" onkeypress="formsubmit(event);" />
						规格:
						<h:inputText id="colo" styleClass="inputtextedit" size="10"
							value="#{poinMB.colo}" onkeypress="formsubmit(event);" />
						规格码:
						<h:inputText id="inst" value="#{poinMB.inst}" size="10"
							styleClass="inputtextedit" />
						<br>
						入库库位：
						<h:selectOneMenu id="whid" value="#{poinMB.mbean.whid}"
							style="width:130px;" disabled="true">
							<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
						</h:selectOneMenu>
						<h:inputText id="dwhid" styleClass="datetime" size="15"
							onkeydown="t.keyPressDeal(this);"
							onfocus="this.select();t.elementFocus();"
							value="#{poinMB.dbean.whid}" />
						<img id="whid_img" style="cursor: pointer"
							src="../../images/find.gif" onclick="selectWahod();" />
											
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="
									SELECT a.biid AS soco,b.inco,c.inna,c.colo,c.inse,b.qty as cqty,'' as qty
									FROM pubm a left join pubd b on a.biid=b.biid
									LEFT JOIN inve c ON b.inco=c.inco
									WHERE a.biid='#{poinMB.mbean.soco}' AND b.inco NOT IN (
									SELECT inco FROM psde WHERE biid='#{poinMB.mbean.biid}')
									#{poinMB.sql} 
								"
								gwidth="550" gpage="(pagesize = -1)" gdebug="true" gsort="inse"
								gsortmethod="DESC"
								gcolumn="gcid = soco(headtext = selall,name = soco,width = 20,align = center,type = checkbox ,headtype = checkbox);
									gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = soco(headtext = 采购订单,name = soco,width = 0,headtype = sort,align = left,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 110,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 120,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 规格,name = colo,width = 70,headtype = sort,align = left,type = text,datatype=string);
									gcid = inse(headtext = 规格码,name = inse,width = 70,headtype = sort,align = left,type = text,datatype=string);
									gcid = cqty(headtext = 采购订单数量,name = arqty,width = 90,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
									gcid = qty(headtext = 本次入库数量,name = qty,width = 90,headtype = sort,align = right,type = input,datatype=number,dataformat={0},gscript={onkeypress=return isInteger(event),selectCheckBox(this),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
									" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{poinMB.msg}" />
							<h:inputHidden id="sellist" value="#{poinMB.sellist}" />
							<h:inputHidden id="socos" value="#{poinMB.socos}" />
							<h:inputHidden id="incos" value="#{poinMB.incos}" />
							<h:inputHidden id="qtys" value="#{poinMB.qtys}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
</body>
</html>