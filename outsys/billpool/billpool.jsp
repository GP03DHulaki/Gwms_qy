<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.gwall.view.OtherOutMB"%>
<%@page import="com.gwall.view.BillPoolMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	BillPoolMB ai = (BillPoolMB) MBUtil.getManageBean("#{billpoolMB}");
	if (request.getParameter("isAll") != null) {
		//ai.initSK();
	}
	
%>

<html>
	<head>
		<title>分单池</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="分单池">
		<script type="text/javascript" src="billpool.js"></script>
	</head>

	<body id='mmain_body'>
		<div id="mmain_nav">
			出库处理&gt;&gt;<b>分单池</b>
		
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id="mmain_cnd">
						<h:outputText value="SKU编码:">
						</h:outputText>
						<h:inputText id="sk_inco" styleClass="datetime" size="15"
							value="#{billpoolMB.sk_inco}" onkeypress="formsubmit(event);" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							action="#{billpoolMB.search}" requestDelay="50"
							onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
							rendered="#{billpoolMB.LST}" />
					</div>
					
					
					
					
						<div style="width: 50%">
						<span style="font-size: 20px;width: 260px;"><B>分单池订单信息<B/></span>	<br>
						<h:outputText value="分配仓库:" ></h:outputText>
						<h:selectOneMenu id="fp_whid" value="#{billpoolMB.fp_whid}"
							style="width:130px;">
							<f:selectItem itemLabel="" itemValue="" />
							<f:selectItems value="#{warehouseMB.wareListWithOrid}" />
						</h:selectOneMenu>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="fp" value="确认分配" type="button"
								onclick="if(!fenpei()){return false};"
								rendered="#{billpoolMB.DEL}" reRender="output,renderArea"
								action="#{billpoolMB.fenpei}"
								oncomplete="endFenpei();" requestDelay="50" />
						
					<a4j:outputPanel id="output">	
							<g:GTable gid="gtable" gtype="grid"
							gselectsql="SELECT b.inco,COUNT(*) AS fcount FROM obma a 
										JOIN oubd b ON a.biid = b.biid 
										JOIN prin p ON b.inco = p.inco 
										WHERE a.whid IS NULL OR a.whid = '' and p.ortp = '1'
										GROUP BY b.inco  
										"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
								gcid = inco(headtext = SKU编码,name = inco,width = 220,align = left,type = text,headtype = text,datatype = string);
								gcid = fcount(headtext = 未分配订单数,name = fcount,width = 120,headtype = sort,align = right,type = text,datatype=number,dataformat=0.##,update=edit,summary=this);
								gcid = -1(headtext = 分配数,value=0,name = fpqty,width = 120,headtype = sort,align = right,type = input,datatype=number,dataformat=0.##,update=edit,summary=this);
							" />
						</div>
						
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{billpoolMB.msg}" />
							<h:inputHidden id="sellist" value="#{billpoolMB.sellist}" />
							<h:inputHidden id="incos" value="#{billpoolMB.incos}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
